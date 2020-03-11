Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MENTIONS_GIT_HOSTING,PDS_HP_HELO_NORDNS,RDNS_NONE,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail-vi1eur05on2082.outbound.protection.outlook.com ([40.107.21.82]:37057
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726160AbgCKFx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 01:53:58 -0400
Date: Wed, 11 Mar 2020 11:23:39 +0530
From: Calvin Johnson <calvin.johnson@oss.nxp.com>
To: dan.carpenter@oracle.com
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ajay Gupta <ajayg@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Iyappan Subramanian <iyappan@os.amperecomputing.com>,
        Keyur Chudgar <keyur@os.amperecomputing.com>,
        Quan Nguyen <quan@os.amperecomputing.com>,
        Steve Glendinning <steve.glendinning@shawell.net>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com"
        <linux-stm32@st-md-mailman.stormreply.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH net] device property: change device_get_phy_mode() to
 prevent signedess bugs
Message-ID: <20200311055339.GA22511@lsv03152.swis.in-blr01.nxp.com>
References: <20200131045953.wbj66jkvijnmf5s2@kili.mountain>
 <202002031247.fhmzF9z1%lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202002031247.fhmzF9z1%lkp@intel.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
Message-ID: <20200311055339.EbgN2-YVxQVzHOhupo2FJeW6s77vv04JqgLTWHchhNo@z>

Hi Dan,

Do you plan to send v2 of this patch set?
https://lkml.org/lkml/2020/1/31/1
I'm preparing my patch set on top of this. Hence the query.

Thanks
Calvin

On Mon, Feb 03, 2020 at 05:11:49AM +0000, kbuild test robot wrote:
> Hi Dan,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on net/master]
> [also build test WARNING on driver-core/driver-core-testing linus/master v5.5 next-20200131]
> [cannot apply to sparc-next/master]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Dan-Carpenter/device-property-change-device_get_phy_mode-to-prevent-signedess-bugs/20200203-043126
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git b7c3a17c6062701d97a0959890a2c882bfaac537
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.1-154-g1dc00f87-dirty
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
> 
>    arch/x86/boot/compressed/cmdline.c:5:20: sparse: sparse: multiple definitions for function 'set_fs'
> >> arch/x86/include/asm/uaccess.h:29:20: sparse:  the previous one is here
>    arch/x86/boot/compressed/../cmdline.c:28:5: sparse: sparse: symbol '__cmdline_find_option' was not declared. Should it be static?
>    arch/x86/boot/compressed/../cmdline.c:100:5: sparse: sparse: symbol '__cmdline_find_option_bool' was not declared. Should it be static?
> 
> vim +29 arch/x86/include/asm/uaccess.h
> 
> ca23386216b9d4 include/asm-x86/uaccess.h      Glauber Costa   2008-06-13  27  
> 13d4ea097d18b4 arch/x86/include/asm/uaccess.h Andy Lutomirski 2016-07-14  28  #define get_fs()	(current->thread.addr_limit)
> 5ea0727b163cb5 arch/x86/include/asm/uaccess.h Thomas Garnier  2017-06-14 @29  static inline void set_fs(mm_segment_t fs)
> 5ea0727b163cb5 arch/x86/include/asm/uaccess.h Thomas Garnier  2017-06-14  30  {
> 5ea0727b163cb5 arch/x86/include/asm/uaccess.h Thomas Garnier  2017-06-14  31  	current->thread.addr_limit = fs;
> 5ea0727b163cb5 arch/x86/include/asm/uaccess.h Thomas Garnier  2017-06-14  32  	/* On user-mode return, check fs is correct */
> 5ea0727b163cb5 arch/x86/include/asm/uaccess.h Thomas Garnier  2017-06-14  33  	set_thread_flag(TIF_FSCHECK);
> 5ea0727b163cb5 arch/x86/include/asm/uaccess.h Thomas Garnier  2017-06-14  34  }
> ca23386216b9d4 include/asm-x86/uaccess.h      Glauber Costa   2008-06-13  35  
> 
> :::::: The code at line 29 was first introduced by commit
> :::::: 5ea0727b163cb5575e36397a12eade68a1f35f24 x86/syscalls: Check address limit on user-mode return
> 
> :::::: TO: Thomas Garnier <thgarnie@google.com>
> :::::: CC: Thomas Gleixner <tglx@linutronix.de>
> 
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

