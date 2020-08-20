Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C8BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E7FC207DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597882237;
	bh=iXmAtY7BG2mwDIC/wHHpkcNbC6q/kDidRTK1GVKOgL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aFEw86muZa7BMO3e4OgVNlhD6mp98lUVpilWbLc1kDpz2hmwvoRZsTRWFTc1n5Pd8
	 RjEmz00es865jewxWRMVGMJNlpFkU3y2hOFnwGdJPcdPHp5pzrP6gtMBbu1RJk5R9B
	 hnZyaZeMGt05TGNvNtW60WsaUlv/wykbmwl/i7Vk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgHTAKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 20:10:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:59088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727926AbgHTACV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 20:02:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3171620FC3;
        Thu, 20 Aug 2020 00:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597881741;
        bh=iXmAtY7BG2mwDIC/wHHpkcNbC6q/kDidRTK1GVKOgL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YDYUK/RHw5xaHRxm8q2SJunZwIwB/3cQ0ZyuuyWstiTy7tnoJCFdAY9RbBm05/3o2
         m9/p2/9mX/Xw4xltwT0brxZAPfsAQsWra/GQ3jKq68cRjLBrUvMKQt7Nq4haPKsTLg
         58nL4wAtPXfe29xBZggZx/paXf8MYXqWGq5AOeM8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mao Wenan <wenan.mao@linux.alibaba.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 5.7 19/24] virtio_ring: Avoid loop when vq is broken in virtqueue_poll
Date:   Wed, 19 Aug 2020 20:01:50 -0400
Message-Id: <20200820000155.215089-19-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820000155.215089-1-sashal@kernel.org>
References: <20200820000155.215089-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mao Wenan <wenan.mao@linux.alibaba.com>

[ Upstream commit 481a0d7422db26fb63e2d64f0652667a5c6d0f3e ]

The loop may exist if vq->broken is true,
virtqueue_get_buf_ctx_packed or virtqueue_get_buf_ctx_split
will return NULL, so virtnet_poll will reschedule napi to
receive packet, it will lead cpu usage(si) to 100%.

call trace as below:
virtnet_poll
	virtnet_receive
		virtqueue_get_buf_ctx
			virtqueue_get_buf_ctx_packed
			virtqueue_get_buf_ctx_split
	virtqueue_napi_complete
		virtqueue_poll           //return true
		virtqueue_napi_schedule //it will reschedule napi

to fix this, return false if vq is broken in virtqueue_poll.

Signed-off-by: Mao Wenan <wenan.mao@linux.alibaba.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Link: https://lore.kernel.org/r/1596354249-96204-1-git-send-email-wenan.mao@linux.alibaba.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virtio/virtio_ring.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 58b96baa8d488..4f7c73e6052f6 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1960,6 +1960,9 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned last_used_idx)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
+	if (unlikely(vq->broken))
+		return false;
+
 	virtio_mb(vq->weak_barriers);
 	return vq->packed_ring ? virtqueue_poll_packed(_vq, last_used_idx) :
 				 virtqueue_poll_split(_vq, last_used_idx);
-- 
2.25.1

