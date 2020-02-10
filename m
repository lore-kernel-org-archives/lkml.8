Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E24CC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74FCE2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581340948;
	bh=W6R6/H9LJYmDqr1OCcfQ0aOFtqfURjgqrU8o3+YAPoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O/ThQCZqHnwZazlT3XFORv13r/fqeed9bz/yxF5O3sebEz4Pxmd6GzHT7hE66gV0D
	 IylwR9p0eJyZ9VoRHbuAIW7S7h5I7fwk0Jzxl10v+HxWQWv+C5tWrgwRtH7e94F2Kf
	 D93mJk5Uq1Ze3wboC/qRo/UnF310M6uxgWGLXlHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgBJMhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:37:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:55054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728290AbgBJMgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:36:13 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08C2C20661;
        Mon, 10 Feb 2020 12:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338173;
        bh=W6R6/H9LJYmDqr1OCcfQ0aOFtqfURjgqrU8o3+YAPoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yegZ1igZbiXxSFKLvhVPQGb2dOXfHmN1b6dQ8B2cTaN4EHPb31mRyorRZFHXEsTdM
         09YeETV6jHGHr9SNgz5ey6L/Uglej5E9C3Su/BKVBu9k3ClAm74UR6uj566zTC1k+s
         vMZ2ehGKlYFFzItjOeEEnpu8n5x1thV8Ks61xYqQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Prabhath Sajeepa <psajeepa@purestorage.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.19 157/195] IB/mlx5: Fix outstanding_pi index for GSI qps
Date:   Mon, 10 Feb 2020 04:33:35 -0800
Message-Id: <20200210122320.696641480@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122305.731206734@linuxfoundation.org>
References: <20200210122305.731206734@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Prabhath Sajeepa <psajeepa@purestorage.com>

commit b5671afe5e39ed71e94eae788bacdcceec69db09 upstream.

Commit b0ffeb537f3a ("IB/mlx5: Fix iteration overrun in GSI qps") changed
the way outstanding WRs are tracked for the GSI QP. But the fix did not
cover the case when a call to ib_post_send() fails and updates index to
track outstanding.

Since the prior commmit outstanding_pi should not be bounded otherwise the
loop generate_completions() will fail.

Fixes: b0ffeb537f3a ("IB/mlx5: Fix iteration overrun in GSI qps")
Link: https://lore.kernel.org/r/1576195889-23527-1-git-send-email-psajeepa@purestorage.com
Signed-off-by: Prabhath Sajeepa <psajeepa@purestorage.com>
Acked-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/mlx5/gsi.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/infiniband/hw/mlx5/gsi.c
+++ b/drivers/infiniband/hw/mlx5/gsi.c
@@ -507,8 +507,7 @@ int mlx5_ib_gsi_post_send(struct ib_qp *
 		ret = ib_post_send(tx_qp, &cur_wr.wr, bad_wr);
 		if (ret) {
 			/* Undo the effect of adding the outstanding wr */
-			gsi->outstanding_pi = (gsi->outstanding_pi - 1) %
-					      gsi->cap.max_send_wr;
+			gsi->outstanding_pi--;
 			goto err;
 		}
 		spin_unlock_irqrestore(&gsi->lock, flags);


