Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AE3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF92920776
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oIlGGYI+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbgFPLam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 07:30:42 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:37131 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgFPLal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 07:30:41 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200616113036epoutp03ea6c4e1e2410b76aafc2d4f392c14fed~ZAtBMbQuH1184911849epoutp03c
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 11:30:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200616113036epoutp03ea6c4e1e2410b76aafc2d4f392c14fed~ZAtBMbQuH1184911849epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592307036;
        bh=XN4zHQ5s2L7w5R9LO9A/kCj0MXyiPg2YWme+Zkr0eyE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=oIlGGYI+t65O1UULUt8uWSEwZLTxtRYnvmtFIfeGkuZF2/Uv/YKRPLYTdIYLKqqBZ
         bivC23T973pN4FpEmBZ/oczMvxT5GrRBUhCZ6Ez2yGGgUX0hforqH43T2GHe52E+UW
         +Nz0iDzjuZa2gciyQXEjNS8Dvc6qLIbKzIETT1tU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20200616113036epcas2p3eaf360f75fdff816f6b9a4c2e90d6155~ZAtA1z5_m2622726227epcas2p3X;
        Tue, 16 Jun 2020 11:30:36 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.40.190]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 49mQx608BtzMqYkW; Tue, 16 Jun
        2020 11:30:34 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        C5.47.27441.95DA8EE5; Tue, 16 Jun 2020 20:30:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20200616113032epcas2p19a45e49c1899f81358a0a41d5db4f8e8~ZAs9QLsyk2655326553epcas2p1Z;
        Tue, 16 Jun 2020 11:30:32 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200616113032epsmtrp129ccfa273ca36c9dd7b00a2cbe8f4d5a~ZAs9Pqxm21393513935epsmtrp1m;
        Tue, 16 Jun 2020 11:30:32 +0000 (GMT)
X-AuditID: b6c32a47-fafff70000006b31-2c-5ee8ad594a04
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8B.E4.08303.85DA8EE5; Tue, 16 Jun 2020 20:30:32 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200616113032epsmtip1183a3a5e8bd30e0f2078184cba9d1fce~ZAs9Gryr42112821128epsmtip1L;
        Tue, 16 Jun 2020 11:30:32 +0000 (GMT)
