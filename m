Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A87EC33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C2924689
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686339;
	bh=gN4JcD8jiWYvaNbwjwMs/E5Rs5MyBH6hQnzaG2lWjdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FVHwekQ75lOtSK5nXTtWnPHVeN/ZnIuTsMCVry85MNJpX2tyB7bw+WwLQTNXuUHqN
	 mgTLCtrPT+dTx7LXd8JQrl+1fc/gqGoMdy+p7nPBofRM8iGis4PTa10VwAIYZ4W0j3
	 ui8f8t7lLYDW/f1cfSdTiVBITVOR1ALMHHoKvcxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388089AbgAVJoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:44:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:37976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388070AbgAVJoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:44:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A69C62468D;
        Wed, 22 Jan 2020 09:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579686278;
        bh=gN4JcD8jiWYvaNbwjwMs/E5Rs5MyBH6hQnzaG2lWjdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hg7M35rjmL9Fc3ly2PaWgbkdeZY49hqmDua7frX0XhOyDqDzA4R7IEok8bCs/DNrM
         9oZGzhAs5alvQUEgfl2cp6p0Iu8XLM6Tddr7vxqsLb+s2s2wDWD102jJZdGyUTe7jl
         INPS+7QycrZE+cPyWt0fw4ODV/eLNncndL26hBFQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.4 013/222] ASoC: msm8916-wcd-digital: Reset RX interpolation path after use
Date:   Wed, 22 Jan 2020 10:26:39 +0100
Message-Id: <20200122092834.328837212@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
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
@@ -586,6 +586,12 @@ static int msm8916_wcd_digital_enable_in
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


