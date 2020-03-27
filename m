Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C94FC2D0ED
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 06:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E45420717
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 06:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgC0GG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 02:06:29 -0400
Received: from mga06.intel.com ([134.134.136.31]:50360 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbgC0GG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 02:06:29 -0400
IronPort-SDR: C0ZSgax653oe9kIuBcNBmjjb5sOBGrLvpXa6HdQay0mrVkeTpBQHn3s1cTKPiXhZEXTXLqYYWU
 nAfNOe9PJKbQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2020 23:06:28 -0700
IronPort-SDR: i81oI8iFE4asEVqdiQqz6xgD0glVRrwUJ1v2RDiFw0ucB0TmMWeEDrp4K9EbwvXVGvMnbRPRfk
 o6J7Ce52yaZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,311,1580803200"; 
   d="scan'208";a="239012996"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 26 Mar 2020 23:06:24 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jHi8N-0004vo-Lh; Fri, 27 Mar 2020 14:06:23 +0800
Date:   Fri, 27 Mar 2020 14:05:33 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Alexander Graf <graf@amazon.com>
Cc:     kbuild-all@lists.01.org,
        "iommu@lists.linux-foundation.org, Konrad Rzeszutek Wilk" 
        <konrad.wilk@oracle.com>, x86@kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        dwmw@amazon.com, benh@amazon.com,
        Jan Kiszka <jan.kiszka@siemens.com>, alcioa@amazon.com,
        aggh@amazon.com, aagch@amazon.com, dhr@amazon.com
Subject: Re: [PATCH] swiotlb: Allow swiotlb to live at pre-defined address
Message-ID: <202003271409.zBJrGfB4%lkp@intel.com>
References: <20200326162922.27085-1-graf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326162922.27085-1-graf@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on swiotlb/linux-next tip/x86/core v5.6-rc7 next-20200326]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Alexander-Graf/swiotlb-Allow-swiotlb-to-live-at-pre-defined-address/20200327-062125
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 9420e8ade4353a6710908ffafa23ecaf1caa0123
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-187-gbff9b106-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   kernel/dma/swiotlb.c:97:14: sparse: sparse: symbol 'max_segment' was not declared. Should it be static?
>> kernel/dma/swiotlb.c:143:53: sparse: sparse: incorrect type in argument 3 (different base types) @@    expected unsigned long *res @@    got  long *res @@
>> kernel/dma/swiotlb.c:143:53: sparse:    expected unsigned long *res
>> kernel/dma/swiotlb.c:143:53: sparse:    got char **
>> kernel/dma/swiotlb.c:268:16: sparse: sparse: incorrect type in assignment (different address spaces) @@    expected unsigned char [noderef] <asn:2> *vstart @@    got n:2> *vstart @@
>> kernel/dma/swiotlb.c:268:16: sparse:    expected unsigned char [noderef] <asn:2> *vstart
>> kernel/dma/swiotlb.c:268:16: sparse:    got void *
>> kernel/dma/swiotlb.c:272:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char *tlb @@    got unsigned char [noderef] <aschar *tlb @@
>> kernel/dma/swiotlb.c:272:35: sparse:    expected char *tlb
>> kernel/dma/swiotlb.c:272:35: sparse:    got unsigned char [noderef] <asn:2> *vstart
>> kernel/dma/swiotlb.c:273:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void *addr @@    got unsigned char [noderef] <asvoid *addr @@
>> kernel/dma/swiotlb.c:273:26: sparse:    expected void *addr
   kernel/dma/swiotlb.c:273:26: sparse:    got unsigned char [noderef] <asn:2> *vstart

