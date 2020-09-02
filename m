Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B84C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 11:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE4662078E
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 11:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599044530;
	bh=SjaZIwH/tb3JNsYjS5SxojsLOb58EBpAvKy4ZzfcdhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ph5zxRQOfoYjuk7yvQZC7vxVJMTwc+4Jai4b/4yNRO5gT9f/e49N1zaIM3QBz+x20
	 SC3s1FlwhITZvWGv8p5Wdn6fYrWkXSFcnFLqcmPQCW3TX0eD0rpRS1VvVoOBpyUJal
	 6jPwxRfFUkd7Jl0Tjbc9RQIQCyKEVsxQfXt0OfWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgIBLCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 07:02:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgIBLA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 07:00:56 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED8832065E;
        Wed,  2 Sep 2020 11:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599044455;
        bh=SjaZIwH/tb3JNsYjS5SxojsLOb58EBpAvKy4ZzfcdhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PxWMEIAiuOe+LaXSvA6XNwEqeDVZ8M4g4r147HDTnNZhnZHBuvO2FzAUrEls+SsS1
         0TAm7ItoPeKbcQZOoPiEXSuT/+en42csi8D0uC2dcVzmMK+eEyIpR0/rF2pUMlpgWX
         o7hblx/CJj95taOMG3pgG/oo6o4tqRBu/W/hg6CU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     himadrispandya@gmail.com, dvyukov@google.com,
        linux-usb@vger.kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, stern@rowland.harvard.ed,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Eli Billauer <eli.billauer@gmail.com>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alexander Tsoy <alexander@tsoy.me>,
        "Geoffrey D. Bennett" <g@b4.vu>, Jussi Laako <jussi@sonarnerd.net>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Dmitry Panchenko <dmitry@d-systems.ee>,
        Chris Wulff <crwulff@gmail.com>,
        Jesus Ramos <jesus-ramos@live.com>
Subject: [PATCH 01/10] USB: move snd_usb_pipe_sanity_check into the USB core
Date:   Wed,  2 Sep 2020 13:01:03 +0200
Message-Id: <20200902110115.1994491-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902110115.1994491-1-gregkh@linuxfoundation.org>
References: <20200902110115.1994491-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snd_usb_pipe_sanity_check() is a great function, so let's move it into
the USB core so that other parts of the kernel, including the USB core,
can call it.

Name it usb_pipe_type_check() to match the existing
usb_urb_ep_type_check() call, which now uses this function.

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Eli Billauer <eli.billauer@gmail.com>
Cc: Emiliano Ingrassia <ingrassia@epigenesys.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Alexander Tsoy <alexander@tsoy.me>
Cc: "Geoffrey D. Bennett" <g@b4.vu>
Cc: Jussi Laako <jussi@sonarnerd.net>
Cc: Nick Kossifidis <mickflemm@gmail.com>
Cc: Dmitry Panchenko <dmitry@d-systems.ee>
Cc: Chris Wulff <crwulff@gmail.com>
Cc: Jesus Ramos <jesus-ramos@live.com>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/urb.c          | 29 ++++++++++++++++++++++-------
 include/linux/usb.h             |  1 +
 sound/usb/helper.c              | 16 +---------------
 sound/usb/helper.h              |  1 -
 sound/usb/mixer_scarlett_gen2.c |  2 +-
 sound/usb/quirks.c              | 12 ++++++------
 6 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
index 27e83e55a590..45bc2914c1ba 100644
--- a/drivers/usb/core/urb.c
+++ b/drivers/usb/core/urb.c
@@ -192,24 +192,39 @@ static const int pipetypes[4] = {
 };
 
 /**
- * usb_urb_ep_type_check - sanity check of endpoint in the given urb
- * @urb: urb to be checked
+ * usb_pipe_type_check - sanity check of a specific pipe for a usb device
+ * @dev: struct usb_device to be checked
+ * @pipe: pipe to check
  *
  * This performs a light-weight sanity check for the endpoint in the
- * given urb.  It returns 0 if the urb contains a valid endpoint, otherwise
- * a negative error code.
+ * given usb device.  It returns 0 if the pipe is a valid for the specific usb
+ * device, otherwise a negative error code.
  */
