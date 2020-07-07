Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE5AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0074220773
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594135019;
	bh=YZ0ha3algqhrGV5syjtFieaiqNFh3cG73FaBlj2s3TM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mV2nIfYYFdvuQlJWYBhzu92wRa/5EWAnsNzLLP2j9y5ulBVBEwi8SXaf1WVCAzsVI
	 v98HTa5R2zlthQBXxZOfOMgGaR1TgEnggnBuCmLmacOPhukCp3vVxg4EgPTjfPcOHc
	 HLAeRdEmWCDVXJOuvBNdCaY4uj7rT1jXgp0OdoF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgGGPQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:16:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729105AbgGGPQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:16:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B280120771;
        Tue,  7 Jul 2020 15:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594135012;
        bh=YZ0ha3algqhrGV5syjtFieaiqNFh3cG73FaBlj2s3TM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yIHU+pSE/uHBOwTGMvVbaS5m7TO5q9RypwaBaJRWriPXREbMXxlRuJEqdIczhlnga
         3CHhmVJRtCwuwGLsw1SZooU88gPqjV5odnj32tKUtJSsdHAALvjBPYjK/aLPYYOqeK
         zOeSth2QG5VHiCp3kcDDhz2flWERKXLWMthrLC4g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Tsoy <alexander@tsoy.me>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        Hans de Goede <jwrdegoede@fedoraproject.org>
Subject: [PATCH 4.14 20/27] Revert "ALSA: usb-audio: Improve frames size computation"
Date:   Tue,  7 Jul 2020 17:15:47 +0200
Message-Id: <20200707145749.911548220@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707145748.944863698@linuxfoundation.org>
References: <20200707145748.944863698@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 99703c921864a318e3e8aae74fde071b1ff35bea which is
commit f0bd62b64016508938df9babe47f65c2c727d25c upstream.

It causes a number of reported issues and a fix for it has not hit
Linus's tree yet.  Revert this to resolve those problems.

Cc: Alexander Tsoy <alexander@tsoy.me>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Sasha Levin <sashal@kernel.org>
Cc: Hans de Goede <jwrdegoede@fedoraproject.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/card.h     |    4 ----
 sound/usb/endpoint.c |   43 +++++--------------------------------------
 sound/usb/endpoint.h |    1 -
 sound/usb/pcm.c      |    2 --
 4 files changed, 5 insertions(+), 45 deletions(-)

--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -81,10 +81,6 @@ struct snd_usb_endpoint {
 	dma_addr_t sync_dma;		/* DMA address of syncbuf */
 
 	unsigned int pipe;		/* the data i/o pipe */
-	unsigned int framesize[2];	/* small/large frame sizes in samples */
-	unsigned int sample_rem;	/* remainder from division fs/fps */
-	unsigned int sample_accum;	/* sample accumulator */
-	unsigned int fps;		/* frames per second */
 	unsigned int freqn;		/* nominal sampling rate in fs/fps in Q16.16 format */
 	unsigned int freqm;		/* momentary sampling rate in fs/fps in Q16.16 format */
 	int	   freqshift;		/* how much to shift the feedback value to get Q16.16 */
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -137,12 +137,12 @@ int snd_usb_endpoint_implicit_feedback_s
 
 /*
  * For streaming based on information derived from sync endpoints,
- * prepare_outbound_urb_sizes() will call slave_next_packet_size() to
+ * prepare_outbound_urb_sizes() will call next_packet_size() to
  * determine the number of samples to be sent in the next packet.
  *
- * For implicit feedback, slave_next_packet_size() is unused.
+ * For implicit feedback, next_packet_size() is unused.
  */
-int snd_usb_endpoint_slave_next_packet_size(struct snd_usb_endpoint *ep)
+int snd_usb_endpoint_next_packet_size(struct snd_usb_endpoint *ep)
 {
 	unsigned long flags;
 	int ret;
@@ -159,29 +159,6 @@ int snd_usb_endpoint_slave_next_packet_s
 	return ret;
 }
 
-/*
- * For adaptive and synchronous endpoints, prepare_outbound_urb_sizes()
- * will call next_packet_size() to determine the number of samples to be
- * sent in the next packet.
- */
-int snd_usb_endpoint_next_packet_size(struct snd_usb_endpoint *ep)
-{
-	int ret;
-
-	if (ep->fill_max)
-		return ep->maxframesize;
-
-	ep->sample_accum += ep->sample_rem;
-	if (ep->sample_accum >= ep->fps) {
-		ep->sample_accum -= ep->fps;
-		ret = ep->framesize[1];
-	} else {
-		ret = ep->framesize[0];
-	}
-
-	return ret;
-}
-
 static void retire_outbound_urb(struct snd_usb_endpoint *ep,
 				struct snd_urb_ctx *urb_ctx)
 {
@@ -226,8 +203,6 @@ static void prepare_silent_urb(struct sn
 
 		if (ctx->packet_size[i])
 			counts = ctx->packet_size[i];
-		else if (ep->sync_master)
-			counts = snd_usb_endpoint_slave_next_packet_size(ep);
 		else
 			counts = snd_usb_endpoint_next_packet_size(ep);
 
@@ -914,17 +889,10 @@ int snd_usb_endpoint_set_params(struct s
 	ep->maxpacksize = fmt->maxpacksize;
 	ep->fill_max = !!(fmt->attributes & UAC_EP_CS_ATTR_FILL_MAX);
 
-	if (snd_usb_get_speed(ep->chip->dev) == USB_SPEED_FULL) {
+	if (snd_usb_get_speed(ep->chip->dev) == USB_SPEED_FULL)
 		ep->freqn = get_usb_full_speed_rate(rate);
-		ep->fps = 1000;
-	} else {
+	else
 		ep->freqn = get_usb_high_speed_rate(rate);
-		ep->fps = 8000;
-	}
-
-	ep->sample_rem = rate % ep->fps;
-	ep->framesize[0] = rate / ep->fps;
-	ep->framesize[1] = (rate + (ep->fps - 1)) / ep->fps;
 
 	/* calculate the frequency in 16.16 format */
 	ep->freqm = ep->freqn;
@@ -983,7 +951,6 @@ int snd_usb_endpoint_start(struct snd_us
 	ep->active_mask = 0;
 	ep->unlink_mask = 0;
 	ep->phase = 0;
-	ep->sample_accum = 0;
 
 	snd_usb_endpoint_start_quirk(ep);
 
--- a/sound/usb/endpoint.h
+++ b/sound/usb/endpoint.h
@@ -28,7 +28,6 @@ void snd_usb_endpoint_release(struct snd
 void snd_usb_endpoint_free(struct snd_usb_endpoint *ep);
 
 int snd_usb_endpoint_implicit_feedback_sink(struct snd_usb_endpoint *ep);
-int snd_usb_endpoint_slave_next_packet_size(struct snd_usb_endpoint *ep);
 int snd_usb_endpoint_next_packet_size(struct snd_usb_endpoint *ep);
 
 void snd_usb_handle_sync_urb(struct snd_usb_endpoint *ep,
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -1484,8 +1484,6 @@ static void prepare_playback_urb(struct
 	for (i = 0; i < ctx->packets; i++) {
 		if (ctx->packet_size[i])
 			counts = ctx->packet_size[i];
-		else if (ep->sync_master)
-			counts = snd_usb_endpoint_slave_next_packet_size(ep);
 		else
 			counts = snd_usb_endpoint_next_packet_size(ep);
 


