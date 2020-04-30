Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA5CC4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4E89206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588255241;
	bh=7M51MWd4LE6fV5sMCcOYb3Gc2/7ggRjkDqSEzQIBf2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D4YgB6VrWSW1uXoHURcHdcdid9HiQphWBj3rXgVzLjcs13dTUVDWNjtmnY6aggfwH
	 KmpjXthUdWUYyU39DQt1IR0nf3jmYBWMCSfFs7pqI1O7ZhVe0iXgkjv11vVLb7V8+L
	 GWSgA2ub8YwCBjRuLuL1XrhsWDJndU3cYeN8qtjg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbgD3OAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:00:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728914AbgD3NyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:54:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E16324958;
        Thu, 30 Apr 2020 13:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588254853;
        bh=7M51MWd4LE6fV5sMCcOYb3Gc2/7ggRjkDqSEzQIBf2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eGRGq3APDvY0RfjJRWWyArKsB6BVCL1B/sC8aJunFceDohmUMgErnWmhfpN4V9CY+
         aAKXQvq/RwhRb+pZZJzjb4Z+jRvwVZYqvrrxcH2InMQCy05AU8fMG8RTxknjrAfd9d
         4SGb0KhbNz2y89nHY+UuOe2jJavoJc1E4+jwfbKw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.14 09/27] ASoC: codecs: hdac_hdmi: Fix incorrect use of list_for_each_entry
Date:   Thu, 30 Apr 2020 09:53:44 -0400
Message-Id: <20200430135402.20994-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430135402.20994-1-sashal@kernel.org>
References: <20200430135402.20994-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

[ Upstream commit 326b509238171d37402dbe308e154cc234ed1960 ]

If we don't find any pcm, pcm will point at address at an offset from
the the list head and not a meaningful structure. Fix this by returning
correct pcm if found and NULL if not. Found with coccinelle.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Link: https://lore.kernel.org/r/20200415162849.308-1-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 1c3626347e12b..aeeec1144558e 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -142,14 +142,14 @@ static struct hdac_hdmi_pcm *
 hdac_hdmi_get_pcm_from_cvt(struct hdac_hdmi_priv *hdmi,
 			   struct hdac_hdmi_cvt *cvt)
 {
-	struct hdac_hdmi_pcm *pcm = NULL;
+	struct hdac_hdmi_pcm *pcm;
 
 	list_for_each_entry(pcm, &hdmi->pcm_list, head) {
 		if (pcm->cvt == cvt)
-			break;
+			return pcm;
 	}
 
-	return pcm;
+	return NULL;
 }
 
 static void hdac_hdmi_jack_report(struct hdac_hdmi_pcm *pcm,
-- 
2.20.1

