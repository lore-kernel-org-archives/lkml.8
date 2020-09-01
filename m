Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA53C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A8E42064B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598975576;
	bh=mlzUzot2M4ZASkpXLf0E01uJE73u+pmFNvA8oFwHmcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B7HVRplFyiCGwQ/NnUMTOM4H7iiflQkCJEpD+cFsvJKTFFfln2X4VWqq+ClAe2JzD
	 OEN9K3NqiPE5nR8FN4UQcUlbEE89xnSLxNdGZdnAspbSS3IYyHc5BNeZlg/Nr84q/P
	 lJ4BHrlYV0pxP3JS3eea8edMmwFcxTvy/OePyXTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbgIAPwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:52:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:38050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgIAPrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:47:17 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B6C921527;
        Tue,  1 Sep 2020 15:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598975236;
        bh=mlzUzot2M4ZASkpXLf0E01uJE73u+pmFNvA8oFwHmcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ciZWJ+U2+TrRwlABNHb57VPMmS8k+v2GjliwHKKH8Q4BLTcyRQYSLLgJs8xKSXhlw
         Qii70jWcexzq6fAW7Hi1HAFluQZWZ6jv4WkqAvK7mZi30trqFpanc4k22RS7llkDsr
         y2rcg8jX6FyNX0/6Q/fUTV6eLJq2pL9D+X/YuLDY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hector Martin <marcan@marcan.st>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.8 255/255] ALSA: usb-audio: Update documentation comment for MS2109 quirk
Date:   Tue,  1 Sep 2020 17:11:51 +0200
Message-Id: <20200901151012.988329326@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hector Martin <marcan@marcan.st>

commit 74a2a7de81a2ef20732ec02087314e92692a7a1b upstream.

As the recent fix addressed the channel swap problem more properly,
update the comment as well.

Fixes: 1b7ecc241a67 ("ALSA: usb-audio: work around streaming quirk for MacroSilicon MS2109")
Signed-off-by: Hector Martin <marcan@marcan.st>
Link: https://lore.kernel.org/r/20200816084431.102151-1-marcan@marcan.st
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/quirks-table.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3727,8 +3727,8 @@ ALC1220_VB_DESKTOP(0x26ce, 0x0a01), /* A
  * they pretend to be 96kHz mono as a workaround for stereo being broken
  * by that...
  *
- * They also have swapped L-R channels, but that's for userspace to deal
- * with.
+ * They also have an issue with initial stream alignment that causes the
+ * channels to be swapped and out of phase, which is dealt with in quirks.c.
  */
 {
 	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |


