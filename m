Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A00C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB5DF22D3E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QykGqt2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgHEROl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:14:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42224 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728574AbgHERKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g3o0OGn0mUAYpih0J/9SEomhwUpjV32w1tKo7wzCsHg=;
        b=QykGqt2Ya93s92X74CarPHZT0RMSzxGY9tconsWpSWySJg1LtJ1mQYLJ2ozmpJKm8YHAbF
        Ba1w5zadd64MeYixY8iSV8RWR/QxXi0CBFI4m/y0jgMWDg/2STUo6kp5jHHlGGto8YPclQ
        f5Ok2IdUrBm3xl5nwMRzM6CHjk3RpIs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-HMPHpdcfO12YYJ8hO5S6rw-1; Wed, 05 Aug 2020 09:43:49 -0400
X-MC-Unique: HMPHpdcfO12YYJ8hO5S6rw-1
Received: by mail-wm1-f72.google.com with SMTP id u144so2740144wmu.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g3o0OGn0mUAYpih0J/9SEomhwUpjV32w1tKo7wzCsHg=;
        b=t0lMcBuKF04Kot55UQVjU5gZiDUgpRpCH6LJl8F8q2AYJwjMY/lznCO4Ay5f3xZNBF
         QZ+De9j3sVOaIJODxOxyEAfLetaErw3q+OWSAfqWofFE2HlEAo0uAIOfFxGFrDSonowS
         G+tTbiOSdjGQ9fACuZ9IWpUCycJ6IIpSQ0n4On6iEj2B2P2p54my3JEeZyK8Z/rHWMk0
         v4/NPlpT/8a6fbDD6QiDrv3AyAej23LtjgwG5IJ3/ncAgfDyDQOrmk2rGbhZeZFfUAaw
         1QZI5tC0w6Uh0V/YIaIeoJcYDJrC5LyIV6qb8LwhZkG5Sup7ZU36JbTFRbP4DeFUh6Wb
         UyzQ==
X-Gm-Message-State: AOAM53009qp7uov00tluYWX6OdRWmkrzaZo2PY4am3CDsgNSRtsdzUCo
        SHkQKF6/s6kwuZlMrz6ObYTfBwzdXtdvQ9KSV6H6a+9a6cW316+QaGaykzPNzrNrXSczgSyMEZq
        q59soOOjAXNZIwUHkunWNMKJ6
X-Received: by 2002:a1c:de85:: with SMTP id v127mr3619749wmg.156.1596635028101;
        Wed, 05 Aug 2020 06:43:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwmrGMDVCn/Eh3OUbw6CERaaET4RDsZOTOCOJ+17iVCbbptXxAFKPNKih6Ihq1bDCxSPDlyg==
X-Received: by 2002:a1c:de85:: with SMTP id v127mr3619743wmg.156.1596635027917;
        Wed, 05 Aug 2020 06:43:47 -0700 (PDT)
Received: from redhat.com (bzq-79-180-0-181.red.bezeqint.net. [79.180.0.181])
        by smtp.gmail.com with ESMTPSA id v29sm2858032wrv.51.2020.08.05.06.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:43:47 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:43:45 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 11/38] virtio_input: correct tags for config space fields
Message-ID: <20200805134226.1106164-12-mst@redhat.com>
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

Since this is a modern-only device,
tag config space fields as having little endian-ness.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 include/uapi/linux/virtio_input.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/virtio_input.h b/include/uapi/linux/virtio_input.h
index a7fe5c8fb135..52084b1fb965 100644
--- a/include/uapi/linux/virtio_input.h
+++ b/include/uapi/linux/virtio_input.h
@@ -40,18 +40,18 @@ enum virtio_input_config_select {
 };
 
 struct virtio_input_absinfo {
-	__u32 min;
-	__u32 max;
-	__u32 fuzz;
-	__u32 flat;
-	__u32 res;
+	__le32 min;
+	__le32 max;
+	__le32 fuzz;
+	__le32 flat;
+	__le32 res;
 };
 
 struct virtio_input_devids {
-	__u16 bustype;
-	__u16 vendor;
-	__u16 product;
-	__u16 version;
+	__le16 bustype;
+	__le16 vendor;
+	__le16 product;
+	__le16 version;
 };
 
 struct virtio_input_config {
-- 
MST

