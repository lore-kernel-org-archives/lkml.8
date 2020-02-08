Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9DCC35242
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 22:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D5E22522
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 22:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbgBHWUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 17:20:13 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50156 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbgBHWUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 17:20:13 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1j0YSM-00012H-9J; Sat, 08 Feb 2020 22:20:06 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hdsp: remove redundant assignment to variable err
Date:   Sat,  8 Feb 2020 22:20:06 +0000
Message-Id: <20200208222006.37376-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable err is being assigned with a value that is never read, it is
assigned a new value in the next statement. The assignment is redundant
and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/rme9652/hdsp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index cc06f0a1a7e4..227aece17e39 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -3353,7 +3353,8 @@ snd_hdsp_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
 				return;
 			}
 		} else {
-			int err = -EINVAL;
+			int err;
+
 			err = hdsp_request_fw_loader(hdsp);
 			if (err < 0) {
 				snd_iprintf(buffer,
-- 
2.25.0

