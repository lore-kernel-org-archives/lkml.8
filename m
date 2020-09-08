Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932CEC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 630EF2098B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599593812;
	bh=1ClE4nVFMN2hjeKwvBixxHf6qulHh5ahnmqBHj+4h24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E2R2DQql+l9+vV+p02MaRcbti/oV/5qudlVhsXy1Sk3LENULDRgM6ir/vtKzD6qTa
	 9IHrXRSOcwIIwQ0ZguGUYvlAte4XF6qQCzL/QyBHZGtnsgHvCd9fo8RWgj50F3zWZV
	 9Cb3wjPAlYKQwkCIKU3C0uFshB/1+sEN19XElD4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731695AbgIHTgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:36:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730960AbgIHP5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:57:16 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C25FC24696;
        Tue,  8 Sep 2020 15:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579584;
        bh=1ClE4nVFMN2hjeKwvBixxHf6qulHh5ahnmqBHj+4h24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cNoOAjxDdTHlw91GtBdh48ObCqUx89A323VPHYJfdpl6VDrR1B8g/4cydSe30EYI6
         jHLMY94S+We/jDkNrXhryeiKJexAoKber8j3P4KoE//pzL+CL+oHOrSlQepKagMtaU
         8+FJoYTl5CVd1Ys0rA5JWYz4gS7DDn8pbzQSeZlo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joshua Sivec <sivec@posteo.net>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.8 137/186] ALSA: usb-audio: Add implicit feedback quirk for UR22C
Date:   Tue,  8 Sep 2020 17:24:39 +0200
Message-Id: <20200908152248.291979079@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152241.646390211@linuxfoundation.org>
References: <20200908152241.646390211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joshua Sivec <sivec@posteo.net>

commit 7c5b892e0871655fea3294ffac6fa3cc3400b60d upstream.

This uses the same quirk as the Motu and SSL2 devices.
Tested on the UR22C.

Fixes bug 208851.

Signed-off-by: Joshua Sivec <sivec@posteo.net>
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=208851
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200825165515.8239-1-sivec@posteo.net
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/pcm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -369,6 +369,7 @@ static int set_sync_ep_implicit_fb_quirk
 	case USB_ID(0x07fd, 0x0008): /* MOTU M Series */
 	case USB_ID(0x31e9, 0x0001): /* Solid State Logic SSL2 */
 	case USB_ID(0x31e9, 0x0002): /* Solid State Logic SSL2+ */
+	case USB_ID(0x0499, 0x172f): /* Steinberg UR22C */
 	case USB_ID(0x0d9a, 0x00df): /* RTX6001 */
 		ep = 0x81;
 		ifnum = 2;


