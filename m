Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0756C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A84F720775
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbYqDwbe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgD2PgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbgD2PgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:36:07 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDF8C03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 08:36:07 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id x26so1169313pgc.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 08:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TJNMR4oboW7WFcnPibORXRu4vpOcald9BO/lcSdsbJU=;
        b=KbYqDwbe+5X2nV8lcrIde+ORFQeQ3rrbblUybL+zsc2dj8sGqWcFfvo39qh+lAI4oJ
         VdbNlNrsY53rPimDsbKp88S8EZty1oNEqB/jbnsypAH6oezvvyGw8TImxfPIF7FNzB/t
         0X4d9EzhWgVFzM61F1G/Lysa9eDK30EsCR7Zu2O92SVY5CsPOaw7QU0taQ/9GdVemUYk
         gM5YoXIyRiO+98yvLLVXRPpL2yI99XAB72IypjVXubKwncZtvnx6iwDEh4iH91RB5KCd
         cukyO6mDVHCqrum+Lo7fNhtfITpRmCEQYdzwtE1/VF2FwojqoTUD2FnJpUmA/1M5mhl5
         NOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TJNMR4oboW7WFcnPibORXRu4vpOcald9BO/lcSdsbJU=;
        b=MZbceYqfoYh5RwyS5eMgGB8oIkactTDLibUpq3zj/x4oUgd8h1aqm+Ahj3RKoyqei/
         MuMrckXWcFnU8furBK9JPi7zmz0vtGLs/N9eg7BXm/A7IV6irvca0BfgUrwNDw/28I6t
         Gk9/np/NzYYOKKgg0RNtjjKZaLmCkUrkxCgGkb6BPYd5qXoq5+GgKuyfmFlklker36Xx
         4+55bbFlUM0bzBq636BP0KKvm7Gk3v48y/cZHwfKbL1utAXYQze6SqSLElLK4d9lYRkk
         t+EsiIQZO3lCkez1DnenpjU+F8kKEWLhVbTL983CGUNk6cU83rYMgFzf/5IXMfDJRFoy
         eOjw==
X-Gm-Message-State: AGi0PuaGttHztQB90Wbs3DYQR6AUm49NHnIzhGcB2WBtqITIIj2vitE0
        otoUUKRdVaFl7flG/aI04Z4=
X-Google-Smtp-Source: APiQypIljJQgPqTe8smMDubFOAi16dTLZaugpCJiNx+uWdfsu5l1tiz7Y3oSKdpcSrNdtXqmb+p5xA==
X-Received: by 2002:a62:144c:: with SMTP id 73mr36548770pfu.37.1588174567209;
        Wed, 29 Apr 2020 08:36:07 -0700 (PDT)
Received: from localhost ([89.208.244.169])
        by smtp.gmail.com with ESMTPSA id y7sm1367321pfq.21.2020.04.29.08.36.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Apr 2020 08:36:06 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     mark.rutland@arm.com, maz@kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH v1] drivers/clocksource/arm_arch_timer: remove duplicate error message
Date:   Wed, 29 Apr 2020 23:35:59 +0800
Message-Id: <20200429153559.21189-1-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

it will print an error message by itself when acpi_gtdt_init()
goes wrong. so remove the duplicate error message.

Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
 drivers/clocksource/arm_arch_timer.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 2204a444e801..ecf7b7db2d05 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1588,10 +1588,8 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 	arch_timers_present |= ARCH_TIMER_TYPE_CP15;
 
 	ret = acpi_gtdt_init(table, &platform_timer_count);
-	if (ret) {
-		pr_err("Failed to init GTDT table.\n");
+	if (ret)
 		return ret;
-	}
 
 	arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI] =
 		acpi_gtdt_map_ppi(ARCH_TIMER_PHYS_NONSECURE_PPI);
-- 
2.25.0

