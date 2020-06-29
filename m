Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C52C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEBB7206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593459664;
	bh=Zr5itSru/+GHNNd9LHWvlnW58UoEc4Xy72bax738w/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Pe89OVyxAd0AXcbvUkv1Fwe1XDU9ypM14IVr1oQwbZ9pEureaQcU1MMvBlvpJ5onP
	 pCF+wjaS8g6OpwYxb8ts/9jLRtK+cWjQq1P/SxUtdv0FaFSRwDzYlXn+ZIUA+6ARJS
	 tFUKNMz17z6bg2aEWn+ZUPMyVjeXIvtgOMDacbU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387902AbgF2TlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:41:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387840AbgF2Tkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:40:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FCF324895;
        Mon, 29 Jun 2020 15:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444391;
        bh=Zr5itSru/+GHNNd9LHWvlnW58UoEc4Xy72bax738w/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jLl63zOBCewMoi4FCXNg2OZ/kebkcFBV1UFUnlUf52Tej2WqDfWUFGoPAnj3GqIyc
         WxtvFjVz8rl2THZhH4Gidek5/cb2zHV6QlDZxXXSk2ENcmNr6D9ToqGNHiVcJ/sS02
         76FEgpXwhPaJCvMApGoBRVRxIgi/TwPJGzr9Nafo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 068/178] ASoc: q6afe: add support to get port direction
Date:   Mon, 29 Jun 2020 11:23:33 -0400
Message-Id: <20200629152523.2494198-69-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629152523.2494198-1-sashal@kernel.org>
References: <20200629152523.2494198-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.50-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.50-rc1
X-KernelTest-Deadline: 2020-07-01T15:25+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

[ Upstream commit 4a95737440d426e93441d49d11abf4c6526d4666 ]

This patch adds support to q6afe_is_rx_port() to get direction
of DSP BE dai port, this is useful for setting dailink
directions correctly.

Fixes: c25e295cd77b (ASoC: qcom: Add support to parse common audio device nodes)
Reported-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Link: https://lore.kernel.org/r/20200612123711.29130-1-srinivas.kandagatla@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/qcom/qdsp6/q6afe.c | 8 ++++++++
 sound/soc/qcom/qdsp6/q6afe.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index e0945f7a58c81..0ce4eb60f9848 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -800,6 +800,14 @@ int q6afe_get_port_id(int index)
 }
 EXPORT_SYMBOL_GPL(q6afe_get_port_id);
 
+int q6afe_is_rx_port(int index)
+{
+	if (index < 0 || index >= AFE_PORT_MAX)
+		return -EINVAL;
+
+	return port_maps[index].is_rx;
+}
+EXPORT_SYMBOL_GPL(q6afe_is_rx_port);
 static int afe_apr_send_pkt(struct q6afe *afe, struct apr_pkt *pkt,
 			    struct q6afe_port *port)
 {
diff --git a/sound/soc/qcom/qdsp6/q6afe.h b/sound/soc/qcom/qdsp6/q6afe.h
index c7ed5422baffd..1a0f80a14afea 100644
--- a/sound/soc/qcom/qdsp6/q6afe.h
+++ b/sound/soc/qcom/qdsp6/q6afe.h
@@ -198,6 +198,7 @@ int q6afe_port_start(struct q6afe_port *port);
 int q6afe_port_stop(struct q6afe_port *port);
 void q6afe_port_put(struct q6afe_port *port);
 int q6afe_get_port_id(int index);
+int q6afe_is_rx_port(int index);
 void q6afe_hdmi_port_prepare(struct q6afe_port *port,
 			    struct q6afe_hdmi_cfg *cfg);
 void q6afe_slim_port_prepare(struct q6afe_port *port,
-- 
2.25.1

