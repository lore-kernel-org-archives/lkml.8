Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BD5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2637B20757
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580868;
	bh=V/FRNN+8zZs3+kt8tKPhVX53NnGRkYtabNRJro1vGqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eva2KxdtJJUeYT5LWZamRZpOLTURsJ8KMpujLt+MP1xKietc36vjQ9Z78jpxV1ZhE
	 tKOlBcMuk4oV3p710BmXguEiuehPAZIoPdIQERwbGSkpuzfIfZ0o3naZUeNl4VAZox
	 oKJVG5yIcAWNTDQblHsnvBcZyFhf8OeDJ7IwQLQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393757AbgFSPeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:34:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393908AbgFSPcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:32:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD36920786;
        Fri, 19 Jun 2020 15:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580759;
        bh=V/FRNN+8zZs3+kt8tKPhVX53NnGRkYtabNRJro1vGqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ay9kEieB5xMBWvzAzhSm3Nd/XwlQkpzzBouFEIv64izhnQlqyq6LNb/c5CBlA6oj9
         CA9hxivluvA+EcFILbe3UlyfU+tuEGPmgoex88f/O7Ixe7/lQSo8cOHoTboQtjv5iu
         y6bq7VY+70r+TP8wH8OKr/ie0/AEthGtsNankQeU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 5.7 345/376] virtio-balloon: Disable free page reporting if page poison reporting is not enabled
Date:   Fri, 19 Jun 2020 16:34:23 +0200
Message-Id: <20200619141726.658495849@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

commit fb69c2c896fc8289b0d9e2c0791472e7cd398bca upstream.

We should disable free page reporting if page poisoning is enabled but we
cannot report it via the balloon interface. This way we can avoid the
possibility of corrupting guest memory. Normally the page poisoning feature
should always be present when free page reporting is enabled on the
hypervisor, however this allows us to correctly handle a case of the
virtio-balloon device being possibly misconfigured.

Fixes: 5d757c8d518d ("virtio-balloon: add support for providing free page reports to host")
Cc: stable@vger.kernel.org
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Link: https://lore.kernel.org/r/20200508173732.17877.85060.stgit@localhost.localdomain
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/virtio/virtio_balloon.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -1107,11 +1107,18 @@ static int virtballoon_restore(struct vi
 
 static int virtballoon_validate(struct virtio_device *vdev)
 {
-	/* Tell the host whether we care about poisoned pages. */
+	/*
+	 * Inform the hypervisor that our pages are poisoned or
+	 * initialized. If we cannot do that then we should disable
+	 * page reporting as it could potentially change the contents
+	 * of our free pages.
+	 */
 	if (!want_init_on_free() &&
 	    (IS_ENABLED(CONFIG_PAGE_POISONING_NO_SANITY) ||
 	     !page_poisoning_enabled()))
 		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_PAGE_POISON);
+	else if (!virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON))
+		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_REPORTING);
 
 	__virtio_clear_bit(vdev, VIRTIO_F_IOMMU_PLATFORM);
 	return 0;


