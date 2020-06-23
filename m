Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D1BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41E8E20702
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592946730;
	bh=rkZX3bav+4P9uCkgZwp0mQI+mbLg2e7iIaI1BqER1kU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dThgKly1t2sG7ittUZZeAE9cQVuDtpDaZCZytou+KU+zQET5O8u3A7kiXqmDDCukL
	 DrNe3Z5CQn5Fxuv6GlqKRRNzz1rO4cH1VhISTwAnSp/maoohDos5v8FNptP+g7nP7i
	 VYXWc8mm4yluy14laIkmwEY6lJkrT1DldcQhwIi4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404127AbgFWVMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:12:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:52718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390995AbgFWUb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:31:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 607A9206C3;
        Tue, 23 Jun 2020 20:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944317;
        bh=rkZX3bav+4P9uCkgZwp0mQI+mbLg2e7iIaI1BqER1kU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oBGWxG/HMDzKvrTYEwO0Zvsu3NH+BO/lJ5+F4nMOEquqIXa4+qsu5hvm+aEeYna3D
         1M5a0uwN9D3kn6a0dl8407A7Z36dCls+mvkOV3CXwrqh+2v/E+K0eAGAY43mi2HnPa
         u7TCapiWe6zmGjSzLQ5bTUIYez2e1aFYkdUlx3SE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li RongQing <lirongqing@baidu.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 257/314] xdp: Fix xsk_generic_xmit errno
Date:   Tue, 23 Jun 2020 21:57:32 +0200
Message-Id: <20200623195351.232441183@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li RongQing <lirongqing@baidu.com>

[ Upstream commit aa2cad0600ed2ca6a0ab39948d4db1666b6c962b ]

Propagate sock_alloc_send_skb error code, not set it to
EAGAIN unconditionally, when fail to allocate skb, which
might cause that user space unnecessary loops.

Fixes: 35fcde7f8deb ("xsk: support for Tx")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Björn Töpel <bjorn.topel@intel.com>
Link: https://lore.kernel.org/bpf/1591852266-24017-1-git-send-email-lirongqing@baidu.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xdp/xsk.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 7181a30666b4a..f9eb5efb237c7 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -362,10 +362,8 @@ static int xsk_generic_xmit(struct sock *sk)
 
 		len = desc.len;
 		skb = sock_alloc_send_skb(sk, len, 1, &err);
-		if (unlikely(!skb)) {
-			err = -EAGAIN;
+		if (unlikely(!skb))
 			goto out;
-		}
 
 		skb_put(skb, len);
 		addr = desc.addr;
-- 
2.25.1



