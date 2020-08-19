Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42154C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ABCA2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a1rBEe6h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w+hGBs4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbgHSOD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbgHSOCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 10:02:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E70C061757;
        Wed, 19 Aug 2020 07:02:46 -0700 (PDT)
Date:   Wed, 19 Aug 2020 14:02:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597845763;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uxItqI+MXVfAQhADfcV+T8vg4ucBEyiaO/XGtNNK1Z4=;
        b=a1rBEe6hTq2VOpRwPDBAFewgDDdzkixUp7sDNXLUTE+dd9p3AWfqfdW/NvWICR4ESCqU/8
        fgTahcNpgwaqz2QxlNLOqKmtdAaQqY3ph3YqE8grVnWjo2kgBMLgErVvya/CpXk5pClp12
        0ufo2GTPYMekzgeTsqBGlVqmR3BVqYL5onhZaSydKFv+5wHqoD0yewqVlsosh3p9GBOSI0
        EOLrYuDbLmtxTguUB5NTKI4w4Kdf254eYcIhFPNg0481jSLMYpRsAR5BFyIbJ+mEte6iUW
        l+UCY5LgwJVfPlRzhk2frpPEelrtHPPWkYuHxJOVTXI4IejWH9IMUjJ7CWBNhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597845763;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uxItqI+MXVfAQhADfcV+T8vg4ucBEyiaO/XGtNNK1Z4=;
        b=w+hGBs4pwfblBBgJ52cihQwYrBhMaH0oh6qI48vzJp8vgpys3WW1Yg92M/4HEtJwh5iZL3
        iSFsoNXuHZlqRoAQ==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Mark SD_OVERLAP as SDF_NEEDS_GROUPS
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200817113003.20802-16-valentin.schneider@arm.com>
References: <20200817113003.20802-16-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <159784576240.3192.13249038734963416301.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3551e954f5d95faf3dbc340d422da7624658c230
Gitweb:        https://git.kernel.org/tip/3551e954f5d95faf3dbc340d422da7624658c230
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Mon, 17 Aug 2020 12:30:01 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Aug 2020 10:49:50 +02:00

sched/topology: Mark SD_OVERLAP as SDF_NEEDS_GROUPS

A sched_domain can only have overlapping sched_groups if it has more than
one group.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: https://lore.kernel.org/r/20200817113003.20802-16-valentin.schneider@arm.com
---
 include/linux/sched/sd_flags.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
index 2998ece..29af5f0 100644
--- a/include/linux/sched/sd_flags.h
+++ b/include/linux/sched/sd_flags.h
@@ -143,8 +143,9 @@ SD_FLAG(SD_PREFER_SIBLING, SDF_NEEDS_GROUPS)
  * sched_groups of this level overlap
  *
  * SHARED_PARENT: Set for all NUMA levels above NODE.
+ * NEEDS_GROUPS: Overlaps can only exist with more than one group.
  */
-SD_FLAG(SD_OVERLAP, SDF_SHARED_PARENT)
+SD_FLAG(SD_OVERLAP, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
 
 /*
  * Cross-node balancing
