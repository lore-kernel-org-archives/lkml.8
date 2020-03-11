Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6DEC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0AD1206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgCKHtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:49:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:51790 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgCKHtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:49:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 28D19AF2F;
        Wed, 11 Mar 2020 07:49:20 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] misc: mic: Use scnprintf() for avoiding potential buffer overflow
Date:   Wed, 11 Mar 2020 08:49:16 +0100
Message-Id: <20200311074916.8783-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/misc/mic/host/mic_x100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mic/host/mic_x100.c b/drivers/misc/mic/host/mic_x100.c
index a7743312da9c..d18cda966912 100644
--- a/drivers/misc/mic/host/mic_x100.c
+++ b/drivers/misc/mic/host/mic_x100.c
@@ -350,10 +350,10 @@ mic_x100_load_command_line(struct mic_device *mdev, const struct firmware *fw)
 	if (!buf)
 		return -ENOMEM;
 
-	len += snprintf(buf, CMDLINE_SIZE - len,
+	len += scnprintf(buf, CMDLINE_SIZE - len,
 		" mem=%dM", boot_mem);
 	if (mdev->cosm_dev->cmdline)
-		snprintf(buf + len, CMDLINE_SIZE - len, " %s",
+		scnprintf(buf + len, CMDLINE_SIZE - len, " %s",
 			 mdev->cosm_dev->cmdline);
 	memcpy_toio(cmd_line_va, buf, strlen(buf) + 1);
 	kfree(buf);
-- 
2.16.4

