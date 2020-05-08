Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29C0C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9B1424968
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941563;
	bh=NducT023nwiNoUlVzfNfhqduldpolUNeS4mDLwt4BWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V5e145GKP4KKwl/0BUyLwY0laQaLGIhWGn9DZV8wf/U043EH22DniYuJKbWAqyWSJ
	 v/gasJSyovcXIcfz9WxCT6yGnSx0uNNqYJcMTPjOntOX6BXyp0VTZnGoS/XUOKOyT1
	 uNTUI2Chh5/OUawq9QHavtnl78Kk4FIKXvjqazVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgEHMjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:39:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728552AbgEHMjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:39:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4653A2495F;
        Fri,  8 May 2020 12:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941548;
        bh=NducT023nwiNoUlVzfNfhqduldpolUNeS4mDLwt4BWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X8QH/JJ4UemFGebGg07mvPrpIo9XFSllLYXXNaDNQk8atYNE9jEOaQRbHSqAmHPZP
         02oBMNfjVAhSO3RaTasU9O6X95WjUHxuSQWcpZsqzHhYsglZXT4o2Fc4MPHbK+250Z
         qtL9cpFWrhpCoBp329TI6/PpzHjuXI282MYYelAs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Majd Dibbiny <majd@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 077/312] net/mlx5: Fix the size of modify QP mailbox
Date:   Fri,  8 May 2020 14:31:08 +0200
Message-Id: <20200508123129.938048967@linuxfoundation.org>
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

From: Majd Dibbiny <majd@mellanox.com>

commit 418f8399a8bedf376ec13eb01088f04a76ebdd6f upstream.

Add 16 reserved bytes at the end of mlx5_modify_qp_mbox_in to
match the hardware spec definition.

Fixes: e126ba97dba9 ('mlx5: Add driver for Mellanox Connect-IB adapters')
Signed-off-by: Majd Dibbiny <majd@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/mlx5/qp.h |    1 +
 1 file changed, 1 insertion(+)

--- a/include/linux/mlx5/qp.h
+++ b/include/linux/mlx5/qp.h
@@ -539,6 +539,7 @@ struct mlx5_modify_qp_mbox_in {
 	__be32			optparam;
 	u8			rsvd1[4];
 	struct mlx5_qp_context	ctx;
+	u8			rsvd2[16];
 };
 
 struct mlx5_modify_qp_mbox_out {


