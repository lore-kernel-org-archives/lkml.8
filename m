Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B041C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B964A21582
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yv7lhRfB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bC35LwbK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbgIJJfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:35:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38770 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730416AbgIJJWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:22:51 -0400
Date:   Thu, 10 Sep 2020 09:22:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729744;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NW1Y3mx7e6uQL7A6qRu67hi0QDn47vmBbfStr+QZW64=;
        b=yv7lhRfBAZ6Ym893EkbA7wNiuWIFinUaVw+NhkpvXEZsVk/DLvPXZXe4OEpKjOxqSv104L
        +y5cIaiSvqTZDE/+5btXZFn26Bx0UYKDhLO9Z7Ic0g5xsTAfzlcec1eDAVA7w9DkSQ0RHg
        ++GCMelQZb8Kmafz5V26ifR59CDtLiTA4cJ9bjia08kj3l9V1QPlh+nk+/R7oq4KPil+fd
        Fvc5nD1rBoNi25ykvcnirjT1a0//0eRu+VFlkP5fl/INoXwmdtIy+opc6hsotmmpDraBEh
        OoCmMXsSOrTHt+XdSstQCQownKlUMY7Q4z+GcCyM4QGCL4bzK5W3cesKbXMpxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729744;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NW1Y3mx7e6uQL7A6qRu67hi0QDn47vmBbfStr+QZW64=;
        b=bC35LwbK+RDkDKOQNj+JrBBFrrl+lEYyL9h1B2NZnRbqKZPJpVfg1KaHAQ4LJoYY66YXEG
        VQlQzy/FLYV2HNCQ==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/boot/compressed/64: Check return value of
 kernel_ident_mapping_init()
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-22-joro@8bytes.org>
References: <20200907131613.12703-22-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972974392.20229.3455617519149103991.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     4b3fdca64a7e8ad90c87cad1fbc6991471f48dc7
Gitweb:        https://git.kernel.org/tip/4b3fdca64a7e8ad90c87cad1fbc6991471f48dc7
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:15:22 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 07 Sep 2020 19:45:25 +02:00

x86/boot/compressed/64: Check return value of kernel_ident_mapping_init()

The function can fail to create an identity mapping, check for that
and bail out if it happens.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-22-joro@8bytes.org
---
 arch/x86/boot/compressed/ident_map_64.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index b4f2a5f..aa91beb 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -91,6 +91,8 @@ static struct x86_mapping_info mapping_info;
  */
 static void add_identity_map(unsigned long start, unsigned long end)
 {
+	int ret;
+
 	/* Align boundary to 2M. */
 	start = round_down(start, PMD_SIZE);
 	end = round_up(end, PMD_SIZE);
@@ -98,8 +100,9 @@ static void add_identity_map(unsigned long start, unsigned long end)
 		return;
 
 	/* Build the mapping. */
-	kernel_ident_mapping_init(&mapping_info, (pgd_t *)top_level_pgt,
-				  start, end);
+	ret = kernel_ident_mapping_init(&mapping_info, (pgd_t *)top_level_pgt, start, end);
+	if (ret)
+		error("Error: kernel_ident_mapping_init() failed\n");
 }
 
 /* Locates and clears a region for a new top level page table. */
