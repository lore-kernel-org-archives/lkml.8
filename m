Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2C1C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 382C12084D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgEGOIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgEGOH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:07:27 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46E3C05BD43;
        Thu,  7 May 2020 07:07:26 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jWhBL-000281-GH; Thu, 07 May 2020 16:07:23 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1C13A1C001A;
        Thu,  7 May 2020 16:07:23 +0200 (CEST)
Date:   Thu, 07 May 2020 14:07:23 -0000
From:   "tip-bot2 for Christoph Hellwig" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Remove the UV*_HUB_IS_SUPPORTED macros
Cc:     Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russ Anderson <rja@hpe.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200504171527.2845224-6-hch@lst.de>
References: <20200504171527.2845224-6-hch@lst.de>
MIME-Version: 1.0
Message-ID: <158886044307.8414.15217547118518717450.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     cc1991058705a9cc4fe51ab6c2116df17922ef82
Gitweb:        https://git.kernel.org/tip/cc1991058705a9cc4fe51ab6c2116df17922ef82
Author:        Christoph Hellwig <hch@lst.de>
AuthorDate:    Mon, 04 May 2020 19:15:21 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 May 2020 15:32:21 +02:00

x86/platform/uv: Remove the UV*_HUB_IS_SUPPORTED macros

All of the macros are always defined to one.  Remove them and the dead
code keyed off them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Not-acked-by:  Dimitri Sivanich <sivanich@hpe.com>
Cc: Russ Anderson <rja@hpe.com>
Link: https://lkml.kernel.org/r/20200504171527.2845224-6-hch@lst.de

---
 arch/x86/include/asm/uv/uv_hub.h  | 19 -------------------
 arch/x86/include/asm/uv/uv_mmrs.h |  7 -------
 2 files changed, 26 deletions(-)

diff --git a/arch/x86/include/asm/uv/uv_hub.h b/arch/x86/include/asm/uv/uv_hub.h
index 950cd13..a998e65 100644
--- a/arch/x86/include/asm/uv/uv_hub.h
+++ b/arch/x86/include/asm/uv/uv_hub.h
@@ -244,51 +244,32 @@ static inline int uv_hub_info_check(int version)
 #define UV4_HUB_REVISION_BASE		7
 #define UV4A_HUB_REVISION_BASE		8	/* UV4 (fixed) rev 2 */
 
-/* WARNING: UVx_HUB_IS_SUPPORTED defines are deprecated and will be removed */
 static inline int is_uv1_hub(void)
 {
-#ifdef	UV1_HUB_IS_SUPPORTED
 	return is_uv_hubbed(uv(1));
-#else
-	return 0;
-#endif
 }
 
 static inline int is_uv2_hub(void)
 {
-#ifdef	UV2_HUB_IS_SUPPORTED
 	return is_uv_hubbed(uv(2));
-#else
-	return 0;
-#endif
 }
 
 static inline int is_uv3_hub(void)
 {
-#ifdef	UV3_HUB_IS_SUPPORTED
 	return is_uv_hubbed(uv(3));
-#else
-	return 0;
-#endif
 }
 
 /* First test "is UV4A", then "is UV4" */
 static inline int is_uv4a_hub(void)
 {
-#ifdef	UV4A_HUB_IS_SUPPORTED
 	if (is_uv_hubbed(uv(4)))
 		return (uv_hub_info->hub_revision == UV4A_HUB_REVISION_BASE);
-#endif
 	return 0;
 }
 
 static inline int is_uv4_hub(void)
 {
-#ifdef	UV4_HUB_IS_SUPPORTED
 	return is_uv_hubbed(uv(4));
-#else
-	return 0;
-#endif
 }
 
 static inline int is_uvx_hub(void)
diff --git a/arch/x86/include/asm/uv/uv_mmrs.h b/arch/x86/include/asm/uv/uv_mmrs.h
index 62c79e2..9ee5ed6 100644
--- a/arch/x86/include/asm/uv/uv_mmrs.h
+++ b/arch/x86/include/asm/uv/uv_mmrs.h
@@ -99,13 +99,6 @@
 #define UV3_HUB_PART_NUMBER_X	0x4321
 #define UV4_HUB_PART_NUMBER	0x99a1
 
-/* Compat: Indicate which UV Hubs are supported. */
-#define UV1_HUB_IS_SUPPORTED	1
-#define UV2_HUB_IS_SUPPORTED	1
-#define UV3_HUB_IS_SUPPORTED	1
-#define UV4_HUB_IS_SUPPORTED	1
-#define UV4A_HUB_IS_SUPPORTED	1
-
 /* Error function to catch undefined references */
 extern unsigned long uv_undefined(char *str);
 
