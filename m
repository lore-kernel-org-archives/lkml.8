Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83577C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 18:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697E620637
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 18:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgCHSHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 14:07:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56891 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgCHSHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 14:07:38 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jB0Kc-00082h-PX; Sun, 08 Mar 2020 19:07:19 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id DBBB11040A5; Sun,  8 Mar 2020 19:07:17 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <rong.a.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>, x86-ml <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        lkp@lists.01.org
Subject: Re: [futex] 8019ad13ef: will-it-scale.per_process_ops -97.8% regression
In-Reply-To: <CAHk-=whrpL8pbKLg3_s3+bxv6kbPnzbSP8dQkZ+Rv=jAT3aoKw@mail.gmail.com>
References: <20200308140200.GO5972@shao2-debian> <CAHk-=wgJV7xrxsTkOG203huPShzZBEC6N_BG0KGwHBmEq4yqWg@mail.gmail.com> <CAHk-=whrpL8pbKLg3_s3+bxv6kbPnzbSP8dQkZ+Rv=jAT3aoKw@mail.gmail.com>
Date:   Sun, 08 Mar 2020 19:07:17 +0100
Message-ID: <87h7yy90ve.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> [ Just a re-send without html crud that makes all the lists unhappy.
> I'm still on the road, the flight I was supposed to be on yesterday
> got cancelled.. ]
>
> I do note that the futex hashing seems to be broken by that commit. Or
> at least it's questionable.  It keeps hashing on "both.word",  and
> doesn't use the u64 field at all for hashing.
>
> Maybe I'm mis-reading it - I didn't apply the patch, I just looked at
> the patch and my source base separately.
>
> But the 98% regression sure says something went wrong ;)

Right you are. The pointer needs to be the starting point as it moved
ahead of word, which means it starts at word and hashes word and
offset and an extra u32 beyond the end of the key.

Thanks,

        tglx
----
diff --git a/kernel/futex.c b/kernel/futex.c
index e14f7cd45dbd..9f3251349f65 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -385,8 +385,8 @@ static inline int hb_waiters_pending(struct futex_hash_bucket *hb)
  */
 static struct futex_hash_bucket *hash_futex(union futex_key *key)
 {
-	u32 hash = jhash2((u32*)&key->both.word,
-			  (sizeof(key->both.word)+sizeof(key->both.ptr))/4,
+	u32 hash = jhash2((u32*)&key->both.ptr,
+			  (sizeof(key->both.ptr) + sizeof(key->both.word)) / 4,
 			  key->both.offset);
 	return &futex_queues[hash & (futex_hashsize - 1)];
 }
