Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2380C54E8E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B13D520674
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W6os7/Rw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbgELMr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 08:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729851AbgELMrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 08:47:24 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38A9C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 05:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=CYYpiqrbBLgooKXOpvi8wy4NrFYsaxk2WuAfbe/cgCE=; b=W6os7/RwiqUdE+aykxc8eGzgyH
        fS7bISumtHbFPFrf4M7xtKFo5FeqDVH6JQa4Xq6qSDNjl2frm/JUmDi97d1mL3x0l8u4NpOaFnKW3
        gx9+Pii5OQt83bS5JqZXK567UF1kC1lE2NVZudxzeS5r41/T5dV77e3KLsEfImeS0gkKs9a735SpY
        C5xF7Yk/YgDkA2IxcKBxDOqSYS3XQjmAAWLYr5X7OWnoNvggJxTIy+E/eZdz38Yofpf0WjbWT5Qdj
        SNwkmL2X79pGemtlg7hfMaUy6cW4S8JZDXl9TNeckLoQ/C+9sS1wyvLcOgzSYu85nlycGfTJPkA1j
        dVv7v0uQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYUJF-0003Ga-Hf; Tue, 12 May 2020 12:46:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 476FC3062BA;
        Tue, 12 May 2020 14:46:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3408D20962E57; Tue, 12 May 2020 14:46:53 +0200 (CEST)
Message-ID: <20200512124450.981890259@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 12 May 2020 14:41:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Leo Yan <leo.yan@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        sboyd@codeaurora.org, john.stultz@linaro.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 4/5] perf: Add perf_event_mmap_page::cap_user_time_short ABI
References: <20200512124058.833263033@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support short clock counters, provide an ABI extention.

As a whole:

    u64 time, delta, cyc = read_cycle_counter();

+   if (cap_user_time_short)
+	cyc = time_cycle + ((cyc - time_cycle) & time_mask);

    delta = mul_u64_u32_shr(cyc, time_mult, time_shift);

    if (cap_user_time_zero)
	time = time_zero + delta;

    delta += time_offset;

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/uapi/linux/perf_event.h |   23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -532,9 +532,10 @@ struct perf_event_mmap_page {
 				cap_bit0_is_deprecated	: 1, /* Always 1, signals that bit 0 is zero */
 
 				cap_user_rdpmc		: 1, /* The RDPMC instruction can be used to read counts */
-				cap_user_time		: 1, /* The time_* fields are used */
+				cap_user_time		: 1, /* The time_{shift,mult,offset} fields are used */
 				cap_user_time_zero	: 1, /* The time_zero field is used */
-				cap_____res		: 59;
+				cap_user_time_short	: 1, /* the time_{cycle,mask} fields are used */
+				cap_____res		: 58;
 		};
 	};
 
@@ -593,13 +594,29 @@ struct perf_event_mmap_page {
 	 *               ((rem * time_mult) >> time_shift);
 	 */
 	__u64	time_zero;
+
 	__u32	size;			/* Header size up to __reserved[] fields. */
+	__u32	__reserved_1;
+
+	/*
+	 * If cap_usr_time_short, the hardware clock is less than 64bit wide
+	 * and we must compute the 'cyc' value, as used by cap_usr_time, as:
+	 *
+	 *   cyc = time_cycles + ((cyc - time_cycles) & time_mask)
+	 *
+	 * NOTE: this form is explicitly chosen such that cap_usr_time_short
+	 *       is a correction on top of cap_usr_time, and code that doesn't
+	 *       know about cap_usr_time_short still works under the assumption
+	 *       the counter doesn't wrap.
+	 */
+	__u64	time_cycles;
+	__u64	time_mask;
 
 		/*
 		 * Hole for extension of the self monitor capabilities
 		 */
 
-	__u8	__reserved[118*8+4];	/* align to 1k. */
+	__u8	__reserved[116*8];	/* align to 1k. */
 
 	/*
 	 * Control data for the mmap() data buffer.


