Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3179DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14E582098B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592324234;
	bh=tm5emzIZe1eyeA5dlv4d4lUnsTh7XE+ZpULMTA+WaiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AcOcWYgnmjL9B+9n9QJo3877i/fjSn88c9efxZegqadKF6ytkg9RVBnSo8WqyG4Gn
	 nULFlH5baPr4EKjtydx44UtDXHzOVr6bjg/WtpHZioZwB6xtL+uCOmy4iopNbIXWIe
	 oOYcK2mtxXEzgzk+34FhCrbsM89rNtJ3sOV9wiiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730925AbgFPPj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:39:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:52456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730885AbgFPPjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:39:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7163D2145D;
        Tue, 16 Jun 2020 15:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592321953;
        bh=tm5emzIZe1eyeA5dlv4d4lUnsTh7XE+ZpULMTA+WaiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MAAdpPdnQs5eD0hXCh9dneJFsOnAkysJWmB2K7+vPWtkXxWxyEUEf73obSQn2xMkd
         vFQ+4Z/FOuI3U9VP8sWO5Bo1rH261qV0QM+cuejlLRqC6yATSZdy7acKwZSlpSkJ//
         0S5V/Jsyuqu6MIyVq9arbGam5qNacpF5jr9MqrRQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Dobias <dobias@2n.cz>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.4 049/134] ASoC: max9867: fix volume controls
Date:   Tue, 16 Jun 2020 17:33:53 +0200
Message-Id: <20200616153103.139324893@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153100.633279950@linuxfoundation.org>
References: <20200616153100.633279950@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Dobias <dobias@2n.cz>

commit 8ba4dc3cff8cbe2c571063a5fd7116e8bde563ca upstream.

The xmax values for Master Playback Volume and Mic Boost
Capture Volume are specified incorrectly (one greater)
which results in the wrong dB gain being shown to the user
in the case of Master Playback Volume.

Signed-off-by: Pavel Dobias <dobias@2n.cz>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200515120757.24669-1-dobias@2n.cz
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/codecs/max9867.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -46,13 +46,13 @@ static const SNDRV_CTL_TLVD_DECLARE_DB_R
 
 static const struct snd_kcontrol_new max9867_snd_controls[] = {
 	SOC_DOUBLE_R_TLV("Master Playback Volume", MAX9867_LEFTVOL,
-			MAX9867_RIGHTVOL, 0, 41, 1, max9867_master_tlv),
+			MAX9867_RIGHTVOL, 0, 40, 1, max9867_master_tlv),
 	SOC_DOUBLE_R_TLV("Line Capture Volume", MAX9867_LEFTLINELVL,
 			MAX9867_RIGHTLINELVL, 0, 15, 1, max9867_line_tlv),
 	SOC_DOUBLE_R_TLV("Mic Capture Volume", MAX9867_LEFTMICGAIN,
 			MAX9867_RIGHTMICGAIN, 0, 20, 1, max9867_mic_tlv),
 	SOC_DOUBLE_R_TLV("Mic Boost Capture Volume", MAX9867_LEFTMICGAIN,
-			MAX9867_RIGHTMICGAIN, 5, 4, 0, max9867_micboost_tlv),
+			MAX9867_RIGHTMICGAIN, 5, 3, 0, max9867_micboost_tlv),
 	SOC_SINGLE("Digital Sidetone Volume", MAX9867_SIDETONE, 0, 31, 1),
 	SOC_SINGLE_TLV("Digital Playback Volume", MAX9867_DACLEVEL, 0, 15, 1,
 			max9867_dac_tlv),


