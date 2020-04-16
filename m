Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC22C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8338D214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587052803;
	bh=1akvloWbQ/bvMO1MxO34ybSKm+WB1SiuOG+RT6rKoU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bjA3lVP4vuqu/lnJ1wF2LxKDbD+LD8HyT8kxEJ9P8fTmlGKq/E5pZXeW7QIFg+3oT
	 yroIoM6XIDMVIuFoODRVxESvhskiVyZ9IkIRgeSj8WCXQnBYeSyE3t2KcQs5AlLuEi
	 R36QiRXBVwjfwxn9gj4Lm2k3dJWTQj4JK4lF1Hfc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896599AbgDPQAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:00:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895629AbgDPN1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:27:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 580B3217D8;
        Thu, 16 Apr 2020 13:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587043673;
        bh=1akvloWbQ/bvMO1MxO34ybSKm+WB1SiuOG+RT6rKoU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HRHlOlTH/2ChvtbWsP8I5YVdR5KGmxPkltttr6BUrjqSqiG10eD5v2vlgzhbR8x4h
         /YsBWoZU2CwNCEx8kKyZf++otfbGPVu44YmZFFseKS+QK1xS8kTyHAQobR8HvDTowW
         NznmS5iPtdfBNwxQNqmyQa8e8QdBO621hKT3kHUE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 053/146] ALSA: ice1724: Fix invalid access for enumerated ctl items
Date:   Thu, 16 Apr 2020 15:23:14 +0200
Message-Id: <20200416131250.155779061@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131242.353444678@linuxfoundation.org>
References: <20200416131242.353444678@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit c47914c00be346bc5b48c48de7b0da5c2d1a296c upstream.

The access to Analog Capture Source control value implemented in
prodigy_hifi.c is wrong, as caught by the recently introduced sanity
check; it should be accessing value.enumerated.item[] instead of
value.integer.value[].  This patch corrects the wrong access pattern.

Fixes: 6b8d6e5518e2 ("[ALSA] ICE1724: Added support for Audiotrak Prodigy 7.1 HiFi & HD2, Hercules Fortissimo IV")
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=207139
Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200407084402.25589-3-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/ice1712/prodigy_hifi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/sound/pci/ice1712/prodigy_hifi.c
+++ b/sound/pci/ice1712/prodigy_hifi.c
@@ -550,7 +550,7 @@ static int wm_adc_mux_enum_get(struct sn
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 
 	mutex_lock(&ice->gpio_mutex);
-	ucontrol->value.integer.value[0] = wm_get(ice, WM_ADC_MUX) & 0x1f;
+	ucontrol->value.enumerated.item[0] = wm_get(ice, WM_ADC_MUX) & 0x1f;
 	mutex_unlock(&ice->gpio_mutex);
 	return 0;
 }
@@ -564,7 +564,7 @@ static int wm_adc_mux_enum_put(struct sn
 
 	mutex_lock(&ice->gpio_mutex);
 	oval = wm_get(ice, WM_ADC_MUX);
-	nval = (oval & 0xe0) | ucontrol->value.integer.value[0];
+	nval = (oval & 0xe0) | ucontrol->value.enumerated.item[0];
 	if (nval != oval) {
 		wm_put(ice, WM_ADC_MUX, nval);
 		change = 1;


