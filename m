Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F72FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BE872220B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592445829;
	bh=VkcaWixqyjfhWDL/yIdtd0ZiSNKdKgFdcGsVMEWCN3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QqvErrUDvuORx8V+Coc8Zja9FPkwaAjp0FPO0j/vlbi13Bk3ChuxDGyglZ1R6vJW1
	 K0dCsMtp++NpmDoooBPLUL5SWWzfmsIR4H55usRQBgJa2UN7D3aTzXNomCfryFg3+z
	 NgtnLJe0RhIe6jG8Hf5HdLqZzGhxI/Sg/JasZz10=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387461AbgFRCDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:03:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730120AbgFRBXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:23:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EA92221EF;
        Thu, 18 Jun 2020 01:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443402;
        bh=VkcaWixqyjfhWDL/yIdtd0ZiSNKdKgFdcGsVMEWCN3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hIPs+fECPxnk1YVrE3nP6YwAoRI5u/Xx6B5cnDQIB9nKYHxq6tmLWb1AuwhqGU6Cw
         SRCwb+GFVvR/RErFRKok4rhSTUoNWwRx8Ukg5E6MsgQ1uENdIQb3FLstt8iazOESPO
         HilclS2hyC2HTIME75ULnI//IJouIymFzaspqVbU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Pavel Machek (CIP)" <pavel@denx.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 047/172] ASoC: meson: add missing free_irq() in error path
Date:   Wed, 17 Jun 2020 21:20:13 -0400
Message-Id: <20200618012218.607130-47-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012218.607130-1-sashal@kernel.org>
References: <20200618012218.607130-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Pavel Machek (CIP)" <pavel@denx.de>

[ Upstream commit 3b8a299a58b2afce464ae11324b59dcf0f1d10a7 ]

free_irq() is missing in case of error, fix that.

Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>
Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

Link: https://lore.kernel.org/r/20200606153103.GA17905@amd
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/meson/axg-fifo.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
index 0e4f65e654c4..b229c182b7c3 100644
--- a/sound/soc/meson/axg-fifo.c
+++ b/sound/soc/meson/axg-fifo.c
@@ -209,7 +209,7 @@ static int axg_fifo_pcm_open(struct snd_pcm_substream *ss)
 	/* Enable pclk to access registers and clock the fifo ip */
 	ret = clk_prepare_enable(fifo->pclk);
 	if (ret)
-		return ret;
+		goto free_irq;
 
 	/* Setup status2 so it reports the memory pointer */
 	regmap_update_bits(fifo->map, FIFO_CTRL1,
@@ -229,8 +229,14 @@ static int axg_fifo_pcm_open(struct snd_pcm_substream *ss)
 	/* Take memory arbitror out of reset */
 	ret = reset_control_deassert(fifo->arb);
 	if (ret)
-		clk_disable_unprepare(fifo->pclk);
+		goto free_clk;
+
+	return 0;
 
+free_clk:
+	clk_disable_unprepare(fifo->pclk);
+free_irq:
+	free_irq(fifo->irq, ss);
 	return ret;
 }
 
-- 
2.25.1

