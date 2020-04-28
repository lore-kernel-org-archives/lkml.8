Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35ACBC83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AE7B208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099339;
	bh=pPmIFV+1g5lafog4sRGHQB4bxuzsE16raYDXiB2UHXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Od8nG6Z4J+6Y1zPcu2VX8WHTB83eXrv4G/V26di+ueYz1/vqik6GIasU00RFQYI9a
	 pJ74zhhu4gliz9bCURGdYsowkizgljR0VK9DHBBnC3qS5mlp8Xp6pMN8seTheb2YgB
	 dtD88VspSQedzxLaSk5NdIfGQThpfw4lXjKgyYJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbgD1SmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:42:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:34014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730653AbgD1SmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:42:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AC7520B1F;
        Tue, 28 Apr 2020 18:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099332;
        bh=pPmIFV+1g5lafog4sRGHQB4bxuzsE16raYDXiB2UHXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bAVom84g2xMYnCNR8Gnp0TJs9+Pb6cNW0FJT5F3PRAnZEiEXxKuybVAX2kZwA8wYZ
         j61Zado2dHflYsSQhOo1Tqtlrewd8l2JctUdwCfRM4vgMYwP4t2lHTDmFWTfR10+ij
         tR7CydxcGOzEZGTAeGbP4RP2mwO0CJy1jTriVhe0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lin Yi <teroincn@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.4 108/168] ALSA: usx2y: Fix potential NULL dereference
Date:   Tue, 28 Apr 2020 20:24:42 +0200
Message-Id: <20200428182246.129102508@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182231.704304409@linuxfoundation.org>
References: <20200428182231.704304409@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 7686e3485253635c529cdd5f416fc640abaf076f upstream.

The error handling code in usX2Y_rate_set() may hit a potential NULL
dereference when an error occurs before allocating all us->urb[].
Add a proper NULL check for fixing the corner case.

Reported-by: Lin Yi <teroincn@gmail.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200420075529.27203-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/usx2y/usbusx2yaudio.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/usb/usx2y/usbusx2yaudio.c
+++ b/sound/usb/usx2y/usbusx2yaudio.c
@@ -681,6 +681,8 @@ static int usX2Y_rate_set(struct usX2Yde
 			us->submitted =	2*NOOF_SETRATE_URBS;
 			for (i = 0; i < NOOF_SETRATE_URBS; ++i) {
 				struct urb *urb = us->urb[i];
+				if (!urb)
+					continue;
 				if (urb->status) {
 					if (!err)
 						err = -ENODEV;


