Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DBFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 02:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8105A206F1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 02:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HwXkUdEZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgFQC0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 22:26:05 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:37674 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgFQC0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 22:26:04 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200617022559epoutp04e494cb09c87bb164695add07c0f44db9~ZM6ytcP9w0457904579epoutp042
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 02:25:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200617022559epoutp04e494cb09c87bb164695add07c0f44db9~ZM6ytcP9w0457904579epoutp042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592360760;
        bh=XN4zHQ5s2L7w5R9LO9A/kCj0MXyiPg2YWme+Zkr0eyE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=HwXkUdEZsRz42Lufa0tj76lWy1pebl6vcxQfBr6KF0EXD8pUq4ZhCx2eKPZfGNi2m
         5+UljwnuB+omixZEdX8FmPK/mdK/+j29X5GRByxYCPnAlPMNmcp2KOKADQjl06PTIr
         OA6VL1RClbz7nwRto/js3TQ6ClLCpUyny0qEQV3k=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20200617022559epcas2p3e57820c4e80a11d8c6636624c639ac04~ZM6ycqWU41758317583epcas2p33;
        Wed, 17 Jun 2020 02:25:59 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.188]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 49mppF0nTmzMqYlt; Wed, 17 Jun
        2020 02:25:57 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        B7.50.19322.33F79EE5; Wed, 17 Jun 2020 11:25:55 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20200617022554epcas2p214a49f03a15e504d8faa28148e06e796~ZM6uAxKd41821918219epcas2p2a;
        Wed, 17 Jun 2020 02:25:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200617022554epsmtrp160c0e4729ed899c86612c41e341b67fd~ZM6uAQf1P1358113581epsmtrp1l;
        Wed, 17 Jun 2020 02:25:54 +0000 (GMT)
X-AuditID: b6c32a45-797ff70000004b7a-e1-5ee97f332cb8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.6A.08382.23F79EE5; Wed, 17 Jun 2020 11:25:54 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200617022554epsmtip2f099c75e3c46c6d85a92d02ac3be6eb9~ZM6tyelGd0063400634epsmtip2K;
        Wed, 17 Jun 2020 02:25:54 +0000 (GMT)
From:   JaeHun Jung <jh0801.jung@samsung.com>
To:     tiwai@suse.de
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        JaeHun Jung <jh0801.jung@samsung.com>
Subject: [PATCH] ANDROID: sound: usb: Add vendor's hooking interface
Date:   Wed, 17 Jun 2020 11:18:24 +0900
Message-Id: <1592360304-29621-1-git-send-email-jh0801.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNKsWRmVeSWpSXmKPExsWy7bCmua5x/cs4g8v3lSyuXDzEZHH34Q8W
        i8u75rBZvNz8hsmBxWPD5yY2j74tqxg9Np+u9vi8SS6AJSrHJiM1MSW1SCE1Lzk/JTMv3VbJ
        OzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwdoo5JCWWJOKVAoILG4WEnfzqYov7QkVSEj
        v7jEVim1ICWnwNCwQK84Mbe4NC9dLzk/18rQwMDIFKgyISdj64xZzAVN9hWvP65ib2CcatLF
        yMkhIWAi8fDsAbYuRi4OIYEdjBLtk9YyQzifGCWuv2xmhHC+MUr0T29nhmk50zQfKrGXUeLm
        94VQLT8YJebu7ACrYhPQltg3ZxE7iC0iICixrWEuC4jNLJAmcebDFiCbg0NYwEVi1k1hkDCL
        gKpE592LYK28Au4S7VMWskEsk5O4ea4TbL6EQD+7xO1/b5kgEi4Sy+a8YYGwhSVeHd/CDmFL
        Sbzsb4Oy6yVOb1wH1dzDKPHxxi6oqcYSs561M4IcwSygKbF+lz6IKSGgLHHkFtSZfBIdh/+y
        Q4R5JTrahCAaVSUONt6E2iot8a33HSOE7SGxZNk1sPOFBGIljt96zDSBUXYWwvwFjIyrGMVS
        C4pz01OLjQoMkSNpEyM4FWm57mCc/PaD3iFGJg7GQ4wSHMxKIrzOv1/ECfGmJFZWpRblxxeV
        5qQWH2I0BYbXRGYp0eR8YDLMK4k3NDUyMzOwNLUwNTOyUBLnzVW8ECckkJ5YkpqdmlqQWgTT
        x8TBKdXAJPP02DmFrfzv2TdEZr481VuTxFzxcebl5iz9opQnt0qLzpzh8rz0UoxNPPTpNIG6
        2G6fjZlT7bY8Pn9TYXrCTCFdu6vLH53OSJ+7aP/3u4856qY7SB1dXHH+n2heySa57ya+74Uk
        Jj3amXzdfd6xTe52Oz4uezBJda2TGlv111siX3+emhde8i7jbLFVkafbik11qvOs1UOWnmCf
        aZAc9sLlMtuUKSffPU11j9pX9vq0sELbJ7trLh2ZDvufsRg6rTG/UhWbrJBb0HBhZtsPueJX
        5ukf4l4LBhY2XwtR/vo//POay5e8RXdOCHrTt5THVXTS28xjmYfzX5V1Rm/gmRG+8fj/tdsL
        N2l7/XmTzKjEUpyRaKjFXFScCACTmsQJzgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJJMWRmVeSWpSXmKPExsWy7bCSvK5R/cs4g58bDSyuXDzEZHH34Q8W
        i8u75rBZvNz8hsmBxWPD5yY2j74tqxg9Np+u9vi8SS6AJYrLJiU1J7MstUjfLoErY+uMWcwF
        TfYVrz+uYm9gnGrSxcjJISFgInGmaT5jFyMXh5DAbkaJDUd6GCES0hI7O6cyQdjCEvdbjrBC
        FH1jlGj72cQCkmAT0JbYN2cRO4gtIiAosa1hLlicWSBDYteOk0A2B4ewgIvErJvCIGEWAVWJ
        zrsXmUFsXgF3ifYpC9kg5stJ3DzXyTyBkWcBI8MqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS9
        5PzcTYzg0NDS3MG4fdUHvUOMTByMhxglOJiVRHidf7+IE+JNSaysSi3Kjy8qzUktPsQozcGi
        JM57o3BhnJBAemJJanZqakFqEUyWiYNTqoEpedr9K03ftv7t0t2l7/Bdga2XNdy+dtEjEfW2
        Qz+fb0gy/ndCZOUq8ftMF491+9VHPY1/nbPp7OzFf9eHF7jNvj/zyfwirTI9t9snU6LP7Hzy
        +qH1IsaFclnyXAkzvzHUtYU8aZOod/RT5uHvioiuP7jXdM00mfW7pl2c/+/bopMls7kuebyT
        W7d54ZxCj88MwmGJN05vY7tv9EJD3Gjhf778jqk9knsDl84ok+1a9ZTn1Ls83SyX4B5tzrZX
        TR3pb2fOcf+wR+J8ML9mjOkk1gOJTaWpL59u3yfRd7viilyJf96psnNCQlb7V1xWyjYtibp+
        9J/bqzk1S1nZZijLSgcEGfkUX5zkJCZVfe6NEktxRqKhFnNRcSIAPMnYCXwCAAA=
X-CMS-MailID: 20200617022554epcas2p214a49f03a15e504d8faa28148e06e796
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200617022554epcas2p214a49f03a15e504d8faa28148e06e796
References: <CGME20200617022554epcas2p214a49f03a15e504d8faa28148e06e796@epcas2p2.samsung.com>
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

