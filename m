Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B8EC35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5172720637
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582274145;
	bh=JjKT3jkmYWo+VH1cMi7pE58cT6ZhUpPjOMoPMHW4uHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wCj+ritLwc26BOZxuZHNi7Mfq+wSmQTtdQ0H5z4rRihe1FZe0CnKd66dHWGJNtaYK
	 5D1L+2GkDoLfLemn0/qw7XFA0oAJW59B/FefA/Z7vEJAlDrLO/PmE1VzPcynCZGOY8
	 MsXLEKZmGtDNEb/9siDOu1fkxsY7pcWw7qUcwwOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730665AbgBUIHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:07:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:41184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731880AbgBUIHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:07:06 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AC2D20578;
        Fri, 21 Feb 2020 08:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272425;
        bh=JjKT3jkmYWo+VH1cMi7pE58cT6ZhUpPjOMoPMHW4uHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=axApk/MsjyxfnWZZCfuj3vmNij8jai48Fhr/KFNcXyWeGhsaVcd4lyXwikdplH/vU
         4ckPTWqzDqaKsfaMIwKgJPbNFur6LYBYrXrfBd3pOXQWj1PKcMXBV7/Wfz1RIOoIIn
         EjUWiMs+KMFvfJK/cetPkrIq9nBpzatY4m4Nly6U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Larry Finger <Larry.Finger@lwfinger.net>,
        Phong Tran <tranmanphong@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 137/344] b43legacy: Fix -Wcast-function-type
Date:   Fri, 21 Feb 2020 08:38:56 +0100
Message-Id: <20200221072401.272340366@linuxfoundation.org>
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

[ Upstream commit 475eec112e4267232d10f4afe2f939a241692b6c ]

correct usage prototype of callback in tasklet_init().
Report by https://github.com/KSPP/linux/issues/20

Tested-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Phong Tran <tranmanphong@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/broadcom/b43legacy/main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43legacy/main.c b/drivers/net/wireless/broadcom/b43legacy/main.c
index 4325e91736eb3..8b6b657c4b85b 100644
--- a/drivers/net/wireless/broadcom/b43legacy/main.c
+++ b/drivers/net/wireless/broadcom/b43legacy/main.c
@@ -1275,8 +1275,9 @@ static void handle_irq_ucode_debug(struct b43legacy_wldev *dev)
 }
 
 /* Interrupt handler bottom-half */
-static void b43legacy_interrupt_tasklet(struct b43legacy_wldev *dev)
+static void b43legacy_interrupt_tasklet(unsigned long data)
 {
+	struct b43legacy_wldev *dev = (struct b43legacy_wldev *)data;
 	u32 reason;
 	u32 dma_reason[ARRAY_SIZE(dev->dma_reason)];
 	u32 merged_dma_reason = 0;
@@ -3741,7 +3742,7 @@ static int b43legacy_one_core_attach(struct ssb_device *dev,
 	b43legacy_set_status(wldev, B43legacy_STAT_UNINIT);
 	wldev->bad_frames_preempt = modparam_bad_frames_preempt;
 	tasklet_init(&wldev->isr_tasklet,
-		     (void (*)(unsigned long))b43legacy_interrupt_tasklet,
+		     b43legacy_interrupt_tasklet,
 		     (unsigned long)wldev);
 	if (modparam_pio)
 		wldev->__using_pio = true;
-- 
2.20.1



