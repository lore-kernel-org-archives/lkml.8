Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577A9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3813B20787
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389895AbgEYKmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 06:42:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19754 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389484AbgEYKmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 06:42:53 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04PAgXu4054861;
        Mon, 25 May 2020 06:42:38 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 317hegpum7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 May 2020 06:42:37 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04PAgY9P054873;
        Mon, 25 May 2020 06:42:34 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 317hegpu3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 May 2020 06:42:33 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04PAV3gl028324;
        Mon, 25 May 2020 10:40:50 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 316uf83ven-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 May 2020 10:40:50 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04PAemqs57540610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 May 2020 10:40:48 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DAE85204F;
        Mon, 25 May 2020 10:40:48 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.39.229])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 43C6052059;
        Mon, 25 May 2020 10:40:47 +0000 (GMT)
Date:   Mon, 25 May 2020 13:40:45 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     kernel test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKP <lkp@lists.01.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 379706875d ("x86/mm: simplify init_trampoline() and .."): BUG:
 kernel reboot-without-warning in boot stage
Message-ID: <20200525104045.GB13212@linux.ibm.com>
References: <20200525002157.GG12456@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525002157.GG12456@shao2-debian>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-25_05:2020-05-25,2020-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 cotscore=-2147483648 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 clxscore=1011 adultscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005250082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 08:21:58AM +0800, kernel test robot wrote:
> Greetings,
> 
> 0day kernel testing robot got the below dmesg and the first bad commit is
> 
> https://github.com/0day-ci/linux/commits/Mike-Rapoport/mm-consolidate-definitions-of-page-table-accessors/20200513-025551
> 
> commit 379706875d28bf7fc90b067355981de242b7bff1
> Author:     Mike Rapoport <rppt@linux.ibm.com>
> AuthorDate: Tue May 12 21:44:17 2020 +0300
> Commit:     0day robot <lkp@intel.com>
> CommitDate: Wed May 13 02:55:59 2020 +0800
> 
>     x86/mm: simplify init_trampoline() and surrounding logic
>     
>     There are three cases for the trampoline initialization:
>     * 32-bit does nothing
>     * 64-bit with kaslr disabled simply copies a PGD entry from the direct map
>       to the trampoline PGD
>     * 64-bit with kaslr enabled maps the real mode trampoline at PUD level
>     
>     These cases are currently differentiated by a bunch of ifdefs inside
>     asm/include/pgtable.h and the case of 64-bits with kaslr on uses
>     pgd_index() helper.
>     
>     Replacing the ifdefs with a static function in arch/x86/mm/init.c gives
>     clearer code and allows moving pgd_index() to the generic implementation in
>     include/linux/pgtable.h
>     
>     Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> 
> 7cc33e59db  m68k/mm: move {cache,nocahe}_page() definitions close to their user
> 379706875d  x86/mm: simplify init_trampoline() and surrounding logic
> 6498f3f0af  mm: consolidate pgd_index() and pgd_offset{_k}() definitions
> +----------------------------------------------------------------------------+------------+------------+------------+
> |                                                                            | 7cc33e59db | 379706875d | 6498f3f0af |
> +----------------------------------------------------------------------------+------------+------------+------------+
> | boot_successes                                                             | 0          | 0          | 0          |
> | boot_failures                                                              | 50         | 17         | 21         |

The patch below fixes this. Its generated vs v5.7-rc6-mmots-2020-05-22-22-39.

From e8877945b2a0b56861e9a263df9d1bc84f792210 Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.ibm.com>
Date: Mon, 25 May 2020 12:18:21 +0300
Subject: [PATCH] x86/kaslr: take CONFIG_RANDOMIZE_MEMORY into account in kaslr_enabled()

Until refactoring of the init_trampoline(), kaslr_enabled() was used only
inside '#ifdef CONFIG_RANDOMIZE_MEMORY' and reported only the state of the
command line override.

The simplification of init_trampoline() made kaslr_enabled() visible for
builds with CONFIG_RANDOMIZE_MEMORY=n and in this case it will return true
if the randomization was not disabled on the command line.

This in turn will call a dummy init_trampoline_kaslr() instead of setting
trampline_pgd_entry directly.

As the result, the kernel reboots while starting the secondary CPUs, e.g.
kernel test bot reported:

...
[    0.244628] Performance Events: unsupported p6 CPU model 60 no PMU driver, software events only.
[    0.244993] rcu: Hierarchical SRCU implementation.
[    0.245617] smp: Bringing up secondary CPUs ...
[    0.247388] x86: Booting SMP configuration:
BUG: kernel reboot-without-warning in boot stage

Adding a check for IS_ENABLED(CONFIG_RANDOMIZE_MEMORY) to kaslr_enabled()
resolves the issue.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Reported-by: kbuild test robot <lkp@intel.com>
---
 arch/x86/include/asm/setup.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index d95cacf210bb..84b645cc8bc9 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -75,7 +75,8 @@ extern char _text[];
 
 static inline bool kaslr_enabled(void)
 {
-	return !!(boot_params.hdr.loadflags & KASLR_FLAG);
+	return IS_ENABLED(CONFIG_RANDOMIZE_MEMORY) &&
+		!!(boot_params.hdr.loadflags & KASLR_FLAG);
 }
 
 /*
-- 
2.26.2

