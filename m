Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268FFC32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29DE208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579858482;
	bh=76H+nVK9gRR9qwTprbz/gqeGaJDdXhDbDWAKVxsG7FY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kEoTeCBQa7DmwNv2O8HexCiiOGDcX8YmNCllnkksuo1bNZS4d0umUoSOXWLol9H15
	 pRnLyj0/0sJaiDA5eVoFYkEFDqWUtqHmIEOwparoA72WBig8jzfZB5wOXljBW1C3wE
	 k75T1ZTcwxqsk6xIeeGYF1GEfv+M8p+JmKtowwAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbgAXJel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:34:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:33042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730166AbgAXJeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:34:36 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3DC721569;
        Fri, 24 Jan 2020 09:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579858476;
        bh=76H+nVK9gRR9qwTprbz/gqeGaJDdXhDbDWAKVxsG7FY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ucX+8J/z/RdjM6pcTfNY9hSyimnNqy9h67PAy7KwbBP3K8Mw4oijDSYysPupB9k6R
         ZdjvxmdAffZy1LlfyJ8irQZ85ASI0HNLcjarLmd4K11ZiE2G8XZrhdTSYrkOEf8mF4
         jVCaevq3X/B1icaXGQI1tsiVLjhPTPa1wvBNeot0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roi Dayan <roid@mellanox.com>,
        Eli Britstein <elibr@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.4 028/102] net/mlx5e: Fix free peer_flow when refcount is 0
Date:   Fri, 24 Jan 2020 10:30:29 +0100
Message-Id: <20200124092810.443854574@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092806.004582306@linuxfoundation.org>
References: <20200124092806.004582306@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roi Dayan <roid@mellanox.com>

commit eb252c3a24fc5856fa62140c2f8269ddce6ce4e5 upstream.

It could be neigh update flow took a refcount on peer flow so
sometimes we cannot release peer flow even if parent flow is
being freed now.

Fixes: 5a7e5bcb663d ("net/mlx5e: Extend tc flow struct with reference counter")
Signed-off-by: Roi Dayan <roid@mellanox.com>
Reviewed-by: Eli Britstein <elibr@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -1615,8 +1615,11 @@ static void __mlx5e_tc_del_fdb_peer_flow
 
 	flow_flag_clear(flow, DUP);
 
-	mlx5e_tc_del_fdb_flow(flow->peer_flow->priv, flow->peer_flow);
-	kfree(flow->peer_flow);
+	if (refcount_dec_and_test(&flow->peer_flow->refcnt)) {
+		mlx5e_tc_del_fdb_flow(flow->peer_flow->priv, flow->peer_flow);
+		kfree(flow->peer_flow);
+	}
+
 	flow->peer_flow = NULL;
 }
 


