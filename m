Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68371C3524C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 13:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC162067C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 13:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580650916;
	bh=t8/FgLSUyj5JVwfpnL1AOTU0aN/NxX7Rj0J4biYsqn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E0W6Gk0frNHJgP7T3QTcp30RlHZJdO/iRokdfUBsqvXWDXgnrueocStX6Rwzc46DD
	 XMJ/Pcghxtp6sT9ab6UYV0b3Q07hg6X8kg74M+I4enjPwLJiPdxlb/UoRVmIqsCnUN
	 UY2/O/+icJMM3KSI1FiuSmV37ja0PD5MvH9t+6Mk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgBBNlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 08:41:55 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38734 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgBBNly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 08:41:54 -0500
Received: by mail-lj1-f193.google.com with SMTP id w1so11865497ljh.5;
        Sun, 02 Feb 2020 05:41:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sClwc243rx1Kc3kGspzVWVFHpzaWriLjgFC0oBv6Nss=;
        b=hYTEN3Y1MHS+AorTMhqTZsRaxveZoqYyXF3A5kmO8oWiMVDAViPJADo4zjlSKKH/nH
         ScqdwzHjSKoy56Ak1msSjaAiS43FuGaK8DPOLQ+QW6Zo/v5mTZk9lFLiDwDNwLx19Kyv
         zl6v5/mjDcyVW1SjDlgck4n1lyJ+R5w/ZYcWMJ1zLnalXX7cPcwdxDULs32SAVh2D9uE
         AJK17PBWN1cVlti0kxBOs81tFr4ngpkCf4YreGLc7RnPJO/O6bqlHI89NqoKaJ1LmQQr
         nvYp38jAQHWtTFlu8tKTnrLDYX9M5AUhbmfRMeKTlir81fphrO4TWxkQdvhAYp13vcmj
         cF+w==
X-Gm-Message-State: APjAAAUmxCrAEgF2E81TYeSSh5MVg8W2X+UzuTXErNbq8IHTgPqtg+fU
        zjZbfbBWg/qdwglRzuttnrh6TYSB
X-Google-Smtp-Source: APXvYqzu0XeKGVI2m1+xIVv9XEHnCQ1jM0D87PStc3fgHGZTAn0ko4urhXBDbVOJ5D+FBIqcRDDrNA==
X-Received: by 2002:a2e:a0d0:: with SMTP id f16mr11124588ljm.130.1580650912215;
        Sun, 02 Feb 2020 05:41:52 -0800 (PST)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id z13sm8089354ljh.21.2020.02.02.05.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 05:41:51 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1iyFVf-0002Uv-Ou; Sun, 02 Feb 2020 14:41:59 +0100
Date:   Sun, 2 Feb 2020 14:41:59 +0100
From:   Johan Hovold <johan@kernel.org>
To:     edes <edes@gmx.net>
Cc:     linux-usb@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: Re: kernel 5.4.11: problems with usb sound cards
Message-ID: <20200202134159.GM10381@localhost>
References: <20200201105829.5682c887@acme7.acmenet>
 <20200201141009.GK10381@localhost>
 <20200201132616.09857152@acme7.acmenet>
 <20200202101933.GL10381@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200202101933.GL10381@localhost>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 02, 2020 at 11:19:33AM +0100, Johan Hovold wrote:

> Since commit 3e4f8e21c4f2 ("USB: core: fix check for duplicate
> endpoints") USB core ignores any duplicate endpoints, but in this case
> we really want to ignore the first instance.
> 
> Can you try the below patch, which adds a blacklist quirk for the broken
> endpoint descriptor?

I realised I forgot the test to match on the device descriptor when
applying the blacklist. It doesn't matter currently since I only enable
the quirk for your device, but if you haven't tested the patch already,
would you mind testing the below patch instead?

Johan


From c01e64edf751b2079c30d57f57c9a2d20d00b80a Mon Sep 17 00:00:00 2001
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
 drivers/usb/core/quirks.c  | 35 +++++++++++++++++++++++++++++++++++
 drivers/usb/core/usb.h     |  3 +++
 include/linux/usb/quirks.h |  3 +++
 4 files changed, 52 insertions(+)

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
index 6b6413073584..9925b18e2154 100644
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
@@ -472,6 +475,38 @@ static const struct usb_device_id usb_amd_resume_quirk_list[] = {
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
+		if (!usb_match_device(udev, id))
+			continue;
+
+		if (!usb_match_one_id_intf(udev, intf, id))
+			continue;
+
+		address = id->driver_info;
+		if (address == epd->bEndpointAddress)
+			return true;
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

