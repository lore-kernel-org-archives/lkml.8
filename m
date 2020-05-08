Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A866C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01D8B24969
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942075;
	bh=YraofylXLPuAdEuUBvMoUNOnCgiq6OQ36ul0xoP7O/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HTr14YC9JuFLbX3o3AmqZom9cPuyRMxho1RvzKeiUVR8mD8YdjerK12jhqWBuiTna
	 FYDjAER8nB+sdDcykhlyMXrD3AzkuPXlJX/OlRYv1e8dYB18sJy5a3aSAlrNHuZQiT
	 0IxryFuVeR1OO3DUFojtUT/VO+Bpk/3C6E1JALcM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbgEHMry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:47:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729587AbgEHMrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:47:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07023221F7;
        Fri,  8 May 2020 12:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942066;
        bh=YraofylXLPuAdEuUBvMoUNOnCgiq6OQ36ul0xoP7O/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cGbwxQJzOR15Dk4LRhzv80WlpamrZx8u6BP04ihPrJmOv9g7HyOEk/fBQa00Qj+e5
         8DHMmkyJATMmyimlYfl8lPhjmEi+QyGXYlr3/AUmNw3MOnxNV0s+zizyMtDf+T79MA
         rev0IUmtQKs1aVLJHORhOdkW/dv4jjN773FPux+0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 284/312] l2tp: fix use-after-free during module unload
Date:   Fri,  8 May 2020 14:34:35 +0200
Message-Id: <20200508123144.376454291@linuxfoundation.org>
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

From: Sabrina Dubroca <sd@queasysnail.net>

commit 2f86953e7436c9b9a4690909c5e2db24799e173b upstream.

Tunnel deletion is delayed by both a workqueue (l2tp_tunnel_delete -> wq
 -> l2tp_tunnel_del_work) and RCU (sk_destruct -> RCU ->
l2tp_tunnel_destruct).

By the time l2tp_tunnel_destruct() runs to destroy the tunnel and finish
destroying the socket, the private data reserved via the net_generic
mechanism has already been freed, but l2tp_tunnel_destruct() actually
uses this data.

Make sure tunnel deletion for the netns has completed before returning
from l2tp_exit_net() by first flushing the tunnel removal workqueue, and
then waiting for RCU callbacks to complete.

Fixes: 167eb17e0b17 ("l2tp: create tunnel sockets in the right namespace")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/l2tp/l2tp_core.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1953,6 +1953,9 @@ static __net_exit void l2tp_exit_net(str
 		l2tp_tunnel_delete(tunnel);
 	}
 	rcu_read_unlock_bh();
+
+	flush_workqueue(l2tp_wq);
+	rcu_barrier();
 }
 
 static struct pernet_operations l2tp_net_ops = {