vim +143 kernel/dma/swiotlb.c

   118	
   119	static int __init
   120	setup_io_tlb_npages(char *str)
   121	{
   122		if (isdigit(*str)) {
   123			io_tlb_nslabs = simple_strtoul(str, &str, 0);
   124			/* avoid tail segment of size < IO_TLB_SEGSIZE */
   125			io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
   126		}
   127		if (*str == ',')
   128			++str;
   129		if (!strncmp(str, "force", 5)) {
   130			swiotlb_force = SWIOTLB_FORCE;
   131			str += 5;
   132		} else if (!strncmp(str, "noforce", 7)) {
   133			swiotlb_force = SWIOTLB_NO_FORCE;
   134			io_tlb_nslabs = 1;
   135			str += 7;
   136		}
   137	
   138		if (*str == ',')
   139			++str;
   140		if (!strncmp(str, "addr=", 5)) {
   141			char *addrstr = str + 5;
   142	
 > 143			io_tlb_addr = kstrtoul(addrstr, 0, &str);
   144			if (addrstr == str)
   145				io_tlb_addr = INVALID_PHYS_ADDR;
   146		}
   147	
   148		return 0;
   149	}
   150	early_param("swiotlb", setup_io_tlb_npages);
   151	
   152	static bool no_iotlb_memory;
   153	
   154	unsigned long swiotlb_nr_tbl(void)
   155	{
   156		return unlikely(no_iotlb_memory) ? 0 : io_tlb_nslabs;
   157	}
   158	EXPORT_SYMBOL_GPL(swiotlb_nr_tbl);
   159	
   160	unsigned int swiotlb_max_segment(void)
   161	{
   162		return unlikely(no_iotlb_memory) ? 0 : max_segment;
   163	}
   164	EXPORT_SYMBOL_GPL(swiotlb_max_segment);
   165	
   166	void swiotlb_set_max_segment(unsigned int val)
   167	{
   168		if (swiotlb_force == SWIOTLB_FORCE)
   169			max_segment = 1;
   170		else
   171			max_segment = rounddown(val, PAGE_SIZE);
   172	}
   173	
   174	/* default to 64MB */
   175	#define IO_TLB_DEFAULT_SIZE (64UL<<20)
   176	unsigned long swiotlb_size_or_default(void)
   177	{
   178		unsigned long size;
   179	
   180		size = io_tlb_nslabs << IO_TLB_SHIFT;
   181	
   182		return size ? size : (IO_TLB_DEFAULT_SIZE);
   183	}
   184	
   185	void swiotlb_print_info(void)
   186	{
   187		unsigned long bytes = io_tlb_nslabs << IO_TLB_SHIFT;
   188	
   189		if (no_iotlb_memory) {
   190			pr_warn("No low mem\n");
   191			return;
   192		}
   193	
   194		pr_info("mapped [mem %#010llx-%#010llx] (%luMB)\n",
   195		       (unsigned long long)io_tlb_start,
   196		       (unsigned long long)io_tlb_end,
   197		       bytes >> 20);
   198	}
   199	
   200	/*
   201	 * Early SWIOTLB allocation may be too early to allow an architecture to
   202	 * perform the desired operations.  This function allows the architecture to
   203	 * call SWIOTLB when the operations are possible.  It needs to be called
   204	 * before the SWIOTLB memory is used.
   205	 */
   206	void __init swiotlb_update_mem_attributes(void)
   207	{
   208		void *vaddr;
   209		unsigned long bytes;
   210	
   211		if (no_iotlb_memory || late_alloc)
   212			return;
   213	
   214		vaddr = phys_to_virt(io_tlb_start);
   215		bytes = PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT);
   216		set_memory_decrypted((unsigned long)vaddr, bytes >> PAGE_SHIFT);
   217		memset(vaddr, 0, bytes);
   218	}
   219	
   220	int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
   221	{
   222		unsigned long i, bytes;
   223		size_t alloc_size;
   224	
   225		bytes = nslabs << IO_TLB_SHIFT;
   226	
   227		io_tlb_nslabs = nslabs;
   228		io_tlb_start = __pa(tlb);
   229		io_tlb_end = io_tlb_start + bytes;
   230	
   231		/*
   232		 * Allocate and initialize the free list array.  This array is used
   233		 * to find contiguous free memory regions of size up to IO_TLB_SEGSIZE
   234		 * between io_tlb_start and io_tlb_end.
   235		 */
   236		alloc_size = PAGE_ALIGN(io_tlb_nslabs * sizeof(int));
   237		io_tlb_list = memblock_alloc(alloc_size, PAGE_SIZE);
   238		if (!io_tlb_list)
   239			panic("%s: Failed to allocate %zu bytes align=0x%lx\n",
   240			      __func__, alloc_size, PAGE_SIZE);
   241	
   242		alloc_size = PAGE_ALIGN(io_tlb_nslabs * sizeof(phys_addr_t));
   243		io_tlb_orig_addr = memblock_alloc(alloc_size, PAGE_SIZE);
   244		if (!io_tlb_orig_addr)
   245			panic("%s: Failed to allocate %zu bytes align=0x%lx\n",
   246			      __func__, alloc_size, PAGE_SIZE);
   247	
   248		for (i = 0; i < io_tlb_nslabs; i++) {
   249			io_tlb_list[i] = IO_TLB_SEGSIZE - OFFSET(i, IO_TLB_SEGSIZE);
   250			io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
   251		}
   252		io_tlb_index = 0;
   253	
   254		if (verbose)
   255			swiotlb_print_info();
   256	
   257		swiotlb_set_max_segment(io_tlb_nslabs << IO_TLB_SHIFT);
   258		return 0;
   259	}
   260	
   261	static int __init swiotlb_init_io(int verbose, unsigned long bytes)
   262	{
   263		unsigned __iomem char *vstart;
   264	
   265		if (io_tlb_addr == INVALID_PHYS_ADDR)
   266			return -EINVAL;
   267	
 > 268		vstart = memremap(io_tlb_addr, bytes, MEMREMAP_WB);
   269		if (!vstart)
   270			return -EINVAL;
   271	
 > 272		if (swiotlb_init_with_tbl(vstart, io_tlb_nslabs, verbose)) {
 > 273			memunmap(vstart);
   274			return -EINVAL;
   275		}
   276	
   277		return 0;
   278	}
   279	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
