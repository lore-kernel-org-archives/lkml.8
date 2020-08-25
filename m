Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C625C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBD1A2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WYPuECm9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="URgFRVEG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgHYXl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 19:41:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53404 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgHYXlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 19:41:05 -0400
Date:   Tue, 25 Aug 2020 23:41:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598398862;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f29ANvwdHE68cOMKguILoDdjkoxV1L2Txqd1M2X6P9E=;
        b=WYPuECm9K3MUXv17wcIEA0tBtOfbOubVv53z42qQZKZ29HQwrs2NU7AsK2slAe994I9Am4
        3SC/FOugxE5m27sX7VTtCl8yyJptlYB9zpkBv7JGSqvFUysCsK2QmpzLulUEU7qHN58CS5
        E9SctDHcrykJ3LztgdUGjveNZJ3z7w1xUFWhJxsyPNnVe8l8JJzAuKjPV/LoFfqeefWH3J
        i4QMyKjBVTL8vIl40NA3Whwwi3naccz1divS2oBAdvLxelzBs7Gf70H1+Mw8uqYVnn+6Fq
        TpL/T3wAzvoibPkhbzRDbvzCSADT/LrPIlBxrJYwKnCnGElYSMOewOqztYqzhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598398862;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f29ANvwdHE68cOMKguILoDdjkoxV1L2Txqd1M2X6P9E=;
        b=URgFRVEGdXYj+JYCJyvTMY5ueJx3b8cD6UpftJylrG16hNW+8J+zkBnPpW3MfRfHxfGB3h
        ClZzf6XqOuFIzNDQ==
From:   "tip-bot2 for Lokesh Vutla" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] firmware: ti_sci: Drop the device id to resource
 type translation
Cc:     Lokesh Vutla <lokeshvutla@ti.com>, Marc Zyngier <maz@kernel.org>,
        Nishanth Menon <nm@ti.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200806074826.24607-2-lokeshvutla@ti.com>
References: <20200806074826.24607-2-lokeshvutla@ti.com>
MIME-Version: 1.0
Message-ID: <159839886206.389.15390769011790154183.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     4473171db68fe9e3de3f2bc68a00527f23852ad8
Gitweb:        https://git.kernel.org/tip/4473171db68fe9e3de3f2bc68a00527f23852ad8
Author:        Lokesh Vutla <lokeshvutla@ti.com>
AuthorDate:    Thu, 06 Aug 2020 13:18:14 +05:30
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 16 Aug 2020 22:00:22 +01:00

firmware: ti_sci: Drop the device id to resource type translation

With ABI 3.0, sysfw deprecated special resource types used for AM65x
SoC. Instead started using device id as resource type similar to the
convention used in J721E SOC.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Nishanth Menon <nm@ti.com>
Link: https://lore.kernel.org/r/20200806074826.24607-2-lokeshvutla@ti.com
---
 drivers/firmware/ti_sci.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 53cee17..81e4d77 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -3355,16 +3355,6 @@ static const struct ti_sci_desc ti_sci_pmmc_k2g_desc = {
 	.rm_type_map = NULL,
 };
 
-static struct ti_sci_rm_type_map ti_sci_am654_rm_type_map[] = {
-	{.dev_id = 56, .type = 0x00b}, /* GIC_IRQ */
-	{.dev_id = 179, .type = 0x000}, /* MAIN_NAV_UDMASS_IA0 */
-	{.dev_id = 187, .type = 0x009}, /* MAIN_NAV_RA */
-	{.dev_id = 188, .type = 0x006}, /* MAIN_NAV_UDMAP */
-	{.dev_id = 194, .type = 0x007}, /* MCU_NAV_UDMAP */
-	{.dev_id = 195, .type = 0x00a}, /* MCU_NAV_RA */
-	{.dev_id = 0, .type = 0x000}, /* end of table */
-};
-
 /* Description for AM654 */
 static const struct ti_sci_desc ti_sci_pmmc_am654_desc = {
 	.default_host_id = 12,
@@ -3373,7 +3363,7 @@ static const struct ti_sci_desc ti_sci_pmmc_am654_desc = {
 	/* Limited by MBOX_TX_QUEUE_LEN. K2G can handle upto 128 messages! */
 	.max_msgs = 20,
 	.max_msg_size = 60,
-	.rm_type_map = ti_sci_am654_rm_type_map,
+	.rm_type_map = NULL,
 };
 
 static const struct of_device_id ti_sci_of_match[] = {
