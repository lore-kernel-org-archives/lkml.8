Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD80C47257
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31AE5206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588943675;
	bh=1wPHcZd42Izy7oPaYRtvpTeCVchX9V3qJyeUrcKZb5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CJWYFHsijigYAkxBTXqa6z2PT/mdID3aCHsTlEpw2GN1CHTyUdq1TfzJkPiwblZ2Q
	 hgS8Mx3yh73YmA0orquq/rGALqH6i6c8CEb0gFc9P+8dUUZ2/VX/9/RRgrRS4hla/+
	 KKbOc96WVDYX2g3H4vSWN9czWNQo3DaWqgKJ4fpY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbgEHNOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:14:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729498AbgEHMq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:46:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80D4B221F7;
        Fri,  8 May 2020 12:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942019;
        bh=1wPHcZd42Izy7oPaYRtvpTeCVchX9V3qJyeUrcKZb5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mzpzXF1Tzkj1ZHWN1Nt6FZwhMea51t0ZQY/yBM4+8o0z1M0LX6LOUHqSPh10FU26E
         NidWLoVHYWLT4JkcwXU8tu+92dC3laFsL0yc7JUym8Ceoib1tOPOO/t3CGP2bmA4OF
         eshavLEiuGFSXVzz5tT0A9pl5zDe4SkXGFUpppWE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 263/312] tipc: fix the error handling in tipc_udp_enable()
Date:   Fri,  8 May 2020 14:34:14 +0200
Message-Id: <20200508123142.920990708@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

commit a5de125dd46c851fc962806135953c1bd0a0f0df upstream.

Fix to return a negative error code in enable_mcast() error handling
case, and release udp socket when necessary.

Fixes: d0f91938bede ("tipc: add ip/udp media type")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/tipc/udp_media.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -405,10 +405,13 @@ static int tipc_udp_enable(struct net *n
 	tuncfg.encap_destroy = NULL;
 	setup_udp_tunnel_sock(net, ub->ubsock, &tuncfg);
 
-	if (enable_mcast(ub, remote))
+	err = enable_mcast(ub, remote);
+	if (err)
 		goto err;
 	return 0;
 err:
+	if (ub->ubsock)
+		udp_tunnel_sock_release(ub->ubsock);
 	kfree(ub);
 	return err;
 }


