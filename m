Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E81C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 23:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CEE4206F8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 23:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QEBfx44U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbgHCX7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 19:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729267AbgHCX62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 19:58:28 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C35C061756
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 16:58:27 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id j9so29279204ilc.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 16:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UWzWGkh475eDnP3/JizWhFyPcCx/wKE7/hIAnqOcwN8=;
        b=QEBfx44UooFtfhTxwf1A4x4A9gi0hLVCA6qIkKxtH5k+4EKr8BXe28XPFAz3JNjnOM
         fCZG/bsMuWnRquSeVgkI69N8h1D3cq2RgeJB+0XtIWTZaZZoabYHF9bXazz4oI+RL0JM
         xYBzKT11MqPD94epC4MK0rkbD6mTKROxNqpEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UWzWGkh475eDnP3/JizWhFyPcCx/wKE7/hIAnqOcwN8=;
        b=nIKNXrDNDEHdk9ikMNUIfeKmDHJ9VOGMrRmmqItpuN1QR7k6P4vMMf2ysmUhi5ozQ7
         nTD8P2n+gjH/KokQWBQIhzerAMErRmslJM1yOSFbROUeOTJklip3XU1VAM7mY4gO9BBc
         sJplOOK6bnknwEkQ68libh/CywabLr7kM77x6+kzkbgo1N8O1nwUJe/G38JvCLG3Mln2
         JayNK9jVBy5AJn9G03BR84zhiiAVlDfyxXQaUmTjX+PyT1FWlIYuYE1pfslIt5XPGpc9
         HNexKgSNdIHyZe04R1csIo3RtoVWdSiA1Jo3ACP/OXSYPr1XKcqbhQKmEp5IXJ0KCfUv
         jQQA==
X-Gm-Message-State: AOAM530Zg8gxl7PNgcQzTJ+KsGRD2DKuBuIZhPmRjl+CGmM/bfQsynyp
        boci6lRuWR7VlsRDQD3swkO2+w==
X-Google-Smtp-Source: ABdhPJzG3AEbRk3LQeUtcxS/Bon/dWfpCYq98jD/xg7No+VeQ8I8ceObrwztDfwhfaCsgN3PTBkVsw==
X-Received: by 2002:a92:858d:: with SMTP id f135mr2002429ilh.257.1596499106394;
        Mon, 03 Aug 2020 16:58:26 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id x185sm11075992iof.41.2020.08.03.16.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 16:58:26 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH v5 07/15] iio: sx9310: Use long instead of int for channel bitmaps
Date:   Mon,  3 Aug 2020 17:58:07 -0600
Message-Id: <20200803175559.v5.7.Iecaa50e469918a385b3e5dab375e442540ea2ad4@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200803235815.778997-1-campello@chromium.org>
References: <20200803235815.778997-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uses for_each_set_bit() macro to loop over channel bitmaps.

Signed-off-by: Daniel Campello <campello@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v5: None
Changes in v4: None
Changes in v3:
 - Added static assert for number of channels.

Changes in v2:
 - Changed prox_stat to chan_prox_stat bitmap.

 drivers/iio/proximity/sx9310.c | 39 ++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 127b1ba79e2dea..f78500b8a5841e 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -119,6 +119,7 @@
 
 /* 4 hardware channels, as defined in STAT0: COMB, CS2, CS1 and CS0. */
 #define SX9310_NUM_CHANNELS				4
