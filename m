Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CD2C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C60BC2072D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gs/QVnsj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kz9wYDXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgHSMeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbgHSMdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:33:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842C1C061344;
        Wed, 19 Aug 2020 05:33:19 -0700 (PDT)
Date:   Wed, 19 Aug 2020 12:33:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597840393;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dtoTID8EnlXgOhbcaoVmq0CgWHupHYcnvxqbDb720g4=;
        b=gs/QVnsjnkfn2HLabVtp4HWqUjI02BuJa12/n5oB6jzrn1rUyP7LXd5CUavkH2EnbX3OuN
        dZYAuCGoSIUyW3us/5Edy1ypwB+UQxPPIq9Jt2ZWehdlHHpgppogRADPT2+pnd9iS1aNC4
        WMI3G7jWRxOob89GmjUONtOnicQkLtkCPIEkrESkvnEstqDd7U0D3XNPZBWhTeDaa4pC+R
        kmicSAaX7qDo7jAa7UVSDN4jcpzQZ8cgswPD60YejNSYmXBszoLJ6jE5ag5RTASt3AcIr9
        qdPN86WlfRwYFcesu8ECY+/SBwISx+OL0830VIytHUJDR09cx/7Q+eqwWVD6hQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597840393;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dtoTID8EnlXgOhbcaoVmq0CgWHupHYcnvxqbDb720g4=;
        b=kz9wYDXyU/JdGS+3Bw2a4ar/QvqGNAd+Cum2BRZGFu8ZMI/svWV6QVJRarXgvJI0/LS1hO
        1in8mOBZ8ZYqXwAw==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Remove struct rdt_membw::max_delay
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200708163929.2783-3-james.morse@arm.com>
References: <20200708163929.2783-3-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <159784039302.3192.3471663986483240927.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     e89f85b9171665c917dca59920884f3d4fe0b1ef
Gitweb:        https://git.kernel.org/tip/e89f85b9171665c917dca59920884f3d4fe0b1ef
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Wed, 08 Jul 2020 16:39:21 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 18 Aug 2020 17:01:23 +02:00

x86/resctrl: Remove struct rdt_membw::max_delay

max_delay is used by x86's __get_mem_config_intel() as a local variable.
Remove it, replacing it with a local variable.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lkml.kernel.org/r/20200708163929.2783-3-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/core.c     | 8 ++++----
 arch/x86/kernel/cpu/resctrl/internal.h | 3 ---
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 6a9df71..9225ee5 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -254,16 +254,16 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
 {
 	union cpuid_0x10_3_eax eax;
 	union cpuid_0x10_x_edx edx;
-	u32 ebx, ecx;
+	u32 ebx, ecx, max_delay;
 
 	cpuid_count(0x00000010, 3, &eax.full, &ebx, &ecx, &edx.full);
 	r->num_closid = edx.split.cos_max + 1;
-	r->membw.max_delay = eax.split.max_delay + 1;
+	max_delay = eax.split.max_delay + 1;
 	r->default_ctrl = MAX_MBA_BW;
 	if (ecx & MBA_IS_LINEAR) {
 		r->membw.delay_linear = true;
-		r->membw.min_bw = MAX_MBA_BW - r->membw.max_delay;
-		r->membw.bw_gran = MAX_MBA_BW - r->membw.max_delay;
+		r->membw.min_bw = MAX_MBA_BW - max_delay;
+		r->membw.bw_gran = MAX_MBA_BW - max_delay;
 	} else {
 		if (!rdt_get_mb_table(r))
 			return false;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 72bb210..1eb39bd 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -369,8 +369,6 @@ struct rdt_cache {
 
 /**
  * struct rdt_membw - Memory bandwidth allocation related data
- * @max_delay:		Max throttle delay. Delay is the hardware
- *			representation for memory bandwidth.
  * @min_bw:		Minimum memory bandwidth percentage user can request
  * @bw_gran:		Granularity at which the memory bandwidth is allocated
  * @delay_linear:	True if memory B/W delay is in linear scale
@@ -378,7 +376,6 @@ struct rdt_cache {
  * @mb_map:		Mapping of memory B/W percentage to memory B/W delay
  */
 struct rdt_membw {
-	u32		max_delay;
 	u32		min_bw;
 	u32		bw_gran;
 	u32		delay_linear;