-int usb_urb_ep_type_check(const struct urb *urb)
+int usb_pipe_type_check(struct usb_device *dev, unsigned int pipe)
 {
 	const struct usb_host_endpoint *ep;
 
-	ep = usb_pipe_endpoint(urb->dev, urb->pipe);
+	ep = usb_pipe_endpoint(dev, pipe);
 	if (!ep)
 		return -EINVAL;
-	if (usb_pipetype(urb->pipe) != pipetypes[usb_endpoint_type(&ep->desc)])
+	if (usb_pipetype(pipe) != pipetypes[usb_endpoint_type(&ep->desc)])
 		return -EINVAL;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(usb_pipe_type_check);
+
+/**
+ * usb_urb_ep_type_check - sanity check of endpoint in the given urb
+ * @urb: urb to be checked
+ *
+ * This performs a light-weight sanity check for the endpoint in the
+ * given urb.  It returns 0 if the urb contains a valid endpoint, otherwise
+ * a negative error code.
+ */
+int usb_urb_ep_type_check(const struct urb *urb)
+{
+	return usb_pipe_type_check(urb->dev, urb->pipe);
+}
 EXPORT_SYMBOL_GPL(usb_urb_ep_type_check);
 
 /**
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 20c555db4621..0b3963d7ec38 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1764,6 +1764,7 @@ static inline int usb_urb_dir_out(struct urb *urb)
 	return (urb->transfer_flags & URB_DIR_MASK) == URB_DIR_OUT;
 }
 
+int usb_pipe_type_check(struct usb_device *dev, unsigned int pipe);
 int usb_urb_ep_type_check(const struct urb *urb);
 
 void *usb_alloc_coherent(struct usb_device *dev, size_t size,
diff --git a/sound/usb/helper.c b/sound/usb/helper.c
index 4c12cc5b53fd..cf92d7110773 100644
--- a/sound/usb/helper.c
+++ b/sound/usb/helper.c
@@ -63,20 +63,6 @@ void *snd_usb_find_csint_desc(void *buffer, int buflen, void *after, u8 dsubtype
 	return NULL;
 }
 
-/* check the validity of pipe and EP types */
-int snd_usb_pipe_sanity_check(struct usb_device *dev, unsigned int pipe)
-{
-	static const int pipetypes[4] = {
-		PIPE_CONTROL, PIPE_ISOCHRONOUS, PIPE_BULK, PIPE_INTERRUPT
-	};
-	struct usb_host_endpoint *ep;
-
-	ep = usb_pipe_endpoint(dev, pipe);
-	if (!ep || usb_pipetype(pipe) != pipetypes[usb_endpoint_type(&ep->desc)])
-		return -EINVAL;
-	return 0;
-}
-
 /*
  * Wrapper for usb_control_msg().
  * Allocates a temp buffer to prevent dmaing from/to the stack.
@@ -89,7 +75,7 @@ int snd_usb_ctl_msg(struct usb_device *dev, unsigned int pipe, __u8 request,
 	void *buf = NULL;
 	int timeout;
 
-	if (snd_usb_pipe_sanity_check(dev, pipe))
+	if (usb_pipe_type_check(dev, pipe))
 		return -EINVAL;
 
 	if (size > 0) {
diff --git a/sound/usb/helper.h b/sound/usb/helper.h
index 5e8a18b4e7b9..f5b4c6647e4d 100644
--- a/sound/usb/helper.h
+++ b/sound/usb/helper.h
@@ -7,7 +7,6 @@ unsigned int snd_usb_combine_bytes(unsigned char *bytes, int size);
 void *snd_usb_find_desc(void *descstart, int desclen, void *after, u8 dtype);
 void *snd_usb_find_csint_desc(void *descstart, int desclen, void *after, u8 dsubtype);
 
-int snd_usb_pipe_sanity_check(struct usb_device *dev, unsigned int pipe);
 int snd_usb_ctl_msg(struct usb_device *dev, unsigned int pipe,
 		    __u8 request, __u8 requesttype, __u16 value, __u16 index,
 		    void *data, __u16 size);
diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index 0ffff7640892..9609c6d9655c 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -1978,7 +1978,7 @@ static int scarlett2_mixer_status_create(struct usb_mixer_interface *mixer)
 		return 0;
 	}
 
-	if (snd_usb_pipe_sanity_check(dev, pipe))
+	if (usb_pipe_type_check(dev, pipe))
 		return -EINVAL;
 
 	mixer->urb = usb_alloc_urb(0, GFP_KERNEL);
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index abf99b814a0f..fc3aab04a0bc 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -846,7 +846,7 @@ static int snd_usb_accessmusic_boot_quirk(struct usb_device *dev)
 	static const u8 seq[] = { 0x4e, 0x73, 0x52, 0x01 };
 	void *buf;
 
-	if (snd_usb_pipe_sanity_check(dev, usb_sndintpipe(dev, 0x05)))
+	if (usb_pipe_type_check(dev, usb_sndintpipe(dev, 0x05)))
 		return -EINVAL;
 	buf = kmemdup(seq, ARRAY_SIZE(seq), GFP_KERNEL);
 	if (!buf)
@@ -875,7 +875,7 @@ static int snd_usb_nativeinstruments_boot_quirk(struct usb_device *dev)
 {
 	int ret;
 
-	if (snd_usb_pipe_sanity_check(dev, usb_sndctrlpipe(dev, 0)))
+	if (usb_pipe_type_check(dev, usb_sndctrlpipe(dev, 0)))
 		return -EINVAL;
 	ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
 				  0xaf, USB_TYPE_VENDOR | USB_RECIP_DEVICE,
@@ -984,7 +984,7 @@ static int snd_usb_axefx3_boot_quirk(struct usb_device *dev)
 
 	dev_dbg(&dev->dev, "Waiting for Axe-Fx III to boot up...\n");
 
-	if (snd_usb_pipe_sanity_check(dev, usb_sndctrlpipe(dev, 0)))
+	if (usb_pipe_type_check(dev, usb_sndctrlpipe(dev, 0)))
 		return -EINVAL;
 	/* If the Axe-Fx III has not fully booted, it will timeout when trying
 	 * to enable the audio streaming interface. A more generous timeout is
@@ -1018,7 +1018,7 @@ static int snd_usb_motu_microbookii_communicate(struct usb_device *dev, u8 *buf,
 {
 	int err, actual_length;
 
-	if (snd_usb_pipe_sanity_check(dev, usb_sndintpipe(dev, 0x01)))
+	if (usb_pipe_type_check(dev, usb_sndintpipe(dev, 0x01)))
 		return -EINVAL;
 	err = usb_interrupt_msg(dev, usb_sndintpipe(dev, 0x01), buf, *length,
 				&actual_length, 1000);
@@ -1030,7 +1030,7 @@ static int snd_usb_motu_microbookii_communicate(struct usb_device *dev, u8 *buf,
 
 	memset(buf, 0, buf_size);
 
-	if (snd_usb_pipe_sanity_check(dev, usb_rcvintpipe(dev, 0x82)))
+	if (usb_pipe_type_check(dev, usb_rcvintpipe(dev, 0x82)))
 		return -EINVAL;
 	err = usb_interrupt_msg(dev, usb_rcvintpipe(dev, 0x82), buf, buf_size,
 				&actual_length, 1000);
@@ -1117,7 +1117,7 @@ static int snd_usb_motu_m_series_boot_quirk(struct usb_device *dev)
 {
 	int ret;
 
-	if (snd_usb_pipe_sanity_check(dev, usb_sndctrlpipe(dev, 0)))
+	if (usb_pipe_type_check(dev, usb_sndctrlpipe(dev, 0)))
 		return -EINVAL;
 	ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
 			      1, USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-- 
2.28.0

