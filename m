Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A29AC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D842087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgCII1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 04:27:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:63271 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbgCII1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 04:27:04 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2020 01:27:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,532,1574150400"; 
   d="scan'208";a="230851565"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.3])
  by orsmga007.jf.intel.com with ESMTP; 09 Mar 2020 01:27:00 -0700
Date:   Mon, 9 Mar 2020 16:26:49 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>, x86-ml <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        lkp@lists.01.org
Subject: Re: [futex] 8019ad13ef: will-it-scale.per_process_ops -97.8%
 regression
Message-ID: <20200309082649.GT5972@shao2-debian>
References: <20200308140200.GO5972@shao2-debian>
 <CAHk-=wgJV7xrxsTkOG203huPShzZBEC6N_BG0KGwHBmEq4yqWg@mail.gmail.com>
 <CAHk-=whrpL8pbKLg3_s3+bxv6kbPnzbSP8dQkZ+Rv=jAT3aoKw@mail.gmail.com>
 <87h7yy90ve.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h7yy90ve.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 08, 2020 at 07:07:17PM +0100, Thomas Gleixner wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > [ Just a re-send without html crud that makes all the lists unhappy.
> > I'm still on the road, the flight I was supposed to be on yesterday
> > got cancelled.. ]
> >
> > I do note that the futex hashing seems to be broken by that commit. Or
> > at least it's questionable.  It keeps hashing on "both.word",  and
> > doesn't use the u64 field at all for hashing.
> >
> > Maybe I'm mis-reading it - I didn't apply the patch, I just looked at
> > the patch and my source base separately.
> >
> > But the 98% regression sure says something went wrong ;)
> 
> Right you are. The pointer needs to be the starting point as it moved
> ahead of word, which means it starts at word and hashes word and
> offset and an extra u32 beyond the end of the key.
> 
> Thanks,
> 
>         tglx
> ----
> diff --git a/kernel/futex.c b/kernel/futex.c
> index e14f7cd45dbd..9f3251349f65 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -385,8 +385,8 @@ static inline int hb_waiters_pending(struct futex_hash_bucket *hb)
>   */
>  static struct futex_hash_bucket *hash_futex(union futex_key *key)
>  {
> -	u32 hash = jhash2((u32*)&key->both.word,
> -			  (sizeof(key->both.word)+sizeof(key->both.ptr))/4,
> +	u32 hash = jhash2((u32*)&key->both.ptr,
> +			  (sizeof(key->both.ptr) + sizeof(key->both.word)) / 4,
>  			  key->both.offset);
>  	return &futex_queues[hash & (futex_hashsize - 1)];
>  }

Hi Thomas,

I have tested the above patch, and the patch can fix the regression.

commit:
  v5.6-rc4
  8019ad13ef ("futex: Fix inode life-time issue")
  8eb641cbc3 ("the fix patch")

        v5.6-rc4  8019ad13ef7f64be44d4f892af  8eb641cbc397e3bbea2a9974e0  testcase/testparams/testbox
----------------  --------------------------  --------------------------  ---------------------------
         %stddev      change         %stddev      change         %stddev
             \          |                \          |                \  
   1083510             -98%      23904                     1078868        will-it-scale/performance-process-100%-futex2-ucode=0x2000065/lkp-skl-fpga01
   1083510             -98%      23904                     1078868        GEO-MEAN will-it-scale.per_process_ops

Best Regards,
Rong Chen
