Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDEEC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FDD32222C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587044826;
	bh=akbKUhbtfBKfRWBbrLrWfpWB85pshxJLlbLzz96tEAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L+UVzp08fctfQm1Jywi4s34JDRZungScGBVu9mzBnAMtgpO2Bw+FMbq4jM/2bJrTM
	 Csy8XQ5xfaJ9H0S+dF0lBoCS0Dgk7Wwg+aOJEwUaod8IN8zwBf5YVxpX9pIqvjojn9
	 vVLxU4RlKCizPvUMGMxDA5uvXmtvCccWpY0zBu+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731800AbgDPNrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:47:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:47266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897087AbgDPNfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:35:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC891208E4;
        Thu, 16 Apr 2020 13:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044121;
        bh=akbKUhbtfBKfRWBbrLrWfpWB85pshxJLlbLzz96tEAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=igg14mZGHNzembiGg755DUgjC7pRMtwRT9iEIatnv2alTsTztOnsrZKIIPIui4BLh
         Ks2sEECbDrQ+jhhSIpRKka+Vee2pI+9zrzPA4sYV7fh4KiZSLscrmMCFXQPKznaRxE
         SiB+oiCB7OESjtuP3wCxmIn52iWMIeq2quJW/vDY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.5 090/257] ALSA: ice1724: Fix invalid access for enumerated ctl items
Date:   Thu, 16 Apr 2020 15:22:21 +0200
Message-Id: <20200416131337.253642879@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.891903893@linuxfoundation.org>
References: <20200416131325.891903893@linuxfoundation.org>
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
@@ -536,7 +536,7 @@ static int wm_adc_mux_enum_get(struct sn
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 
 	mutex_lock(&ice->gpio_mutex);
-	ucontrol->value.integer.value[0] = wm_get(ice, WM_ADC_MUX) & 0x1f;
+	ucontrol->value.enumerated.item[0] = wm_get(ice, WM_ADC_MUX) & 0x1f;
 	mutex_unlock(&ice->gpio_mutex);
 	return 0;
 }
@@ -550,7 +550,7 @@ static int wm_adc_mux_enum_put(struct sn
 
 	mutex_lock(&ice->gpio_mutex);
 	oval = wm_get(ice, WM_ADC_MUX);
-	nval = (oval & 0xe0) | ucontrol->value.integer.value[0];
+	nval = (oval & 0xe0) | ucontrol->value.enumerated.item[0];
 	if (nval != oval) {
 		wm_put(ice, WM_ADC_MUX, nval);
 		change = 1;


