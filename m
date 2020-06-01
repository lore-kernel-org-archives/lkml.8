Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EA1C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25DC82065C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591035176;
	bh=ZJo7ImFdaxzShG0yRFkqeTe7Vk+/5dwJQ/zGcxn47cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rANs4lY5WptDsBwdtQhS4okzoBtm1TALSnhO9HyhiB6IkUoswYhv4zHpG/qTUNPt/
	 qUUAY2To91L5fNMxPwHfIpU3svAKmMfbyC+CiOU/uAP2vUrzqUwT13XXXOIn68HyA1
	 kBGLjTXwllxurzGrA9I0KCyL9nOnv2GEQ2ysAwYU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730910AbgFASMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:12:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729813AbgFASMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:12:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4127E2068D;
        Mon,  1 Jun 2020 18:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591035163;
        bh=ZJo7ImFdaxzShG0yRFkqeTe7Vk+/5dwJQ/zGcxn47cg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eH+BcmQadnWlSnJE3YPS7nNU07jEpCUeROVFokK/YKsr9OBSr/00tB9pMsXNJn5aH
         aM5Xt+j0z6xF1vSPa9cX37mIdI81zSn5No+MX9EbfjRPW9GKyrehU21e1ZRq47yFhT
         CUbaGs/QYDll0qmb6qGxa1eVk+6CdAno6/QIkPmg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roi Dayan <roid@mellanox.com>,
        Mark Bloch <markb@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.6 036/177] net/mlx5: Annotate mutex destroy for root ns
Date:   Mon,  1 Jun 2020 19:52:54 +0200
Message-Id: <20200601174051.946831038@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174048.468952319@linuxfoundation.org>
References: <20200601174048.468952319@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roi Dayan <roid@mellanox.com>

commit 9ca415399dae133b00273a4283ef31d003a6818d upstream.

Invoke mutex_destroy() to catch any errors.

Fixes: 2cc43b494a6c ("net/mlx5_core: Managing root flow table")
Signed-off-by: Roi Dayan <roid@mellanox.com>
Reviewed-by: Mark Bloch <markb@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -416,6 +416,12 @@ static void del_sw_ns(struct fs_node *no
 
 static void del_sw_prio(struct fs_node *node)
 {
+	struct mlx5_flow_root_namespace *root_ns;
+	struct mlx5_flow_namespace *ns;
+
+	fs_get_obj(ns, node);
+	root_ns = container_of(ns, struct mlx5_flow_root_namespace, ns);
+	mutex_destroy(&root_ns->chain_lock);
 	kfree(node);
 }
 


