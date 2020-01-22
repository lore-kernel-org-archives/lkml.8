Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110BAC33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B952467B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686072;
	bh=DczAF+vKmAN+mWw+pcMpCxaJ1uY3iuKd2RO+aTQcOQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AsdoQgvjBwHZ1Jlw/tO7mwzfHSpzJ6QbIk+EpScGgEh5y/+vUwdAD9xiRuZxDfiJa
	 P40t+FcLpSWKjHMhqBDFiUK3m7Bt3wlfLLDzStt3wBtMalFXGwL9xkbg+21vhU7tmS
	 fBsmsOML2TnKBJ3qKb7VX1Nq1Rx1vQAToQstxlTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387525AbgAVJlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:41:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:60230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387478AbgAVJlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:41:01 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C92B24688;
        Wed, 22 Jan 2020 09:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579686061;
        bh=DczAF+vKmAN+mWw+pcMpCxaJ1uY3iuKd2RO+aTQcOQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W6Z4GqqOuhSa4zSzy+ovRT70X2wT9q+HFKKfy3npxjTbFIulNn9MLqeeTApWT6Eso
         z4BUy+Md6uEFx0gVQGJ7K1ovxWfpXtREi5ZM24dp3iK7sgMxSQ8P4mFIbb2b8v2TFk
         DEkuL6zZJbhTcYDkZp8WsCJyySUjsu0WMKlh9N5E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.19 020/103] ASoC: msm8916-wcd-analog: Fix selected events for MIC BIAS External1
Date:   Wed, 22 Jan 2020 10:28:36 +0100
Message-Id: <20200122092806.751557932@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092803.587683021@linuxfoundation.org>
References: <20200122092803.587683021@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephan Gerhold <stephan@gerhold.net>

commit e0beec88397b163c7c4ea6fcfb67e8e07a2671dc upstream.

MIC BIAS External1 sets pm8916_wcd_analog_enable_micbias_ext1()
as event handler, which ends up in pm8916_wcd_analog_enable_micbias_ext().

But pm8916_wcd_analog_enable_micbias_ext() only handles the POST_PMU
event, which is not specified in the event flags for MIC BIAS External1.
This means that the code in the event handler is never actually run.

Set SND_SOC_DAPM_POST_PMU as the only event for the handler to fix this.

Fixes: 585e881e5b9e ("ASoC: codecs: Add msm8916-wcd analog codec")
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Link: https://lore.kernel.org/r/20200111164006.43074-2-stephan@gerhold.net
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/codecs/msm8916-wcd-analog.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -885,10 +885,10 @@ static const struct snd_soc_dapm_widget
 
 	SND_SOC_DAPM_SUPPLY("MIC BIAS External1", CDC_A_MICB_1_EN, 7, 0,
 			    pm8916_wcd_analog_enable_micbias_ext1,
-			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+			    SND_SOC_DAPM_POST_PMU),
 	SND_SOC_DAPM_SUPPLY("MIC BIAS External2", CDC_A_MICB_2_EN, 7, 0,
 			    pm8916_wcd_analog_enable_micbias_ext2,
-			    SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+			    SND_SOC_DAPM_POST_PMU),
 
 	SND_SOC_DAPM_ADC_E("ADC1", NULL, CDC_A_TX_1_EN, 7, 0,
 			   pm8916_wcd_analog_enable_adc,


