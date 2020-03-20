Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BD0C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182BC20753
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbgCTQeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:34:16 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:49569 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbgCTQeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 12:34:15 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mv3Ds-1jWivO1vvM-00r3aG for <linux-kernel@vger.kernel.org>; Fri, 20 Mar
 2020 17:34:14 +0100
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 4949F65007A
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 16:34:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JE53r3c8yRdx for <linux-kernel@vger.kernel.org>;
        Fri, 20 Mar 2020 17:34:14 +0100 (CET)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id 0539064FD3A
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 17:34:14 +0100 (CET)
Received: from pflmari.corp.cetitec.com (10.8.5.41) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 20 Mar 2020 17:34:13 +0100
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id 2CE8680503; Fri, 20 Mar 2020 17:12:02 +0100 (CET)
Date:   Fri, 20 Mar 2020 17:12:02 +0100
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
Subject: [PATCH v3 06/11] media: adv748x: prepare/enable mclk when the audio
 is used
Message-ID: <7ed1287d00da70de13627480b1601bfd2c6e570a.1584720678.git.alexander.riesen@cetitec.com>
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
References: <cover.1584720678.git.alexander.riesen@cetitec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1584720678.git.alexander.riesen@cetitec.com>
X-Originating-IP: [10.8.5.41]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
X-EsetResult: clean, is OK
X-EsetId: 37303A290D7F536A6D7660
X-Provags-ID: V03:K1:XSCsVBN0+dt/w5IPkdvkitGTgDFQgCfhZYM6yhJgRqgurA2HbO8
 xk8HNxecm2dU7h8R1I52oaVDXP6j7xt4bRyscO868HCXYlpKC++6FiMfuL1LQLNcmWd/hod
 hGaydUPOhVLrEWdY/Fi+LS7qn5kXCh5hri3evdRe+sBoRt9u5zggIxFAAtflFOX+Vqcw0G3
 hPQRe3WAOaQrWzESKNkXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L3OychSALdo=:9SVKSAxaor3W+MwQED3Iz0
 w0TXd2q2VwZD+We2fl3JzD35K03w5QwsjrFRGR9u7j7UO6TJQBgwqy8JqsmoOJf1ZcblcCvqQ
 7OclS1uMMzRaC6G5S3szE/k1o1BudtxPrW+/o2d6bhO8I2Yoby4j8RW8yBhHcfRXOpnSdwfCM
 AZZRjLOhxK288xnqw9pbFXV4FnxOFDRSTVnHv+PMn++W53RehTG1J8gnJcp0aQcdK99emXflK
 2GQfFVtIKdxaE30xRMONkhffzjhaXIah/TX80UL4zdgjR8bRYegV3PsVbrNMywdVEhKhKqWY4
 hfvDpt7JONQ1BbqE8X8rSXNnxjCv1cXFyMUp40HyIkK0r+y7bEfmxWa5w0Kxe5UJp6m5/25mK
 +csC+COtbAt0H40RuzIi2GCquDAfFi/qrh6WupMJnji9b6R6m6oLS8spLCP19DwGe1rcl7bwr
 fYi89wC6409NXWzFW8cIQ9+pDIJj0EJLvESGnCplPdySZMMy9lGBVqKSEpxrDkanfMpxFzagD
 JbZC9YLIsmBrdJTWk22BqkN9ZA/UJI8Erfbdfe6KF4L4tcJcQFcCijEsFMOxfX+kQVckR9ox4
 NNY34k5U9mpbzBVPWk7aykBkQDESq76GWEn58sd00VjI4ctlr8+ZZZcqCeVlKPPnMVKEr2vsm
 JbBW3/FQzZ/bgSSGAkaMNQwUxet8PNA8NfPyQoEe2ynZR8ua88oA0kqQiP+PgLKiV6nuamuKi
 k7VTNhRfSCEWAbH+1dsGrV0uHkQHSRIxh1GwHdEdqwL2+zDHNTkrWRKzDfhzbzg71485Z0ekr
 2FOW3CxN0GqW6x5rvMABnlAXVRhQ5jTmZTXOteMJTRFtEymf3i+qUbXaUpE69VGgMfH1ACh
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
index 6fce7d000423..1c673efd4745 100644
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
+	ret = clk_prepare_enable(state->dai.mclk);
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
 
+	clk_disable_unprepare(state->dai.mclk);
 	set_audio_pads_state(state, 0);
 }
 
-- 
2.25.1.25.g9ecbe7eb18


