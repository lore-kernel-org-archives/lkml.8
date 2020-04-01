Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07C4C2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BCF214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758698;
	bh=AABPsAeS0WRMB4og4yRTksa1AlhSg3dQrMGyJCKVP4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jwb5MtofL2b316S9RqmqIQm7Cj2LiOuZav+ueA4P5SO3xiasGIq4vEUW+fjWCfbBr
	 IRzxdqk1nGChh3Kb4jc22gl7Xvx9fo7sS5mfe17EN2DCbaIk+H3w+J4qd2+76feVfH
	 N1SaNMX/+NbJ6JEw2nFh4W5Fc9n+OMfuX5Ra7qXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388297AbgDAQbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:31:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:57672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388268AbgDAQb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:31:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 857E221582;
        Wed,  1 Apr 2020 16:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758686;
        bh=AABPsAeS0WRMB4og4yRTksa1AlhSg3dQrMGyJCKVP4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uaQLsueOzp0ePOhLJXFXE/xK6j0hCRI//gt4qAfqa4oidaXcIqV7UoG3QeNRdxctT
         5xunwQgiOtwq9Ws56x/pOxI4i74o9/FlWu9YawGF9yAPwl3k4gXXvgEMft0e+E4Upt
         ORHs+Y/LDyZOfSONQlWf3qG8AKhNGCVErupLl7Xo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+f2a62d07a5198c819c7b@syzkaller.appspotmail.com,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 44/91] vhost: Check docket sk_family instead of call getname
Date:   Wed,  1 Apr 2020 18:17:40 +0200
Message-Id: <20200401161528.834152308@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161512.917494101@linuxfoundation.org>
References: <20200401161512.917494101@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugenio Pérez <eperezma@redhat.com>

[ Upstream commit 42d84c8490f9f0931786f1623191fcab397c3d64 ]

Doing so, we save one call to get data we already have in the struct.

Also, since there is no guarantee that getname use sockaddr_ll
parameter beyond its size, we add a little bit of security here.
It should do not do beyond MAX_ADDR_LEN, but syzbot found that
ax25_getname writes more (72 bytes, the size of full_sockaddr_ax25,
versus 20 + 32 bytes of sockaddr_ll + MAX_ADDR_LEN in syzbot repro).

Fixes: 3a4d5c94e9593 ("vhost_net: a kernel-level virtio server")
Reported-by: syzbot+f2a62d07a5198c819c7b@syzkaller.appspotmail.com
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/net.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 1459dc9fd7010..5efac33c29dcb 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -815,11 +815,7 @@ static int vhost_net_release(struct inode *inode, struct file *f)
 
 static struct socket *get_raw_socket(int fd)
 {
-	struct {
-		struct sockaddr_ll sa;
-		char  buf[MAX_ADDR_LEN];
-	} uaddr;
-	int uaddr_len = sizeof uaddr, r;
+	int r;
 	struct socket *sock = sockfd_lookup(fd, &r);
 
 	if (!sock)
@@ -831,12 +827,7 @@ static struct socket *get_raw_socket(int fd)
 		goto err;
 	}
 
-	r = sock->ops->getname(sock, (struct sockaddr *)&uaddr.sa,
-			       &uaddr_len, 0);
-	if (r)
-		goto err;
-
-	if (uaddr.sa.sll_family != AF_PACKET) {
+	if (sock->sk->sk_family != AF_PACKET) {
 		r = -EPFNOSUPPORT;
 		goto err;
 	}
-- 
2.20.1



