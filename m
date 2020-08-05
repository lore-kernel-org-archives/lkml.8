Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AB9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65E8D2177B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HURz2JqF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgHERS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:18:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45318 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728561AbgHERKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:10:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QNkBL0MOslnxA1lTPWBDwCkBLDnBYOCw/rGPZtjWTCU=;
        b=HURz2JqFY/dwqZrAfMPekXwUKK8YBlOtrSYFFpJipcIaESfSxkkyOMsunprKOwyl697Nqo
        HQK44aN//Xi4r/QiZnP5GkF/YbR9xFfAea5asOvMVqOqLWtVS3ey3B6EUuLx1ptO1KsDo8
        pbrL0Fyr8PgItsEYnwh5ukezCcWVe5w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-DQe5YfECNWev7XjdFSdJ5Q-1; Wed, 05 Aug 2020 09:43:47 -0400
X-MC-Unique: DQe5YfECNWev7XjdFSdJ5Q-1
Received: by mail-wm1-f70.google.com with SMTP id d22so2749588wmd.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QNkBL0MOslnxA1lTPWBDwCkBLDnBYOCw/rGPZtjWTCU=;
        b=Sfbfnk4OnwGE7TKG107C31KGBlCJcVeTo7BJWx0eVN7UnXpyQn3U3Qfj1YGukEu2LG
         esBqKE2GQe34pUJMT230wyoexlmt6G9ZJYOOxlvw0B7ztGiNF6qfBee99sgiWd1oql2k
         tHAu5DsI7puiLihRjPsqYBlgN8jg0l7ObzzwvnGyi7GF2D6lxxr4q8CwSpGObf9LIBYz
         SGvN6yN5BS0Rly81VsdsyqVdPDsECzBfkyzUHn0d5kEk9tjNFqGiwOC0T4EWOgn/w4tF
         HSpFrLGbHWFHlMX2Z30IWH87BqG1BfqCdtD5iRmRTlMQ6lbw8tCogjRyXusDHrETxBto
         4aTg==
X-Gm-Message-State: AOAM531u1iYVkWkfnfxHdr/vtO0wnsDUufamX+qB7fmPcK/StMingTiy
        SUxy/RwWMahUwEuPjRReAfCcD6KDyFTY30cwzvRqzzcwBfpiNtMgJypeWAib6umd0Vt5wzVlsaM
        obOS+H+2wEd7CI4U4IYv3s0Ty
X-Received: by 2002:adf:f64a:: with SMTP id x10mr2692845wrp.99.1596635025556;
        Wed, 05 Aug 2020 06:43:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+wOWu/BUGFDnYiFNkYnDk0qc3NvkypKVIbTb4eZBzRtJysZaIOINp4bGehYs8hyi8ABgcfQ==
X-Received: by 2002:adf:f64a:: with SMTP id x10mr2692831wrp.99.1596635025403;
        Wed, 05 Aug 2020 06:43:45 -0700 (PDT)
Received: from redhat.com (bzq-79-180-0-181.red.bezeqint.net. [79.180.0.181])
        by smtp.gmail.com with ESMTPSA id s131sm2941176wme.17.2020.08.05.06.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:43:44 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:43:42 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Cornelia Huck <cohuck@redhat.com>, David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 10/38] virtio_gpu: correct tags for config space fields
Message-ID: <20200805134226.1106164-11-mst@redhat.com>
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

Since gpu is a modern-only device,
tag config space fields as having little endian-ness.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 include/uapi/linux/virtio_gpu.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
index 0c85914d9369..ccbd174ef321 100644
--- a/include/uapi/linux/virtio_gpu.h
+++ b/include/uapi/linux/virtio_gpu.h
@@ -320,10 +320,10 @@ struct virtio_gpu_resp_edid {
 #define VIRTIO_GPU_EVENT_DISPLAY (1 << 0)
 
 struct virtio_gpu_config {
-	__u32 events_read;
-	__u32 events_clear;
-	__u32 num_scanouts;
-	__u32 num_capsets;
+	__le32 events_read;
+	__le32 events_clear;
+	__le32 num_scanouts;
+	__le32 num_capsets;
 };
 
 /* simple formats for fbcon/X use */
-- 
MST

