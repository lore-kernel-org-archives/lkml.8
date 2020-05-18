Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CE4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B6D720657
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589826427;
	bh=w1mJuf5YXBTW8551sQHSLT3REbrk7YfNih/aE8SoXSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ocwmEJBIy3GFiBsyRHnYP3jt5fSKSJ1DW9zpjT78ndInUrH2PmDoaVJ4oEaLoqrId
	 0g4nfShAsPky9jUL1BY/oO/gDAnOEaMeBr8KwszDQV/byn+o+SaUUnj93QM5xjZMS/
	 eXL25Krbr+OobMvsNmnEN+f0gvrcDdnzTYqMdzhY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387953AbgERS1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:27:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729793AbgERRoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:44:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43F7220715;
        Mon, 18 May 2020 17:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589823885;
        bh=w1mJuf5YXBTW8551sQHSLT3REbrk7YfNih/aE8SoXSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tqLliK+W4mx8CsQR+ON6LtdCws+AORhjSMk43FfxzmfUxmlD6MJgm/IM3ruNvLXvs
         zXBxFvQZOtde6yTq000AZuQPeKM71NQOgwbSIxTupCe2h0HRQBn/W4VrWu+jCSUEW4
         gavuRzUPE9Ivo0iyjtXPcAZ/G9DvDJEwEHo9G4+c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jesus Ramos <jesus-ramos@live.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 76/90] ALSA: usb-audio: Add control message quirk delay for Kingston HyperX headset
Date:   Mon, 18 May 2020 19:36:54 +0200
Message-Id: <20200518173506.747539018@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173450.930655662@linuxfoundation.org>
References: <20200518173450.930655662@linuxfoundation.org>
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
@@ -1316,13 +1316,14 @@ void snd_usb_ctl_msg_quirk(struct usb_de
 	    && (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS)
 		mdelay(20);
 
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
 		mdelay(1);
 }


