Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCC0C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 18:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C0AD206F8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 18:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389739AbgDBS4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 14:56:31 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:51881 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388658AbgDBS4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 14:56:31 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N4yNG-1jALfN3Ie4-010x38 for <linux-kernel@vger.kernel.org>; Thu, 02 Apr
 2020 20:56:29 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 7ACC265073A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Apr 2020 18:56:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jyX4JAh99Un5 for <linux-kernel@vger.kernel.org>;
        Thu,  2 Apr 2020 20:56:29 +0200 (CEST)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id 3574164EDB3
        for <linux-kernel@vger.kernel.org>; Thu,  2 Apr 2020 20:56:29 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (10.8.5.12) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 2 Apr 2020 20:56:29 +0200
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id E692280503; Thu,  2 Apr 2020 20:34:48 +0200 (CEST)
Date:   Thu, 2 Apr 2020 20:34:48 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        <devel@driverdev.osuosl.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>
Subject: [PATCH v5 6/9] media: adv748x: prepare/enable mclk when the audio is
 used
Message-ID: <d9b7a7290e3d95b484a7a760484f827c3ed7651e.1585852001.git.alexander.riesen@cetitec.com>
Mail-Followup-To: Alex Riesen <alexander.riesen@cetitec.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        devel@driverdev.osuosl.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <cover.1585852001.git.alexander.riesen@cetitec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1585852001.git.alexander.riesen@cetitec.com>
X-Originating-IP: [10.8.5.12]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
X-EsetResult: clean, is OK
X-EsetId: 37303A290D7F536A6C7266
X-Provags-ID: V03:K1:emA9+eyx+bfMN1K+X0bQHRrQ755sVujhRAUytttif4qOevwdxqu
 CgTGeR8iX8tAzXamoe05vE//cWgCF4lljKAWtTMRP1/FY6gpUKTTGLvdCI7BxWZsliuty9d
 U6gz5Y8J+AjebPGUWFqk5QO5uSdfKKHr1EBQjwQN8npiBO/9sP1vQymUJilnPLx+L5Cqatl
 BzPs5v5yZOepm9sAF0w5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4zR2z4qi4Mw=:C/3MR25q9YRrXIVDIqgWxm
 BcVcJXcw/LZRCqMYgtB7t/Z6CmbEryn65uqWzhckkWs8B1xtTspqHY+zPq/58av9SZQOYzeeS
 dmR5dJ7mVlHK/is9dx0/htcR7DEVp+sGFdUFXRwcDtStUBg6SKUaGKxKVFeIhWPCkNyku9Bcv
 R9+pubmybn5yLoikdAgFtmkyKifysF+hsqZXkci13HXlWolQWepM/sOqUq7c/NtPyLn4s66mJ
 12ykKz9H5JzT8TdDPL1s93ZKdQWFhf/K94xSBWSYanD3ATNMzk98DTRg4Ill91SfKC8by2f7x
 VKmmSUNZSXCxcYlG/WGpUPsbT8K8QK+J1Mu1OOVtPEOQJFXusy6sQ4zz5KjocQFaDa76/k4Zd
 wJVMZnFvO1Xrq8b9o09/cXGecpR15yjVEofIwiTZCB9XgexPMlhyGJ8hbSleX5VESInia76/U
 XemnqvIzm2kTrLJkX961bKLhNnlMOwMlHaK6R2eSxKH/HFg731UOiNkQsmxAjf9Dwdj/UiOJp
 v7S8vT/5V3B25lsGpBL1382Zla2YWSjm77CV+5CcWffOpbFE/Y5HpSFPzhwFQ0R4Ayf5Fbuyj
 N8oViwIJRLfo5f00L8dAJZ5ZYaZTp4tKVYQiS27Z2g6GD2SJHI5FdAknGSoog67AtG7PePjtG
 ILmGQxoQP6gfRzyTGmlObCQ7eTStCF6RvKx8h6TbKId6Qyk58ktNdrFf82CgWy9vE20CJjB53
 58gBE3ug8whevXfgl18uowdWhl+A/UYF7XPMXvAdOUSOQYFXcGc6ezrGmuZU52hqsPlxvxlU6
 wuy++8m3IXtoloBNnm1ApDg6DNeV9zaY2kNBbXSBY0yoEK8x68xWmtK6mnVWjW9/quEihsM
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As there is nothing else (the consumers are supposed to do that) which
enables the clock, do it in the driver.

Signed-off-by: Alexander Riesen <alexander.riesen@cetitec.com>
--

v3: added
---
 drivers/media/i2c/adv748x/adv748x-dai.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/adv748x/adv748x-dai.c b/drivers/media/i2c/adv748x/adv748x-dai.c
index c9191f8f1ca8..185f78023e91 100644
--- a/drivers/media/i2c/adv748x/adv748x-dai.c
+++ b/drivers/media/i2c/adv748x/adv748x-dai.c
@@ -117,11 +117,22 @@ static int adv748x_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 
 static int adv748x_dai_startup(struct snd_pcm_substream *sub, struct snd_soc_dai *dai)
 {
+	int ret;
 	struct adv748x_state *state = state_of(dai);
 
 	if (sub->stream != SNDRV_PCM_STREAM_CAPTURE)
 		return -EINVAL;
-	return set_audio_pads_state(state, 1);
+	ret = set_audio_pads_state(state, 1);
+	if (ret)
+		goto fail;
+	ret = clk_prepare_enable(mclk_of(state));
+	if (ret)
+		goto fail_pwdn;
+	return 0;
+fail_pwdn:
+	set_audio_pads_state(state, 0);
+fail:
+	return ret;
 }
 
 static int adv748x_dai_hw_params(struct snd_pcm_substream *sub,
@@ -174,6 +185,7 @@ static void adv748x_dai_shutdown(struct snd_pcm_substream *sub, struct snd_soc_d
 {
 	struct adv748x_state *state = state_of(dai);
 
+	clk_disable_unprepare(mclk_of(state));
 	set_audio_pads_state(state, 0);
 }
 
-- 
2.25.1.25.g9ecbe7eb18


