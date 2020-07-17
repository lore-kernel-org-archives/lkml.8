Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DF3C433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D735207EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pyok3V3X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tVUHKEFC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgGQOvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:51:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41184 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbgGQOvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:51:15 -0400
Date:   Fri, 17 Jul 2020 14:51:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594997471;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yr/ArMpWvm0dDDNKC3p0jopudAskrVmCtE9kA48NBn0=;
        b=pyok3V3XUtgW0vO8SUAqxciYxvhV7bvFCRJOmoeMUzeUAfyL5DJ88lpz8Hm/+BPI4uMe/k
        aY8AVV8JExfymflVNpH9d+NR4FVYB4VSFBl9T81KyS72Fc0z0I6Wt0+FlPwyAqQ3e+13Ww
        +J+26EhWjWu00p9i+k2MO3YCuRsyrO9jzQVxEVbOYHPQXjEH1/5nCBvii5M4PrmGtf0WnO
        FvMuH63pePXuJD6ZSDH0i0vNdsdi7CgSqfEtEfrB3kRD4aqqzBJP0gRKI+L1w669bO7/ql
        EI17/ix4VHDtE5ZWuU6YEgOExYt7jeTpxoevC4PS9onRe72qLzGuKUOZ4qK0fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594997471;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yr/ArMpWvm0dDDNKC3p0jopudAskrVmCtE9kA48NBn0=;
        b=tVUHKEFCbpRtVqfZ/hvT8MTWKOzLfkZAL0HAn/ZSzMa2AiViUhyQhKlprx2xTkx2KEVpLf
        qH5kCSGBH6wohjBQ==
From:   "tip-bot2 for steve.wahl@hpe.com" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Remove support for UV1 platform
 from uv_bau
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200713212955.083309377@hpe.com>
References: <20200713212955.083309377@hpe.com>
MIME-Version: 1.0
Message-ID: <159499747120.4006.835579346373365906.tip-bot2@tip-bot2>
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

Commit-ID:     711621a098f4d62a9cdbcfc105e804fe8c22f8bb
Gitweb:        https://git.kernel.org/tip/711621a098f4d62a9cdbcfc105e804fe8c22f8bb
Author:        steve.wahl@hpe.com <steve.wahl@hpe.com>
AuthorDate:    Mon, 13 Jul 2020 16:29:59 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 17 Jul 2020 16:47:45 +02:00

x86/platform/uv: Remove support for UV1 platform from uv_bau

UV1 is not longer supported.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200713212955.083309377@hpe.com

---
 arch/x86/include/asm/uv/uv_bau.h | 118 +-----------------------------
 arch/x86/platform/uv/tlb_uv.c    |   4 +-
 2 files changed, 9 insertions(+), 113 deletions(-)

diff --git a/arch/x86/include/asm/uv/uv_bau.h b/arch/x86/include/asm/uv/uv_bau.h
index f1188bd..cd24804 100644
--- a/arch/x86/include/asm/uv/uv_bau.h
+++ b/arch/x86/include/asm/uv/uv_bau.h
@@ -46,10 +46,7 @@
 #define UV_ACT_STATUS_SIZE		2
 #define UV_DISTRIBUTION_SIZE		256
 #define UV_SW_ACK_NPENDING		8
-#define UV1_NET_ENDPOINT_INTD		0x38
-#define UV2_NET_ENDPOINT_INTD		0x28
-#define UV_NET_ENDPOINT_INTD		(is_uv1_hub() ?			\
-			UV1_NET_ENDPOINT_INTD : UV2_NET_ENDPOINT_INTD)
+#define UV_NET_ENDPOINT_INTD		0x28
 #define UV_PAYLOADQ_GNODE_SHIFT		49
 #define UV_PTC_BASENAME			"sgi_uv/ptc_statistics"
 #define UV_BAU_BASENAME			"sgi_uv/bau_tunables"
@@ -64,14 +61,9 @@
  * UV2: Bit 19 selects between
  *  (0): 10 microsecond timebase and
  *  (1): 80 microseconds
