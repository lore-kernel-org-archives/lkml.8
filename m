Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8C2C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0A22204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597689845;
	bh=hob5rQU3KtWXDybm623x085AoUsNKY9aH/mUMcv3jD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DtHgPOw9GkQULlIKj/3e68wdMIJIjH7glgNoYVw/HWmP0REWvtdr7/j4zcfurK0TL
	 zXfp1DrYf7bQjKrf4kwzxqwkO3M3cYW0I0c4mzTMA/RtAtNCMQr789L4x+Zvncv6Hh
	 a9TV8f+mKbd0IQeUs9L4U8Hd6ojagFyW6rBFLJEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391519AbgHQSoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:44:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388077AbgHQP4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:56:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1D98221E2;
        Mon, 17 Aug 2020 15:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679788;
        bh=hob5rQU3KtWXDybm623x085AoUsNKY9aH/mUMcv3jD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oM6xIgZab7jmbkQO9nfX7WPVMJo6kMc0xdKTF4DcC1CoMSPPQq1+CPjSty1akMCod
         dwR96FTjedA5iXIbfgVW0T+AqfRbcUgNrKD5w1LXHaS/rHmJnrhr9Q1Fcwz7Xy0fcO
         UtovaYvJhqLpAkDq9hLETyWYKrJUMTPyh92aDXMs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mirko Dietrich <buzz@l4m1.de>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.7 335/393] ALSA: usb-audio: Creative USB X-Fi Pro SB1095 volume knob support
Date:   Mon, 17 Aug 2020 17:16:25 +0200
Message-Id: <20200817143835.848186262@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mirko Dietrich <buzz@l4m1.de>

commit fec9008828cde0076aae595ac031bfcf49d335a4 upstream.

Adds an entry for Creative USB X-Fi to the rc_config array in
mixer_quirks.c to allow use of volume knob on the device.
Adds support for newer X-Fi Pro card, known as "Model No. SB1095"
with USB ID "041e:3263"

Signed-off-by: Mirko Dietrich <buzz@l4m1.de>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200806124850.20334-1-buzz@l4m1.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/mixer_quirks.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -185,6 +185,7 @@ static const struct rc_config {
 	{ USB_ID(0x041e, 0x3042), 0, 1, 1, 1,  1,  0x000d }, /* Usb X-Fi S51 */
 	{ USB_ID(0x041e, 0x30df), 0, 1, 1, 1,  1,  0x000d }, /* Usb X-Fi S51 Pro */
 	{ USB_ID(0x041e, 0x3237), 0, 1, 1, 1,  1,  0x000d }, /* Usb X-Fi S51 Pro */
+	{ USB_ID(0x041e, 0x3263), 0, 1, 1, 1,  1,  0x000d }, /* Usb X-Fi S51 Pro */
 	{ USB_ID(0x041e, 0x3048), 2, 2, 6, 6,  2,  0x6e91 }, /* Toshiba SB0500 */
 };
 


