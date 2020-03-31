Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57BDC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722EC208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645476;
	bh=8eomCZrlpS/TCs3dRXpFrmJQOARXZnLrGcwtpcnyBwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hp+aP1KLcWB1VO9P031CzeLJpY/Yd+Zw/05nXkcPRIe97nVlLLD2A43KLu/64NITb
	 hfnYthkcfkglewNhBadlD2T46xni6TMRKP2BZ7OBKuYTEnDgd67wtq/BSd/JHa+KIB
	 z5rgCT2C/+m5v2/L6RGfnkTElyu175k7UFE+ciD4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730977AbgCaJEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:04:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730965AbgCaJEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:04:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C67EB20675;
        Tue, 31 Mar 2020 09:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645470;
        bh=8eomCZrlpS/TCs3dRXpFrmJQOARXZnLrGcwtpcnyBwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SubkYtWUuVg/ndKFzhUi/iUQb3CyjMIby45qow77tLoqatZpgYFvRf0OCoVmc+gQC
         BjyZbuUW9WbXQOtOW+ChvL42y3YMGCWpT1ZQeTJBrTU0PSV+Rxz/+ytBWVchP9FTid
         4kOOtNfTO1AoCx3b376zvIAYO2yO0RDwne8rFNg0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sebastian Hense <sebastian.hense1@ibm.com>,
        Roi Dayan <roid@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 063/170] net/mlx5e: Fix endianness handling in pedit mask
Date:   Tue, 31 Mar 2020 10:57:57 +0200
Message-Id: <20200331085431.190535282@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085423.990189598@linuxfoundation.org>
References: <20200331085423.990189598@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Hense <sebastian.hense1@ibm.com>

[ Upstream commit 404402abd5f90aa90a134eb9604b1750c1941529 ]

The mask value is provided as 64 bit and has to be casted in
either 32 or 16 bit. On big endian systems the wrong half was
casted which resulted in an all zero mask.

Fixes: 2b64beba0251 ("net/mlx5e: Support header re-write of partial fields in TC pedit offload")
Signed-off-by: Sebastian Hense <sebastian.hense1@ibm.com>
Reviewed-by: Roi Dayan <roid@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -2432,10 +2432,11 @@ static int offload_pedit_fields(struct p
 			continue;
 
 		if (f->field_bsize == 32) {
-			mask_be32 = *(__be32 *)&mask;
+			mask_be32 = (__be32)mask;
 			mask = (__force unsigned long)cpu_to_le32(be32_to_cpu(mask_be32));
 		} else if (f->field_bsize == 16) {
-			mask_be16 = *(__be16 *)&mask;
+			mask_be32 = (__be32)mask;
+			mask_be16 = *(__be16 *)&mask_be32;
 			mask = (__force unsigned long)cpu_to_le16(be16_to_cpu(mask_be16));
 		}
 


