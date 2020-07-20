Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F00DC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 247F2206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261547;
	bh=8uQoqT5zUgLztGzMfxjnNS5IaFdpCmc2jC0iDhz27EU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MZio0RW8RAanELuYf5r13bFjJ4Bri3ad95SXmIlG+w5HBLbvxkbJLRxi89IwvvZtY
	 VNwfsFatQrlACnlt7uC8TKmbkBxmjbQEAU8BEwc7h6Nnz41OldFS0JJSIwY57UzruI
	 FyD0sk5sndcpQkxXzcEXH57ZunMkNh+AtagXI9pE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387950AbgGTQMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:12:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387924AbgGTQMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:12:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C740C2064B;
        Mon, 20 Jul 2020 16:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261542;
        bh=8uQoqT5zUgLztGzMfxjnNS5IaFdpCmc2jC0iDhz27EU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jc6uy7upA056W7murEpSiF6fOxpYa3XCaZrk7h7iT04E38Lbbgf68r9nl2RpMyDdF
         ZUZfU00fKkuKDSr2LWup2+Ao/Y/uvBp4Aa1IvkVFvQVK3D5Ktp0rLhi8nh3IrSKgrk
         0dF8we0TFuPYDafln2YDdppplLyNQc2qy0aXgS/M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.7 154/244] ALSA: hda/realtek - change to suitable link model for ASUS platform
Date:   Mon, 20 Jul 2020 17:37:05 +0200
Message-Id: <20200720152833.177810351@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
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
@@ -7082,7 +7082,7 @@ static const struct hda_fixup alc269_fix
 			{ }
 		},
 		.chained = true,
-		.chain_id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
+		.chain_id = ALC269_FIXUP_HEADSET_MIC
 	},
 	[ALC294_FIXUP_ASUS_HEADSET_MIC] = {
 		.type = HDA_FIXUP_PINS,
@@ -7091,7 +7091,7 @@ static const struct hda_fixup alc269_fix
 			{ }
 		},
 		.chained = true,
-		.chain_id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
+		.chain_id = ALC269_FIXUP_HEADSET_MIC
 	},
 	[ALC294_FIXUP_ASUS_SPK] = {
 		.type = HDA_FIXUP_VERBS,


