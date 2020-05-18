Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB34AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA06C20826
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824687;
	bh=O9xcISJN/z1FNJAF1HxhOJkTIsQ+vTAHx4xaTb60ltw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zfuKsD57+2M8FjmOyQb54OMa0g+xoNWz+K5v2ModrfTq1kbDCRL/h+pbRlRmBb5Ak
	 DV7mNa7n/uvOjcTXcfPByG0u4SFr26vCAbxgAfpV816EeIjO/ukjvO4ohaCwedoFkj
	 /Rv0+K94Cm3T9XrtHaOCYKZailg/NWKVS25NGg8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731314AbgERR6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:58:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:37080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729934AbgERR6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:58:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDCE720715;
        Mon, 18 May 2020 17:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824682;
        bh=O9xcISJN/z1FNJAF1HxhOJkTIsQ+vTAHx4xaTb60ltw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZaT/1baEsJdeijgHk07C1r4JJVyZnTnuuRyJGQO+CM+5ln7EOHWSHKSdKn62zAMHP
         1PDv/YiZ34z6GPbevSVHKvONmMnQFQakRoLkmD4hhcvcks1Gpk+/8CHI/Y8SNuCymP
         YsDWkN+xBWMuPP7R7Y3g6LuKLDRzt6s0ez5e3L0g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jesus Ramos <jesus-ramos@live.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.4 108/147] ALSA: usb-audio: Add control message quirk delay for Kingston HyperX headset
Date:   Mon, 18 May 2020 19:37:11 +0200
Message-Id: <20200518173526.673184044@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173513.009514388@linuxfoundation.org>
References: <20200518173513.009514388@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesus Ramos <jesus-ramos@live.com>

commit 073919e09ca445d4486968e3f851372ff44cf2b5 upstream.

Kingston HyperX headset with 0951:16ad also needs the same quirk for
delaying the frequency controls.

Signed-off-by: Jesus Ramos <jesus-ramos@live.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/BY5PR19MB3634BA68C7CCA23D8DF428E796AF0@BY5PR19MB3634.namprd19.prod.outlook.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/quirks.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1592,13 +1592,14 @@ void snd_usb_ctl_msg_quirk(struct usb_de
 	    && (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS)
 		msleep(20);
 
-	/* Zoom R16/24, Logitech H650e, Jabra 550a needs a tiny delay here,
-	 * otherwise requests like get/set frequency return as failed despite
-	 * actually succeeding.
+	/* Zoom R16/24, Logitech H650e, Jabra 550a, Kingston HyperX needs a tiny
+	 * delay here, otherwise requests like get/set frequency return as
+	 * failed despite actually succeeding.
 	 */
 	if ((chip->usb_id == USB_ID(0x1686, 0x00dd) ||
 	     chip->usb_id == USB_ID(0x046d, 0x0a46) ||
-	     chip->usb_id == USB_ID(0x0b0e, 0x0349)) &&
+	     chip->usb_id == USB_ID(0x0b0e, 0x0349) ||
+	     chip->usb_id == USB_ID(0x0951, 0x16ad)) &&
 	    (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS)
 		usleep_range(1000, 2000);
 }


