Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079EBC35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D401920578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582272436;
	bh=6bg20xgzmssxyeH7ivBMhEcUxrLYmmoh21+Gie1Fxxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xyiTdbhtd9TY0NR8uwETZdghu5So1wcwAXsKWRa8TEE2bMgp6qGmsE1nAaByFJ0R5
	 UuvQ7yu8t/bbfkboewtCmzoGV6TBwQGc6VIa3Nx60YXENTkqygEuRHx31e4oaVf/56
	 Gxbh74MAhQ2ZGnnc+5g/ptssg4jKRfAy3wT34sY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731734AbgBUIHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:07:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:41316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732038AbgBUIHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:07:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D681B20578;
        Fri, 21 Feb 2020 08:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272431;
        bh=6bg20xgzmssxyeH7ivBMhEcUxrLYmmoh21+Gie1Fxxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wKbGHGdQFEU2JmPC5WLQ1b60q6MbfufxCMuJGm+N6s8qU2OWsKa3ZO4R6xjY1U6ai
         tP/LWgC12LOML9uftAnDtH5XeIs7QQiK00OfT6tNZTNym49BaKHsmZIp47BtEP5zP3
         L9FGbseoB/aguY+roQuDmxFV4Np3/Ozk1EQlALrA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Phong Tran <tranmanphong@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 139/344] iwlegacy: Fix -Wcast-function-type
Date:   Fri, 21 Feb 2020 08:38:58 +0100
Message-Id: <20200221072401.464557052@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
References: <20200221072349.335551332@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phong Tran <tranmanphong@gmail.com>

[ Upstream commit da5e57e8a6a3e69dac2937ba63fa86355628fbb2 ]

correct usage prototype of callback in tasklet_init().
Report by https://github.com/KSPP/linux/issues/20

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlegacy/3945-mac.c | 5 +++--
 drivers/net/wireless/intel/iwlegacy/4965-mac.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/3945-mac.c b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
index 4fbcc7fba3cc1..e2e9c3e8fff51 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
@@ -1376,8 +1376,9 @@ il3945_dump_nic_error_log(struct il_priv *il)
 }
 
 static void
-il3945_irq_tasklet(struct il_priv *il)
+il3945_irq_tasklet(unsigned long data)
 {
+	struct il_priv *il = (struct il_priv *)data;
 	u32 inta, handled = 0;
 	u32 inta_fh;
 	unsigned long flags;
@@ -3403,7 +3404,7 @@ il3945_setup_deferred_work(struct il_priv *il)
 	timer_setup(&il->watchdog, il_bg_watchdog, 0);
 
 	tasklet_init(&il->irq_tasklet,
-		     (void (*)(unsigned long))il3945_irq_tasklet,
+		     il3945_irq_tasklet,
 		     (unsigned long)il);
 }
 
diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
index ffb705b18fb13..5fe17039a3375 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
@@ -4344,8 +4344,9 @@ il4965_synchronize_irq(struct il_priv *il)
 }
 
 static void
-il4965_irq_tasklet(struct il_priv *il)
+il4965_irq_tasklet(unsigned long data)
 {
+	struct il_priv *il = (struct il_priv *)data;
 	u32 inta, handled = 0;
 	u32 inta_fh;
 	unsigned long flags;
@@ -6238,7 +6239,7 @@ il4965_setup_deferred_work(struct il_priv *il)
 	timer_setup(&il->watchdog, il_bg_watchdog, 0);
 
 	tasklet_init(&il->irq_tasklet,
-		     (void (*)(unsigned long))il4965_irq_tasklet,
+		     il4965_irq_tasklet,
 		     (unsigned long)il);
 }
 
-- 
2.20.1