From:   JaeHun Jung <jh0801.jung@samsung.com>
To:     linux-kernel@vger.kernel.org
Cc:     JaeHun Jung <jh0801.jung@samsung.com>
Subject: [PATCH] ANDROID: sound: usb: Add vendor's hooking interface
Date:   Tue, 16 Jun 2020 20:22:57 +0900
Message-Id: <1592306577-130318-1-git-send-email-jh0801.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsWy7bCmqW7k2hdxBj83W1ncffiDxeLyrjls
        DkwefVtWMXp83iQXwBSVY5ORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtq
        q+TiE6DrlpkDNF5JoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BoWKBXnJhbXJqX
        rpecn2tlaGBgZApUmZCTsXXGLOaCJvuK1x9XsTcwTjXpYuTkkBAwkdjz/D5rFyMXh5DADkaJ
        a9e/MkE4nxgldk9fzgxSJSTwmVHi6Bp1mI6uK5dZIIp2MUpMnfccquMHo8SR3YvZQarYBLQl
        9s1ZBGaLCChIbO59xgpiMwtoSnz+BrKCg0NYwEVi1k1hkDCLgKrEsjsL2UHCvAIeEsse8EPs
        kpO4ea6TGWS8hMBnNokbV7qYIBIuElenLmWDsIUlXh3fwg5hS0m87G+DsuslTm9cB9Xcwyjx
        8cYuqAZjiVnP2hlBloHcs36XPogpIaAsceQWC8SVfBIdh/+yQ4R5JTrahCAaVSUONt5kgbCl
        Jb71vmOEsD0k/l55xQgJqliJNW8Ps09glJ2FMH8BI+MqRrHUguLc9NRiowJj5CjaxAhOMFru
        OxhnvP2gd4iRiYPxEKMEB7OSCG+07Ys4Id6UxMqq1KL8+KLSnNTiQ4ymwOCayCwlmpwPTHF5
        JfGGpkZmZgaWphamZkYWSuK8xVYX4oQE0hNLUrNTUwtSi2D6mDg4pRqYNgtKP5IJT29XS1Pf
        lJN1o+6ftdbsc5tvpxbwZu371XBK73XKP3vDU2sMbyq75H+8xcIVy/X994uPMyNyD+lPi3ni
        Us+2UO1WZX9HbeT5Ves2dfU275y7SGThvJTZrD+0v95Nublq4e9Gg1WnDzy4dkh69w/R6C8Z
        RttL9q9eY/zhuUCbyS9f8QUin/4U7DnZvLUy4Op943jtkMnaXw6aWqxL7jCWXnRzb6DLFhnh
        AJc+icWaKSF+q+YeM/2omP3putzyrk4b1cmznyZ3hq+Yoq/ssjul46hy92S9uvtnmu+2rX34
        JjnfYY/mlIQrhU+W3ZTQfaCg9M3yg13cljVp+681eMq4PVnx5nlw6pU/h5RYijMSDbWYi4oT
        AZmKrjK5AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCJMWRmVeSWpSXmKPExsWy7bCSnG7E2hdxBo2HVCzuPvzBYnF51xw2
        ByaPvi2rGD0+b5ILYIrisklJzcksSy3St0vgytg6YxZzQZN9xeuPq9gbGKeadDFyckgImEh0
        XbnMAmILCexglLi51hoiLi2xs3MqE4QtLHG/5QhrFyMXUM03RokH698ygiTYBLQl9s1ZxA5i
        iwgoSGzufcYKYjMLaEp8/vYVqJmDQ1jARWLWTWGQMIuAqsSyOwvZQcK8Ah4Syx7wQ4yXk7h5
        rpN5AiPPAkaGVYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwR7X0trBuGfVB71DjEwc
        jIcYJTiYlUR4o21fxAnxpiRWVqUW5ccXleakFh9ilOZgURLn/TprYZyQQHpiSWp2ampBahFM
        lomDU6qBybtDjSV5T/0kIbeQhhMHvgR1efBPk/cwZNruLPt9xh33eP8DvIVpRg8qZ0UfVvn9
        oEtO43rT5stqW1fpTeGNcGg8OFdj8tW8CgV1dZWGbc3s+pErA85/iWr6ufW785/aQK3FufWx
        xjHhkU4+Du1iiu/Z/orP1lx4W8X3qI6KqtVkhQev7TLjrP//VDo7LWnCKj6uW/80LriFKT95
        6Lf68yxFFtFqpc/m7ZdtajhT7CS/6YhJLfZxvaTcs4Xny6e0Jetutf/RmHd9efrHgOtGD3pP
        Xv3CfDmrtVRCaan6eqa25tPFwqdmhxde9FvbcvfzVc9TF6PyH6w5PpuzaBfP8YpCQZ+CPzc+
        K7mvVTRUYinOSDTUYi4qTgQAuPzTbGcCAAA=
X-CMS-MailID: 20200616113032epcas2p19a45e49c1899f81358a0a41d5db4f8e8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200616113032epcas2p19a45e49c1899f81358a0a41d5db4f8e8
References: <CGME20200616113032epcas2p19a45e49c1899f81358a0a41d5db4f8e8@epcas2p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mobile, a co-processor is used when using USB audio
to improve power consumption.
hooking is required for sync-up when operating
the co-processor. So register call-back function.
The main operation of the call-back function is as follows:
- Initialize the co-processor by transmitting data
  when initializing.
- Change the co-processor setting value through
  the interface function.
- Configure sampling rate
- pcm open/close

Bug: 156315379

