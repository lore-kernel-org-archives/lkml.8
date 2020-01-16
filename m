Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4DBC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48612064C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579218342;
	bh=i0+bc8psChPsL8aeaO1Qw8WqA3DPbGaJi4hMtSmorAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yr1ej8OJJPApIjBJRGWlye1ZGYMdXOIqxlYXtCPMLHd32xVraZMOmmJu6i9vzdCXQ
	 noo/mbNXnHZSnoq6xO+4Ywzr6cLdQubN3+KrV834LeJS2643fxiS12rtj8kBRd5Z4C
	 J6i/KrUQQ40hjMlYVnxJo2LA1KQz582WMdI+6H2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391837AbgAPXpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:45:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:50776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390942AbgAPXWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:22:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7067B2072E;
        Thu, 16 Jan 2020 23:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579216968;
        bh=i0+bc8psChPsL8aeaO1Qw8WqA3DPbGaJi4hMtSmorAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I8lra9IsS41lva0u+scg77GU8IW5CMgFjblJiy4dsh5SwpjinklnJR8VZY/IxciDp
         X/Jc2fxjgQarhONil9Qhwkf4zx1SomJievRT3BhA641+4yhxAWt2/87YKunrCq9f5e
         ydXWPdbQ22/7NDtFPFmBfqa1Qx3hsDZvWyw+7AhQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 5.4 094/203] xprtrdma: Fix completion wait during device removal
Date:   Fri, 17 Jan 2020 00:16:51 +0100
Message-Id: <20200116231753.886716695@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

commit 13cb886c591f341a8759f175292ddf978ef903a1 upstream.

I've found that on occasion, "rmmod <dev>" will hang while if an NFS
is under load.

Ensure that ri_remove_done is initialized only just before the
transport is woken up to force a close. This avoids the completion
possibly getting initialized again while the CM event handler is
waiting for a wake-up.

Fixes: bebd031866ca ("xprtrdma: Support unplugging an HCA from under an NFS mount")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sunrpc/xprtrdma/verbs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -245,6 +245,7 @@ rpcrdma_cm_event_handler(struct rdma_cm_
 			ia->ri_id->device->name,
 			rpcrdma_addrstr(r_xprt), rpcrdma_portstr(r_xprt));
 #endif
+		init_completion(&ia->ri_remove_done);
 		set_bit(RPCRDMA_IAF_REMOVING, &ia->ri_flags);
 		ep->rep_connected = -ENODEV;
 		xprt_force_disconnect(xprt);
@@ -299,7 +300,6 @@ rpcrdma_create_id(struct rpcrdma_xprt *x
 	trace_xprtrdma_conn_start(xprt);
 
 	init_completion(&ia->ri_done);
-	init_completion(&ia->ri_remove_done);
 
 	id = rdma_create_id(xprt->rx_xprt.xprt_net, rpcrdma_cm_event_handler,
 			    xprt, RDMA_PS_TCP, IB_QPT_RC);


