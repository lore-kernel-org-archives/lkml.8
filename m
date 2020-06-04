Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069F4C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 10:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3DAD2074B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 10:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zzqrnKvo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbgFDKZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 06:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbgFDKZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 06:25:31 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBCCC03E96E
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 03:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=oykwMbU7Wmvh1ZGkCXwhZjfvHzNP7lFFbQQT7fF0pCA=; b=zzqrnKvos/Jhw/yC2usTSVagG8
        tMISst0ceWqCRicCc/W5/SDTTJKufGU2UPP9dPjpLjf+bS6SjYcxSXF0F3satI9G4G6ypQDVYjWPR
        wDgJ0ur5wcr2AqcHrUylFbPXJ0PDfDnB6Ya/ikUb65BJcYatc3EfYDQNa88CoULmdFHOQhcfmJkA8
        bITJbZqYb4JCespUqx/TyyIxI+76bo0iKk9OKDaae2nm1hz1oRF97fScsNGZctMkGtzBNWu7LPXIA
        4bySgaBEO7zdDB64nO9tf/CnSnbc8Z/qWLlD3gfyX3suYdAnj1bqxbhpRHV0ego27SE3REFWZ2beG
        NT72a2ig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgn3e-0003tl-Jp; Thu, 04 Jun 2020 10:25:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 10E6D306E56;
        Thu,  4 Jun 2020 12:25:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EB8E620CC68B3; Thu,  4 Jun 2020 12:25:07 +0200 (CEST)
Message-ID: <20200604102428.364746275@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 04 Jun 2020 12:22:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de
Cc:     x86@kernel.org, elver@google.com, paulmck@kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, will@kernel.org, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com
Subject: [PATCH 8/8] x86/entry, bug: Comment the instrumentation_begin() usage for WARN()
References: <20200604102241.466509982@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explain the rationale for annotating WARN(), even though, strictly
speaking printk() and friends are very much not safe in many of the
places we put them.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/bug.h |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -76,6 +76,12 @@ do {								\
 	unreachable();						\
 } while (0)
 
+/*
+ * This instrumentation_begin() is strictly speaking incorrect; but it
+ * suppresses the complaints from WARN()s in noinstr code. If such a WARN()
+ * were to trigger, we'd rather wreck the machine in an attempt to get the
+ * message out than not know about it.
+ */
 #define __WARN_FLAGS(flags)					\
 do {								\
 	instrumentation_begin();				\


