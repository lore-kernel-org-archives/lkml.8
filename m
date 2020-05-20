Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6F8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 13:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02AC42070A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 13:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgETNUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 09:20:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49754 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726486AbgETNUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 09:20:17 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04KD40Zn110410;
        Wed, 20 May 2020 09:20:12 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 312cqpcwuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 May 2020 09:20:12 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04KDIPS8007375;
        Wed, 20 May 2020 13:20:10 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 313xehkpx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 May 2020 13:20:10 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04KDK88J54198456
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 May 2020 13:20:08 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24A74A405F;
        Wed, 20 May 2020 13:20:08 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8280BA4054;
        Wed, 20 May 2020 13:20:07 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.206.2])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 20 May 2020 13:20:07 +0000 (GMT)
Date:   Wed, 20 May 2020 16:20:05 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: arch/sparc/mm/srmmu.c:300:9: error: variable 'pud' set but not
 used
Message-ID: <20200520132005.GM1059226@linux.ibm.com>
References: <20200520005733.GB3101@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520005733.GB3101@intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-20_09:2020-05-19,2020-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 cotscore=-2147483648
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005200113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 08:57:33AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   642b151f45dd54809ea00ecd3976a56c1ec9b53d
> commit: 7235db268a2777bc380b99b7db49ff7b19c8fb76 sparc32: use pgtable-nopud instead of 4level-fixup
> config: sparc-defconfig (attached as .config)
> compiler: sparc-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 7235db268a2777bc380b99b7db49ff7b19c8fb76
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=sparc
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> arch/sparc/mm/srmmu.c: In function 'srmmu_nocache_init':
> >> arch/sparc/mm/srmmu.c:300:9: error: variable 'pud' set but not used [-Werror=unused-but-set-variable]
> 300 |  pud_t *pud;
> |         ^~~

Here's the fix vs v5.7-rc6-mmots-2020-05-19-21-52:

From 192848144e61e3ebacd34598386e4fa773d19ae9 Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.ibm.com>
Date: Wed, 20 May 2020 15:39:22 +0300
Subject: [PATCH] sparc32: use PUD rather than PGD to get PMD in
 srmmu_nocache_init()

The kbuild test robot reported the following warning:

arch/sparc/mm/srmmu.c: In function 'srmmu_nocache_init':
>> arch/sparc/mm/srmmu.c:300:9: error: variable 'pud' set but not used
>> [-Werror=unused-but-set-variable]
300 |  pud_t *pud;

This warning is caused by misprint in the page table traversal in
srmmu_nocache_init() function which accessed a PMD entry using PGD rather
than PUD.
Since sparc32 has only 3 page table levels, the PGD and PUD are essentially
the same and usage of __nocache_fix() removed the type checking.

Use PUD for the consistency and to silence the compiler warning.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/sparc/mm/srmmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 6cb1ea2d2b5c..75b56bdd38ef 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -304,7 +304,7 @@ static void __init srmmu_nocache_init(void)
 		pgd = pgd_offset_k(vaddr);
 		p4d = p4d_offset(__nocache_fix(pgd), vaddr);
 		pud = pud_offset(__nocache_fix(p4d), vaddr);
-		pmd = pmd_offset(__nocache_fix(pgd), vaddr);
+		pmd = pmd_offset(__nocache_fix(pud), vaddr);
 		pte = pte_offset_kernel(__nocache_fix(pmd), vaddr);
 
 		pteval = ((paddr >> 4) | SRMMU_ET_PTE | SRMMU_PRIV);
-- 
2.26.2

