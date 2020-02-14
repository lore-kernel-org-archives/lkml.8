Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A9CC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A00520656
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581699532;
	bh=HT5L93YR/HJ4vRRxxviyJu2IQ9sUF4CagOliP9ync7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UzoCVKPLEOa2kxU3wGMc2NUHQa3mIKTQ2beO2sXE51USLy273YlxH5aIMp3C//anG
	 6gpBN+8SEDnWmnjI2AqsQdCFHRdHcyHOr3FirNJV+ZKPObzvqmKTjyTbnjLfhpATnL
	 4pBb+jogRpwDh+yCjpCki+qZfzn9N1bSboe88TbM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394270AbgBNQ6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:58:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:48186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392424AbgBNQRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:17:03 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80DCA24687;
        Fri, 14 Feb 2020 16:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697023;
        bh=HT5L93YR/HJ4vRRxxviyJu2IQ9sUF4CagOliP9ync7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gFXUr1g455LZhJpTcqKVWOSgafcWdkslbwZhu6EpwUd3Kg2FnuZ286KpxKepAxyHl
         870cweNFSuYLPy2ZLmtLzTsB4+Vy4BXP461iukLGmNkzPyYY2hX9YaJpJu1T4HfEPS
         QBxvCxsuL8gESZPyft/I6W8/U/MQuNxi0OWbcqSs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 4.19 251/252] virtio_balloon: prevent pfn array overflow
Date:   Fri, 14 Feb 2020 11:11:46 -0500
Message-Id: <20200214161147.15842-251-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161147.15842-1-sashal@kernel.org>
References: <20200214161147.15842-1-sashal@kernel.org>
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
index 14ac36ca8fbd3..1afcbef397ab7 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -126,6 +126,8 @@ static void set_page_pfns(struct virtio_balloon *vb,
 {
 	unsigned int i;
 
+	BUILD_BUG_ON(VIRTIO_BALLOON_PAGES_PER_PAGE > VIRTIO_BALLOON_ARRAY_PFNS_MAX);
+
 	/*
 	 * Set balloon pfns pointing at this page.
 	 * Note that the first pfn points at start of the page.
-- 
2.20.1

