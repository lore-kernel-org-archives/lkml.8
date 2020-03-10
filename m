Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC13C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90CE520409
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583846392;
	bh=k3anyPXoWfuRk/65vL+xvVR5Ln95LO54LBC6PBWYsWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ugkr4oLNNzbh1de7+PAE//xDF28WidHPWq35fa3/FA/IKgRqAayeSHkk7LzUgM32j
	 CCBymh4ATDWeEwPN0T0RI9UpZeJHnfsrsX/RswdM10uuUBAqvXsMCTvTpogvB4zg2k
	 AP6+1dkeo8dTIr6wGyAUKu+jv7haVheHeuFZ4pDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbgCJNIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:08:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730511AbgCJNIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:08:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D6B5208E4;
        Tue, 10 Mar 2020 13:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845693;
        bh=k3anyPXoWfuRk/65vL+xvVR5Ln95LO54LBC6PBWYsWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PUNjwDd9CfMOQ5cChO2P6f3OeQjAGZbj91Kb4FRuwFMI/7SowXbmq2/mfzaGNv24t
         ZNFVuRxlj3dwvHol7XkQ/AmgnOZfM/bwANT85ywp9WTPkhTghD1KGce+SAcmE1Fmal
         6fZp8U+//zXIOyqHNz1/wd/rgGfTGpKao40v8yXk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+f2a62d07a5198c819c7b@syzkaller.appspotmail.com,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 067/126] vhost: Check docket sk_family instead of call getname
Date:   Tue, 10 Mar 2020 13:41:28 +0100
Message-Id: <20200310124208.344989998@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310124203.704193207@linuxfoundation.org>
References: <20200310124203.704193207@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugenio Pérez <eperezma@redhat.com>

commit 42d84c8490f9f0931786f1623191fcab397c3d64 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[jwang: backport to 4.14]
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/net.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 4d11152e60c15..8fe07622ae59e 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1025,11 +1025,7 @@ static int vhost_net_release(struct inode *inode, struct file *f)
 
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
@@ -1041,12 +1037,7 @@ static struct socket *get_raw_socket(int fd)
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



