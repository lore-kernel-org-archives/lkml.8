Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21DEC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7659224958
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340432;
	bh=Sc7dqRboe0f83TWzURgIoZH5Am++zw6wDemfVjkrris=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aqWmicFhNEUI6ZV9HyVtk1l6zmYCaZ9KzYhjkSSOJ1ysKO347nkjXURORmD9iiaTI
	 4WOUrQQ7ZWr+J8Mw13G4m9d/aThNFT0p3IkvjbOS+1Hh4MUSHz57jtn//j3vLUqELT
	 VAiAsC6XeFsNLnrGN+0Ddkg2cvlvtO63jVzMbiaY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbgEANkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:40:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731315AbgEANk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:40:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AB9E24953;
        Fri,  1 May 2020 13:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340427;
        bh=Sc7dqRboe0f83TWzURgIoZH5Am++zw6wDemfVjkrris=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=drHiQDNXuplaejrdUtH1weycuL/y9hxFNn9rw2V1HfQT+hsUdq7F8AorEo726AQEM
         e9BJodcgj0h67jcTP0el1ZVlvjJvjNtdew8c3Xk8yaTvPnAX7oqZTRpTZKewgg9mul
         X2rJokk11M8RPhuE636BCx9dFB8tZRzmKsVUziak=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roy Spliet <nouveau@spliet.org>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 61/83] ALSA: hda: Explicitly permit using autosuspend if runtime PM is supported
Date:   Fri,  1 May 2020 15:23:40 +0200
Message-Id: <20200501131540.361070213@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131524.004332640@linuxfoundation.org>
References: <20200501131524.004332640@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roy Spliet <nouveau@spliet.org>

[ Upstream commit 3ba21113bd33d49f3c300a23fc08cf114c434995 ]

This fixes runtime PM not working after a suspend-to-RAM cycle at least for
the codec-less HDA device found on NVIDIA GPUs.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=207043
Signed-off-by: Roy Spliet <nouveau@spliet.org>
Link: https://lore.kernel.org/r/20200413082034.25166-7-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_intel.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index fbffec2ab2372..a85b0cf7371a3 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2303,8 +2303,10 @@ static int azx_probe_continue(struct azx *chip)
 
 	set_default_power_save(chip);
 
-	if (azx_has_pm_runtime(chip))
+	if (azx_has_pm_runtime(chip)) {
+		pm_runtime_use_autosuspend(&pci->dev);
 		pm_runtime_put_autosuspend(&pci->dev);
+	}
 
 out_free:
 	if (err < 0) {
-- 
2.20.1



