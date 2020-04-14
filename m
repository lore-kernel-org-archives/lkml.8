Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5C1C2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 00:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E430E2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 00:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390406AbgDNAVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 20:21:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:51536 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727878AbgDNAVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 20:21:41 -0400
IronPort-SDR: T8vmkwGjE+40wTPHjCHyiEiaHgNHJJM2fTwQzw0Awx7/mH+hPqM/1YE59sq2e+30K1z1jzB3Kk
 nbZ7Mo26Xaow==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 17:21:36 -0700
IronPort-SDR: 1b21HcODtVCfDHG4IeMHFNm64QaxLDrSSDc66HxRJkjAdsIDnuoG5aAdnaHcIr3J1/VGPJXS3z
 eoyrATMfPtNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,380,1580803200"; 
   d="gz'50?scan'50,208,50";a="298552079"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Apr 2020 17:21:34 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jO9KY-000AGK-54; Tue, 14 Apr 2020 08:21:34 +0800
Date:   Tue, 14 Apr 2020 08:20:43 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 5/5] RISC-V: Add EFI stub support.
Message-ID: <202004140827.fIxyYP7R%lkp@intel.com>
References: <20200413212907.29244-6-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <20200413212907.29244-6-atish.patra@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Atish,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.7-rc1 next-20200413]
[cannot apply to efi/next arm/for-next arm64/for-next/core linux/master]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Atish-Patra/Add-UEFI-support-for-RISC-V/20200414-053224
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 8f3d9f354286745c751374f5f1fcafee6b3f3136
config: riscv-nommu_virt_defconfig (attached as .config)
compiler: riscv64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=9.3.0 make.cross ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/firmware/efi/earlycon.c: In function 'efi_earlycon_map':
>> drivers/firmware/efi/earlycon.c:59:34: error: implicit declaration of function 'pgprot_writecombine' [-Werror=implicit-function-declaration]
      59 |  fb_prot = fb_wb ? PAGE_KERNEL : pgprot_writecombine(PAGE_KERNEL);
         |                                  ^~~~~~~~~~~~~~~~~~~
>> drivers/firmware/efi/earlycon.c:59:32: error: type mismatch in conditional expression
      59 |  fb_prot = fb_wb ? PAGE_KERNEL : pgprot_writecombine(PAGE_KERNEL);
         |                                ^
   cc1: some warnings being treated as errors
--
   drivers/firmware/efi/libstub/riscv-stub.c: In function 'efi_enter_kernel':
>> drivers/firmware/efi/libstub/riscv-stub.c:64:33: warning: initialization makes '__attribute__((noreturn))' qualified function pointer from unqualified [-Wdiscarded-qualifiers]
      64 |  jump_kernel_func jump_kernel = (void (*)(unsigned int, unsigned long))kernel_entry;
         |                                 ^

vim +64 drivers/firmware/efi/libstub/riscv-stub.c

    53	
    54	/*
    55	 * Jump to real kernel here with following constraints.
    56	 * 1. MMU should be disabled.
    57	 * 2. a0 should contain hartid
    58	 * 3. a1 should DT address
    59	 */
    60	void __noreturn efi_enter_kernel(unsigned long entrypoint, unsigned long fdt,
    61					 unsigned long fdt_size)
    62	{
    63		unsigned long kernel_entry = entrypoint + (unsigned long)stext_offset;
  > 64		jump_kernel_func jump_kernel = (void (*)(unsigned int, unsigned long))kernel_entry;
    65		u32 hartid = get_boot_hartid_from_fdt(fdt);
    66	
    67		if (hartid == U32_MAX)
    68			/* We can not use panic or BUG at this point */
    69			__asm__ __volatile__ ("ebreak");
    70		/* Disable MMU */
    71		csr_write(CSR_SATP, 0);
    72		jump_kernel(hartid, fdt);
    73	}
    74	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--Nq2Wo0NMKNjxTN9z
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--Nq2Wo0NMKNjxTN9z--
