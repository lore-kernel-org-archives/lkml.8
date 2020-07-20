Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD22AC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99C2622CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260406;
	bh=riXWFFP6pjp3gbdsUAjIE8ZYR+nTr6F6kWkrX6R/R08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RgrcmcJFdCO8ii3XnDsWa1dDXlQsKNYH/TqPXrKXinQgSH95RS6jOVA3zOWaUwtul
	 9X4JHNQN1OzPt5ROrbbQm38OG6l9WdcUdYqk6JzwLZd2XEdLeQuA59Bjbg7bMKPjNr
	 ocGgga5Gyy71XrbHIwRXwaCLpkPwz1vBpKK2qw6c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbgGTPxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:53:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730573AbgGTPxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:53:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F01E22482;
        Mon, 20 Jul 2020 15:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260399;
        bh=riXWFFP6pjp3gbdsUAjIE8ZYR+nTr6F6kWkrX6R/R08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tRSgivg3cnBipQQPszgwn4vnS2jODPDTy/l3vHjn5ZVH/8Co01pPf1qXbqUVTo7ab
         jnWGNnGUKWRmudFH9j0c1lrPChIJ35lu9WxkS/bpmWMMJBCLXWmm/JiXYbNkeQjH+z
         ptY5gYdMJ1JiyLXrtCalXIfk69B5Ic8B98SNVsq8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 088/133] ALSA: hda/realtek - change to suitable link model for ASUS platform
Date:   Mon, 20 Jul 2020 17:37:15 +0200
Message-Id: <20200720152807.967352772@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152803.732195882@linuxfoundation.org>
References: <20200720152803.732195882@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kailang Yang <kailang@realtek.com>

commit ef9ddb9dc4f8b1da3b975918cd1fd98ec055b918 upstream.

ASUS platform couldn't need to use Headset Mode model.
It changes to the suitable model.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/d05bcff170784ec7bb35023407148161@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6701,7 +6701,7 @@ static const struct hda_fixup alc269_fix
 			{ }
 		},
 		.chained = true,
-		.chain_id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
+		.chain_id = ALC269_FIXUP_HEADSET_MIC
 	},
 	[ALC294_FIXUP_ASUS_HEADSET_MIC] = {
 		.type = HDA_FIXUP_PINS,
@@ -6710,7 +6710,7 @@ static const struct hda_fixup alc269_fix
 			{ }
 		},
 		.chained = true,
-		.chain_id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
+		.chain_id = ALC269_FIXUP_HEADSET_MIC
 	},
 	[ALC294_FIXUP_ASUS_SPK] = {
 		.type = HDA_FIXUP_VERBS,


