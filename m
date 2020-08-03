Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36231C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42A4E22C9F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fqse8Qyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgHCU7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 16:59:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31245 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729079AbgHCU7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 16:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596488387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x1j0olsHvV0V6+MFf0hWmaE1+y5yyprKXDwwe6dxMow=;
        b=Fqse8QyiO2hAbIxpmtxguJ8bLQrdLigR9DwrJb1PygliMNY91KCI0YKwcOc6VxA5ACuo6e
        l8XQVQRbm2+v4YpKw+dq+WGZVUMOywRDZzNPLkA/+MkVNKNCv4IRsuR6zyBxKHWmWWDYeQ
        VZIX5K8B6jF7j6wk7fOE2+QFXOq0vvo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-9fCy_5c_P0SPtmyHAyfiGA-1; Mon, 03 Aug 2020 16:59:45 -0400
X-MC-Unique: 9fCy_5c_P0SPtmyHAyfiGA-1
Received: by mail-qk1-f200.google.com with SMTP id 1so13761563qki.22
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 13:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x1j0olsHvV0V6+MFf0hWmaE1+y5yyprKXDwwe6dxMow=;
        b=eaVE3PmNk233YwpiJnsXOTX6vcYEhl5NqbWRB2cJa8fliVc0o45UZ41A9SmDtZohSB
         oFUb/N6YHJCbMO9Y8CdBAMOn9FTXuTiHXYB760Kyy71ugcY6cNW7PxX1ghmHIas9HGfQ
         y/1dYzVo/VLLXmIFFqPngl6/i3FrjBJGQCNPKbabPCrp5u3jysAD6Wbrw6HUM+f+SbxQ
         hABHkHWJBYp7f7g8kQJfIG3F0qGl3pD0ClNOAQw3miagyCW13lAo01i1nT1HPqNx1RIp
         thAf16d5ahcrH92eBM2MjpYJhKqcHq/+bYcHwFu8f5puFhLfhPSlpmeOCHLxMFY56Mhk
         Ig3g==
X-Gm-Message-State: AOAM532YPuKdaBSCGrPp8LChmCj8K0wYMS83lxcNyZ91WyHJV3fs/vuU
        rfprdZwiUNt0wG0F6giyekT+mIfob8ZrNzN0qWUajKkRrcEnRGfu77S0wnrcAq9MvCeY8PSL/qF
        1Ev2dX8N96mkMtHVcAdNsaXeu
X-Received: by 2002:a0c:9b96:: with SMTP id o22mr9972997qve.213.1596488385064;
        Mon, 03 Aug 2020 13:59:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzH9dNDqsUYBKBCOi0Umn0NLw+eC0AYUWS9k8D6ClCP/hrTzlIAavyJN2TlvoS77wfyYVmamA==
X-Received: by 2002:a0c:9b96:: with SMTP id o22mr9972982qve.213.1596488384917;
        Mon, 03 Aug 2020 13:59:44 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id q13sm19880255qkn.85.2020.08.03.13.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 13:59:44 -0700 (PDT)
Date:   Mon, 3 Aug 2020 16:59:41 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 15/24] virtio_pmem: correct tags for config space fields
Message-ID: <20200803205814.540410-16-mst@redhat.com>
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

Since this is a modern-only device,
tag config space fields as having little endian-ness.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/virtio_pmem.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/virtio_pmem.h b/include/uapi/linux/virtio_pmem.h
index b022787ffb94..d676b3620383 100644
--- a/include/uapi/linux/virtio_pmem.h
+++ b/include/uapi/linux/virtio_pmem.h
@@ -15,8 +15,8 @@
 #include <linux/virtio_config.h>
 
 struct virtio_pmem_config {
-	__u64 start;
-	__u64 size;
+	__le64 start;
+	__le64 size;
 };
 
 #define VIRTIO_PMEM_REQ_TYPE_FLUSH      0
-- 
MST

