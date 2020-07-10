Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EB0C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 11:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A7802078B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 11:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ea77Z4Ro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgGJLbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 07:31:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21763 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728024AbgGJLbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 07:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594380701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=5Ofr2MCGvPvfpwIdGlSnpSEf1nx+bNb0i5ZzaI9/r3g=;
        b=ea77Z4Rozl+oBx2N//ruO8G7A9G75ak3Inwg3JToKlffzcobwWScPB2HGLGZcf33DjwTar
        jerbmzPFL7PlAwB5vr9Mp6iCO8Bb1Buq0Gt4jdYPZzs+SlvLpAt8fU2sVUVfciWIskRQea
        F50Pep5csgXhBida/frXdI5iV6W7Pqo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-hY56vrMPO6uzEaps24TObA-1; Fri, 10 Jul 2020 07:31:40 -0400
X-MC-Unique: hY56vrMPO6uzEaps24TObA-1
Received: by mail-wr1-f70.google.com with SMTP id b8so5767425wro.19
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 04:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=5Ofr2MCGvPvfpwIdGlSnpSEf1nx+bNb0i5ZzaI9/r3g=;
        b=f+B1ll2d9PrVR45v20RmEp9F2v7RALdwge97k3ufFrP85HiV6CS2Wfw10Lyk/WRTAk
         sL2GUF6nKtxnqU7nTw4uFmkrvi3dkBNj2g4bQKnZfLj7wbb+vMKmfo3v1zeFpQRSOz3V
         HRkium/Ah72Y7DfoKBZqR+RfbUOXwswXYaCOITncjUk+MTdp300XW8DGHyDSuR3sx+AZ
         QCsoXayW2tZ3GUI0n8a2jk2ZDE4sZOGSL1bo9NSdO+DjqVkV05bc5cIFqj7IUxx4yuJi
         RhYkwre5ESKivRHtyxX/bGrcjLjLqfPB+A/V1kPWAoohlMq+2GIoir23xTzZJb3pzm2A
         jaIQ==
X-Gm-Message-State: AOAM531drevKDAYi2ZvE7u+vvnJXn90vdY+V9p78/hKZGIZw2ZQw+sRY
        xDwL6abhiKumhE0O75njBSxE7k8zWcNmPqKgYiCPg21nxKj0PxzpyX9d3bbjqFTc2wyGaVoitF0
        q9ahlLjIoRzT3RauqjOgDAvjH
X-Received: by 2002:adf:ea06:: with SMTP id q6mr65083189wrm.69.1594380698302;
        Fri, 10 Jul 2020 04:31:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4g++MZXIVwdtMKOQxK6lrsv51Rp7rwp+FV4RYaCSdZuYHSZRZ0n8HTomwQMFHmG03mUFrHg==
X-Received: by 2002:adf:ea06:: with SMTP id q6mr65083170wrm.69.1594380698095;
        Fri, 10 Jul 2020 04:31:38 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
        by smtp.gmail.com with ESMTPSA id o21sm8912958wmh.18.2020.07.10.04.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 04:31:37 -0700 (PDT)
Date:   Fri, 10 Jul 2020 07:31:34 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Alexander Duyck <alexander.duyck@gmail.com>
Subject: [PATCH] virtio_balloon: clear modern features under legacy
Message-ID: <20200710113046.421366-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Page reporting features were never supported by legacy hypervisors.
Supporting them poses a problem: should we use native endian-ness (like
current code assumes)? Or little endian-ness like the virtio spec says?
Rather than try to figure out, and since results of
incorrect endian-ness are dire, let's just block this configuration.

Cc: stable@vger.kernel.org
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 5d4b891bf84f..b9bc03345157 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -1107,6 +1107,15 @@ static int virtballoon_restore(struct virtio_device *vdev)
 
 static int virtballoon_validate(struct virtio_device *vdev)
 {
+	/*
+	 * Legacy devices never specified how modern features should behave.
+	 * E.g. which endian-ness to use? Better not to assume anything.
+	 */
+	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT);
+		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_PAGE_POISON);
+		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_REPORTING);
+	}
 	/*
 	 * Inform the hypervisor that our pages are poisoned or
 	 * initialized. If we cannot do that then we should disable
-- 
MST

