Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF78EC52D5E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE1272469D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811953;
	bh=EAL46EwKLVJaEP2JtTsJWL3kefGYXgAvQpHvNA/cNMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QUlwjtud7ekKtYcgX1lXodrDAHDkDAUDwLrMGm8RKBE1SOPgrfn5gpmFgImruikGN
	 +P6bL+3YT/hUSlZC+4NCzFiNSxMjgtACPAUwQSUy55LQMLszz3KFfMDn+sBZLMa7mn
	 peUC6IHY9i0EV7rpKz08Ajzz8c29qL5rKzQitCwQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732586AbgB0N7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:59:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:60476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732577AbgB0N7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:59:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 461CC24656;
        Thu, 27 Feb 2020 13:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811948;
        bh=EAL46EwKLVJaEP2JtTsJWL3kefGYXgAvQpHvNA/cNMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AxlNavhQmuJKQctN1xZ0WDt8se7uq9lwSjgOj5nI/CXh4Fvi2Wmgn+jUQntZ4Y6sR
         +Kvej9C9xwlhxP9QunlNLgt/xJjjLkitwwiFVMm8vgJ/HJQ8dj0EihowDELBEhp7uT
         7TqglYoWA74mAsD4N70JJJy5xXfLzupi5C5Ib9ko=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 164/237] virtio_balloon: prevent pfn array overflow
Date:   Thu, 27 Feb 2020 14:36:18 +0100
Message-Id: <20200227132308.555281547@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael S. Tsirkin <mst@redhat.com>

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
index 499531608fa26..71970773aad13 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -132,6 +132,8 @@ static void set_page_pfns(struct virtio_balloon *vb,
 {
 	unsigned int i;
 
+	BUILD_BUG_ON(VIRTIO_BALLOON_PAGES_PER_PAGE > VIRTIO_BALLOON_ARRAY_PFNS_MAX);
+
 	/*
 	 * Set balloon pfns pointing at this page.
 	 * Note that the first pfn points at start of the page.
-- 
2.20.1



