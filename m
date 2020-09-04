Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F0FC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 23:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACC482078E
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 23:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K+rNvidz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lAqUJ/9a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgIDXdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 19:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgIDXdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 19:33:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126CAC061244;
        Fri,  4 Sep 2020 16:33:10 -0700 (PDT)
Date:   Fri, 04 Sep 2020 23:33:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599262388;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T+APnNSye1kJjw9olDELRnc3+FWK++0UzgXwBMBFY2k=;
        b=K+rNvidzdBzbmmZtm4supmHy2Ysh/Fe+yZLe0kqY6cE5YBbXTuXiOkAmVLT1n5OE5yDaA4
        HI9z8I6RQ4fOlraleUZEg+04sneaDJ2o0IdbGviBCKY/v3ENfUCAMjZ76N3UPT8Uwb/u4L
        Eiqw6pINqNtRcFw4ajG1vSnlEdWhFxVBMWUqtnEluasBlGEvOKv0Pqq4YMuTaXXcBQr8+q
        Eaf8aOisXMtx1DauCxXgUVUOB3ok9dIKwBXReBLHmXG8Xkp/mrPTLiSKlMF3QoWYrENUNZ
        0Xp8uYT0df34qVU1m4L4hphaM2SRm9Y7MsZ1tdAzlaxqATHy7DoKkclktn5BEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599262388;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T+APnNSye1kJjw9olDELRnc3+FWK++0UzgXwBMBFY2k=;
        b=lAqUJ/9aeS9DKSzPUQ90warCqDzVfV3mf5Kj/MpuLAz7U9lsueHZ8lHRfTYCbTTl+Q+uoE
        KwA+CBcQt6ZgfUCw==
From:   "tip-bot2 for Colin Ian King" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/resctrl: Fix spelling in user-visible warning
 messages
Cc:     Colin Ian King <colin.king@canonical.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200810075508.46490-1-colin.king@canonical.com>
References: <20200810075508.46490-1-colin.king@canonical.com>
MIME-Version: 1.0
Message-ID: <159926238705.20229.16169849403685136300.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     93921baa3f6ff77e57d7e772165aa7bd709b5387
Gitweb:        https://git.kernel.org/tip/93921baa3f6ff77e57d7e772165aa7bd709b5387
Author:        Colin Ian King <colin.king@canonical.com>
AuthorDate:    Mon, 10 Aug 2020 08:55:08 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 05 Sep 2020 01:24:17 +02:00

x86/resctrl: Fix spelling in user-visible warning messages

Fix spelling mistake "Could't" -> "Couldn't" in user-visible warning
messages.

 [ bp: Massage commit message; s/cpu/CPU/g ]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200810075508.46490-1-colin.king@canonical.com
---
 arch/x86/kernel/cpu/resctrl/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 6a9df71..9cceee6 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -562,7 +562,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 
 	d = rdt_find_domain(r, id, &add_pos);
 	if (IS_ERR(d)) {
-		pr_warn("Could't find cache id for cpu %d\n", cpu);
+		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
 		return;
 	}
 
@@ -607,7 +607,7 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 
 	d = rdt_find_domain(r, id, NULL);
 	if (IS_ERR_OR_NULL(d)) {
-		pr_warn("Could't find cache id for cpu %d\n", cpu);
+		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
 		return;
 	}
 