Change-Id: I32e1dd408e64aaef68ee06c480c4b4d4c95546dc
Signed-off-by: JaeHun Jung <jh0801.jung@samsung.com>
---
 sound/usb/card.c     | 16 ++++++++++++++++
 sound/usb/card.h     |  1 +
 sound/usb/clock.c    |  5 +++++
 sound/usb/pcm.c      | 33 +++++++++++++++++++++++++++++++++
 sound/usb/usbaudio.h | 30 ++++++++++++++++++++++++++++++
 5 files changed, 85 insertions(+)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index fd6fd17..2f3fa14 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -111,6 +111,7 @@ MODULE_PARM_DESC(skip_validation, "Skip unit descriptor validation (default: no)
 static DEFINE_MUTEX(register_mutex);
 static struct snd_usb_audio *usb_chip[SNDRV_CARDS];
 static struct usb_driver usb_audio_driver;
+struct snd_usb_audio_vendor_ops *usb_audio_ops;
 
 /*
  * disconnect streams
@@ -210,6 +211,12 @@ static int snd_usb_create_stream(struct snd_usb_audio *chip, int ctrlif, int int
 	return 0;
 }
 
+void snd_set_vender_interface(struct snd_usb_audio_vendor_ops *vendor_ops)
+{
+	usb_audio_ops = vendor_ops;
+}
+EXPORT_SYMBOL_GPL(snd_set_vender_interface);
+
 /*
  * parse audio control descriptor and create pcm/midi streams
  */
@@ -598,6 +605,9 @@ static int usb_audio_probe(struct usb_interface *intf,
 	if (err < 0)
 		return err;
 
+	if (usb_audio_ops && usb_audio_ops->vendor_conn)
+		usb_audio_ops->vendor_conn(intf, dev);
+
 	/*
 	 * found a config.  now register to ALSA
 	 */
@@ -653,6 +663,9 @@ static int usb_audio_probe(struct usb_interface *intf,
 	}
 	dev_set_drvdata(&dev->dev, chip);
 
+	if (usb_audio_ops && usb_audio_ops->vendor_usb_add_ctls)
+		usb_audio_ops->vendor_usb_add_ctls(chip, 0);
+
 	/*
 	 * For devices with more than one control interface, we assume the
 	 * first contains the audio controls. We might need a more specific
@@ -737,6 +750,9 @@ static void usb_audio_disconnect(struct usb_interface *intf)
 
 	card = chip->card;
 
+	if (usb_audio_ops && usb_audio_ops->vendor_disc)
+		usb_audio_ops->vendor_disc();
+
 	mutex_lock(&register_mutex);
 	if (atomic_inc_return(&chip->shutdown) == 1) {
 		struct snd_usb_stream *as;
diff --git a/sound/usb/card.h b/sound/usb/card.h
index 395403a..a55bb4c 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -175,5 +175,6 @@ struct snd_usb_stream {
 	struct snd_usb_substream substream[2];
 	struct list_head list;
 };
+void snd_set_vender_interface(struct snd_usb_audio_vendor_ops *vendor_ops);
 
 #endif /* __USBAUDIO_CARD_H */
diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index b118cf9..0ceeccb 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -642,8 +642,13 @@ static int set_sample_rate_v2v3(struct snd_usb_audio *chip, int iface,
 	 * interface is active. */
 	if (rate != prev_rate) {
 		usb_set_interface(dev, iface, 0);
+		if (usb_audio_ops && usb_audio_ops->vendor_set_intf)
+			usb_audio_ops->vendor_set_intf(dev, alts, iface, 0);
 		snd_usb_set_interface_quirk(dev);
 		usb_set_interface(dev, iface, fmt->altsetting);
+		if (usb_audio_ops && usb_audio_ops->vendor_set_intf)
+			usb_audio_ops->vendor_set_intf(dev, alts, iface,
+					fmt->altsetting);
 		snd_usb_set_interface_quirk(dev);
 	}
 
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index a4e4064..6cdacac 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -134,6 +134,9 @@ static struct audioformat *find_format(struct snd_usb_substream *subs)
 			found = fp;
 			cur_attr = attr;
 		}
+
+		if (usb_audio_ops && usb_audio_ops->vendor_pcm_binterval)
+			usb_audio_ops->vendor_pcm_binterval(fp, found, &cur_attr, &attr);
 	}
 	return found;
 }
@@ -568,6 +571,9 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 		}
 		dev_dbg(&dev->dev, "setting usb interface %d:%d\n",
 			fmt->iface, fmt->altsetting);
+		if (usb_audio_ops && usb_audio_ops->vendor_set_pcm_intf)
+			usb_audio_ops->vendor_set_pcm_intf(dev, fmt->iface,
+					fmt->altsetting, subs->direction);
 		snd_usb_set_interface_quirk(dev);
 	}
 
@@ -891,6 +897,15 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
 	struct usb_interface *iface;
 	int ret;
 