- *  we're using 560us, similar to UV1: 65 units of 10us
+ *  we're using 560us
  */
-#define UV1_INTD_SOFT_ACK_TIMEOUT_PERIOD (9UL)
-#define UV2_INTD_SOFT_ACK_TIMEOUT_PERIOD (15UL)
-
-#define UV_INTD_SOFT_ACK_TIMEOUT_PERIOD	(is_uv1_hub() ?			\
-		UV1_INTD_SOFT_ACK_TIMEOUT_PERIOD :			\
-		UV2_INTD_SOFT_ACK_TIMEOUT_PERIOD)
+#define UV_INTD_SOFT_ACK_TIMEOUT_PERIOD	(15UL)
 /* assuming UV3 is the same */
 
 #define BAU_MISC_CONTROL_MULT_MASK	3
@@ -148,7 +140,6 @@
 
 #define UV_LB_SUBNODEID			0x10
 
-/* these two are the same for UV1 and UV2: */
 #define UV_SA_SHFT UVH_LB_BAU_MISC_CONTROL_INTD_SOFT_ACK_TIMEOUT_PERIOD_SHFT
 #define UV_SA_MASK UVH_LB_BAU_MISC_CONTROL_INTD_SOFT_ACK_TIMEOUT_PERIOD_MASK
 /* 4 bits of software ack period */
@@ -189,8 +180,7 @@
 #define BAU_DESC_QUALIFIER		0x534749
 
 enum uv_bau_version {
-	UV_BAU_V1 = 1,
-	UV_BAU_V2,
+	UV_BAU_V2 = 2,
 	UV_BAU_V3,
 	UV_BAU_V4,
 };
