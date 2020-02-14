Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F128CC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD175246A1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581696758;
	bh=ybj/Nt82ZeTCt3/1NcDfrCgtDu3mB6y65FHdG/OJQ/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AQd7rtLQE6JzvFUh8Mj37Z0b4AW9+z3aemCTyhzPcbeAqmT9q+tXl5I+cR0HA2rKp
	 gty/1DstBIV/R6elvYfUeI0gq2g9oiLePOwh6M/OB9fJqodVrwgwL8348OAH9dcj5B
	 R+9zvd/L4i6tWY0yJPkz9Vl/NLH6CQAO7wlkKy3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392026AbgBNQMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:12:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:38386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391555AbgBNQLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:11:31 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E82B2469D;
        Fri, 14 Feb 2020 16:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696691;
        bh=ybj/Nt82ZeTCt3/1NcDfrCgtDu3mB6y65FHdG/OJQ/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Thb1YpyCw3WJkjwHufSvojC3bIC816X0x6zlInkFrpbQWYK4SqpzWDngxAm22hpDS
         7l4NjNST7Y3bmDdkawYxv2eiuDxfroQ/lK2N99BwBkBdOkaOntOHZByV0pDWMcvq/n
         V9PknHnSEmIlZfU8JNSJNygPQdSK8sLDh+k25sNI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 5.4 457/459] virtio_balloon: prevent pfn array overflow
Date:   Fri, 14 Feb 2020 11:01:47 -0500
Message-Id: <20200214160149.11681-457-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@redhat.com>

[ Upstream commit 6e9826e77249355c09db6ba41cd3f84e89f4b614 ]

Make sure, at build time, that pfn array is big enough to hold a single
page.  It happens to be true since the PAGE_SHIFT value at the moment is
20, which is 1M - exactly 256 4K balloon pages.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virtio/virtio_balloon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index c962d9b370c69..d2c4eb9efd70b 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -157,6 +157,8 @@ static void set_page_pfns(struct virtio_balloon *vb,
 {
 	unsigned int i;
 
+	BUILD_BUG_ON(VIRTIO_BALLOON_PAGES_PER_PAGE > VIRTIO_BALLOON_ARRAY_PFNS_MAX);
+
 	/*
 	 * Set balloon pfns pointing at this page.
 	 * Note that the first pfn points at start of the page.
-- 
2.20.1

