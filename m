Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C724C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ADE224962
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941494;
	bh=hCwdM43GWBpJyfOLKgBXUxkqtGWyoUYBGA/7WyIwRyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vaVzwuZYswV/KjTNUb7qWYTovHukzrcXk4Gxou0JzLR96MVe36Z9oOe5+hNNRSSbO
	 8NhyrGTfqqfUQzj7a4jSu3LxkiLReTH2tjOB3KhFbSX19UZ0njVhx1Naf0JPSfwM6x
	 uXv45fHpC/HBPjj1MHhXcCoKiLHct26H/BgLKEr8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgEHMiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:38:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728311AbgEHMiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:38:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA7AC207DD;
        Fri,  8 May 2020 12:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941484;
        bh=hCwdM43GWBpJyfOLKgBXUxkqtGWyoUYBGA/7WyIwRyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GtIf+t2i+V5+FjJQA6KSndlHyilAlcnHofDRakLcwAv+RIbNGR0W9HW72S4kb+OQD
         rlqKVBTY3sT52WlY3kZUbB+95xruN+dBJn/NTA1R1ktSbaFHpYiDNWG/1QD54E/92Q
         kGmGmKoIMe13B69eNpQmPoJM+MT/o0Te/p5EceCI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ondrej Zary <linux@rainbow-software.org>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 049/312] ALSA: fm801: propagate TUNER_ONLY bit when autodetected
Date:   Fri,  8 May 2020 14:30:40 +0200
Message-Id: <20200508123128.002333909@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

commit dbec6719ac036f68568d8488805d41346c021eff upstream.

The commit d7ba858a7f7a (ALSA: fm801: implement TEA575x tuner autodetection)
brings autodetection to the driver. However the autodetection algorithm misses
the TUNER_ONLY bit if it is supplied by the user.

Thus, user gets weird messages and no card registered.

 snd_fm801 0000:0d:01.0: detected TEA575x radio type SF64-PCR
 snd_fm801 0000:0d:01.0: AC'97 interface is busy (1)
 snd_fm801 0000:0d:01.0: AC'97 interface is busy (1)
...
 snd_fm801 0000:0d:01.0: AC'97 0 does not respond - RESET
 snd_fm801 0000:0d:01.0: AC'97 interface is busy (1)
 snd_fm801 0000:0d:01.0: AC'97 interface is busy (1)
 snd_fm801 0000:0d:01.0: AC'97 0 access is not valid [0x0], removing mixer.
 snd_fm801: probe of 0000:0d:01.0 failed with error -5

Do a copy of TUNER_ONLY bit to be applied after autodetection is done.

Fixes: d7ba858a7f7a (ALSA: fm801: implement TEA575x tuner autodetection)
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ondrej Zary <linux@rainbow-software.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/fm801.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -1259,6 +1259,8 @@ static int snd_fm801_create(struct snd_c
 			return -ENODEV;
 		}
 	} else if ((tea575x_tuner & TUNER_TYPE_MASK) == 0) {
+		unsigned int tuner_only = tea575x_tuner & TUNER_ONLY;
+
 		/* autodetect tuner connection */
 		for (tea575x_tuner = 1; tea575x_tuner <= 3; tea575x_tuner++) {
 			chip->tea575x_tuner = tea575x_tuner;
@@ -1273,6 +1275,8 @@ static int snd_fm801_create(struct snd_c
 			dev_err(card->dev, "TEA575x radio not found\n");
 			chip->tea575x_tuner = TUNER_DISABLED;
 		}
+
+		chip->tea575x_tuner |= tuner_only;
 	}
 	if (!(chip->tea575x_tuner & TUNER_DISABLED)) {
 		strlcpy(chip->tea.card, get_tea575x_gpio(chip)->name,


