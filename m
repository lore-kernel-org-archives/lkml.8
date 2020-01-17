Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82ECDC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 08:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 409B22082F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 08:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbgAQI0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 03:26:55 -0500
Received: from mga07.intel.com ([134.134.136.100]:16311 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbgAQI0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 03:26:54 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 00:23:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,329,1574150400"; 
   d="gz'50?scan'50,208,50";a="261796643"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 17 Jan 2020 00:23:41 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1isMuq-000CHD-RB; Fri, 17 Jan 2020 16:23:40 +0800
Date:   Fri, 17 Jan 2020 16:23:16 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     kbuild-all@lists.01.org, Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] reboot: support hotplug CPUs before reboot
Message-ID: <202001171053.CKH0lPCU%lkp@intel.com>
References: <20200114063056.98368-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ucnengkl2am5kktf"
Content-Disposition: inline
In-Reply-To: <20200114063056.98368-1-hsinyi@chromium.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ucnengkl2am5kktf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Hsin-Yi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20200110]
[also build test ERROR on v5.5-rc6]
[cannot apply to arm64/for-next/core arm/for-next ia64/next hp-parisc/for-next powerpc/next s390/features sparc/master tip/x86/core linus/master sparc-next/master v5.5-rc6 v5.5-rc5 v5.5-rc4]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Hsin-Yi-Wang/reboot-support-hotplug-CPUs-before-reboot/20200114-143340
base:    6c09d7dbb7d366122d0218bc7487e0a1e6cca6ed
config: powerpc-rhel-kconfig (attached as .config)
compiler: powerpc64le-linux-gcc (GCC) 7.5.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.5.0 make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/cpu.c:1286:6: error: redefinition of 'enable_nonboot_cpus'
    void enable_nonboot_cpus(void)
         ^~~~~~~~~~~~~~~~~~~
   In file included from kernel/cpu.c:16:0:
   include/linux/cpu.h:167:20: note: previous definition of 'enable_nonboot_cpus' was here
    static inline void enable_nonboot_cpus(void) {}
                       ^~~~~~~~~~~~~~~~~~~

vim +/enable_nonboot_cpus +1286 kernel/cpu.c

d0af9eed5aa91b Suresh Siddha     2009-08-19  1285  
71cf5aeeb8e215 Mathias Krause    2015-07-19 @1286  void enable_nonboot_cpus(void)
e3920fb42c8ddf Rafael J. Wysocki 2006-09-25  1287  {
e3920fb42c8ddf Rafael J. Wysocki 2006-09-25  1288  	int cpu, error;
e3920fb42c8ddf Rafael J. Wysocki 2006-09-25  1289  
e3920fb42c8ddf Rafael J. Wysocki 2006-09-25  1290  	/* Allow everyone to use the CPU hotplug again */
d221938c049f48 Gautham R Shenoy  2008-01-25  1291  	cpu_maps_update_begin();
01b41159066531 Lianwei Wang      2016-06-09  1292  	__cpu_hotplug_enable();
e0b582ec56f1a1 Rusty Russell     2009-01-01  1293  	if (cpumask_empty(frozen_cpus))
1d64b9cb1dc2a7 Rafael J. Wysocki 2007-04-01  1294  		goto out;
e3920fb42c8ddf Rafael J. Wysocki 2006-09-25  1295  
84117da5b79ffb Fabian Frederick  2014-06-04  1296  	pr_info("Enabling non-boot CPUs ...\n");
d0af9eed5aa91b Suresh Siddha     2009-08-19  1297  
d0af9eed5aa91b Suresh Siddha     2009-08-19  1298  	arch_enable_nonboot_cpus_begin();
d0af9eed5aa91b Suresh Siddha     2009-08-19  1299  
e0b582ec56f1a1 Rusty Russell     2009-01-01  1300  	for_each_cpu(cpu, frozen_cpus) {
bb3632c6101b2f Todd E Brandt     2014-06-06  1301  		trace_suspend_resume(TPS("CPU_ON"), cpu, true);
af1f40457da6f7 Thomas Gleixner   2016-02-26  1302  		error = _cpu_up(cpu, 1, CPUHP_ONLINE);
bb3632c6101b2f Todd E Brandt     2014-06-06  1303  		trace_suspend_resume(TPS("CPU_ON"), cpu, false);
e3920fb42c8ddf Rafael J. Wysocki 2006-09-25  1304  		if (!error) {
84117da5b79ffb Fabian Frederick  2014-06-04  1305  			pr_info("CPU%d is up\n", cpu);
e3920fb42c8ddf Rafael J. Wysocki 2006-09-25  1306  			continue;
e3920fb42c8ddf Rafael J. Wysocki 2006-09-25  1307  		}
84117da5b79ffb Fabian Frederick  2014-06-04  1308  		pr_warn("Error taking CPU%d up: %d\n", cpu, error);
e3920fb42c8ddf Rafael J. Wysocki 2006-09-25  1309  	}
d0af9eed5aa91b Suresh Siddha     2009-08-19  1310  
d0af9eed5aa91b Suresh Siddha     2009-08-19  1311  	arch_enable_nonboot_cpus_end();
d0af9eed5aa91b Suresh Siddha     2009-08-19  1312  
e0b582ec56f1a1 Rusty Russell     2009-01-01  1313  	cpumask_clear(frozen_cpus);
1d64b9cb1dc2a7 Rafael J. Wysocki 2007-04-01  1314  out:
d221938c049f48 Gautham R Shenoy  2008-01-25  1315  	cpu_maps_update_done();
^1da177e4c3f41 Linus Torvalds    2005-04-16  1316  }
e0b582ec56f1a1 Rusty Russell     2009-01-01  1317  

:::::: The code at line 1286 was first introduced by commit
:::::: 71cf5aeeb8e2154efda5f40be50c925f15057755 kernel, cpu: Remove bogus __ref annotations

:::::: TO: Mathias Krause <minipli@googlemail.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--ucnengkl2am5kktf
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
RYK0FJVOQfa3CN5iB4F/AHkWfpt97wAA

--ucnengkl2am5kktf--
