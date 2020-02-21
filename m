Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10102C35642
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4ED206ED
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582274685;
	bh=QuibLGJxi5N9X8ol8r7LnQclohG6opJBBZnbALm4+OI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qH7pngSkWFuLdvcVRlK0rH2OnZoDvgGh2CLJFzvScwjbMShqG0lOQZt2Yg8+8ofWq
	 vgX62A0JtDchtA7xT+UBkzDWWVSWH9u/KcSnKy9eIh5axBQaC5a4wJrD1FnuMvsFvy
	 mtLrnUcjDexcSPoFvLRxIb9bG9ZcLvo0UCaOZOZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbgBUHvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:51:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:49380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729812AbgBUHvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:51:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8B0D2073A;
        Fri, 21 Feb 2020 07:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271509;
        bh=QuibLGJxi5N9X8ol8r7LnQclohG6opJBBZnbALm4+OI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I3fOpuT4/mwarSsMPxjF1X5g1Z0/QujVcVXSTz2I5bHtx6BercFSFv6W4jPBg+KMX
         zQqAkysEW/SgEgIvwYt/gTK3IX2gBlZvm0jVU9DIVc5NW64PLDu18W4V97FlICjJSt
         ev+V5+HM6jRhD+Kk8OIxjXk9slwStw9N184QRzV0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Phong Tran <tranmanphong@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 156/399] iwlegacy: Fix -Wcast-function-type
Date:   Fri, 21 Feb 2020 08:38:01 +0100
Message-Id: <20200221072417.685989842@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
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
index 1168055da1828..206b43b9dff86 100644
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
@@ -3401,7 +3402,7 @@ il3945_setup_deferred_work(struct il_priv *il)
 	timer_setup(&il->watchdog, il_bg_watchdog, 0);
 
 	tasklet_init(&il->irq_tasklet,
-		     (void (*)(unsigned long))il3945_irq_tasklet,
+		     il3945_irq_tasklet,
 		     (unsigned long)il);
 }
 
diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
index 3664f56f8cbd0..d1e17589dbeb7 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
@@ -4343,8 +4343,9 @@ il4965_synchronize_irq(struct il_priv *il)
 }
 
 static void
-il4965_irq_tasklet(struct il_priv *il)
+il4965_irq_tasklet(unsigned long data)
 {
+	struct il_priv *il = (struct il_priv *)data;
 	u32 inta, handled = 0;
 	u32 inta_fh;
 	unsigned long flags;
@@ -6237,7 +6238,7 @@ il4965_setup_deferred_work(struct il_priv *il)
 	timer_setup(&il->watchdog, il_bg_watchdog, 0);
 
 	tasklet_init(&il->irq_tasklet,
-		     (void (*)(unsigned long))il4965_irq_tasklet,
+		     il4965_irq_tasklet,
 		     (unsigned long)il);
 }
 
-- 
2.20.1



