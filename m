Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC33C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E89B82082F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581700997;
	bh=+wNQcH+TJ4zlI48ZRTuJb8YhmGGiHfyRhbMPl65NfmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w/UsnLXthFcufuKmaEatif+bDnSGuI8zGb2NMStytdCtVntOr3WVanULW0g+Uttnj
	 Cc1hcx6gzQ1//N+0WzIweMYvKmpRcy7KFbBJEJXCmg22+NK2h60vfWSHWUuD885pme
	 ahRoFQC9tjI5gg8YKgDElk+uA22XkMdtUKmNlZig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394496AbgBNRXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:23:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:34284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391323AbgBNQJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:09:38 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB0F22468C;
        Fri, 14 Feb 2020 16:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696577;
        bh=+wNQcH+TJ4zlI48ZRTuJb8YhmGGiHfyRhbMPl65NfmM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FHdCFhDw4P0zCqjBzoIVsC2J0SAkCpHLgM8YdDb9kUSOjFx3ILs4re5GWmAipVhrv
         qL/7QdHSV29MN+43rL6Llv40T92j1RUGCzK6f02LO3QFSGbyNbvrFxagPtxO3WNmX2
         JHpTGAzClXDHNTNVnHDiulSv5L9+WsYTQ+D1ZqiE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.4 366/459] ALSA: hda/hdmi - add retry logic to parse_intel_hdmi()
Date:   Fri, 14 Feb 2020 11:00:16 -0500
Message-Id: <20200214160149.11681-366-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

[ Upstream commit 2928fa0a97ebb9549cb877fdc99aed9b95438c3a ]

The initial snd_hda_get_sub_node() can fail on certain
devices (e.g. some Chromebook models using Intel GLK).
The failure rate is very low, but as this is is part of
the probe process, end-user impact is high.

In observed cases, related hardware status registers have
expected values, but the node query still fails. Retrying
the node query does seem to help, so fix the problem by
adding retry logic to the query. This does not impact
non-Intel platforms.

BugLink: https://github.com/thesofproject/linux/issues/1642
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20200120160117.29130-4-kai.vehmanen@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_hdmi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 8ac805a634f4e..307ca1f036762 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2794,9 +2794,12 @@ static int alloc_intel_hdmi(struct hda_codec *codec)
 /* parse and post-process for Intel codecs */
 static int parse_intel_hdmi(struct hda_codec *codec)
 {
-	int err;
+	int err, retries = 3;
+
+	do {
+		err = hdmi_parse_codec(codec);
+	} while (err < 0 && retries--);
 
-	err = hdmi_parse_codec(codec);
 	if (err < 0) {
 		generic_spec_free(codec);
 		return err;
-- 
2.20.1

