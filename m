Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F064EC33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 04:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43E520708
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 04:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgAKENJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 23:13:09 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8692 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728318AbgAKENJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 23:13:09 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CA5319154E9F00CB80E4;
        Sat, 11 Jan 2020 12:13:05 +0800 (CST)
Received: from huawei.com (10.175.127.16) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Sat, 11 Jan 2020
 12:12:56 +0800
From:   Pan Zhang <zhangpan26@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <dan.j.williams@intel.com>,
        <dave.hansen@linux.intel.com>, <ardb@kernel.org>,
        <fanc.fnst@cn.fujitsu.com>, <daniel.kiper@oracle.com>
CC:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <hushiyuan@huawei.com>, <wuxu.wu@huawei.com>,
        <liangyun2@huawei.com>
Subject: [PATCH] x86/kaslr: support separate multiple memmaps parameter parsing
Date:   Sat, 11 Jan 2020 12:16:31 +0800
Message-ID: <1578716191-19351-1-git-send-email-zhangpan26@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.16]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the kernel is loading,
the load address of the kernel needs to be calculated firstly.

If the kernel address space layout randomization(`kaslr`) is enabled,
the memory range reserved by the memmap parameter will be excluded
to avoid loading the kernel address into the memmap reserved area.

Currently, this is what the manual says:
	`memmap = nn [KMG] @ss [KMG]
		[KNL] Force usage of a specific region of memory.
    	Region of memory to be used is from ss to ss + nn.
   		If @ss [KMG] is omitted, it is equivalent to mem = nn [KMG],
    	which limits max address to nn [KMG].
		Multiple different regions can be specified,
		comma delimited.
		Example:
		memmap=100M@2G, 100M#3G, 1G!1024G
	`

Can we relax the use of memmap?
In our production environment we see many people who use it like this:
Separate multiple memmaps parameters to reserve memory,
memmap=xx\$xxx memmap=xx\$xxx memmap=xx\$xxx memmap=xx\$xxx memmap=xx\$xxx

If this format is used, and the reserved memory segment is greater than 4,
there is no way to parse the 5th and subsequent memmaps and the kaslr cannot be disabled by `memmap_too_large`
so the kernel loading address may fall within the memmap range
(reserved memory area from memmap after fourth segment),
which will have bad consequences for use of reserved memory.

Signed-off-by: Pan Zhang <zhangpan26@huawei.com>
---
 arch/x86/boot/compressed/kaslr.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index d7408af..24a2778 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -203,9 +203,6 @@ static void mem_avoid_memmap(enum parse_mode mode, char *str)
 {
 	static int i;
 
-	if (i >= MAX_MEMMAP_REGIONS)
-		return;
-
 	while (str && (i < MAX_MEMMAP_REGIONS)) {
 		int rc;
 		unsigned long long start, size;
@@ -233,7 +230,7 @@ static void mem_avoid_memmap(enum parse_mode mode, char *str)
 	}
 
 	/* More than 4 memmaps, fail kaslr */
-	if ((i >= MAX_MEMMAP_REGIONS) && str)
+	if ((i >= MAX_MEMMAP_REGIONS) && !memmap_too_large)
 		memmap_too_large = true;
 }
 
-- 
2.7.4

