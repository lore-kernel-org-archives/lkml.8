Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503D9C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA4621D56
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579194541;
	bh=I8jebYuN4oqA6mDmwu1r6O1sLy31vTIYstUt3itOYqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dLIWnyim6Sj7HrbFpSyrkgF9lw4HujBTD3ZMK+SfHGWMcSQKGnMT6K/LwOHcESe5b
	 O85wPtmyHEgdHSw9Vap79MzOJ6OXYCHQkfXiKYpENccMvMHeBhauUPZYVtg5p328sB
	 0ooHj3BVu750u2RFMHzP5cqxuHKkrEQEKBDIQGTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389552AbgAPRJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:09:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:43810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389545AbgAPRI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:08:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5034217F4;
        Thu, 16 Jan 2020 17:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194537;
        bh=I8jebYuN4oqA6mDmwu1r6O1sLy31vTIYstUt3itOYqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qe4klgPmTzZ0R7RnniLcWuOwc8O5W7ypFQ8u9d4ObcavPNn54z9NJU8xTs46qYzk4
         FPJZeFpAu6fKgEb9QRHt3gw/Ru8tER16J6xGsqPmbLnUXcbtPHQpCPXff1NCHRdTm1
         GRdwSDL1b0ThNl6AF087AIWAvnc7L+t6hi1GkaDE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.19 424/671] ASoC: ti: davinci-mcasp: Fix slot mask settings when using multiple AXRs
Date:   Thu, 16 Jan 2020 12:01:02 -0500
Message-Id: <20200116170509.12787-161-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

[ Upstream commit fd14f4436fd47d5418023c90e933e66d3645552e ]

If multiple serializers are connected in the system and the number of
channels will need to use more than one serializer the mask to enable the
serializers were left to 0 if tdm_mask is provided

Fixes: dd55ff8346a97 ("ASoC: davinci-mcasp: Add set_tdm_slots() support")

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/davinci/davinci-mcasp.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 6a8c279a4b20..14ab16e1369f 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -874,14 +874,13 @@ static int mcasp_i2s_hw_param(struct davinci_mcasp *mcasp, int stream,
 		active_slots = hweight32(mcasp->tdm_mask[stream]);
 		active_serializers = (channels + active_slots - 1) /
 			active_slots;
-		if (active_serializers == 1) {
+		if (active_serializers == 1)
 			active_slots = channels;
-			for (i = 0; i < total_slots; i++) {
-				if ((1 << i) & mcasp->tdm_mask[stream]) {
-					mask |= (1 << i);
-					if (--active_slots <= 0)
-						break;
-				}
+		for (i = 0; i < total_slots; i++) {
+			if ((1 << i) & mcasp->tdm_mask[stream]) {
+				mask |= (1 << i);
+				if (--active_slots <= 0)
+					break;
 			}
 		}
 	} else {
-- 
2.20.1

