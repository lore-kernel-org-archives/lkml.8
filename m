Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6748DC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E0D2070A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgCZKxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 06:53:25 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:51007 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgCZKxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 06:53:24 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M42b8-1jHQ8Z1lom-0002ql for <linux-kernel@vger.kernel.org>; Thu, 26 Mar
 2020 11:53:23 +0100
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 33D8964FB32
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 10:53:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sKDe8Qdpvcqw for <linux-kernel@vger.kernel.org>;
        Thu, 26 Mar 2020 11:53:22 +0100 (CET)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id CAB4264E3E5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 11:53:22 +0100 (CET)
Received: from pflmari.corp.cetitec.com (10.8.5.79) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 26 Mar 2020 11:53:22 +0100
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id 220CD80503; Thu, 26 Mar 2020 11:35:42 +0100 (CET)
Date:   Thu, 26 Mar 2020 11:35:42 +0100
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
Subject: [PATCH v4 6/9] media: adv748x: prepare/enable mclk when the audio is
 used
Message-ID: <c4469e5897f0974c3e6eaba7cd1d4be983cf84a9.1585218857.git.alexander.riesen@cetitec.com>
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
References: <cover.1585218857.git.alexander.riesen@cetitec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1585218857.git.alexander.riesen@cetitec.com>
X-Originating-IP: [10.8.5.79]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
X-EsetResult: clean, is OK
X-EsetId: 37303A290D7F536A6D7C67
X-Provags-ID: V03:K1:JSjRztgKcedVK/AMppGVhnmq8k+xsyxjyhV05Pitxk0MiLjAKjA
 o9UfngB9DKF5GYDbseg5gzhlSiZxxwepasseKb5C92rHgskAoLmDsLo1vgYLNl3h9HI6v55
 VTpYbKztBOzfE0N9Zlwy0W9iHXJZ9qDggp6jN8q9qYTDP3shxYlgvr3jFAbXIggd+5sc43w
 FXzjgjm8SGhlX5OKIIkxw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tp3Kn9jxUNs=:U5yh9EaYB3bqL5XxeZ54MA
 qFWqzEcLH0lDtVF3wukS8FpCobxZbSf5eaXwYQMhEjN/GP1C2YdsD4+j7g1GZ2cTRJUY0aUQv
 HkwxPgo2Q0wWAKwqmXllFgKKzVAYvvds82rL1nAD5hgy2oF2MbYUEGptYFuoDO2Gipkbk0oic
 mwbVyRQaH2Qzy39lo/L8U7Io/7U2ZoeHjTK8Q3piLWc25lI8oSHJlBf8hfXvh3WpB3uzPp01W
 MRAbEcdRGP3OlT6n2LgrOH+sSUAJV5Z8jlmvkbkRbp/OpCM9/ts2bbVVwKxwr4HwO/XG5t2RP
 2rynavXOconFnKFyIKjz4g3BdylTVQ6cy/OpGM00JZiOQRMRCAClvMJp6fH48hgtWHgx0Smbg
 v+nlts1RamtXJFIhNExzKmbeIMTdbdToC7/jXwT0KaH8hLHLpBcRTBfKjmC8YohD/SWvnmaGf
 M6exNor2LrHmbjQgE+P4Zgt4qD7+xIbfELKCw0+B5a1qu9bkeECshcS7BADAmZABkK/7us9O4
 dS1glq998BjjplbzVpK3MzjmBnjxqVAAedqk74PQMZ0lUEQkFbj63BRMewAErbWKCRTYwXz/x
 0U5AsTPLzf++lU0dmUQr+sT1JOvtGiVegxj9BNU0mKJ2JRgIw9wMQH1hn0ebCR5ooCosqqiSk
 69xX1JbM/gCP+RvmIqN3X//3lcJp556k8T9oHGtKoGZwkLdZQlkTSd1cdOt5zlZQRSzAd0NvX
 gnH8K+iwO64Jta7mCwcEEs5Xk9COq5aiELJoWEoKDNMzZ73K0D9CrJAts0lh4QHb/i7CEESWq
 eb8SThGq174D6ElbTW9zFcxfd7oOPWR9zPOS+wHFyccv7hMRLaM7f8PYrL0UBPS00vyFyfo
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


