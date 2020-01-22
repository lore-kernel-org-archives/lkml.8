Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D65C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2EB24688
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686064;
	bh=8tE/D4mz4jFGF0L2PYaXFgqEex6xw+gmIOcsNkew/uQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uQbmu87wg5kNU/r87PtosNHfC7P0PA05I0WztsHA1rNcQfUYVYBOQbQfVzXjaW9h0
	 ggtWJruIeCj0XJEvM6bSKlLtpt2gb4LHRyKFfzWEjtmh5jqjP6TuwV6DTqyGSIK2TO
	 8pjH37Iil1G+01fffsYZ+tfRjBPKdUGsELErOJY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387504AbgAVJlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:41:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:59918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733260AbgAVJkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:40:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 196A424684;
        Wed, 22 Jan 2020 09:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579686048;
        bh=8tE/D4mz4jFGF0L2PYaXFgqEex6xw+gmIOcsNkew/uQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tdGLb7/q5eRCY3O3E//uXfl6tjDVDqtyinvoYMg2aMtkScbwja/gxFqBMzMb0jMiF
         MPCPbinPWJ3JbjMnlmnnLXsGY8iElfGn19nK/Hc3ImAYujirwSqO3qqcRYcs88u55Z
         7NlqR5dzI32S/clT3KJOgmt2Jbj0sEp4JHxKoJMM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.19 006/103] ASoC: msm8916-wcd-digital: Reset RX interpolation path after use
Date:   Wed, 22 Jan 2020 10:28:22 +0100
Message-Id: <20200122092804.628145113@linuxfoundation.org>
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

commit 85578bbd642f65065039b1765ebe1a867d5435b0 upstream.

For some reason, attempting to route audio through QDSP6 on MSM8916
causes the RX interpolation path to get "stuck" after playing audio
a few times. In this situation, the analog codec part is still working,
but the RX path in the digital codec stops working, so you only hear
the analog parts powering up. After a reboot everything works again.

So far I was not able to reproduce the problem when using lpass-cpu.

The downstream kernel driver avoids this by resetting the RX
interpolation path after use. In mainline we do something similar
for the TX decimator (LPASS_CDC_CLK_TX_RESET_B1_CTL), but the
interpolator reset (LPASS_CDC_CLK_RX_RESET_CTL) got lost when the
msm8916-wcd driver was split into analog and digital.

Fix this problem by adding the reset to
msm8916_wcd_digital_enable_interpolator().

Fixes: 150db8c5afa1 ("ASoC: codecs: Add msm8916-wcd digital codec")
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Link: https://lore.kernel.org/r/20200105102753.83108-1-stephan@gerhold.net
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/codecs/msm8916-wcd-digital.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/sound/soc/codecs/msm8916-wcd-digital.c
+++ b/sound/soc/codecs/msm8916-wcd-digital.c
@@ -357,6 +357,12 @@ static int msm8916_wcd_digital_enable_in
 		snd_soc_component_write(component, rx_gain_reg[w->shift],
 			      snd_soc_component_read32(component, rx_gain_reg[w->shift]));
 		break;
+	case SND_SOC_DAPM_POST_PMD:
+		snd_soc_component_update_bits(component, LPASS_CDC_CLK_RX_RESET_CTL,
+					      1 << w->shift, 1 << w->shift);
+		snd_soc_component_update_bits(component, LPASS_CDC_CLK_RX_RESET_CTL,
+					      1 << w->shift, 0x0);
+		break;
 	}
 	return 0;
 }


