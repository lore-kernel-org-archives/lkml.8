Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794C8C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CC2420748
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598030527;
	bh=MH/XHhgIuGUSwCqDceXgRYfcAdjj+S7B5fgn8Cpmi+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WJ/yjcr+NAx0IegHKWQfI7A/4axelsVHQk7fRK247SMdlhONt8kgKV6n3K4QEcN0d
	 lnldS+QR5IX7AK/Z6sfak15jD0bmOLOt8IlAQzTSJyolrs8Hxw8L7kaVADuC49Munj
	 oj3a2Yo2xG0xCfl2kAbyk2MGDtJUm49XRdUkUOtA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbgHURWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:22:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:48004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727993AbgHUQPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:15:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C7FD22B40;
        Fri, 21 Aug 2020 16:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598026551;
        bh=MH/XHhgIuGUSwCqDceXgRYfcAdjj+S7B5fgn8Cpmi+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P2LAcydz4BI0diKWUAh7BYgmfv4qT+YhfXUt84uXHMV5h2a+v/npvcmy79WksmE4D
         aFop6kLCFgQAFR67YVMlAHTEo4m8L/oQS3FTMcXdCmCsXM6LjNvPF3ioWSiGLZ1FpX
         QdYFFV3835O1zj7PwgeQOvpxwlC76rt+1VF3TYeU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.7 04/61] ALSA: hda/hdmi: Use force connectivity quirk on another HP desktop
Date:   Fri, 21 Aug 2020 12:14:48 -0400
Message-Id: <20200821161545.347622-4-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821161545.347622-1-sashal@kernel.org>
References: <20200821161545.347622-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit d96f27c80b65437a7b572647ecb4717ec9a50c98 ]

There's another HP desktop has buggy BIOS which flags the Port
Connectivity bit as no connection.

Apply force connectivity quirk to enable DP/HDMI audio.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Link: https://lore.kernel.org/r/20200811095336.32396-1-kai.heng.feng@canonical.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index de9570032e07c..1f6f6b955362e 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1805,6 +1805,7 @@ static int hdmi_add_cvt(struct hda_codec *codec, hda_nid_t cvt_nid)
 }
 
 static const struct snd_pci_quirk force_connect_list[] = {
+	SND_PCI_QUIRK(0x103c, 0x870f, "HP", 1),
 	SND_PCI_QUIRK(0x103c, 0x871a, "HP", 1),
 	{}
 };
-- 
2.25.1

