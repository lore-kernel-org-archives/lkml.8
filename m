Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEA4C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BBB62070E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgCEPOe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:14:34 -0500
Received: from mga04.intel.com ([192.55.52.120]:37454 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbgCEPOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 10:14:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 07:14:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; 
   d="scan'208";a="234479827"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga008.fm.intel.com with ESMTP; 05 Mar 2020 07:14:33 -0800
Received: from shsmsx106.ccr.corp.intel.com (10.239.4.159) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 5 Mar 2020 07:14:32 -0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.50]) by
 SHSMSX106.ccr.corp.intel.com ([169.254.10.86]) with mapi id 14.03.0439.000;
 Thu, 5 Mar 2020 23:14:30 +0800
From:   "Li, Philip" <philip.li@intel.com>
To:     lkp <lkp@intel.com>, "cl@rock-chips.com" <cl@rock-chips.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "surenb@google.com" <surenb@google.com>,
        "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "wad@chromium.org" <wad@chromium.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "george_davis@mentor.com" <george_davis@mentor.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "info@metux.net" <info@metux.net>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "huangtao@rock-chips.com" <huangtao@rock-chips.com>,
        Liang Chen <cl@rock-chips.com>
Subject: RE: [kbuild-all] Re: [PATCH v1 1/1] sched/fair: do not preempt
 current task if it is going to call schedule()
Thread-Topic: [kbuild-all] Re: [PATCH v1 1/1] sched/fair: do not preempt
 current task if it is going to call schedule()
Thread-Index: AQHV8vwSaUDvAnC/i0OErjRILa0VAag6GycQ
Date:   Thu, 5 Mar 2020 15:14:29 +0000
Message-ID: <831EE4E5E37DCC428EB295A351E66249524206DF@shsmsx102.ccr.corp.intel.com>
References: <20200305081611.29323-2-cl@rock-chips.com>
 <202003052243.P59yLrjh%lkp@intel.com>
In-Reply-To: <202003052243.P59yLrjh%lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [kbuild-all] Re: [PATCH v1 1/1] sched/fair: do not preempt current task if
> it is going to call schedule()
> 
> Hi,
> 
> Thank you for the patch! Yet something to improve:
Sorry, there're a few duplicated reports around this patch, kindly
ignore similar reports, we will look for the possible issue.

Thanks

> 
> [auto build test ERROR on tip/sched/core]
> [also build test ERROR on arm64/for-next/core tip/auto-latest linus/master v5.6-
> rc4 next-20200305]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/cl-rock-chips-
> com/wait_task_inactive-spend-too-much-time-on-system-startup/20200305-
> 201639
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
> a0f03b617c3b2644d3d47bf7d9e60aed01bd5b10
> config: s390-zfcpdump_defconfig (attached as .config)
> compiler: s390-linux-gcc (GCC) 7.5.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-
> tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.5.0 make.cross ARCH=s390
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/kvm_host.h:12:0,
>                     from arch/s390/kernel/asm-offsets.c:11:
>    include/linux/sched.h: In function 'set_tsk_going_to_sched':
> >> include/linux/sched.h:1776:27: error: 'TIF_GOING_TO_SCHED' undeclared
> (first use in this function); did you mean 'TIF_SINGLE_STEP'?
>      set_tsk_thread_flag(tsk, TIF_GOING_TO_SCHED);
>                               ^~~~~~~~~~~~~~~~~~
>                               TIF_SINGLE_STEP
>    include/linux/sched.h:1776:27: note: each undeclared identifier is reported only
> once for each function it appears in
>    include/linux/sched.h: In function 'clear_tsk_going_to_sched':
>    include/linux/sched.h:1781:29: error: 'TIF_GOING_TO_SCHED' undeclared (first
> use in this function); did you mean 'TIF_SINGLE_STEP'?
>      clear_tsk_thread_flag(tsk, TIF_GOING_TO_SCHED);
>                                 ^~~~~~~~~~~~~~~~~~
>                                 TIF_SINGLE_STEP
>    In file included from include/linux/kernel.h:11:0,
>                     from include/linux/list.h:9,
>                     from include/linux/preempt.h:11,
>                     from include/linux/hardirq.h:5,
>                     from include/linux/kvm_host.h:7,
>                     from arch/s390/kernel/asm-offsets.c:11:
>    include/linux/sched.h: In function 'test_tsk_going_to_sched':
>    include/linux/sched.h:1786:44: error: 'TIF_GOING_TO_SCHED' undeclared (first
> use in this function); did you mean 'TIF_SINGLE_STEP'?
>      return unlikely(test_tsk_thread_flag(tsk, TIF_GOING_TO_SCHED));
>                                                ^
>    include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
>     # define unlikely(x) __builtin_expect(!!(x), 0)
>                                              ^
>    make[2]: *** [scripts/Makefile.build:101: arch/s390/kernel/asm-offsets.s] Error 1
>    make[2]: Target '__build' not remade because of errors.
>    make[1]: *** [Makefile:1112: prepare0] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [Makefile:179: sub-make] Error 2
>    142 real  47 user  83 sys  92.07% cpu 	make prepare
> 
> vim +1776 include/linux/sched.h
> 
>   1773
>   1774	static inline void set_tsk_going_to_sched(struct task_struct *tsk)
>   1775	{
> > 1776		set_tsk_thread_flag(tsk, TIF_GOING_TO_SCHED);
>   1777	}
>   1778
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
