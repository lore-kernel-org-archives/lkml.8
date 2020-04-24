Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8C5C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F405215A4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587730977;
	bh=oL+8TEkGErZ9ILv0k+jhUSJahhEcOSEpINEPR+DQHUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S30/6KtAFJbdGujo7MGqEwzq6neNQNsFnYEgM5tuYeuM2lPQPT7Cd+mf6u0y5RyXo
	 AzMXAVrw32RQSqtS/aKnWi5smZcjclkrMKmXGG4qCD09qiRymnXa917kSaE2X1m+ou
	 TIGCSEdX3G5jkl5gUcwigmKCg5v33u9yOGOs22D8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgDXMW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:22:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbgDXMWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 08:22:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63F77215A4;
        Fri, 24 Apr 2020 12:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587730972;
        bh=oL+8TEkGErZ9ILv0k+jhUSJahhEcOSEpINEPR+DQHUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MRtY/2XlgeDyNRCHY6GAsLAIP/+6DObSOgtfT2ngde5+KGtgZtSMVJkKH+sWLlT+4
         Nl3UWHPMBN9/RccuSg3YkkYTiO7hJKmCTHecdSPHwqaKShFmuis1w+dHLWYGyI1VoA
         hK4wGkUhHlF1cRt7zocfbCCRaYTcHmNouGPE1OYk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Roy Spliet <nouveau@spliet.org>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.6 13/38] ALSA: hda: Explicitly permit using autosuspend if runtime PM is supported
Date:   Fri, 24 Apr 2020 08:22:11 -0400
Message-Id: <20200424122237.9831-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424122237.9831-1-sashal@kernel.org>
References: <20200424122237.9831-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 02c6308502b1e..8519051a426e7 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2354,8 +2354,10 @@ static int azx_probe_continue(struct azx *chip)
 
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

