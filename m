Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF81C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6CE0207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388221AbgE0Ndj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 09:33:39 -0400
Received: from mga18.intel.com ([134.134.136.126]:10478 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387650AbgE0Ndh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:33:37 -0400
IronPort-SDR: 3QBb63cQmxayhPe23+Yhhp8Dstw/DvlHo7FHXlH5uA3wlsf0aT2cJ4SUEtaTJeERzIC8Rpai/N
 mPPdP8mVejww==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 06:33:37 -0700
IronPort-SDR: Sp85A4i2kD1hIJeERk2+fDoPnHvu1ieNLHpHlYnUQoRo+UJZ+SVOZlsY8FKXyMSUVQx+2yYVDX
 C2fHseRFb0VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,441,1583222400"; 
   d="scan'208";a="291594465"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by fmsmga004.fm.intel.com with ESMTP; 27 May 2020 06:33:34 -0700
Date:   Wed, 27 May 2020 21:33:32 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] make vm_committed_as_batch aware of vm overcommit
 policy
Message-ID: <20200527133332.GA20232@shbuild999.sh.intel.com>
References: <1588922717-63697-1-git-send-email-feng.tang@intel.com>
 <20200521212726.GC6367@ovpn-112-192.phx2.redhat.com>
 <20200526181459.GD991@lca.pw>
 <20200527014647.GB93879@shbuild999.sh.intel.com>
 <20200527022539.GK991@lca.pw>
 <20200527104606.GE93879@shbuild999.sh.intel.com>
 <20200527120549.GA741@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527120549.GA741@lca.pw>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qian,

On Wed, May 27, 2020 at 08:05:49AM -0400, Qian Cai wrote:
> On Wed, May 27, 2020 at 06:46:06PM +0800, Feng Tang wrote:
> > Hi Qian,
> > 
> > On Tue, May 26, 2020 at 10:25:39PM -0400, Qian Cai wrote:
> > > > > > > [1] https://lkml.org/lkml/2020/3/5/57
> > > > > > 
> > > > > > Reverted this series fixed a warning under memory pressue.
> > > > > 
> > > > > Andrew, Stephen, can you drop this series?
> > > > > 
> > > > > > 
> > > > > > [ 3319.257898] LTP: starting oom01
> > > > > > [ 3319.284417] ------------[ cut here ]------------
> > > > > > [ 3319.284439] memory commitment underflow
> > > > 
> > > > Thanks for the catch!
> > > > 
> > > > Could you share the info about the platform, like the CPU numbers
> > > > and RAM size, and what's the mmap test size of your test program.
> > > > It would be great if you can point me the link to the test program.
> > > 
> > > I have been reproduced this on both AMD and Intel. The test just
> > > allocating memory and swapping.
> > > 
> > > https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/oom/oom01.c
> > > https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/tunable/overcommit_memory.c
> > > 
> > > It might be better to run the whole LTP mm tests if none of the above
> > > triggers it for you which has quite a few memory pressurers.
> > > 
> > > /opt/ltp/runltp -f mm
> > 
> > Thanks for sharing. I tried to reproduce this on 2 server plaforms,
> > but can't reproduce it, and they are still under testing.
> > 
> > Meanwhile, could you help to try the below patch, which is based on
> > Andi's suggestion and have some debug info. The warning is a little
> > strange, as the condition is
> > 
> > 	(percpu_counter_read(&vm_committed_as) <
> >                        -(s64)vm_committed_as_batch * num_online_cpus())
> > 
> > while for your platform (48 CPU + 128 GB RAM), the
> > '-(s64)vm_committed_as_batch * num_online_cpus()'
> > is a s64 value: '-32G', which makes the condition hard to be true,
> > and when it is,  it could be triggered by some magic for s32/s64
> > operations around the percpu-counter. 
> 
> Here is the information on AMD and powerpc below affected by this. It
> could need a bit patient to reproduce, but our usual daily CI would
> trigger it eventually after a few tries.
> 
> # git clone https://github.com/cailca/linux-mm.git
> # cd linux-mm
> # ./compile.sh
> # systemctl reboot
> # ./test.sh

I just downloaded it, and it failed on my desktop machine as it failed
in 'yum' and 'grub2' setup. The difficulty for me to reproduce is the
test platforms are behind the 0day framework, and I can hardly  setup
external test suits, though I have been trying for all day today :) 

So if possible, please help to try the patch in my last email. thanks!

- Feng

