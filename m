Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE8BC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D825720738
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598287419;
	bh=GdninRPnCQPW4BAma6oSZQxiIbzt7eGIxs9RRTt+EnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OH9Xeb6y6tQJIvCzi7gJp887OrPzA7g+vmdq0S4OazWWm+C+VgDXsbLeMPrjgRZur
	 ViC2cSpXwtx9Qvjtt/MFByJpF7EfgkZBy2NoXzic6nKqoLoRsmVZCI/soY5auxt0W5
	 EIiry0tgiDhVcmJvLqvHmo/+6dtLL5Tu5HRDyd+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgHXQjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 12:39:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728074AbgHXQft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:35:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BBA422CB3;
        Mon, 24 Aug 2020 16:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598286949;
        bh=GdninRPnCQPW4BAma6oSZQxiIbzt7eGIxs9RRTt+EnI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AIl3s1C5WtFw4t/0ms2VfqlS221yM3qmma11oMxXvUNiAvwG0wylIPpiGsdPzZkWV
         QvV8Gb+XL6M/rYgdZCXh9tqQY9yFNM/L6mdo/hlpBOoMmLR2RWU+WYLxo5cpXqUhBb
         XeCekkxKchgorMIb3wnG/Pmu2TmlQ+iPv2BlrsTI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mike Pozulp <pozulp.kernel@gmail.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.8 33/63] ALSA: hda/realtek: Add model alc298-samsung-headphone
Date:   Mon, 24 Aug 2020 12:34:33 -0400
Message-Id: <20200824163504.605538-33-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824163504.605538-1-sashal@kernel.org>
References: <20200824163504.605538-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Pozulp <pozulp.kernel@gmail.com>

[ Upstream commit 23dc958689449be85e39351a8c809c3d344b155b ]

The very quiet and distorted headphone output bug that afflicted my
Samsung Notebook 9 is appearing in many other Samsung laptops. Expose
the quirk which fixed my laptop as a model so other users can try it.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=207423
Signed-off-by: Mike Pozulp <pozulp.kernel@gmail.com>
Link: https://lore.kernel.org/r/20200817043219.458889-1-pozulp.kernel@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 8626e59f1e6a9..ce9cf6013e9d3 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7956,6 +7956,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC299_FIXUP_PREDATOR_SPK, .name = "predator-spk"},
 	{.id = ALC298_FIXUP_HUAWEI_MBX_STEREO, .name = "huawei-mbx-stereo"},
 	{.id = ALC256_FIXUP_MEDION_HEADSET_NO_PRESENCE, .name = "alc256-medion-headset"},
+	{.id = ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET, .name = "alc298-samsung-headphone"},
 	{}
 };
 #define ALC225_STANDARD_PINS \
-- 
2.25.1

