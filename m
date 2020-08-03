Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F0BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C72CE22C9F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KsqbwsX0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgHCU72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 16:59:28 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44070 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729079AbgHCU71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 16:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596488365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pjba7UTEkMQb9cgNSFsINkPwPT47kJGCQxpArSsq/v4=;
        b=KsqbwsX0OSBi/UozBeZItDI5uUU7UMHVs6ocbS143ebggkM6ba1HHhxr3yhN+lkTQ+CsTv
        RAb/mvMvbCccdt73hEwlKMMjdRrGxPjTCrjlErbhm/dYFW7ZDkOBIy/KbDxUhS6xAAQPjE
        QbocxOFGhGqcZV9oueNXM8/bZlWHFCk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-c8DtTkrWNOOjovcFo3pFJA-1; Mon, 03 Aug 2020 16:59:23 -0400
X-MC-Unique: c8DtTkrWNOOjovcFo3pFJA-1
Received: by mail-qt1-f200.google.com with SMTP id b18so14778315qte.18
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 13:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pjba7UTEkMQb9cgNSFsINkPwPT47kJGCQxpArSsq/v4=;
        b=eXe0uVM+NkWMhQNzYuQm6Y6/tTBsyrbCYHFI/lNOUkHyObav/7HeKIdbS7litHZiw6
         twwY5swDTxKw8N0n63UQkZkOoZBxG9DC1Cn1bM1ILGZndNh/NJvsEtfrBe540sKVolkX
         SjcO8peOcwloQn+9/aJYrpSywe/vMXJfF0wXVluXYHyuQHczL4v+eUGJTzHW9DZFxKUO
         S7rDzbmCfZU76lLyFWXSAGyemTbyRGpuKJ5N9ds98Z0ve35uj9KUDIPr88nPf7G8xgFg
         DqTx8SFD6ix+PmGmkFCKxEhG9FxSRn8dATP8wQ4tAVFLXfEs2RiL+XdkZfDHBJyPHZDI
         jV3g==
X-Gm-Message-State: AOAM53337gPBIHvCMdYX8DwEViL5QdIWOO7D0w5kDRsIcjIeR8tHmsdK
        F20dQN0zPFSiJ7wZK6xuDseYCHoFE3AWTmEkqytg411eP3/rtscwJ/PNSf1hHyh6yyyIzESru6R
        u3k8yKebr8uTiQ4uMakOnpkE8
X-Received: by 2002:ac8:387b:: with SMTP id r56mr18809900qtb.353.1596488363032;
        Mon, 03 Aug 2020 13:59:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHozttQuejm//tCqktxmYXDIQpJ0ThAuBb6QUqCnnttWqM4Fv1n/r76PemaGEK2xQsqaBj5g==
X-Received: by 2002:ac8:387b:: with SMTP id r56mr18809888qtb.353.1596488362838;
        Mon, 03 Aug 2020 13:59:22 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id p17sm19764307qkj.69.2020.08.03.13.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 13:59:22 -0700 (PDT)
Date:   Mon, 3 Aug 2020 16:59:18 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 10/24] virtio_gpu: correct tags for config space fields
Message-ID: <20200803205814.540410-11-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803205814.540410-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since gpu is a modern-only device,
tag config space fields as having little endian-ness.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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

