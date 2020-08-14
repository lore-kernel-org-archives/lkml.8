Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A94C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 15:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01FE120866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 15:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nHJCA4bC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UINynS6b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgHNPXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 11:23:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37374 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbgHNPXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 11:23:32 -0400
Date:   Fri, 14 Aug 2020 15:23:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597418610;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2387gP5Ra5yqujQ4UJsWART/df5bzYPCQMLcDcUCLco=;
        b=nHJCA4bCMmUfvye1T/VI25EXJy+QOyzrHhi61r+VmQlhjSL1ztSS3rrUiVvCxuVtpjADW9
        p4Zm8VJqFSWiKwfwH5Ey8LpeDHezXJ/R5s1/Y1FXAjKY3sktXQL2lE+g7KafoqtlHgt32j
        9/GhAbQnubJa3H6jn09HFX21vXJMu7lZZfHBZ2TaeYh4PvWPVBe0FAOyWwFQrwprVXuxUz
        EfloN/DWCxUz88BM8H09nPM8cnjip7hU78/FLm8hyYff45fIxdAnQ1N8YASWKU1cwMc+mT
        iK1QdEog8G1yWk1/W4uPBBPuUw3RyY5VK8tXSfwNkmuUwu8EuuUopkLDmc93MQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597418610;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2387gP5Ra5yqujQ4UJsWART/df5bzYPCQMLcDcUCLco=;
        b=UINynS6bRWQP7V0kQVUSCZYD8CBVnpfTuob2Y0f9vM3KHqv1xmlXGTRB0+kd3+m9cV2u6x
        c+gt3wCeg5zPIPCQ==
From:   "tip-bot2 for Zhang Rui" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/rapl: Fix missing psys sysfs attributes
Cc:     Zhang Rui <rui.zhang@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Len Brown <len.brown@intel.com>, Jiri Olsa <jolsa@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200811153149.12242-2-rui.zhang@intel.com>
References: <20200811153149.12242-2-rui.zhang@intel.com>
MIME-Version: 1.0
Message-ID: <159741861009.3192.851997896622686550.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     4bb5fcb97a5df0bbc0a27e0252b1e7ce140a8431
Gitweb:        https://git.kernel.org/tip/4bb5fcb97a5df0bbc0a27e0252b1e7ce140a8431
Author:        Zhang Rui <rui.zhang@intel.com>
AuthorDate:    Tue, 11 Aug 2020 23:31:47 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 14 Aug 2020 12:35:11 +02:00

perf/x86/rapl: Fix missing psys sysfs attributes

This fixes a problem introduced by commit:

  5fb5273a905c ("perf/x86/rapl: Use new MSR detection interface")

that perf event sysfs attributes for psys RAPL domain are missing.

Fixes: 5fb5273a905c ("perf/x86/rapl: Use new MSR detection interface")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Link: https://lore.kernel.org/r/20200811153149.12242-2-rui.zhang@intel.com
---
 arch/x86/events/rapl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 68b3882..e972383 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -665,7 +665,7 @@ static const struct attribute_group *rapl_attr_update[] = {
 	&rapl_events_pkg_group,
 	&rapl_events_ram_group,
 	&rapl_events_gpu_group,
-	&rapl_events_gpu_group,
+	&rapl_events_psys_group,
 	NULL,
 };
 
