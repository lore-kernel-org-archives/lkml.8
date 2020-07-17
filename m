Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89892C433EC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 506232063A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgGQJZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 05:25:56 -0400
Received: from mga11.intel.com ([192.55.52.93]:23954 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbgGQJZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 05:25:48 -0400
IronPort-SDR: yr0wdHiUr4TrTjUhpUMWbEvHQ+q4YVS3TO3Y0nld5lB1SDz0V3RuwPn3wjg1Isv41SJmqYZIH9
 mr0lEvcB/EtQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="147545077"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="gz'50?scan'50,208,50";a="147545077"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 01:58:46 -0700
IronPort-SDR: RVeCLchsctiZTy/GGZqCoKY0Eaoru1+EYj8WWQ1Ut5+HS5ICkKiePXNIoE0O1t/R39GCD9vr7Q
 EGime163Bztw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="gz'50?scan'50,208,50";a="361293617"
Received: from lkp-server02.sh.intel.com (HELO 50058c6ee6fc) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 17 Jul 2020 01:58:43 -0700
Received: from kbuild by 50058c6ee6fc with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jwMCZ-0000Dc-2H; Fri, 17 Jul 2020 08:58:43 +0000
Date:   Fri, 17 Jul 2020 16:58:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/platforms/powernv/pci-ioda-tce.c:77:34: sparse: sparse:
 cast from restricted __be64
Message-ID: <202007171634.jwM1uf7b%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   07a56bb875afbe39dabbf6ba7b83783d166863db
commit: 56090a3902c80c296e822d11acdb6a101b322c52 powerpc/powernv/ioda: Fix race in TCE level allocation
date:   11 months ago
config: powerpc64-randconfig-s031-20200717 (attached as .config)
compiler: powerpc64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-49-g707c5017-dirty
        git checkout 56090a3902c80c296e822d11acdb6a101b322c52
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   arch/powerpc/platforms/powernv/pci-ioda-tce.c:196:45: sparse: sparse: cast to restricted __be64
>> arch/powerpc/platforms/powernv/pci-ioda-tce.c:77:34: sparse: sparse: cast from restricted __be64
>> arch/powerpc/platforms/powernv/pci-ioda-tce.c:77:34: sparse: sparse: cast from restricted __be64
   arch/powerpc/platforms/powernv/pci-ioda-tce.c:77:34: sparse: sparse: cast to restricted __be64

vim +77 arch/powerpc/platforms/powernv/pci-ioda-tce.c

    50	
    51	static void pnv_pci_ioda2_table_do_free_pages(__be64 *addr,
    52			unsigned long size, unsigned int levels);
    53	
    54	static __be64 *pnv_tce(struct iommu_table *tbl, bool user, long idx, bool alloc)
    55	{
    56		__be64 *tmp = user ? tbl->it_userspace : (__be64 *) tbl->it_base;
    57		int  level = tbl->it_indirect_levels;
    58		const long shift = ilog2(tbl->it_level_size);
    59		unsigned long mask = (tbl->it_level_size - 1) << (level * shift);
    60	
    61		while (level) {
    62			int n = (idx & mask) >> (level * shift);
    63			unsigned long oldtce, tce = be64_to_cpu(READ_ONCE(tmp[n]));
    64	
    65			if (!tce) {
    66				__be64 *tmp2;
    67	
    68				if (!alloc)
    69					return NULL;
    70	
    71				tmp2 = pnv_alloc_tce_level(tbl->it_nid,
    72						ilog2(tbl->it_level_size) + 3);
    73				if (!tmp2)
    74					return NULL;
    75	
    76				tce = __pa(tmp2) | TCE_PCI_READ | TCE_PCI_WRITE;
  > 77				oldtce = be64_to_cpu(cmpxchg(&tmp[n], 0,
    78						cpu_to_be64(tce)));
    79				if (oldtce) {
    80					pnv_pci_ioda2_table_do_free_pages(tmp2,
    81						ilog2(tbl->it_level_size) + 3, 1);
    82					tce = oldtce;
    83				}
    84			}
    85	
    86			tmp = __va(tce & ~(TCE_PCI_READ | TCE_PCI_WRITE));
    87			idx &= ~mask;
    88			mask >>= shift;
    89			--level;
    90		}
    91	
    92		return tmp + idx;
    93	}
    94	
    95	int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
    96			unsigned long uaddr, enum dma_data_direction direction,
    97			unsigned long attrs)
    98	{
    99		u64 proto_tce = iommu_direction_to_tce_perm(direction);
   100		u64 rpn = __pa(uaddr) >> tbl->it_page_shift;
   101		long i;
   102	
   103		if (proto_tce & TCE_PCI_WRITE)
   104			proto_tce |= TCE_PCI_READ;
   105	
   106		for (i = 0; i < npages; i++) {
   107			unsigned long newtce = proto_tce |
   108				((rpn + i) << tbl->it_page_shift);
   109			unsigned long idx = index - tbl->it_offset + i;
   110	
   111			*(pnv_tce(tbl, false, idx, true)) = cpu_to_be64(newtce);
   112		}
   113	
   114		return 0;
   115	}
   116	
   117	#ifdef CONFIG_IOMMU_API
   118	int pnv_tce_xchg(struct iommu_table *tbl, long index,
   119			unsigned long *hpa, enum dma_data_direction *direction,
   120			bool alloc)
   121	{
   122		u64 proto_tce = iommu_direction_to_tce_perm(*direction);
   123		unsigned long newtce = *hpa | proto_tce, oldtce;
   124		unsigned long idx = index - tbl->it_offset;
   125		__be64 *ptce = NULL;
   126	
   127		BUG_ON(*hpa & ~IOMMU_PAGE_MASK(tbl));
   128	
   129		if (*direction == DMA_NONE) {
   130			ptce = pnv_tce(tbl, false, idx, false);
   131			if (!ptce) {
   132				*hpa = 0;
   133				return 0;
   134			}
   135		}
   136	
   137		if (!ptce) {
   138			ptce = pnv_tce(tbl, false, idx, alloc);
   139			if (!ptce)
   140				return alloc ? H_HARDWARE : H_TOO_HARD;
   141		}
   142	
   143		if (newtce & TCE_PCI_WRITE)
   144			newtce |= TCE_PCI_READ;
   145	
   146		oldtce = be64_to_cpu(xchg(ptce, cpu_to_be64(newtce)));
   147		*hpa = oldtce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
   148		*direction = iommu_tce_direction(oldtce);
   149	
   150		return 0;
   151	}
   152	
   153	__be64 *pnv_tce_useraddrptr(struct iommu_table *tbl, long index, bool alloc)
   154	{
   155		if (WARN_ON_ONCE(!tbl->it_userspace))
   156			return NULL;
   157	
   158		return pnv_tce(tbl, true, index - tbl->it_offset, alloc);
   159	}
   160	#endif
   161	
   162	void pnv_tce_free(struct iommu_table *tbl, long index, long npages)
   163	{
   164		long i;
   165	
   166		for (i = 0; i < npages; i++) {
   167			unsigned long idx = index - tbl->it_offset + i;
   168			__be64 *ptce = pnv_tce(tbl, false, idx,	false);
   169	
   170			if (ptce)
   171				*ptce = cpu_to_be64(0);
   172		}
   173	}
   174	
   175	unsigned long pnv_tce_get(struct iommu_table *tbl, long index)
   176	{
   177		__be64 *ptce = pnv_tce(tbl, false, index - tbl->it_offset, false);
   178	
   179		if (!ptce)
   180			return 0;
   181	
   182		return be64_to_cpu(*ptce);
   183	}
   184	
   185	static void pnv_pci_ioda2_table_do_free_pages(__be64 *addr,
   186			unsigned long size, unsigned int levels)
   187	{
   188		const unsigned long addr_ul = (unsigned long) addr &
   189				~(TCE_PCI_READ | TCE_PCI_WRITE);
   190	
   191		if (levels) {
   192			long i;
   193			u64 *tmp = (u64 *) addr_ul;
   194	
   195			for (i = 0; i < size; ++i) {
 > 196				unsigned long hpa = be64_to_cpu(tmp[i]);
   197	
   198				if (!(hpa & (TCE_PCI_READ | TCE_PCI_WRITE)))
   199					continue;
   200	
   201				pnv_pci_ioda2_table_do_free_pages(__va(hpa), size,
   202						levels - 1);
   203			}
   204		}
   205	
   206		free_pages(addr_ul, get_order(size << 3));
   207	}
   208	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--qDbXVdCdHGoSgWSk
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICLNfEV8AAy5jb25maWcAjFxbc9w2sn7Pr5hyXnZrK1ldLDk+p/QAgiAHGZKAAXJG0gtK
lsdeVWTJR5ds8u9PN8ALAIJjb+1mM90NEGgA3V83Gvr5p59X5PXl8evNy93tzf3936sv+4f9
083L/tPq8939/n9XuVg1ol2xnLe/gnB19/D617+/Pf53//TtdnX26+mvR7883Z6sNvunh/39
ij4+fL778god3D0+/PTzT/Dfn4H49Rv09fQ/q77d+dtf7rGfX77c3q7+UVL6z9V77AmkqWgK
XhpKDdcGOBd/DyT4YbZMaS6ai/dHp0dHo2xFmnJkHXldrIk2RNemFK2YOuoZO6IaU5OrjJmu
4Q1vOan4Ncs9QdHoVnW0FUpPVK4+mJ1Qm4mSdbzKW14zwy5bklXMaKHaid+uFSO54U0h4B+m
JRobW9WUVtv3q+f9y+u3afo4HMOarSGqNBWveXtxeoKaHAZWSw6faZluV3fPq4fHF+xhEljD
95ia8XtuJSipBn29eZMiG9L5KrMzNJpUrSe/JltmNkw1rDLlNZeTuM+5vJ7oofA42lEyMdac
FaSrWrMWum1IzS7e/OPh8WH/z3EU+kpvufT2SU/A/6dt5X9HCs0vTf2hYx1Lqo0qobWpWS3U
lSFtS+g6MaROs4pnfsekg9ORkLR6IIqunQSOiFTVsPawkVbPrx+f/35+2X+d1r5kDVOc2n2m
12LnnYCIYyq2ZVWaX/NSkRYX2FsVlQNLG70zimnW5OGmZnkJO1hwEGzyiql0x3TtrzRSclET
3syla82RHwoXQlGW90eCN6W3bpIozcIW/odzlnVloa3e9w+fVo+fIw3GjeyJ3E5Kj9gU9vsG
FNi03uG2i4XWoeV0YzIlSE6Jbg+2PihWC206mZOWDcve3n3dPz2nVt5+UzQM1tbrqhFmfY1H
vraLOZ3xayPhGyLnNLH1XCsO6+i3cdSiq6qlJt524eUa94nVowr0PpuCd8YUY7VsobOGJb4x
sLei6pqWqKvgfDrmgWZUQKtBkVR2/25vnv9YvcBwVjcwtOeXm5fn1c3t7ePrw8vdw5dItdDA
EGr7cDtv/PKWqzZimwaOzzZtJ1LisOJJWdy6didOsokJZjqHSQrKwP6AYOsPLuaZ7WnyS+hX
dEtaneRKzUN6v5Y/oMXRH8KMuRbVYFfsKijarXRiL8OKGeBN+wl+gH+ELevtbR1I2DYRCec0
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
AQA=

--qDbXVdCdHGoSgWSk--
