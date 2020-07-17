Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D42C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D061E2083B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HUF0UuSe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hfE0Hg0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgGQOvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:51:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41212 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbgGQOvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:51:16 -0400
Date:   Fri, 17 Jul 2020 14:51:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594997474;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CfObQ50Werxo2Beh6hgckDzaE7BRIz31Ngyz6fdTMek=;
        b=HUF0UuSeLYzyIqWKZ83lhSPMf3j0uUyF3xLC7dBUw+4rnz7qh9q9eGd8TPodCbQiuEgpyL
        Bu7YHQQCRDOR77PIwGSSOj/ZX8RWhiMiu3AFYd0okvI4eEO4QRUc6f1z/zh9MH0k1xmmqb
        TZwKy7r/WT/cONlkJC0zo7hr2nsG82qstWvtkwcUH9XCUr6R4zrbWYBXPlN4O22iJ16ZGw
        TEAsERDmHMYjGDGtTS+6ssGM+7ryYIcICl5aDQifIgD5dt/4W8b69FxftAWaadia5lNkB7
        YZZeEIk+PPV5/SBwrjE9INRjvaKWVdPUnQWCE04Ypjpq2qBa6ASrtp7Ea0gxMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594997474;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CfObQ50Werxo2Beh6hgckDzaE7BRIz31Ngyz6fdTMek=;
        b=hfE0Hg0zI2JsoWWsSxJA8t9g/tfRvcoP34wkuBRNja1eV+gSu/vuIq+/WoIteSYOegdkwX
        fmrCSTkkPgMwytDQ==
From:   "tip-bot2 for steve.wahl@hpe.com" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Remove support for UV1 platform
 from uv_time
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200713212954.610885520@hpe.com>
References: <20200713212954.610885520@hpe.com>
MIME-Version: 1.0
Message-ID: <159499747361.4006.10651559471205581924.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     8b3c9b160648ceb9ec4068080fd055fdc04e35a7
Gitweb:        https://git.kernel.org/tip/8b3c9b160648ceb9ec4068080fd055fdc04e35a7
Author:        steve.wahl@hpe.com <steve.wahl@hpe.com>
AuthorDate:    Mon, 13 Jul 2020 16:29:55 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 17 Jul 2020 16:47:43 +02:00

x86/platform/uv: Remove support for UV1 platform from uv_time

UV1 is not longer supported

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200713212954.610885520@hpe.com

---
 arch/x86/platform/uv/uv_time.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/x86/platform/uv/uv_time.c b/arch/x86/platform/uv/uv_time.c
index 7af31b2..f82a133 100644
--- a/arch/x86/platform/uv/uv_time.c
+++ b/arch/x86/platform/uv/uv_time.c
@@ -74,7 +74,6 @@ static void uv_rtc_send_IPI(int cpu)
 
 	apicid = cpu_physical_id(cpu);
 	pnode = uv_apicid_to_pnode(apicid);
-	apicid |= uv_apicid_hibits;
 	val = (1UL << UVH_IPI_INT_SEND_SHFT) |
 	      (apicid << UVH_IPI_INT_APIC_ID_SHFT) |
 	      (X86_PLATFORM_IPI_VECTOR << UVH_IPI_INT_VECTOR_SHFT);
@@ -85,10 +84,7 @@ static void uv_rtc_send_IPI(int cpu)
 /* Check for an RTC interrupt pending */
 static int uv_intr_pending(int pnode)
 {
-	if (is_uv1_hub())
-		return uv_read_global_mmr64(pnode, UVH_EVENT_OCCURRED0) &
-			UV1H_EVENT_OCCURRED0_RTC1_MASK;
-	else if (is_uvx_hub())
+	if (is_uvx_hub())
 		return uv_read_global_mmr64(pnode, UVXH_EVENT_OCCURRED2) &
 			UVXH_EVENT_OCCURRED2_RTC_1_MASK;
 	return 0;
@@ -98,19 +94,15 @@ static int uv_intr_pending(int pnode)
 static int uv_setup_intr(int cpu, u64 expires)
 {
 	u64 val;
-	unsigned long apicid = cpu_physical_id(cpu) | uv_apicid_hibits;
+	unsigned long apicid = cpu_physical_id(cpu);
 	int pnode = uv_cpu_to_pnode(cpu);
 
 	uv_write_global_mmr64(pnode, UVH_RTC1_INT_CONFIG,
 		UVH_RTC1_INT_CONFIG_M_MASK);
 	uv_write_global_mmr64(pnode, UVH_INT_CMPB, -1L);
 
-	if (is_uv1_hub())
-		uv_write_global_mmr64(pnode, UVH_EVENT_OCCURRED0_ALIAS,
-				UV1H_EVENT_OCCURRED0_RTC1_MASK);
-	else
-		uv_write_global_mmr64(pnode, UVXH_EVENT_OCCURRED2_ALIAS,
-				UVXH_EVENT_OCCURRED2_RTC_1_MASK);
+	uv_write_global_mmr64(pnode, UVXH_EVENT_OCCURRED2_ALIAS,
+			      UVXH_EVENT_OCCURRED2_RTC_1_MASK);
 
 	val = (X86_PLATFORM_IPI_VECTOR << UVH_RTC1_INT_CONFIG_VECTOR_SHFT) |
 		((u64)apicid << UVH_RTC1_INT_CONFIG_APIC_ID_SHFT);
