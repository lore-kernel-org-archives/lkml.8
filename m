Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307E2C35240
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 10:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E242067C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 10:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580638772;
	bh=G9oaWmX9SL3kJNAlEuJfisNLw7GQxdN+ajefHkF//lA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vn8Nwc+geERvb+VReh1OtuuDUTKo+PGYjN/u8Rvmxasvdz28Z77kVmSyNwY+BgU8Z
	 W1AsOW3hsQ4nzorhsBYcapitccRT3T5aGQws6YbcXaX8Trf3RUrJlM/HbeZkDjhvoM
	 UpVD5NzgxFCatsJw0DSAWQhraYCDPhxzeKfAYHyo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgBBKT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 05:19:29 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45313 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgBBKT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 05:19:28 -0500
Received: by mail-lj1-f196.google.com with SMTP id f25so11535906ljg.12;
        Sun, 02 Feb 2020 02:19:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KbZhK4eiEfC8B9hj7RYWwm4vi0wSDmiVDkqX6tXrqSk=;
        b=WyNctkVD92W5Zo5okgP3pijP49S6fSxWYgYHcizXbfYrUKOH2PhITs/0a/pQEzk1YY
         5xMwOFUroNNjM9BdO1EwXNkbk7cp7qIpq4DskpPIXG5emYlly5IR+xnXcw0zIA/6y3mc
         6JN19zf+LQQl0FgyYCbW5zfMo3wbYhtNrcFN5V00eKJ1TVDTTMDGESV6NTJEEKuNOtS3
         5E2BdhRhfxrW0/PabgeFDdE5wbq8E2yZ/3mV/M+YDyMh8en0C1iF6mo3urBWF8oxB7g7
         zeUH4ngfSizeJJlipAvd0bCzXxJmUeuzJofnn304F19if4RhPlOP73fzDb+zDF0KcBE4
         Qqrw==
X-Gm-Message-State: APjAAAW149f3UfxYwN1wdJMkdio1jhngtfETDJkjn9LMct9YdYXcpN2Z
        xNf+7k1FDSvdYhhoVx0waE4=
X-Google-Smtp-Source: APXvYqyjioxR0Waw/lsP+2544J5hsUPeUMXhRKM96QkyLQezDZ78Q42rqjZ4IJDsFkmfrnapIiweXw==
X-Received: by 2002:a2e:85cd:: with SMTP id h13mr11017543ljj.191.1580638766146;
        Sun, 02 Feb 2020 02:19:26 -0800 (PST)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id u16sm7837548ljl.34.2020.02.02.02.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 02:19:25 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1iyCLl-0008Sx-2W; Sun, 02 Feb 2020 11:19:33 +0100
Date:   Sun, 2 Feb 2020 11:19:33 +0100
From:   Johan Hovold <johan@kernel.org>
To:     edes <edes@gmx.net>
Cc:     linux-usb@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: Re: kernel 5.4.11: problems with usb sound cards
Message-ID: <20200202101933.GL10381@localhost>
References: <20200201105829.5682c887@acme7.acmenet>
 <20200201141009.GK10381@localhost>
 <20200201132616.09857152@acme7.acmenet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200201132616.09857152@acme7.acmenet>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ +CC: Takashi ]

On Sat, Feb 01, 2020 at 01:26:16PM -0300, edes wrote:
> 
> > Can you please post the output of "lsusb -v" for this device on 5.4.10
> > and 5.4.11, respectively?
> 
> 
> Hello, thanks for your prompt response. Please see attached (I hope that
> is OK) the output of lsusb -v on both 5.4.10 and 5.4.11.
> 
> The device in question is the Sound Devices USBPre2, Bus 003 Device 004:
> ID 0926:0202, beginning at line 808.

Ok, so the device has a broken altsetting 3 for interface 1, where
endpoint 0x85 is declared as an isochronous endpoint, despite being used
by interface 2 as an audio endpoint:

    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       3
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x85  EP 5 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0126  1x 294 bytes
        bInterval               1

...

    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           4
        bDelay                  1 frames
        wFormatTag         0x0001 PCM
      AudioStreaming Interface Descriptor:
        bLength                26
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            6 Discrete
        tSamFreq[ 0]         8000
        tSamFreq[ 1]        16000
        tSamFreq[ 2]        24000
        tSamFreq[ 3]        32000
        tSamFreq[ 4]        44100
        tSamFreq[ 5]        48000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x85  EP 5 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0126  1x 294 bytes
        bInterval               4
        bRefresh                0
        bSynchAddress           0
        AudioStreaming Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         2 Decoded PCM samples
          wLockDelay         0x0000


