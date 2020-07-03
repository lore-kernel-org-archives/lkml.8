Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EEFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45F4420836
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y38GxzHl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A7eNjvET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgGCIBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgGCIBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:01:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0BEC08C5C1;
        Fri,  3 Jul 2020 01:01:30 -0700 (PDT)
Date:   Fri, 03 Jul 2020 08:01:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593763288;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oK9his7BX2zy8pN/vWTauVsFCG50lHQ+Vq82uTFwBmI=;
        b=y38GxzHlE5YSCqaT9GeBOBq75n160FsiF1PCYGuN6UjgXDXpzM9CPOZ/AzzHqfLDYCt05S
        AvVN+xdza7TYDuth5LbOEsPz8JUVMdMqs38ahcZpRYyMop8jPwUA9LHN5ALVoo7KbKmGPO
        7KZmDyn613gq7afn2CSSlQUvC4Gai7vxlqd49Ncls/C9GbsE3jaYyVXPJGVjafA5SomBAv
        x/I5oFCQJt+x68v+sFgLilm14n1MMyDKYFXPyDOv1fFlfSBTz6WWi8dzRt8o/+0cqd6fIw
        QbKYGBnWeorgp30KuhQ+46LNnDE5qWWimp1ObyR8tqlJoDRiSQ/Na+WTvKP5kA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593763288;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oK9his7BX2zy8pN/vWTauVsFCG50lHQ+Vq82uTFwBmI=;
        b=A7eNjvETYcvOVXL3n5krZDndEx0/9IOiqG+g/xQBVsQHW2YWi7Q+6zb/uLSUPoefg08i8A
        qWf5/CryqKTmaDCw==
From:   "tip-bot2 for Wei Wang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Fix variable types for LBR registers
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Wei Wang <wei.w.wang@intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200613080958.132489-2-like.xu@linux.intel.com>
References: <20200613080958.132489-2-like.xu@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159376328837.4006.10960362738687676693.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     3cb9d5464c1ceea86f6225089b2f7965989cf316
Gitweb:        https://git.kernel.org/tip/3cb9d5464c1ceea86f6225089b2f7965989cf316
Author:        Wei Wang <wei.w.wang@intel.com>
AuthorDate:    Sat, 13 Jun 2020 16:09:46 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 02 Jul 2020 15:51:45 +02:00

perf/x86: Fix variable types for LBR registers

The MSR variable type can be 'unsigned int', which uses less memory than
the longer 'unsigned long'. Fix 'struct x86_pmu' for that. The lbr_nr won't
be a negative number, so make it 'unsigned int' as well.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200613080958.132489-2-like.xu@linux.intel.com
---
 arch/x86/events/perf_event.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index e17a3d8..eb37f6c 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -673,8 +673,8 @@ struct x86_pmu {
 	/*
 	 * Intel LBR
 	 */
-	unsigned long	lbr_tos, lbr_from, lbr_to; /* MSR base regs       */
-	int		lbr_nr;			   /* hardware stack size */
+	unsigned int	lbr_tos, lbr_from, lbr_to,
+			lbr_nr;			   /* LBR base regs and size */
 	u64		lbr_sel_mask;		   /* LBR_SELECT valid bits */
 	const int	*lbr_sel_map;		   /* lbr_select mappings */
 	bool		lbr_double_abort;	   /* duplicated lbr aborts */
