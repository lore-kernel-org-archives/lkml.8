Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77291C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 487BF2083B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596457662;
	bh=yTP/gbX7NwD9prvx9sgZEXLgLl6qKkR5XehZhqhxzfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Er6IaJ0j921G2fWSShvUfdvcbvENYCU6Iq4zdhzldeYOgPEYVqAFHeZUvcIH8Teev
	 SoViama+GiBoO0F3FuTChyPe5rhJ/CuIq/qFuYh9omEHzt92yijGMv51ax6d+qpV3j
	 PUxYb3/IfhFz2OndWkPnzwFWqXDu28rHDi23E6tA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgHCM1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:27:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728511AbgHCM1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:27:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB118204EC;
        Mon,  3 Aug 2020 12:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596457643;
        bh=yTP/gbX7NwD9prvx9sgZEXLgLl6qKkR5XehZhqhxzfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T0jzCgfgIlXiBGfv3NFIJq36d7lExLaOyGu2QuVsZDJcvCaMmpOx5l/pC/RrlX9oO
         766ma0hJRprTqiSzuPSeZ5djjUKdsjYRza1acgKx+8Y7wOkaO8vYy2PpBOVagEwzSl
         6A7sm/I+orSh+imcPRJfrV/NUUpSgmZh/7jQspq4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Wei Wang <wei.w.wang@intel.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH 5.4 21/90] virtio_balloon: fix up endian-ness for free cmd id
Date:   Mon,  3 Aug 2020 14:18:43 +0200
Message-Id: <20200803121858.644051268@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121857.546052424@linuxfoundation.org>
References: <20200803121857.546052424@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael S. Tsirkin <mst@redhat.com>

commit 168c358af2f8c5a37f8b5f877ba2cc93995606ee upstream.

free cmd id is read using virtio endian, spec says all fields
in balloon are LE. Fix it up.

Fixes: 86a559787e6f ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
Cc: stable@vger.kernel.org
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Wei Wang <wei.w.wang@intel.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/virtio/virtio_balloon.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -529,10 +529,14 @@ static int init_vqs(struct virtio_balloo
 static u32 virtio_balloon_cmd_id_received(struct virtio_balloon *vb)
 {
 	if (test_and_clear_bit(VIRTIO_BALLOON_CONFIG_READ_CMD_ID,
-			       &vb->config_read_bitmap))
+			       &vb->config_read_bitmap)) {
 		virtio_cread(vb->vdev, struct virtio_balloon_config,
 			     free_page_report_cmd_id,
 			     &vb->cmd_id_received_cache);
+		/* Legacy balloon config space is LE, unlike all other devices. */
+		if (!virtio_has_feature(vb->vdev, VIRTIO_F_VERSION_1))
+			vb->cmd_id_received_cache = le32_to_cpu((__force __le32)vb->cmd_id_received_cache);
+	}
 
 	return vb->cmd_id_received_cache;
 }