Since commit 3e4f8e21c4f2 ("USB: core: fix check for duplicate
endpoints") USB core ignores any duplicate endpoints, but in this case
we really want to ignore the first instance.

Can you try the below patch, which adds a blacklist quirk for the broken
endpoint descriptor?

Note that the broken altsetting probably should be using endpoint 0x81
just like the other altsettings for that interface, but hopefully you
don't really use this setting so that simply ignoring the endpoint will
make the device work again.

Interestingly enough, in your lsusb output from 5.4.11, the device
reports a second configuration in which this broken altsetting doesn't
exist. Switching to that config should also make the problem go away.

Johan


From c8980be317939eb7fae73960b0c6fa641c45bd7d Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Sun, 2 Feb 2020 10:39:05 +0100
Subject: [PATCH] USB: core: add endpoint blacklist quirk

Add a new device quirk that can be used to blacklist endpoints.

Since commit 3e4f8e21c4f2 ("USB: core: fix check for duplicate
endpoints") USB core ignores any duplicate endpoints found during
descriptor parsing.

In order to handle devices where the first interfaces with duplicate
endpoints are the ones that should have their endpoints ignored, we need
to add a blacklist.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/core/config.c  | 11 +++++++++++
 drivers/usb/core/quirks.c  | 32 ++++++++++++++++++++++++++++++++
 drivers/usb/core/usb.h     |  3 +++
 include/linux/usb/quirks.h |  3 +++
 4 files changed, 49 insertions(+)

diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index 26bc05e48d8a..7df22bcefa9d 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -256,6 +256,7 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 		struct usb_host_interface *ifp, int num_ep,
 		unsigned char *buffer, int size)
 {
+	struct usb_device *udev = to_usb_device(ddev);
 	unsigned char *buffer0 = buffer;
 	struct usb_endpoint_descriptor *d;
 	struct usb_host_endpoint *endpoint;
@@ -297,6 +298,16 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 		goto skip_to_next_endpoint_or_interface_descriptor;
 	}
 
+	/* Ignore blacklisted endpoints */
+	if (udev->quirks & USB_QUIRK_ENDPOINT_BLACKLIST) {
+		if (usb_endpoint_is_blacklisted(udev, ifp, d)) {
+			dev_warn(ddev, "config %d interface %d altsetting %d has a blacklisted endpoint with address 0x%X, skipping\n",
+					cfgno, inum, asnum,
+					d->bEndpointAddress);
+			goto skip_to_next_endpoint_or_interface_descriptor;
+		}
+	}
+
 	endpoint = &ifp->endpoint[ifp->desc.bNumEndpoints];
 	++ifp->desc.bNumEndpoints;
 
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 6b6413073584..a677a47a6438 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -354,6 +354,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x0904, 0x6103), .driver_info =
 			USB_QUIRK_LINEAR_FRAME_INTR_BINTERVAL },
 
+	/* Sound Devices USBPre2 */
+	{ USB_DEVICE(0x0926, 0x0202), .driver_info = USB_QUIRK_ENDPOINT_BLACKLIST },
+
 	/* Keytouch QWERTY Panel keyboard */
 	{ USB_DEVICE(0x0926, 0x3333), .driver_info =
 			USB_QUIRK_CONFIG_INTF_STRINGS },
@@ -472,6 +475,35 @@ static const struct usb_device_id usb_amd_resume_quirk_list[] = {
 	{ }  /* terminating entry must be last */
 };
 
+/*
+ * Entries for blacklisted endpoints.
+ *
+ * Matched for devices with USB_QUIRK_ENDPOINT_BLACKLIST.
+ */
+static const struct usb_device_id usb_endpoint_blacklist_quirk_list[] = {
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0926, 0x0202, 1), .driver_info = 0x85 },
+	{ },
+};
+
+bool usb_endpoint_is_blacklisted(struct usb_device *udev,
+		struct usb_host_interface *intf,
+		struct usb_endpoint_descriptor *epd)
+{
+	const struct usb_device_id *id;
+	unsigned int address;
+
+	for (id = usb_endpoint_blacklist_quirk_list; id->match_flags; ++id) {
+		if (usb_match_one_id_intf(udev, intf, id)) {
+			address = id->driver_info;
+
+			if (address == epd->bEndpointAddress)
+				return true;
+		}
+	}
+
+	return false;
+}
+
 static bool usb_match_any_interface(struct usb_device *udev,
 				    const struct usb_device_id *id)
 {
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index cf4783cf661a..3ad0ee57e859 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -37,6 +37,9 @@ extern void usb_authorize_interface(struct usb_interface *);
 extern void usb_detect_quirks(struct usb_device *udev);
 extern void usb_detect_interface_quirks(struct usb_device *udev);
 extern void usb_release_quirk_list(void);
+extern bool usb_endpoint_is_blacklisted(struct usb_device *udev,
+		struct usb_host_interface *intf,
+		struct usb_endpoint_descriptor *epd);
 extern int usb_remove_device(struct usb_device *udev);
 
 extern int usb_get_device_descriptor(struct usb_device *dev,
diff --git a/include/linux/usb/quirks.h b/include/linux/usb/quirks.h
index a1be64c9940f..22c1f579afe3 100644
--- a/include/linux/usb/quirks.h
+++ b/include/linux/usb/quirks.h
@@ -69,4 +69,7 @@
 /* Hub needs extra delay after resetting its port. */
 #define USB_QUIRK_HUB_SLOW_RESET		BIT(14)
 
+/* device has blacklisted endpoints */
+#define USB_QUIRK_ENDPOINT_BLACKLIST		BIT(15)
+
 #endif /* __LINUX_USB_QUIRKS_H */
-- 
2.24.1

