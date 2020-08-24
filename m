Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FA5C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E2EB206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598258129;
	bh=9HAS2loCHxQ24PIAcghVs2Z0hXa2Wx19xvuumM0vtFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o/qrkxGMbxoHCQ8spGVD7rscys8s/Vo3yZvW4yvPV4+Vtk82NvQo7eGolcZpfkslN
	 qd7vKkTCo08ZulGF5pgfH8Hc78X40ZMt/0m4aS4D1ShtNZn7O82oHpC+Sq6oq+8iGL
	 Ybsi+NCTAxO9H6YM+vYw9wObW9F/bJl5C4YW59i4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgHXIf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:35:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728054AbgHXIfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:35:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D415206F0;
        Mon, 24 Aug 2020 08:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258113;
        bh=9HAS2loCHxQ24PIAcghVs2Z0hXa2Wx19xvuumM0vtFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cv5vhWX7BlACiaQCjQXKBdcGXK1hQvHxVg4WGP5lpHxoEvXyxzwbU1ax8fLrSvoT8
         TW1KuD/UPy9AIb5yQ7MhaN15IILkosN6qy4zND4mHROUCEcn2NPUB5GWRMiFSx+NQg
         6OrAcbvEgy3P+/PjUYaGhyM95g2vseD0KqyelZkg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 079/148] ASoC: q6routing: add dummy register read/write function
Date:   Mon, 24 Aug 2020 10:29:37 +0200
Message-Id: <20200824082417.851958095@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082413.900489417@linuxfoundation.org>
References: <20200824082413.900489417@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

[ Upstream commit 796a58fe2b8c9b6668db00d92512ec84be663027 ]

Most of the DAPM widgets for DSP ASoC components reuse reg field
of the widgets for its internal calculations, however these are not
real registers. So read/writes to these numbers are not really
valid. However ASoC core will read these registers to get default
state during startup.

With recent changes to ASoC core, every register read/write
failures are reported very verbosely. Prior to this fails to reads
are totally ignored, so we never saw any error messages.

To fix this add dummy read/write function to return default value.

Fixes: e3a33673e845 ("ASoC: qdsp6: q6routing: Add q6routing driver")
Reported-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20200811120205.21805-2-srinivas.kandagatla@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/qcom/qdsp6/q6routing.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index 46e50612b92c1..750e6a30444eb 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -973,6 +973,20 @@ static int msm_routing_probe(struct snd_soc_component *c)
 	return 0;
 }
 
+static unsigned int q6routing_reg_read(struct snd_soc_component *component,
+				       unsigned int reg)
+{
+	/* default value */
+	return 0;
+}
+
+static int q6routing_reg_write(struct snd_soc_component *component,
+			       unsigned int reg, unsigned int val)
+{
+	/* dummy */
+	return 0;
+}
+
 static const struct snd_soc_component_driver msm_soc_routing_component = {
 	.probe = msm_routing_probe,
 	.name = DRV_NAME,
@@ -981,6 +995,8 @@ static const struct snd_soc_component_driver msm_soc_routing_component = {
 	.num_dapm_widgets = ARRAY_SIZE(msm_qdsp6_widgets),
 	.dapm_routes = intercon,
 	.num_dapm_routes = ARRAY_SIZE(intercon),
+	.read = q6routing_reg_read,
+	.write = q6routing_reg_write,
 };
 
 static int q6pcm_routing_probe(struct platform_device *pdev)
-- 
2.25.1



