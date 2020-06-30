Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74645C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E42D2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732927AbgF3LPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 07:15:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50896 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728534AbgF3LPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 07:15:33 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05UB1rg3194602;
        Tue, 30 Jun 2020 07:15:28 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31ycgduckf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 07:15:27 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05UBCnEJ027416;
        Tue, 30 Jun 2020 07:15:27 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31ycgducjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 07:15:26 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05UBAgqG022481;
        Tue, 30 Jun 2020 11:15:25 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 31wwcgsnvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 11:15:24 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05UBFMSc58130610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jun 2020 11:15:22 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A01C242057;
        Tue, 30 Jun 2020 11:15:22 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D27524206C;
        Tue, 30 Jun 2020 11:15:21 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.202.137])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 30 Jun 2020 11:15:21 +0000 (GMT)
Date:   Tue, 30 Jun 2020 14:15:19 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michal Simek <monstr@monstr.eu>
Subject: Re: ERROR: "min_low_pfn" undefined!
Message-ID: <20200630111519.GA1951986@linux.ibm.com>
References: <202006300524.y9r1ZSHI%lkp@intel.com>
 <alpine.DEB.2.22.394.2006291911220.1118534@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2006291911220.1118534@chino.kir.corp.google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-30_04:2020-06-30,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 cotscore=-2147483648 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 phishscore=0 spamscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006300077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(addde Michal)

On Mon, Jun 29, 2020 at 07:13:30PM -0700, David Rientjes wrote:
> On Tue, 30 Jun 2020, kernel test robot wrote:
> 
> > Hi Alexander,
> > 
> > FYI, the error/warning still remains.
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   7c30b859a947535f2213277e827d7ac7dcff9c84
> > commit: f220df66f67684246ae1bf4a4e479efc7c2f325a intel_th: msu-sink: An example msu buffer "sink"
> > date:   11 months ago
> > config: microblaze-randconfig-c023-20200629 (attached as .config)
> > compiler: microblaze-linux-gcc (GCC) 9.3.0
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    ERROR: "min_low_pfn" [drivers/rpmsg/virtio_rpmsg_bus.ko] undefined!
> > >> ERROR: "min_low_pfn" [drivers/hwtracing/intel_th/intel_th_msu_sink.ko] undefined!
> >    ERROR: "min_low_pfn" [drivers/hwtracing/intel_th/intel_th_msu.ko] undefined!
> >    ERROR: "min_low_pfn" [drivers/mmc/core/mmc_core.ko] undefined!
> >    ERROR: "min_low_pfn" [drivers/md/dm-crypt.ko] undefined!
> >    ERROR: "min_low_pfn" [drivers/net/wireless/ath/ath6kl/ath6kl_sdio.ko] undefined!
> >    ERROR: "min_low_pfn" [crypto/tcrypt.ko] undefined!
> >    ERROR: "min_low_pfn" [crypto/asymmetric_keys/asym_tpm.ko] undefined!
> > 
> 
> Looks like we have precedence for min_low_pfn failures and we can't blame 
> this poor commit :)

This commit only added a new occurence of this error :)
It seems that the problem is caused by nommu defintion of pfn_valid() in
microblaze:

define pfn_valid(pfn)       (((pfn) >= min_low_pfn) && \
			       ((pfn) <= (min_low_pfn + max_mapnr)))

but I could not reproduce the error with nommu_defconfig. 

> I wonder why we don't simply do EXPORT_SYMBOL() in mm/memblock.c, 
> non-microblaze architectures do this themselves because it doesn't get 
> generically exported:

> arch/ia64/kernel/ia64_ksyms.c:EXPORT_SYMBOL(min_low_pfn);       /* defined by bootmem.c, but not exported by generic code */
> arch/sh/kernel/sh_ksyms_32.c:EXPORT_SYMBOL(min_low_pfn);
 
I think we can do better than that. The below patch is build-tested
only.

From 86d21c2c2e6a859400a3319dc21ba9b35d126539 Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.ibm.com>
Date: Tue, 30 Jun 2020 13:37:53 +0300
Subject: [PATCH] microblaze: cleanup memory start aliases

There are several variables that have the same meaning and value, but they
are used with different configuration options:

- memory_start - "main memory where the kernel is"
- __page_offset - an alias for memory_start disguised as PAGE_OFFSET fot
  no-MMU case
- min_low_pfn - a legacy from i386 memory layout weirdness, an alias for
  (memory_start >> PAGE_SHIFT)

Since there are "different" variables that point to the start of the
memory, MMU and no-MMU variants of pfn_valid() and ARCH_PFN_OFFSET used
memory_start and __page_offset with min_low_pfn respectively.

Use memory_start for both MMU and no-MMU versions of pfn_valid() and
ARCH_PFN_OFFSET and get rid of __page_offset entirely.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/microblaze/include/asm/page.h | 18 ++++--------------
 arch/microblaze/mm/init.c          |  1 -
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/microblaze/include/asm/page.h b/arch/microblaze/include/asm/page.h
index b13463d39b38..d664c437b377 100644
--- a/arch/microblaze/include/asm/page.h
+++ b/arch/microblaze/include/asm/page.h
@@ -50,8 +50,7 @@
  * using MMU this corresponds to the first free page in physical memory (aligned
  * on a page boundary).
  */
-extern unsigned int __page_offset;
-#define PAGE_OFFSET __page_offset
+#define PAGE_OFFSET memory_start
 
 #else /* CONFIG_MMU */
 
@@ -124,10 +123,6 @@ typedef struct { p4d_t		pge[1]; }	pgd_t;
  *
  */
 
-extern unsigned long max_low_pfn;
-extern unsigned long min_low_pfn;
-extern unsigned long max_pfn;
-
 extern unsigned long memory_start;
 extern unsigned long memory_size;
 extern unsigned long lowmem_size;
@@ -156,14 +151,9 @@ extern int page_is_ram(unsigned long pfn);
 #  define phys_to_page(paddr)	(pfn_to_page(phys_to_pfn(paddr)))
 #  endif /* CONFIG_MMU */
 
-#  ifndef CONFIG_MMU
-#  define pfn_valid(pfn)	(((pfn) >= min_low_pfn) && \
-				((pfn) <= (min_low_pfn + max_mapnr)))
-#  define ARCH_PFN_OFFSET	(PAGE_OFFSET >> PAGE_SHIFT)
-#  else /* CONFIG_MMU */
-#  define ARCH_PFN_OFFSET	(memory_start >> PAGE_SHIFT)
-#  define pfn_valid(pfn)	((pfn) < (max_mapnr + ARCH_PFN_OFFSET))
-#  endif /* CONFIG_MMU */
+#define ARCH_PFN_OFFSET	(memory_start >> PAGE_SHIFT)
+#define pfn_valid(pfn)	(((pfn) >= ARCH_PFN_OFFSET) && \
+			 ((pfn) < (ARCH_PFN_OFFSET + max_mapnr)))
 
 # endif /* __ASSEMBLY__ */
 
diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index 521b59ba716c..0ddc5fcc55c2 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -117,7 +117,6 @@ void __init setup_memory(void)
 		if ((memory_start <= (u32)_text) &&
 			((u32)_text <= (memory_start + lowmem_size - 1))) {
 			memory_size = lowmem_size;
-			PAGE_OFFSET = memory_start;
 			pr_info("%s: Main mem: 0x%x, size 0x%08x\n",
 				__func__, (u32) memory_start,
 					(u32) memory_size);
-- 
2.26.2

-- 
Sincerely yours,
Mike.
