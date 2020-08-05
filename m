Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEFEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EE522245C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJ8MNgFU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgHERTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:19:08 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56112 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728611AbgHERLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e2jHnVO0sEztuVrpmrLjXxFZdWdSW7ZIexUpdoeRg8Q=;
        b=XJ8MNgFUo22ALS5jLyv2z4zgfVwKlbTDoVD2hgFa6kxWh3G306SWmcgpfG7DgF0vWGeKWi
        zhJXbE6L+LsOlwrRSCEDr1iPdrJ+6F4CU77CG/22e1f0/2nyg63SX5dt+qplDrzxhXG2W+
        CqpjkN/3Mwtygb5MqAZw6YH8sLM2GjQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-XhyM8ioGM_q2Vgd6nhcb3A-1; Wed, 05 Aug 2020 09:44:41 -0400
X-MC-Unique: XhyM8ioGM_q2Vgd6nhcb3A-1
Received: by mail-wm1-f70.google.com with SMTP id a207so2469932wme.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e2jHnVO0sEztuVrpmrLjXxFZdWdSW7ZIexUpdoeRg8Q=;
        b=WtSSKJYHACwRbXlojm9u2ucC5wBdPSQqrPw8587U0QRF/avYygqrg/D4DI1hdCO3k4
         vdKiSECbZWRVmQxRB0PNwEjMcKj5Kj/GQYkOifQuUdi4MIf+mpyu8xtkOxGvmF1ddo0T
         YbXQEqjPBe/VDTLPL0ziftwi0J26hDVp9vTJvUt5rm/txJxDv42w+hucIffbYXkrN0Mh
         5IjvAKwQ7f37SxWDcZAkj5LLMLjmxQKXyT/eZ8FlQzKjvMt1JaddHx0uIZAjw9Xb3rP0
         zRKPtkDd98pZ/Q+1cbsFDKAmfJLa+g4Ajn/gqtQqYFFkQ3gXO3cRMKDl3F83BpvSuQq3
         u9Dg==
X-Gm-Message-State: AOAM531qSfuUceUI9bF2Afe/BzEG+NXIdqw6/Pa4/AWwVBnsPUPyv2zT
        WhEyHgbVt12TFL+5brgF4imx8p992IugJqhUQlgwHlFEdHy9DIAlH4A4dCCi51ZdxvtTH5BUpGI
        HeNUWGuVDjQ2/yqW5OG96U07w
X-Received: by 2002:a5d:67d2:: with SMTP id n18mr2817779wrw.214.1596635079551;
        Wed, 05 Aug 2020 06:44:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1ib/ImC76XF/Meb2+m6CfoYcJAU9nZg0obXIEdj/4+DzOtUwLHz22KMW3gaDBsLcUTuN9qA==
X-Received: by 2002:a5d:67d2:: with SMTP id n18mr2817757wrw.214.1596635079284;
        Wed, 05 Aug 2020 06:44:39 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
        by smtp.gmail.com with ESMTPSA id i4sm2825723wrw.26.2020.08.05.06.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:44:38 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:44:36 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 30/38] virtio_input: convert to LE accessors
Message-ID: <20200805134226.1106164-31-mst@redhat.com>
References: <20200805134226.1106164-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805134226.1106164-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Virtio input is modern-only. Use LE accessors for config space.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_input.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index efaf65b0f42d..877b2ea3ed05 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -113,9 +113,9 @@ static u8 virtinput_cfg_select(struct virtio_input *vi,
 {
 	u8 size;
 
-	virtio_cwrite(vi->vdev, struct virtio_input_config, select, &select);
-	virtio_cwrite(vi->vdev, struct virtio_input_config, subsel, &subsel);
-	virtio_cread(vi->vdev, struct virtio_input_config, size, &size);
+	virtio_cwrite_le(vi->vdev, struct virtio_input_config, select, &select);
+	virtio_cwrite_le(vi->vdev, struct virtio_input_config, subsel, &subsel);
+	virtio_cread_le(vi->vdev, struct virtio_input_config, size, &size);
 	return size;
 }
 
@@ -158,11 +158,11 @@ static void virtinput_cfg_abs(struct virtio_input *vi, int abs)
 	u32 mi, ma, re, fu, fl;
 
 	virtinput_cfg_select(vi, VIRTIO_INPUT_CFG_ABS_INFO, abs);
-	virtio_cread(vi->vdev, struct virtio_input_config, u.abs.min, &mi);
-	virtio_cread(vi->vdev, struct virtio_input_config, u.abs.max, &ma);
-	virtio_cread(vi->vdev, struct virtio_input_config, u.abs.res, &re);
-	virtio_cread(vi->vdev, struct virtio_input_config, u.abs.fuzz, &fu);
-	virtio_cread(vi->vdev, struct virtio_input_config, u.abs.flat, &fl);
+	virtio_cread_le(vi->vdev, struct virtio_input_config, u.abs.min, &mi);
+	virtio_cread_le(vi->vdev, struct virtio_input_config, u.abs.max, &ma);
+	virtio_cread_le(vi->vdev, struct virtio_input_config, u.abs.res, &re);
+	virtio_cread_le(vi->vdev, struct virtio_input_config, u.abs.fuzz, &fu);
+	virtio_cread_le(vi->vdev, struct virtio_input_config, u.abs.flat, &fl);
 	input_set_abs_params(vi->idev, abs, mi, ma, fu, fl);
 	input_abs_set_res(vi->idev, abs, re);
 }
@@ -244,14 +244,14 @@ static int virtinput_probe(struct virtio_device *vdev)
 
 	size = virtinput_cfg_select(vi, VIRTIO_INPUT_CFG_ID_DEVIDS, 0);
 	if (size >= sizeof(struct virtio_input_devids)) {
-		virtio_cread(vi->vdev, struct virtio_input_config,
-			     u.ids.bustype, &vi->idev->id.bustype);
-		virtio_cread(vi->vdev, struct virtio_input_config,
-			     u.ids.vendor, &vi->idev->id.vendor);
-		virtio_cread(vi->vdev, struct virtio_input_config,
-			     u.ids.product, &vi->idev->id.product);
-		virtio_cread(vi->vdev, struct virtio_input_config,
-			     u.ids.version, &vi->idev->id.version);
+		virtio_cread_le(vi->vdev, struct virtio_input_config,
+				u.ids.bustype, &vi->idev->id.bustype);
+		virtio_cread_le(vi->vdev, struct virtio_input_config,
+				u.ids.vendor, &vi->idev->id.vendor);
+		virtio_cread_le(vi->vdev, struct virtio_input_config,
+				u.ids.product, &vi->idev->id.product);
+		virtio_cread_le(vi->vdev, struct virtio_input_config,
+				u.ids.version, &vi->idev->id.version);
 	} else {
 		vi->idev->id.bustype = BUS_VIRTUAL;
 	}
-- 
MST

