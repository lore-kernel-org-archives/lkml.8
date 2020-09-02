Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614A5C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 11:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C002207D3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 11:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599044565;
	bh=tPRhJJgXvDc0IuVKlXjbFRDWA8BX95/8fwQ++InXL5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vjifD7/lgYLorLFclxW1T2G3zjT7bB22KNmRjO57LgPOQ6Z2MiPgtpBz9HjmnmYU1
	 ZDXsDQ4Anl5qdozo4yJthSH4GapC8kdoQDREb4JeVx4Gcp8brWEP1V+CT83V0xJPEj
	 F120vDKR39l7gGJLpHU1FGWtLU7EWQZDiZMmJikI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgIBLCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 07:02:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:45956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbgIBLBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 07:01:30 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB99E2166E;
        Wed,  2 Sep 2020 11:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599044489;
        bh=tPRhJJgXvDc0IuVKlXjbFRDWA8BX95/8fwQ++InXL5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=07OoVR0jEQGE5aJ5jGecu1PUSSxjmfVizWumbkwRmppmTzi/9M+GYZ6sLUlp/8xsA
         MatkLBEBframZqC4xWnXZgXV2Gexp07mxPQDdNbBrtzD/tJyKLiaWzNS5FIbLeFx4n
         BewIUXy+pc/RvMtGbdmQB3kbyYdWeaqMLVXio7Bs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     himadrispandya@gmail.com, dvyukov@google.com,
        linux-usb@vger.kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, stern@rowland.harvard.ed,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 8/9] sound: 6fire: move to use new usb control functions...
Date:   Wed,  2 Sep 2020 13:01:11 +0200
Message-Id: <20200902110115.1994491-10-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902110115.1994491-1-gregkh@linuxfoundation.org>
References: <20200902110115.1994491-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/6fire/firmware.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/sound/usb/6fire/firmware.c b/sound/usb/6fire/firmware.c
index 69137c14d0dc..e87bfa97be4e 100644
--- a/sound/usb/6fire/firmware.c
+++ b/sound/usb/6fire/firmware.c
@@ -158,29 +158,17 @@ static int usb6fire_fw_ihex_init(const struct firmware *fw,
 static int usb6fire_fw_ezusb_write(struct usb_device *device,
 		int type, int value, char *data, int len)
 {
-	int ret;
-
-	ret = usb_control_msg(device, usb_sndctrlpipe(device, 0), type,
+	return usb_control_msg_send(device, 0, type,
 			USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 			value, 0, data, len, HZ);
-	if (ret < 0)
-		return ret;
-	else if (ret != len)
-		return -EIO;
-	return 0;
 }
 
 static int usb6fire_fw_ezusb_read(struct usb_device *device,
 		int type, int value, char *data, int len)
 {
-	int ret = usb_control_msg(device, usb_rcvctrlpipe(device, 0), type,
+	return usb_control_msg_recv(device, 0, type,
 			USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE, value,
 			0, data, len, HZ);
-	if (ret < 0)
-		return ret;
-	else if (ret != len)
-		return -EIO;
-	return 0;
 }
 
 static int usb6fire_fw_fpga_write(struct usb_device *device,
-- 
2.28.0

