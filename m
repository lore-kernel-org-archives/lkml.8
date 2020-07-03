Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3920BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 21:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFB3620782
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 21:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wRPO2b69"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgGCVZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 17:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgGCVZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 17:25:03 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E0DC061794;
        Fri,  3 Jul 2020 14:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ghnLeOY3iJxUEntc3I9wRbbv5Gi2ZNHt3igCZ3zdcXA=; b=wRPO2b69zwPWQCEM92vRpe3YES
        GPw9qXyg6NCu+4lA5cNcYnHsn8SSNad8/kIieZgmNisPSaxBJisaPUP28llzxiV69NkljXFMBNq/p
        kLxz9E+DcGvK1jLYUR7AXHkBMmuInRD99B3Q4h85m/2jMIEPr3x2YizjnE/v5MF98j3xFs3rulm/O
        KBy00GDeK7ITYxjORVp7ZrgGV3J3WaajV+AYyEm2YXhg8nxqLneCWHh8lONU67ZhxvuJ1vayR5aY5
        VTAcMWwlv93XqIP0C/M6alFZ1LMCHHTF8Lrlc2aInHXMD1vxItKijPvbdMt4jFiFrcvHrp4S/6E9b
        sC2/72gA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrTB6-0006Bh-Ia; Fri, 03 Jul 2020 21:25:01 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 1/3] Documentation: trace/ftrace: drop doubled words
Date:   Fri,  3 Jul 2020 14:24:51 -0700
Message-Id: <20200703212453.30553-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200703212453.30553-1-rdunlap@infradead.org>
References: <20200703212453.30553-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the doubled words "for" and "that".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
---
 Documentation/trace/ftrace.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200701.orig/Documentation/trace/ftrace.rst
+++ linux-next-20200701/Documentation/trace/ftrace.rst
@@ -561,7 +561,7 @@ of ftrace. Here is a list of some of the
 
   trace_marker_raw:
 
-	This is similar to trace_marker above, but is meant for for binary data
+	This is similar to trace_marker above, but is meant for binary data
 	to be written to it, where a tool can be used to parse the data
 	from trace_pipe_raw.
 
@@ -1394,7 +1394,7 @@ an example::
    => x86_64_start_reservations
    => x86_64_start_kernel
 
-Here we see that that we had a latency of 16 microseconds (which is
+Here we see that we had a latency of 16 microseconds (which is
 very good). The _raw_spin_lock_irq in run_timer_softirq disabled
 interrupts. The difference between the 16 and the displayed
 timestamp 25us occurred because the clock was incremented
