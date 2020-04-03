Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA03C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 11:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371E320857
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 11:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390810AbgDCL35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 07:29:57 -0400
Received: from mga07.intel.com ([134.134.136.100]:30646 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389188AbgDCL3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 07:29:54 -0400
IronPort-SDR: koMvlJg3xLff50WYA1PpC/Rh+NDWk5mcieBzxvz5y5uUSV3IhILgh0HSJ9nLvZm/Rsl6ro3IHx
 lq5B/nNVHlgg==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 04:29:53 -0700
IronPort-SDR: RnVJJy+qqzT/8x0ylbnWQuE5qe5ateKSie0Fg3Uh2rDUVV1nDU2hopFVZ1skJxuBmjpL5OTiPE
 3bRx1pQXHyPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,339,1580803200"; 
   d="gz'50?scan'50,208,50";a="449998820"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 03 Apr 2020 04:29:49 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jKKWC-0005Gs-Uv; Fri, 03 Apr 2020 19:29:48 +0800
Date:   Fri, 3 Apr 2020 19:29:37 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org, Kenneth R. Crudup " <kenny@panix.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 1/2] x86,module: Detect VMX modules and disable
 Split-Lock-Detect
Message-ID: <202004031956.TbiHolcZ%lkp@intel.com>
References: <20200402124205.242674296@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <20200402124205.242674296@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Thomas,

I love your patch! Yet something to improve:

[auto build test ERROR on tip/auto-latest]
[also build test ERROR on next-20200403]
[cannot apply to jeyu/modules-next tip/x86/core v5.6]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Thomas-Gleixner/x86-Prevent-Split-Lock-Detection-wreckage-on-VMX-hypervisors/20200403-171430
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ee8bac724cc7767dcf9480afb656318994f22c3d
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=um SUBARCH=x86_64

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   /usr/bin/ld: arch/x86/um/../kernel/module.o: in function `module_finalize':
>> module.c:(.text+0x315): undefined reference to `split_lock_validate_module_text'
>> collect2: error: ld returned 1 exit status
--
   In file included from arch/x86/um/../kernel/module.c:27:0:
>> arch/x86/include/asm/cpu.h:38:31: warning: 'struct cpuinfo_x86' declared inside parameter list will not be visible outside of this definition or declaration
    int mwait_usable(const struct cpuinfo_x86 *);
                                  ^~~~~~~~~~~
   arch/x86/include/asm/cpu.h:44:49: warning: 'struct cpuinfo_x86' declared inside parameter list will not be visible outside of this definition or declaration
    extern void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c);
                                                    ^~~~~~~~~~~

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--0F1p//8PRICkK4MW
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
5TUrhAUoGXs8ti7uDY84bQD9Hx9mEoU/gwAA

--0F1p//8PRICkK4MW--