@@ -233,12 +223,12 @@ struct bau_local_cpumask {
  */
 
 /**
- * struct uv1_2_3_bau_msg_payload - defines payload for INTD transactions
+ * struct uv2_3_bau_msg_payload - defines payload for INTD transactions
  * @address:		Signifies a page or all TLB's of the cpu
  * @sending_cpu:	CPU from which the message originates
  * @acknowledge_count:	CPUs on the destination Hub that received the interrupt
  */
-struct uv1_2_3_bau_msg_payload {
+struct uv2_3_bau_msg_payload {
 	u64 address;
 	u16 sending_cpu;
 	u16 acknowledge_count;
@@ -260,89 +250,6 @@ struct uv4_bau_msg_payload {
 };
 
 /*
- * UV1 Message header:  16 bytes (128 bits) (bytes 0x30-0x3f of descriptor)
- * see table 4.2.3.0.1 in broacast_assist spec.
- */
-struct uv1_bau_msg_header {
-	unsigned int	dest_subnodeid:6;	/* must be 0x10, for the LB */
-	/* bits 5:0 */
-	unsigned int	base_dest_nasid:15;	/* nasid of the first bit */
-	/* bits 20:6 */				/* in uvhub map */
-	unsigned int	command:8;		/* message type */
-	/* bits 28:21 */
-	/* 0x38: SN3net EndPoint Message */
-	unsigned int	rsvd_1:3;		/* must be zero */
-	/* bits 31:29 */
-	/* int will align on 32 bits */
-	unsigned int	rsvd_2:9;		/* must be zero */
-	/* bits 40:32 */
-	/* Suppl_A is 56-41 */
-	unsigned int	sequence:16;		/* message sequence number */
-	/* bits 56:41 */			/* becomes bytes 16-17 of msg */
-						/* Address field (96:57) is
-						   never used as an address
-						   (these are address bits
-						   42:3) */
-
-	unsigned int	rsvd_3:1;		/* must be zero */
-	/* bit 57 */
-	/* address bits 27:4 are payload */
-	/* these next 24  (58-81) bits become bytes 12-14 of msg */
-	/* bits 65:58 land in byte 12 */
-	unsigned int	replied_to:1;		/* sent as 0 by the source to
-						   byte 12 */
-	/* bit 58 */
-	unsigned int	msg_type:3;		/* software type of the
-						   message */
-	/* bits 61:59 */
-	unsigned int	canceled:1;		/* message canceled, resource
-						   is to be freed*/
-	/* bit 62 */
-	unsigned int	payload_1a:1;		/* not currently used */
-	/* bit 63 */
-	unsigned int	payload_1b:2;		/* not currently used */
-	/* bits 65:64 */
-
-	/* bits 73:66 land in byte 13 */
-	unsigned int	payload_1ca:6;		/* not currently used */
-	/* bits 71:66 */
-	unsigned int	payload_1c:2;		/* not currently used */
-	/* bits 73:72 */
-
-	/* bits 81:74 land in byte 14 */
-	unsigned int	payload_1d:6;		/* not currently used */
-	/* bits 79:74 */
-	unsigned int	payload_1e:2;		/* not currently used */
-	/* bits 81:80 */
-
-	unsigned int	rsvd_4:7;		/* must be zero */
-	/* bits 88:82 */
-	unsigned int	swack_flag:1;		/* software acknowledge flag */
-	/* bit 89 */
-						/* INTD trasactions at
-						   destination are to wait for
-						   software acknowledge */
-	unsigned int	rsvd_5:6;		/* must be zero */
-	/* bits 95:90 */
-	unsigned int	rsvd_6:5;		/* must be zero */
-	/* bits 100:96 */
-	unsigned int	int_both:1;		/* if 1, interrupt both sockets
-						   on the uvhub */
-	/* bit 101*/
-	unsigned int	fairness:3;		/* usually zero */
-	/* bits 104:102 */
-	unsigned int	multilevel:1;		/* multi-level multicast
-						   format */
-	/* bit 105 */
-	/* 0 for TLB: endpoint multi-unicast messages */
-	unsigned int	chaining:1;		/* next descriptor is part of
-						   this activation*/
-	/* bit 106 */
-	unsigned int	rsvd_7:21;		/* must be zero */
-	/* bits 127:107 */
-};
-
-/*
  * UV2 Message header:  16 bytes (128 bits) (bytes 0x30-0x3f of descriptor)
  * see figure 9-2 of harp_sys.pdf
  * assuming UV3 is the same
@@ -418,25 +325,14 @@ struct bau_desc {
 	 * message template, consisting of header and payload:
 	 */
 	union bau_msg_header {
-		struct uv1_bau_msg_header	uv1_hdr;
 		struct uv2_3_bau_msg_header	uv2_3_hdr;
 	} header;
 
 	union bau_payload_header {
-		struct uv1_2_3_bau_msg_payload	uv1_2_3;
+		struct uv2_3_bau_msg_payload	uv2_3;
 		struct uv4_bau_msg_payload	uv4;
 	} payload;
 };
-/* UV1:
- *   -payload--    ---------header------
- *   bytes 0-11    bits 41-56  bits 58-81
- *       A           B  (2)      C (3)
- *
- *            A/B/C are moved to:
- *       A            C          B
- *   bytes 0-11  bytes 12-14  bytes 16-17  (byte 15 filled in by hw as vector)
- *   ------------payload queue-----------
- */
 /* UV2:
  *   -payload--    ---------header------
  *   bytes 0-11    bits 70-78  bits 21-44
diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
index 395073d..62ea907 100644
--- a/arch/x86/platform/uv/tlb_uv.c
+++ b/arch/x86/platform/uv/tlb_uv.c
@@ -1050,8 +1050,8 @@ const struct cpumask *uv_flush_tlb_others(const struct cpumask *cpumask,
 	switch (bcp->uvhub_version) {
 	case UV_BAU_V2:
 	case UV_BAU_V3:
-		bau_desc->payload.uv1_2_3.address = address;
-		bau_desc->payload.uv1_2_3.sending_cpu = cpu;
+		bau_desc->payload.uv2_3.address = address;
+		bau_desc->payload.uv2_3.sending_cpu = cpu;
 		break;
 	case UV_BAU_V4:
 		bau_desc->payload.uv4.address = address;
