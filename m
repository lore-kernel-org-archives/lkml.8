Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B124C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3880E20870
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583258174;
	bh=EJaw7nSihU84X6HW/kSe1Dq4ngkgNCk0RFoO+OkqYWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0E90/vZhZElTJ+CvFsYkGDpKKXlOvpFxoyb1SgmclnFwcQlpfjN911g7PV6d1oK+q
	 73RRV0+iM8Kqko4mxfjF7ojG7hoa0Dp25CeYbi1wav0CLQwQhfT49q/+12+blxD03P
	 T8KJlBHTkUEYdX2OfV+tiwr1d3vkzkw7jvXvJm0g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732857AbgCCR4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:56:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:38110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732833AbgCCR4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:56:06 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F0EF20728;
        Tue,  3 Mar 2020 17:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583258165;
        bh=EJaw7nSihU84X6HW/kSe1Dq4ngkgNCk0RFoO+OkqYWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zypg5uvwalKTEuyQTI7sUe008ZlpTKd0440fNtfXwgfdocstRdWn4zMFW/ofdk8NW
         jiW46yUJKaz/sp5YBOCSud0KMecfne1TsDGrdy9JPlq1LV2Xh3F03mCR/ppSEyYjcm
         L27drFpnqyl4e9AXgmA3q6cN/2w6kcWweBKxWLEI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+f2a62d07a5198c819c7b@syzkaller.appspotmail.com,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 089/152] vhost: Check docket sk_family instead of call getname
Date:   Tue,  3 Mar 2020 18:43:07 +0100
Message-Id: <20200303174312.678120325@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174302.523080016@linuxfoundation.org>
References: <20200303174302.523080016@linuxfoundation.org>
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

---
 drivers/vhost/net.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1414,10 +1414,6 @@ static int vhost_net_release(struct inod
 
 static struct socket *get_raw_socket(int fd)
 {
-	struct {
-		struct sockaddr_ll sa;
-		char  buf[MAX_ADDR_LEN];
-	} uaddr;
 	int r;
 	struct socket *sock = sockfd_lookup(fd, &r);
 
@@ -1430,11 +1426,7 @@ static struct socket *get_raw_socket(int
 		goto err;
 	}
 
-	r = sock->ops->getname(sock, (struct sockaddr *)&uaddr.sa, 0);
-	if (r < 0)
-		goto err;
-
-	if (uaddr.sa.sll_family != AF_PACKET) {
+	if (sock->sk->sk_family != AF_PACKET) {
 		r = -EPFNOSUPPORT;
 		goto err;
 	}