+static_assert(SX9310_NUM_CHANNELS < BITS_PER_LONG);
 
 struct sx9310_data {
 	/* Serialize access to registers and channel configuration */
@@ -130,7 +131,7 @@ struct sx9310_data {
 	 * Last reading of the proximity status for each channel.
 	 * We only send an event to user space when this changes.
 	 */
-	bool prox_stat[SX9310_NUM_CHANNELS];
+	unsigned long chan_prox_stat;
 	bool trigger_enabled;
 	/* Ensure correct alignment of timestamp when present. */
 	struct {
@@ -140,7 +141,8 @@ struct sx9310_data {
 	/* Remember enabled channels and sample rate during suspend. */
 	unsigned int suspend_ctrl0;
 	struct completion completion;
-	unsigned int chan_read, chan_event;
+	unsigned long chan_read;
+	unsigned long chan_event;
 	int channel_users[SX9310_NUM_CHANNELS];
 	unsigned int whoami;
 };
@@ -283,15 +285,16 @@ static const struct regmap_config sx9310_regmap_config = {
 };
 
 static int sx9310_update_chan_en(struct sx9310_data *data,
-				 unsigned int chan_read,
-				 unsigned int chan_event)
+				 unsigned long chan_read,
+				 unsigned long chan_event)
 {
 	int ret;
+	unsigned long channels = chan_read | chan_event;
 
-	if ((data->chan_read | data->chan_event) != (chan_read | chan_event)) {
+	if ((data->chan_read | data->chan_event) != channels) {
 		ret = regmap_update_bits(data->regmap, SX9310_REG_PROX_CTRL0,
 					 SX9310_REG_PROX_CTRL0_SENSOREN_MASK,
-					 chan_read | chan_event);
+					 channels);
 		if (ret)
 			return ret;
 	}
@@ -532,6 +535,7 @@ static void sx9310_push_events(struct iio_dev *indio_dev)
 	unsigned int val, chan;
 	struct sx9310_data *data = iio_priv(indio_dev);
 	s64 timestamp = iio_get_time_ns(indio_dev);
+	unsigned long prox_changed;
 
 	/* Read proximity state on all channels */
 	ret = regmap_read(data->regmap, SX9310_REG_STAT0, &val);
@@ -540,24 +544,23 @@ static void sx9310_push_events(struct iio_dev *indio_dev)
 		return;
 	}
 
-	for (chan = 0; chan < SX9310_NUM_CHANNELS; chan++) {
+	/*
+	 * Only iterate over channels with changes on proximity status that have
+	 * events enabled.
+	 */
+	prox_changed = (data->chan_prox_stat ^ val) & data->chan_event;
+
+	for_each_set_bit(chan, &prox_changed, SX9310_NUM_CHANNELS) {
 		int dir;
 		u64 ev;
-		bool new_prox = val & BIT(chan);
-
-		if (!(data->chan_event & BIT(chan)))
-			continue;
-		if (new_prox == data->prox_stat[chan])
-			/* No change on this channel. */
-			continue;
 
-		dir = new_prox ? IIO_EV_DIR_FALLING : IIO_EV_DIR_RISING;
+		dir = val & BIT(chan) ? IIO_EV_DIR_FALLING : IIO_EV_DIR_RISING;
 		ev = IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, chan,
 					  IIO_EV_TYPE_THRESH, dir);
 
 		iio_push_event(indio_dev, ev, timestamp);
-		data->prox_stat[chan] = new_prox;
 	}
+	data->chan_prox_stat = val;
 }
 
 static irqreturn_t sx9310_irq_thread_handler(int irq, void *private)
@@ -714,13 +717,13 @@ static irqreturn_t sx9310_trigger_handler(int irq, void *private)
 static int sx9310_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct sx9310_data *data = iio_priv(indio_dev);
-	unsigned int channels = 0;
+	unsigned long channels = 0;
 	int bit, ret;
 
 	mutex_lock(&data->mutex);
 	for_each_set_bit(bit, indio_dev->active_scan_mask,
 			 indio_dev->masklength)
-		channels |= BIT(indio_dev->channels[bit].channel);
+		__set_bit(indio_dev->channels[bit].channel, &channels);
 
 	ret = sx9310_update_chan_en(data, channels, data->chan_event);
 	mutex_unlock(&data->mutex);
-- 
2.28.0.163.g6104cc2f0b6-goog

