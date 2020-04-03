Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC922C2BA15
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33C6206F8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KRyZMKFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404523AbgDCQdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:33:07 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46596 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403834AbgDCQdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ZF+Ip9r0n6MFzf3R/fk5zen8jodRMHuqnK57s4fq5I4=; b=KRyZMKFMR2hlTriIUZmEdRae44
        /wWewmvIlqZZs/O+7ipwhwHdGbXg6arMJI9AYhfjR0KJcrZbCCBvuQ+3orW4YN7ZDON/Gqj6Fzuj8
        9CTth0R/yKI7M1fQu/ag+FYXZAcrvjfdIKQIXaz9MQ2U/snhW5XaF4DOQXexT7ZqJalYc+bSKwS09
        Q5/yO0wY4uU1huqjRQg8/gxib12L8y5X91/2tLZLYaTuQ/GqF9JHjzN0FvrTb4V/dJVQmQRdJNN1j
        fOup5OyOLwQKATd/gXxTimbt8ZR2JatF6w41ggyXB9nBFKWqaahMXmQJzbvYJTi8Hvj81WBHyZfGz
        bCBOKL3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKPFX-00038Q-Sw; Fri, 03 Apr 2020 16:32:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4DC693056DE;
        Fri,  3 Apr 2020 18:32:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 335732B12078B; Fri,  3 Apr 2020 18:32:53 +0200 (CEST)
Date:   Fri, 3 Apr 2020 18:32:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, jroedel@suse.de,
        vbabka@suse.cz, urezki@gmail.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] mm/vmalloc: Sanitize __get_vm_area() arguments
Message-ID: <20200403163253.GU20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


__get_vm_area() is an exported symbol, make sure the callers stay in
the expected memory range. When calling this function with memory
ranges outside of the VMALLOC range *bad* things can happen.

(I noticed this when I managed to corrupt the kernel text by accident)

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 mm/vmalloc.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2130,6 +2130,13 @@ static struct vm_struct *__get_vm_area_n
 struct vm_struct *__get_vm_area(unsigned long size, unsigned long flags,
 				unsigned long start, unsigned long end)
 {
+	/*
+	 * Ensure callers stay in the vmalloc range.
+	 */
+	if (WARN_ON(start < VMALLOC_START || start > VMALLOC_END ||
+		    end < VMALLOC_START || end > VMALLOC_END))
+		return NULL;
+
 	return __get_vm_area_node(size, 1, flags, start, end, NUMA_NO_NODE,
 				  GFP_KERNEL, __builtin_return_address(0));
 }
