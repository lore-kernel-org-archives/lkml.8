Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44026C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1817021473
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941919;
	bh=FbrW2Zz3cLZCT8P5J3NmVfeHF6yFYYm6ZWLl8d8nbPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jeoFsMfbDpPOZpCHZLp15AgWFnYNhGqfeMvmWwqQyNd79z37RtT1KpCuWnM1uTLOt
	 2oCWCHK0K6F9Nk2XfYaT3B1uQdoc4jJv/m7/dmW1uzKlJnsciXP7/ysk47PQpOKhLE
	 Hdi6F5A5U14QBkLAP/wydO3UGAlCtcKNthXIPuv4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgEHMpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:45:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729276AbgEHMpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:45:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADD3F2495D;
        Fri,  8 May 2020 12:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941910;
        bh=FbrW2Zz3cLZCT8P5J3NmVfeHF6yFYYm6ZWLl8d8nbPQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hy2we8OwtNEa96V0w/Q9STm5bQy0HVAB6P+OpvObp7nnAu2WpVqd9ZI+n7z5lWzys
         CdbpX21MFlb9eMdeTNEYyb9S4j7rDW3T52ZbSmFzG08mHk8ROqYlpmEm/kOEvusdFO
         IjA7CmWw5jJXEy2ImFA4eblsSIWuLQFUxTkYEZyQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 220/312] net/mlx4: Fix uninitialized fields in rule when adding promiscuous mode to device managed flow steering
Date:   Fri,  8 May 2020 14:33:31 +0200
Message-Id: <20200508123139.933892692@linuxfoundation.org>
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

From: Jack Morgenstein <jackm@dev.mellanox.co.il>

commit 44b911e77793d686b481608770d0c55c18055ba0 upstream.

In procedure mlx4_flow_steer_promisc_add(), several fields
were left uninitialized in the rule structure.
Correctly initialize these fields.

Fixes: 592e49dda812 ("net/mlx4: Implement promiscuous mode with device managed flow-steering")
Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/mellanox/mlx4/mcg.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx4/mcg.c
+++ b/drivers/net/ethernet/mellanox/mlx4/mcg.c
@@ -1464,7 +1464,12 @@ EXPORT_SYMBOL_GPL(mlx4_multicast_detach)
 int mlx4_flow_steer_promisc_add(struct mlx4_dev *dev, u8 port,
 				u32 qpn, enum mlx4_net_trans_promisc_mode mode)
 {
-	struct mlx4_net_trans_rule rule;
+	struct mlx4_net_trans_rule rule = {
+		.queue_mode = MLX4_NET_TRANS_Q_FIFO,
+		.exclusive = 0,
+		.allow_loopback = 1,
+	};
+
 	u64 *regid_p;
 
 	switch (mode) {


