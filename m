Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4DCC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B012067D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582056485;
	bh=S7Ztsxekh19xf5KRg0jXLvZMQ3oj0ync9f2TGpT6rxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NT++uiePT1GzRfrjjvHoIE/03MSYs9Vyd3r7naIffOVuZBT8758hNL6XOAEXxVJjs
	 ybYg55jVB4LzCrb1rJu19jMyzcDE2gAHIOEdP8MKUVg9nHXHXFw1i3fxEmjTSx40YK
	 xCP4NssQKYdyCDfxATBVEAgF9fDl+tOxOD/JjTyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgBRUIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:08:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:36384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728226AbgBRT6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:58:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0FEC2464E;
        Tue, 18 Feb 2020 19:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582055915;
        bh=S7Ztsxekh19xf5KRg0jXLvZMQ3oj0ync9f2TGpT6rxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p9WofKwK/cna7q1mmyb7kZ2T/RyjOj+m2NEn0WTnkUemnvC9ATfalmfJNQxM3u0wE
         kSNuo7YRn5UrJFeSePeMwS/NOnnSpKY80FeW18ies5luuMKBwmt+8Sq9kIRgeVskIV
         HNeohwWHiJHaWKrtq1JnUcz5RsnCEIhk7H65myUU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.4 12/66] ALSA: usb-audio: sound: usb: usb true/false for bool return type
Date:   Tue, 18 Feb 2020 20:54:39 +0100
Message-Id: <20200218190429.246014666@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200218190428.035153861@linuxfoundation.org>
References: <20200218190428.035153861@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saurav Girepunje <saurav.girepunje@gmail.com>

commit 1d4961d9eb1aaa498dfb44779b7e4b95d79112d0 upstream.

Use true/false for bool type return in uac_clock_source_is_valid().

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
Link: https://lore.kernel.org/r/20191029175200.GA7320@saurav
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/clock.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -165,21 +165,21 @@ static bool uac_clock_source_is_valid(st
 			snd_usb_find_clock_source_v3(chip->ctrl_intf, source_id);
 
 		if (!cs_desc)
-			return 0;
+			return false;
 		bmControls = le32_to_cpu(cs_desc->bmControls);
 	} else { /* UAC_VERSION_1/2 */
 		struct uac_clock_source_descriptor *cs_desc =
 			snd_usb_find_clock_source(chip->ctrl_intf, source_id);
 
 		if (!cs_desc)
-			return 0;
+			return false;
 		bmControls = cs_desc->bmControls;
 	}
 
 	/* If a clock source can't tell us whether it's valid, we assume it is */
 	if (!uac_v2v3_control_is_readable(bmControls,
 				      UAC2_CS_CONTROL_CLOCK_VALID))
-		return 1;
+		return true;
 
 	err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_CUR,
 			      USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
@@ -191,10 +191,10 @@ static bool uac_clock_source_is_valid(st
 		dev_warn(&dev->dev,
 			 "%s(): cannot get clock validity for id %d\n",
 			   __func__, source_id);
-		return 0;
+		return false;
 	}
 
-	return !!data;
+	return data ? true :  false;
 }
 
 static int __uac_clock_find_source(struct snd_usb_audio *chip, int entity_id,


