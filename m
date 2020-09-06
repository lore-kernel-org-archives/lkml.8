Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5884C43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 19:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6797A208B3
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 19:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="UsuAxr5q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgIFTaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 15:30:46 -0400
Received: from crapouillou.net ([89.234.176.41]:35874 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgIFTap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 15:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1599420590; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rrrt5HoP/VVUW2qAG5IfseT3oimk5TMDtCPW0Cfm0Yw=;
        b=UsuAxr5qCoGXUE2tDlqLATyLJHQSSb3oR1t6gKPVSjE9gZqXla+a3F1BgB3XIVMykXUt+Z
        I/bUYR/Iy34uoWR+EU+jfkEtMXQJ7QvFkyMNsaSKyiNlheEeEX2oyx9GVS+EqfbQefzrWX
        /xiC4NwtWXD0uTnOQvxMdlZ19Czwfsg=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     "Maciej W . Rozycki" <macro@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        Zhou Yanjie <zhouyanjie@wanyeetech.com>, od@zcrc.me,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 06/15] MIPS: generic: Allow boards to set system type
Date:   Sun,  6 Sep 2020 21:29:26 +0200
Message-Id: <20200906192935.107086-7-paul@crapouillou.net>
In-Reply-To: <20200906192935.107086-1-paul@crapouillou.net>
References: <20200906192935.107086-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check for the (already existing) "system_type" variable in the
get_system_type() function. If non-NULL, return it as the system type.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: Instead of adding a .get_system_type callback to the mips_machine
    	struct, the boards now simply override the "system_type" variable
    	when they want to set a custom one.
    
    v3: No change

 arch/mips/generic/proc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/generic/proc.c b/arch/mips/generic/proc.c
index 4c992809cc3f..cce2fde219a3 100644
--- a/arch/mips/generic/proc.c
+++ b/arch/mips/generic/proc.c
@@ -8,11 +8,16 @@
 
 #include <asm/bootinfo.h>
 
+char *system_type;
+
 const char *get_system_type(void)
 {
 	const char *str;
 	int err;
 
+	if (system_type)
+		return system_type;
+
 	err = of_property_read_string(of_root, "model", &str);
 	if (!err)
 		return str;
-- 
2.28.0

