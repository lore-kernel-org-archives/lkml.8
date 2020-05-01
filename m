Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3754EC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A6B020836
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340662;
	bh=LHTo9DvQW6BxdBodV8TTM9gnOIZGXIo1XYPR6CZ17V8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f0wokTW8H6Q5/eGrfGeUtkSxusXV2WIV1R9zUl0TkDzJMiXUeBUL7zRFsp6p5Uo3f
	 lD2S0vJu4OvQbDdj/nOo/mLLMaMBahYXlkUQo7nTu4TfjYZnPrTcgjiGAIQd8SuebS
	 Vk6cxccvnhACuhNEoyWt1AaHUKGfbhPxiMpGqCLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731736AbgEANoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:44:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730973AbgEANoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:44:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F4F5216FD;
        Fri,  1 May 2020 13:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340657;
        bh=LHTo9DvQW6BxdBodV8TTM9gnOIZGXIo1XYPR6CZ17V8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LlDlgSeE3TL31ZwYhajbSe717eatPh/o+mAlWI2cAERXoOCfvBHi5fHcqLhIJ3bvp
         IobA9BtQrFKBviPAeVFUlPcTBdeg4CMRGj1oHcBqi9Hk0WHXg95fN/CcWJi6q11ZzN
         4K9sOFODBJ9N4io8Wvf4LxgQhI9bi7wDKLAfRrbE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hui Wang <hui.wang@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 083/106] ALSA: hda: call runtime_allow() for all hda controllers
Date:   Fri,  1 May 2020 15:23:56 +0200
Message-Id: <20200501131553.663916801@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131543.421333643@linuxfoundation.org>
References: <20200501131543.421333643@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hui Wang <hui.wang@canonical.com>

[ Upstream commit 9a6418487b566503c772cb6e7d3d44e652b019b0 ]

Before the pci_driver->probe() is called, the pci subsystem calls
runtime_forbid() and runtime_get_sync() on this pci dev, so only call
runtime_put_autosuspend() is not enough to enable the runtime_pm on
this device.

For controllers with vgaswitcheroo feature, the pci/quirks.c will call
runtime_allow() for this dev, then the controllers could enter
rt_idle/suspend/resume, but for non-vgaswitcheroo controllers like
Intel hda controllers, the runtime_pm is not enabled because the
runtime_allow() is not called.

Since it is no harm calling runtime_allow() twice, here let hda
driver call runtime_allow() for all controllers. Then the runtime_pm
is enabled on all controllers after the put_autosuspend() is called.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
Link: https://lore.kernel.org/r/20200414142725.6020-1-hui.wang@canonical.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_intel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 4f6d8a4b38452..59b60b1f26f80 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2339,6 +2339,7 @@ static int azx_probe_continue(struct azx *chip)
 
 	if (azx_has_pm_runtime(chip)) {
 		pm_runtime_use_autosuspend(&pci->dev);
+		pm_runtime_allow(&pci->dev);
 		pm_runtime_put_autosuspend(&pci->dev);
 	}
 
-- 
2.20.1



