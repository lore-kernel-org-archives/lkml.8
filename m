Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A1BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 19:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C18B20781
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 19:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PAFVVerl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgHLTOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 15:14:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33096 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726515AbgHLTOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 15:14:31 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07CJ364I077487;
        Wed, 12 Aug 2020 15:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=eATWMevvC55IYahwQYFrwSPVJNQTEwFpSNyukSzrRCw=;
 b=PAFVVerlGyhXLaqHox/oHdsYwH6sgeTN6JzZOMnKlzeNmYaZeRUOUOZykkgid7370MEB
 68F0vGki7IEXb4etLBbZKt7EuwoNWTgdGgiJ1cnQfXzuKUX3GSaGzNgtdT4Q9ywJKwAd
 IEp7aA+9p2YuoBtc+tw+0ZkYVsCYOUBKG7b3yicEGREx0vzcoCCegv93OAC0l+QGqIsB
 isBqx1ufow7Od0msVlxTbXj0G7b8WbS9O1DLqqSmwfrNYBbCZ07kix1W5XYcb30xyyFd
 kQOSXbdb9yDhruJ2c7Mn/EE6fe83gjjJgbx8bsw0ydXLLpiHb6n3taDPzzYyVuKigx1m xg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32vf4peu86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Aug 2020 15:14:22 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07CJ4G6m024802;
        Wed, 12 Aug 2020 19:14:20 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 32skp84rb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Aug 2020 19:14:20 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07CJEIbf27066770
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Aug 2020 19:14:18 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27CC442047;
        Wed, 12 Aug 2020 19:14:18 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D93442042;
        Wed, 12 Aug 2020 19:14:17 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.85.161])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 12 Aug 2020 19:14:17 +0000 (GMT)
Date:   Wed, 12 Aug 2020 22:14:15 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Pekka Enberg <penberg@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: arch/mips/include/asm/pgalloc.h:81:22: error: redefinition of
 'pud_alloc_one'
Message-ID: <20200812191415.GE163101@linux.ibm.com>
References: <202008130114.Em0abJAv%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008130114.Em0abJAv%lkp@intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-12_15:2020-08-11,2020-08-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 clxscore=1011 priorityscore=1501 bulkscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008120117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 01:28:17AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   fb893de323e2d39f7a1f6df425703a2edbdf56ea
> commit: d9e8b929670b4f79e07cdbcb0fb4f162a561d5c6 asm-generic: pgalloc: provide generic pud_alloc_one() and pud_free_one()
> date:   5 days ago
> config: mips-randconfig-p001-20200812 (attached as .config)
> compiler: mips64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout d9e8b929670b4f79e07cdbcb0fb4f162a561d5c6
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from arch/mips/mm/init.c:43:
> >> arch/mips/include/asm/pgalloc.h:81:22: error: redefinition of 'pud_alloc_one'
>       81 | static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
>          |                      ^~~~~~~~~~~~~
>    In file included from arch/mips/include/asm/pgalloc.h:18,
>                     from arch/mips/mm/init.c:43:
>    include/asm-generic/pgalloc.h:160:22: note: previous definition of 'pud_alloc_one' was here
>      160 | static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
>          |                      ^~~~~~~~~~~~~
>    arch/mips/mm/init.c:61:6: warning: no previous prototype for 'setup_zero_pages' [-Wmissing-prototypes]
>       61 | void setup_zero_pages(void)
>          |      ^~~~~~~~~~~~~~~~

From 03ab41f5c9f12733be3581333b512d99b0f75cac Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.ibm.com>
Date: Wed, 12 Aug 2020 22:06:49 +0300
Subject: [PATCH] asm-generic: pgalloc.h: use correct #ifdef to enable pud_alloc_one()

The #ifdef statement that guards the generic version of pud_alloc_one() by
mistake used __HAVE_ARCH_PUD_FREE instead of __HAVE_ARCH_PUD_ALLOC_ONE.

Fix it.

Fixes: d9e8b929670b ("asm-generic: pgalloc: provide generic pud_alloc_one() and pud_free_one()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 include/asm-generic/pgalloc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 6f44810921aa..02932efad3ab 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -147,7 +147,7 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 
 #if CONFIG_PGTABLE_LEVELS > 3
 
-#ifndef __HAVE_ARCH_PUD_FREE
+#ifndef __HAVE_ARCH_PUD_ALLOC_ONE
 /**
  * pud_alloc_one - allocate a page for PUD-level page table
  * @mm: the mm_struct of the current context
-- 
2.26.2


