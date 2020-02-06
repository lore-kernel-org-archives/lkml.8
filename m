Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67119C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 07:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D615206CC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 07:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c9/M2HXH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgBFHsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 02:48:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39225 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727923AbgBFHsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 02:48:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580975282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=vfV+T2mR+ZINyLA8LbxLyRCcFt6072JPvLxeCgd1lQo=;
        b=c9/M2HXH6UmXt+OqkEha3jgvH5A7K5nFaiyJ+UXkVGAJRwcF3g3piY+WF5D54Z50hLYXa6
        2vOh164UlOdktp3YC4YaStC8MItNF9kz8H/gu9xtSdKi0CqkeFAK296BB68uI0GYOWK2Zf
        BWbUG9JB4kfUIXnza0hVc443BR57Pgo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-9Caa8tRHOKuHVE2SO10tAQ-1; Thu, 06 Feb 2020 02:48:00 -0500
X-MC-Unique: 9Caa8tRHOKuHVE2SO10tAQ-1
Received: by mail-qk1-f197.google.com with SMTP id t195so2999499qke.23
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 23:48:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=vfV+T2mR+ZINyLA8LbxLyRCcFt6072JPvLxeCgd1lQo=;
        b=VuGagSWHr5F/RnckcAO60NH7vVjUJpthxHd6cc8zGnnvjA8Cj39oh+anrZV+j+SO3f
         knDoNV5psnekXjtwwc2rwi67kxiBWQ6CbqAuc/R7M4AjN8k+rns1M/3q8MH6YD+9hKZD
         ZIP3DqhJrAYk03z+l0KNhJ1wp1XYJSh3VW/8RrmRbq72vPYRirsLNY1IVHDl7jKM7r+9
         G4JgYy59tIYicZdHa944V2k5yMgK+h6b9ZKW0MWg7/m1Kb/VXjp34BoR30HNL7GhQy9A
         2qEiueRW9lGTP11h/w9auqD/t0YwVSAG5Z4e5y02/M4XdEvD9Q6GmsDiopAMpwk2Yvcr
         XSCw==
X-Gm-Message-State: APjAAAVZS6W/UkjGXBAltANsvSMVgCUmFUB4V6gIECNjpuqY8zhQsr1u
        x7sf47OhBnSOLuyQ479QkZcbf8OJuLvCQazs4WgK9VRVW9OkrSZ7/HGOg6BDf+EWkxfqIv2YF1Y
        eVdcV0Yu0vXFMAOuzhNKayokc
X-Received: by 2002:ac8:7b9b:: with SMTP id p27mr1563781qtu.2.1580975279420;
        Wed, 05 Feb 2020 23:47:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqyFG1AMzWVRgSI1qX48T8kdlxIMXg0Zo6VHwW7vlPrw3PtMkvwlNKHMeCwck82QMACgkj8XhA==
X-Received: by 2002:ac8:7b9b:: with SMTP id p27mr1563767qtu.2.1580975279213;
        Wed, 05 Feb 2020 23:47:59 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id 24sm1052973qka.32.2020.02.05.23.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 23:47:58 -0800 (PST)
Date:   Thu, 6 Feb 2020 02:47:55 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Subject: [PATCH] virtio_balloon: prevent pfn array overflow
Message-ID: <20200206074644.1177551-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure, at build time, that pfn array is big enough to hold a single
page.  It happens to be true since the PAGE_SHIFT value at the moment is
20, which is 1M - exactly 256 4K balloon pages.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 8e400ece9273..2457c54b6185 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -158,6 +158,8 @@ static void set_page_pfns(struct virtio_balloon *vb,
 {
 	unsigned int i;
 
+	BUILD_BUG_ON(VIRTIO_BALLOON_PAGES_PER_PAGE > VIRTIO_BALLOON_ARRAY_PFNS_MAX);
+
 	/*
 	 * Set balloon pfns pointing at this page.
 	 * Note that the first pfn points at start of the page.
-- 
MST