+	if (usb_audio_ops && usb_audio_ops->vendor_set_pcmbuf) {
+		ret = usb_audio_ops->vendor_set_pcmbuf(subs->dev);
+
+		if (ret < 0) {
+			dev_err(&subs->dev->dev, "pcm buf transfer failed\n");
+			return ret;
+		}
+	}
+
 	if (! subs->cur_audiofmt) {
 		dev_err(&subs->dev->dev, "no format is specified!\n");
 		return -ENXIO;
@@ -924,6 +939,15 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
 		if (ret < 0)
 			goto unlock;
 
+		if (usb_audio_ops && usb_audio_ops->vendor_set_rate) {
+			subs->need_setup_ep = false;
+			usb_audio_ops->vendor_set_rate(
+					subs->cur_audiofmt->iface,
+					subs->cur_rate,
+					subs->cur_audiofmt->altsetting);
+			goto unlock;
+		}
+
 		ret = configure_endpoint(subs);
 		if (ret < 0)
 			goto unlock;
@@ -1333,6 +1357,9 @@ static int snd_usb_pcm_open(struct snd_pcm_substream *substream)
 	struct snd_usb_substream *subs = &as->substream[direction];
 	int ret;
 
+	if (usb_audio_ops && usb_audio_ops->vendor_pcm_con)
+		usb_audio_ops->vendor_pcm_con(true, direction);
+
 	subs->interface = -1;
 	subs->altset_idx = 0;
 	runtime->hw = snd_usb_hardware;
@@ -1361,12 +1388,18 @@ static int snd_usb_pcm_close(struct snd_pcm_substream *substream)
 	struct snd_usb_substream *subs = &as->substream[direction];
 	int ret;
 
+	if (usb_audio_ops && usb_audio_ops->vendor_pcm_con)
+		usb_audio_ops->vendor_pcm_con(false, direction);
+
 	snd_media_stop_pipeline(subs);
 
 	if (!as->chip->keep_iface &&
 	    subs->interface >= 0 &&
 	    !snd_usb_lock_shutdown(subs->stream->chip)) {
 		usb_set_interface(subs->dev, subs->interface, 0);
+		if (usb_audio_ops && usb_audio_ops->vendor_set_pcm_intf)
+			usb_audio_ops->vendor_set_pcm_intf(subs->dev,
+					subs->interface, 0, direction);
 		subs->interface = -1;
 		ret = snd_usb_pcm_change_state(subs, UAC3_PD_STATE_D1);
 		snd_usb_unlock_shutdown(subs->stream->chip);
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 1c892c7..a2fd8a4 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -124,4 +124,34 @@ void snd_usb_unlock_shutdown(struct snd_usb_audio *chip);
 extern bool snd_usb_use_vmalloc;
 extern bool snd_usb_skip_validation;
 
+/* for vender function mapping */
+extern struct snd_usb_audio_vendor_ops *usb_audio_ops;
+
+/* USB audio interface function for audio core */
+struct snd_usb_audio_vendor_ops {
+	/* Set descriptors and memory map */
+	void (*vendor_conn)(struct usb_interface *intf,
+			struct usb_device *udev);
+	/* Set disconnection */
+	void (*vendor_disc)(void);
+	/* Set interface info and setting value */
+	int (*vendor_set_intf)(struct usb_device *udev,
+			struct usb_host_interface *alts, int iface, int alt);
+	/* Set sample rate */
+	int (*vendor_set_rate)(int iface, int rate, int alt);
+	/* Alloc pcm buffer */
+	int (*vendor_set_pcmbuf)(struct usb_device *udev);
+	/* Set pcm interface */
+	int (*vendor_set_pcm_intf)(struct usb_device *udev,
+			int iface, int alt, int direction);
+	/* informed whether pcm open/close to vendor */
+	void (*vendor_pcm_con)(int onoff, int direction);
+	/* set datainterval */
+	void (*vendor_pcm_binterval)(void *fp, void *found,
+			int *cur_attr, int *attr);
+	/* control USB F/W */
+	int (*vendor_usb_add_ctls)(struct snd_usb_audio *chip,
+				unsigned long private_value);
+};
+
 #endif /* __USBAUDIO_H */
-- 
2.7.4

