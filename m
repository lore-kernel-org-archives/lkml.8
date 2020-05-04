Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA727C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B52402073E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588615435;
	bh=dqmjn3h/I4Fn6vVblAKNtJS0ofNa5xg52qIQQiEYaHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FOCKuqIGmIxfh0JCPMHIXUw+SPTa2H2U8pesObbt7kxJddh2K7Bus3zq9nKTenXkw
	 qRh+wfoRaoLEZbwZXLkTx35JIaWVVqRDB55iDAlZiNGGxdlhvBA0pkbVf2tqPlCWwW
	 9Ib4Avqjf5Sj1YLN4AVf4XpebmoIXi5QKfHx8nMc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731027AbgEDSDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:03:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:32960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731567AbgEDSDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:03:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF9A9206B8;
        Mon,  4 May 2020 18:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615430;
        bh=dqmjn3h/I4Fn6vVblAKNtJS0ofNa5xg52qIQQiEYaHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2IlWL12/LoSUkNbkyXJU6xpIwOAvd8ItDT1DLQNwwONzR0IhW6XDcLE6P5+GvsvKP
         V92NREiQHPE0IOhF2nsGX8JInOeo45b+JACriPpgiMA1vXjRRAIVEwnJdk7hVOSIbo
         DLrKXhDVFZgbSmess//mGJoSJvk/XYPZ2wn2iTJA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aharon Landau <aharonl@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 5.4 36/57] RDMA/mlx5: Set GRH fields in query QP on RoCE
Date:   Mon,  4 May 2020 19:57:40 +0200
Message-Id: <20200504165459.478026078@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165456.783676004@linuxfoundation.org>
References: <20200504165456.783676004@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aharon Landau <aharonl@mellanox.com>

commit 2d7e3ff7b6f2c614eb21d0dc348957a47eaffb57 upstream.

GRH fields such as sgid_index, hop limit, et. are set in the QP context
when QP is created/modified.

Currently, when query QP is performed, we fill the GRH fields only if the
GRH bit is set in the QP context, but this bit is not set for RoCE. Adjust
the check so we will set all relevant data for the RoCE too.

Since this data is returned to userspace, the below is an ABI regression.

Fixes: d8966fcd4c25 ("IB/core: Use rdma_ah_attr accessor functions")
Link: https://lore.kernel.org/r/20200413132028.930109-1-leon@kernel.org
Signed-off-by: Aharon Landau <aharonl@mellanox.com>
Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/mlx5/qp.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -5496,7 +5496,9 @@ static void to_rdma_ah_attr(struct mlx5_
 	rdma_ah_set_path_bits(ah_attr, path->grh_mlid & 0x7f);
 	rdma_ah_set_static_rate(ah_attr,
 				path->static_rate ? path->static_rate - 5 : 0);
-	if (path->grh_mlid & (1 << 7)) {
+
+	if (path->grh_mlid & (1 << 7) ||
+	    ah_attr->type == RDMA_AH_ATTR_TYPE_ROCE) {
 		u32 tc_fl = be32_to_cpu(path->tclass_flowlabel);
 
 		rdma_ah_set_grh(ah_attr, NULL,


