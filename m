Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF13C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FDFA20737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416205AbgDOQpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:45:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:44200 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416181AbgDOQpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:45:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6C043ABC7;
        Wed, 15 Apr 2020 16:45:02 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: Drop unused pages field from struct firmware
Date:   Wed, 15 Apr 2020 18:45:00 +0200
Message-Id: <20200415164500.28749-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct firmware contains a page table pointer that was used only
internally in the past.  Since the actual page tables are referred
from struct fw_priv and should be never from struct firmware, we can
drop this unused field gracefully.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/base/firmware_loader/main.c | 3 ---
 include/linux/firmware.h            | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 76f79913916d..5296aaca35cf 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -548,9 +548,6 @@ static void firmware_free_data(const struct firmware *fw)
 static void fw_set_page_data(struct fw_priv *fw_priv, struct firmware *fw)
 {
 	fw->priv = fw_priv;
-#ifdef CONFIG_FW_LOADER_USER_HELPER
-	fw->pages = fw_priv->pages;
-#endif
 	fw->size = fw_priv->size;
 	fw->data = fw_priv->data;
 
diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index 4bbd0afd91b7..cb3e2c06ed8a 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -12,7 +12,6 @@
 struct firmware {
 	size_t size;
 	const u8 *data;
-	struct page **pages;
 
 	/* firmware loader private fields */
 	void *priv;
-- 
2.25.0

