Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46E6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B08F920774
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597074046;
	bh=e083/SwxnTJB1VaRxcyAEteqkXRBIia0Z23r4eMPWzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=luGgiKL8bOWguNW0FuT7eAvnmSg5FVm5cf0FdzOHFfQeyFIl3v1mKaVvWCeoND9c7
	 iIwkB08t/tOvJWfQ81Ms8MdYZUGWx+7K45vgMhy7qVNHUJx4YPhIkyxmN3kr2N8buX
	 Y5kye4D6Q98mDflkMYHbKQO0oivIi6+OajQy88+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbgHJPko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:40:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728401AbgHJPYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:24:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CF3620772;
        Mon, 10 Aug 2020 15:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597073040;
        bh=e083/SwxnTJB1VaRxcyAEteqkXRBIia0Z23r4eMPWzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xWQiTpQn4tmkD+rrflV5x50DEm97lHkfOt1nYemc2sr8T7fZECz/HFN77qnNe+fOk
         00pZ8NomXIjZb7cpAht51YfFECfZ/kqz1EmyAK++EHMRxHHxQ/Z6yIZJUfgx/xESu5
         OFmwyWjSkmnKSx+RAqwU+5/bG03mhr4I34rPiLvc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 46/79] ALSA: hda: fix NULL pointer dereference during suspend
Date:   Mon, 10 Aug 2020 17:21:05 +0200
Message-Id: <20200810151814.538258256@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810151812.114485777@linuxfoundation.org>
References: <20200810151812.114485777@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

[ Upstream commit 7fcd9bb5acd01250bcae1ecc0cb8b8d4bb5b7e63 ]

When the ASoC card registration fails and the codec component driver
never probes, the codec device is not initialized and therefore
memory for codec->wcaps is not allocated. This results in a NULL pointer
dereference when the codec driver suspend callback is invoked during
system suspend. Fix this by returning without performing any actions
during codec suspend/resume if the card was not registered successfully.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/20200728231011.1454066-1-ranjani.sridharan@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_codec.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 7e3ae4534df91..803978d69e3c4 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2935,6 +2935,10 @@ static int hda_codec_runtime_suspend(struct device *dev)
 	struct hda_codec *codec = dev_to_hda_codec(dev);
 	unsigned int state;
 
+	/* Nothing to do if card registration fails and the component driver never probes */
+	if (!codec->card)
+		return 0;
+
 	cancel_delayed_work_sync(&codec->jackpoll_work);
 	state = hda_call_codec_suspend(codec);
 	if (codec->link_down_at_suspend ||
@@ -2949,6 +2953,10 @@ static int hda_codec_runtime_resume(struct device *dev)
 {
 	struct hda_codec *codec = dev_to_hda_codec(dev);
 
+	/* Nothing to do if card registration fails and the component driver never probes */
+	if (!codec->card)
+		return 0;
+
 	codec_display_power(codec, true);
 	snd_hdac_codec_link_up(&codec->core);
 	hda_call_codec_resume(codec);
-- 
2.25.1



