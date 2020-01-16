Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C556C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1566A206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579201548;
	bh=0HOxhgXjTtfHd52wQ4/17nUx4EhZOHQbdZ9+10cLDxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EnpdbDHD9oaNS46VM0hNX1RBV72sKRDZq9juxIqqgbldYeMByEYWPdXJBSkVst622
	 JvwqBc892NwbyfPi6xhHIG5GhiFtO5F1BbxrpJQKHewkzWkhNDO3+0F2sr6ak8wG2J
	 OAKxAXfs06rso4vAeQPY68bwTLmEB+662I3aYv6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388504AbgAPTFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:05:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:53568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388190AbgAPRBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:01:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B5B1207FF;
        Thu, 16 Jan 2020 17:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194109;
        bh=0HOxhgXjTtfHd52wQ4/17nUx4EhZOHQbdZ9+10cLDxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x6jCbzHwk4GN2gR10JFx5LQP30KvWQIKwiAt/WMEYk51X40S4jvBWX5MiuTB+o4rJ
         KTrTZ+dueGMTmxBkRTzz1QAkiRTv/36ufPubMmy1X57bdIQi2hJ+DFfJm8EtOGqGTq
         WsY/go8vJFkaLBLgNlPpW6CYP2l1N/GwLm6HiDXw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>, Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.19 206/671] ASoC: qcom: Fix of-node refcount unbalance in apq8016_sbc_parse_of()
Date:   Thu, 16 Jan 2020 11:51:55 -0500
Message-Id: <20200116165940.10720-89-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165940.10720-1-sashal@kernel.org>
References: <20200116165940.10720-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 8d1667200850f8753c0265fa4bd25c9a6e5f94ce ]

The apq8016 driver leaves the of-node refcount at aborting from the
loop of for_each_child_of_node() in the error path.  Not only the
iterator node of for_each_child_of_node(), the children nodes referred
from it for codec and cpu have to be properly unreferenced.

Fixes: bdb052e81f62 ("ASoC: qcom: add apq8016 sound card support")
Cc: Patrick Lai <plai@codeaurora.org>
Cc: Banajit Goswami <bgoswami@codeaurora.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/qcom/apq8016_sbc.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/sound/soc/qcom/apq8016_sbc.c b/sound/soc/qcom/apq8016_sbc.c
index 1dd23bba1bed..4b559932adc3 100644
--- a/sound/soc/qcom/apq8016_sbc.c
+++ b/sound/soc/qcom/apq8016_sbc.c
@@ -164,41 +164,52 @@ static struct apq8016_sbc_data *apq8016_sbc_parse_of(struct snd_soc_card *card)
 
 		if (!cpu || !codec) {
 			dev_err(dev, "Can't find cpu/codec DT node\n");
-			return ERR_PTR(-EINVAL);
+			ret = -EINVAL;
+			goto error;
 		}
 
 		link->cpu_of_node = of_parse_phandle(cpu, "sound-dai", 0);
 		if (!link->cpu_of_node) {
 			dev_err(card->dev, "error getting cpu phandle\n");
-			return ERR_PTR(-EINVAL);
+			ret = -EINVAL;
+			goto error;
 		}
 
 		ret = snd_soc_of_get_dai_name(cpu, &link->cpu_dai_name);
 		if (ret) {
 			dev_err(card->dev, "error getting cpu dai name\n");
-			return ERR_PTR(ret);
+			goto error;
 		}
 
 		ret = snd_soc_of_get_dai_link_codecs(dev, codec, link);
 
 		if (ret < 0) {
 			dev_err(card->dev, "error getting codec dai name\n");
-			return ERR_PTR(ret);
+			goto error;
 		}
 
 		link->platform_of_node = link->cpu_of_node;
 		ret = of_property_read_string(np, "link-name", &link->name);
 		if (ret) {
 			dev_err(card->dev, "error getting codec dai_link name\n");
-			return ERR_PTR(ret);
+			goto error;
 		}
 
 		link->stream_name = link->name;
 		link->init = apq8016_sbc_dai_init;
 		link++;
+
+		of_node_put(cpu);
+		of_node_put(codec);
 	}
 
 	return data;
+
+ error:
+	of_node_put(np);
+	of_node_put(cpu);
+	of_node_put(codec);
+	return ERR_PTR(ret);
 }
 
 static const struct snd_soc_dapm_widget apq8016_sbc_dapm_widgets[] = {
-- 
2.20.1

