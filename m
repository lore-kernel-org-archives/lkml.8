Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10932C433F1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E05742070A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595859698;
	bh=qZ/q8yUYZulNBOTbHyiSlh+qQ7ws0lW90pxD72l4R9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sl9Bcxng95q0/nunGgwgg5jS5QWDLFo/OA1REx76MKTFxQlSKv2J3S7G1MHBIiPzf
	 HQuzI2lGWamvwS4VkmWEoEaLT129VgBZzgj7nuxNvo5PmScR/XXFCeTFpnS4kcHiz0
	 fRLmnLuUTyvpfi9VXKeeEFeNhHQNO0iOZoP4BIoc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbgG0OVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:21:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:50168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730258AbgG0OVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:21:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DADC2070B;
        Mon, 27 Jul 2020 14:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859692;
        bh=qZ/q8yUYZulNBOTbHyiSlh+qQ7ws0lW90pxD72l4R9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rLzg6Ebq2TheqrePFb87qusuHZwmnoCiyrBb2bLPTJRB8vCi9rrMdDAUQG6hLFNyT
         dRXienJvQt/ulV3Lg0H9rwhTc4N0fNAjVSA1kWlj1Z6k8k/9ACWcAoOCMws9ahOrCa
         UBh69c4rq7M8U2WufZlkURiYAKLXeGA0oz5R1TDI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 051/179] vsock/virtio: annotate the_virtio_vsock RCU pointer
Date:   Mon, 27 Jul 2020 16:03:46 +0200
Message-Id: <20200727134935.154462720@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134932.659499757@linuxfoundation.org>
References: <20200727134932.659499757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Garzarella <sgarzare@redhat.com>

[ Upstream commit f961134a612c793d5901a93d85a29337c74af978 ]

Commit 0deab087b16a ("vsock/virtio: use RCU to avoid use-after-free
on the_virtio_vsock") starts to use RCU to protect 'the_virtio_vsock'
pointer, but we forgot to annotate it.

This patch adds the annotation to fix the following sparse errors:

    net/vmw_vsock/virtio_transport.c:73:17: error: incompatible types in comparison expression (different address spaces):
    net/vmw_vsock/virtio_transport.c:73:17:    struct virtio_vsock [noderef] __rcu *
    net/vmw_vsock/virtio_transport.c:73:17:    struct virtio_vsock *
    net/vmw_vsock/virtio_transport.c:171:17: error: incompatible types in comparison expression (different address spaces):
    net/vmw_vsock/virtio_transport.c:171:17:    struct virtio_vsock [noderef] __rcu *
    net/vmw_vsock/virtio_transport.c:171:17:    struct virtio_vsock *
    net/vmw_vsock/virtio_transport.c:207:17: error: incompatible types in comparison expression (different address spaces):
    net/vmw_vsock/virtio_transport.c:207:17:    struct virtio_vsock [noderef] __rcu *
    net/vmw_vsock/virtio_transport.c:207:17:    struct virtio_vsock *
    net/vmw_vsock/virtio_transport.c:561:13: error: incompatible types in comparison expression (different address spaces):
    net/vmw_vsock/virtio_transport.c:561:13:    struct virtio_vsock [noderef] __rcu *
    net/vmw_vsock/virtio_transport.c:561:13:    struct virtio_vsock *
    net/vmw_vsock/virtio_transport.c:612:9: error: incompatible types in comparison expression (different address spaces):
    net/vmw_vsock/virtio_transport.c:612:9:    struct virtio_vsock [noderef] __rcu *
    net/vmw_vsock/virtio_transport.c:612:9:    struct virtio_vsock *
    net/vmw_vsock/virtio_transport.c:631:9: error: incompatible types in comparison expression (different address spaces):
    net/vmw_vsock/virtio_transport.c:631:9:    struct virtio_vsock [noderef] __rcu *
    net/vmw_vsock/virtio_transport.c:631:9:    struct virtio_vsock *

Fixes: 0deab087b16a ("vsock/virtio: use RCU to avoid use-after-free on the_virtio_vsock")
Reported-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/vmw_vsock/virtio_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index dfbaf6bd8b1c7..2700a63ab095e 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -22,7 +22,7 @@
 #include <net/af_vsock.h>
 
 static struct workqueue_struct *virtio_vsock_workqueue;
-static struct virtio_vsock *the_virtio_vsock;
+static struct virtio_vsock __rcu *the_virtio_vsock;
 static DEFINE_MUTEX(the_virtio_vsock_mutex); /* protects the_virtio_vsock */
 
 struct virtio_vsock {
-- 
2.25.1



