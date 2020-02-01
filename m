Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11846C33CB2
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 01:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D87B720674
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 01:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JSkarRTK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgBABvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 20:51:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52302 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgBABvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 20:51:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Y4oH0DJoPTg1vs/wo5hS8AuSrbZQqTSvRDnjdivmgcw=; b=JSkarRTK6B/eHxgPZOtfNHCxn
        EoL1mNd7heoS6ln+lgRZb5aaXxNQ+XkINB9O0QD+hYlcrhponNAPp3JU0tb4pFsIulavIFfqRRy8W
        6sfGKWeXq2sOycf1tUoE6Kdde3IAq4cXp88tCuYfF+aq/UULKyRQiexACh6zNlXePDIlDmXHZky28
        WFaj/gkNpEiiZhaw7y3Wy1+zPQ1hpofTe7M/mnBwnTtLD6DkMFY/Qk5v/GVP4M6TZ07rs48y0PUt9
        xm57fbLzOIBNY69AU+RcYMoWBEb2Z6AGFH5Xa8ynMMTDHh814uDVUXkE4jecENbKSHTCz6ACOwn96
        yuvIrWXDA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixhwB-0005XH-PR; Sat, 01 Feb 2020 01:51:07 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] arm64: fix NUMA Kconfig typos
Message-ID: <2c69f4d8-03a1-20a6-e8ef-a4518a7c6d07@infradead.org>
Date:   Fri, 31 Jan 2020 17:51:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix typos in arch/arm64/Kconfig:

- spell Numa as NUMA
- add hyphenation to Non-Uniform

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200131.orig/arch/arm64/Kconfig
+++ linux-next-20200131/arch/arm64/Kconfig
@@ -952,11 +952,11 @@ config HOTPLUG_CPU
 
 # Common NUMA Features
 config NUMA
-	bool "Numa Memory Allocation and Scheduler Support"
+	bool "NUMA Memory Allocation and Scheduler Support"
 	select ACPI_NUMA if ACPI
 	select OF_NUMA
 	help
-	  Enable NUMA (Non Uniform Memory Access) support.
+	  Enable NUMA (Non-Uniform Memory Access) support.
 
 	  The kernel will try to allocate memory used by a CPU on the
 	  local memory of the CPU and add some more

