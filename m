Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A898C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F141320704
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865505;
	bh=ZrNIB5c/Dpraf2+dyHOY3QdZBesP0tyTXZwse2eGJIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DLkU6S8g3n/47hDUr7q2Nrdlv2srBCtCDnVDwBJt7zDOyOnHdpVzPZS1amVqr8pFK
	 Mp2Yny1zP5SFNpoIt8FL0Ztk8vuy5qDQxmA9Z7/1fk9KPuEfOQqnwdWSKMUydh9T7W
	 w1h7REOnq7Li9BZ8Qxb37YtH5FRjhvjwHmlV3Xqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404137AbgAXLbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:31:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:50064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391894AbgAXLbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:31:36 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF0B5206D4;
        Fri, 24 Jan 2020 11:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865495;
        bh=ZrNIB5c/Dpraf2+dyHOY3QdZBesP0tyTXZwse2eGJIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rOyu3pIw4ar+aN5l9FS5/WgAmzWW9xzoJ8qok17XBqOlda+mA7fu8yFO/8Jffg6uu
         kE0lSD2jaaNsa9HDxRjaUapvggaoZl9wiWcr4OvHsGzUsN+ZPOhu0Vj8TstpwYp0uu
         UkE3TbPvpKvpTTtHfcMLzlKFjFolU0KREBZibOGc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonathan Lemon <jonathan.lemon@gmail.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 544/639] xsk: avoid store-tearing when assigning umem
Date:   Fri, 24 Jan 2020 10:31:54 +0100
Message-Id: <20200124093157.222069051@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Björn Töpel <bjorn.topel@intel.com>

[ Upstream commit 9764f4b301c3e7eb3b75eec85b73cad449cdbb0d ]

The umem member of struct xdp_sock is read outside of the control
mutex, in the mmap implementation, and needs a WRITE_ONCE to avoid
potential store-tearing.

Acked-by: Jonathan Lemon <jonathan.lemon@gmail.com>
Fixes: 423f38329d26 ("xsk: add umem fill queue support and mmap")
Signed-off-by: Björn Töpel <bjorn.topel@intel.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xdp/xsk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index b580078f04d15..72caa4fb13f47 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -454,7 +454,7 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 		}
 
 		xdp_get_umem(umem_xs->umem);
-		xs->umem = umem_xs->umem;
+		WRITE_ONCE(xs->umem, umem_xs->umem);
 		sockfd_put(sock);
 	} else if (!xs->umem || !xdp_umem_validate_queues(xs->umem)) {
 		err = -EINVAL;
@@ -534,7 +534,7 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
 
 		/* Make sure umem is ready before it can be seen by others */
 		smp_wmb();
-		xs->umem = umem;
+		WRITE_ONCE(xs->umem, umem);
 		mutex_unlock(&xs->mutex);
 		return 0;
 	}
-- 
2.20.1



