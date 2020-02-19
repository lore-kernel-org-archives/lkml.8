Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5338BC34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 01:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2281A2465A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 01:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgBSBPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 20:15:22 -0500
Received: from mga18.intel.com ([134.134.136.126]:21223 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbgBSBPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 20:15:21 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 17:15:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,458,1574150400"; 
   d="gz'50?scan'50,208,50";a="228460856"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 18 Feb 2020 17:15:18 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j4DxN-000CmA-OS; Wed, 19 Feb 2020 09:15:17 +0800
Date:   Wed, 19 Feb 2020 09:14:48 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     kbuild-all@lists.01.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] mm/vma: Replace all remaining open encodings with
 is_vm_hugetlb_page()
Message-ID: <202002190954.rWlsTEwn%lkp@intel.com>
References: <1581915833-21984-4-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <1581915833-21984-4-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Anshuman,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on mmotm/master]
[also build test ERROR on tip/perf/core m68k/for-next powerpc/next tip/sched/core char-misc/char-misc-testing linux/master linus/master tip/x86/mm asm-generic/master v5.6-rc2 next-20200218]
[cannot apply to kvm-ppc/kvm-ppc-next]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Anshuman-Khandual/mm-vma-Use-available-wrappers-when-possible/20200219-065223
base:   git://git.cmpxchg.org/linux-mmotm.git master
config: nds32-allnoconfig (attached as .config)
compiler: nds32le-linux-gcc (GCC) 9.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=9.2.0 make.cross ARCH=nds32 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/nds32/include/asm/tlb.h:7,
                    from arch/nds32/mm/init.c:18:
   include/asm-generic/tlb.h: In function 'tlb_update_vma_flags':
>> include/asm-generic/tlb.h:382:18: error: implicit declaration of function 'is_vm_hugetlb_page' [-Werror=implicit-function-declaration]
     382 |  tlb->vma_huge = is_vm_hugetlb_page(vma);
         |                  ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/is_vm_hugetlb_page +382 include/asm-generic/tlb.h

   367	
   368	static inline void
   369	tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma)
   370	{
   371		/*
   372		 * flush_tlb_range() implementations that look at VM_HUGETLB (tile,
   373		 * mips-4k) flush only large pages.
   374		 *
   375		 * flush_tlb_range() implementations that flush I-TLB also flush D-TLB
   376		 * (tile, xtensa, arm), so it's ok to just add VM_EXEC to an existing
   377		 * range.
   378		 *
   379		 * We rely on tlb_end_vma() to issue a flush, such that when we reset
   380		 * these values the batch is empty.
   381		 */
 > 382		tlb->vma_huge = is_vm_hugetlb_page(vma);
   383		tlb->vma_exec = !!(vma->vm_flags & VM_EXEC);
   384	}
   385	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--IS0zKkzwUGydFO0o
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--IS0zKkzwUGydFO0o--
