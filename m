Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F0EC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFC1B24968
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941654;
	bh=uyUtCCfEOMXx/HM8+s2jNeNjGzgsriRXI766PY6HXD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CXjoUK0MFlRpAx6fNjTg2cwWcJ0KtlLBBCECLZAiMQi2Wmcr7E5ZdG9sIi65M693U
	 UcErHm/KWNonlsRhQqAzJcvi9vFKagOHebMk2rhxWyPcyuryW2nkSOTNPeEK2S3OdJ
	 XFwePQ2gBZGTPJzA07Sx+oBac28bPn3VE2E6kJK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgEHMkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:40:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728692AbgEHMkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:40:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E785A21835;
        Fri,  8 May 2020 12:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941623;
        bh=uyUtCCfEOMXx/HM8+s2jNeNjGzgsriRXI766PY6HXD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wr8T5T/WUnHap52ZRdCWxzlpgYtkpr5/b3x1eV3Y8CfDTdFFOnoHRlOLv9xuCvWo1
         55ovk8bZmQBetc2s+OgX6yscyIxRDvAxl0MWYZsK7zye+Z/Y7RYSBD1EyB6U06Sp1W
         FY+Ku+tC45Uam9v8zjuGMKzm9P5nhByqcT+35cTw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matan Barak <matanb@mellanox.com>,
        Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.4 066/312] IB/mlx4: Initialize hop_limit when creating address handle
Date:   Fri,  8 May 2020 14:30:57 +0200
Message-Id: <20200508123129.195324355@linuxfoundation.org>
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

From: Matan Barak <matanb@mellanox.com>

commit 4e4081673445485aa6bc90383bdb83e7a96cc48a upstream.

Hop limit value wasn't copied from attributes  when ah was created.
This may influence packets for unconnected services to get dropped in
routers when endpoints are not in the same subnet.

Fixes: fa417f7b520e ("IB/mlx4: Add support for IBoE")
Signed-off-by: Matan Barak <matanb@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/mlx4/ah.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/infiniband/hw/mlx4/ah.c
+++ b/drivers/infiniband/hw/mlx4/ah.c
@@ -107,6 +107,7 @@ static struct ib_ah *create_iboe_ah(stru
 		return ERR_PTR(ret);
 	ah->av.eth.gid_index = ret;
 	ah->av.eth.vlan = cpu_to_be16(vlan_tag);
+	ah->av.eth.hop_limit = ah_attr->grh.hop_limit;
 	if (ah_attr->static_rate) {
 		ah->av.eth.stat_rate = ah_attr->static_rate + MLX4_STAT_RATE_OFFSET;
 		while (ah->av.eth.stat_rate > IB_RATE_2_5_GBPS + MLX4_STAT_RATE_OFFSET &&


