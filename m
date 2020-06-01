Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7148AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44B9E2077D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591034867;
	bh=OWscbb58LV3wYU2t0kpPZcQFKkJCIC9E+3xuGSvNeqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1DLZE2hV8sSzQhkzaw0T0csKxAFDjrH/QonD3GehhqJBx7wzXc+nPpUK+ZGwfw+JK
	 Q8GH8oFLU+4zR9zfMtBOTQogY1njomqF5AKXv338is8WgYR9csfA8HXI8VA+GU2L4r
	 jttZVMKoRJWNpFkeMkKK8j7/pq2jvjTD798eeM6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbgFASHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:07:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:52882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729801AbgFASHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:07:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FC6D2068D;
        Mon,  1 Jun 2020 18:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034824;
        bh=OWscbb58LV3wYU2t0kpPZcQFKkJCIC9E+3xuGSvNeqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GLdWq50xnqdNmGMPcXMzHSlTvYWz8D8+/Gp8ttVE+2cTLL8laczVrMW8mHJ7IUVgW
         SmY7SftryYBYtPc74E9ELlpjd8wiDTGQiYqnZuuBXSujdCDeLpmyX/Ul3eypBqirs6
         4FZaemNAFh5RHuDhwap/ji4ZvOzgsOFAbeTM9ILI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 030/142] net/mlx4_core: fix a memory leak bug.
Date:   Mon,  1 Jun 2020 19:53:08 +0200
Message-Id: <20200601174041.020658881@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174037.904070960@linuxfoundation.org>
References: <20200601174037.904070960@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

commit febfd9d3c7f74063e8e630b15413ca91b567f963 upstream.

In function mlx4_opreq_action(), pointer "mailbox" is not released,
when mlx4_cmd_box() return and error, causing a memory leak bug.
Fix this issue by going to "out" label, mlx4_free_cmd_mailbox() can
free this pointer.

Fixes: fe6f700d6cbb ("net/mlx4_core: Respond to operation request by firmware")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/mellanox/mlx4/fw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx4/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx4/fw.c
@@ -2734,7 +2734,7 @@ void mlx4_opreq_action(struct work_struc
 		if (err) {
 			mlx4_err(dev, "Failed to retrieve required operation: %d\n",
 				 err);
-			return;
+			goto out;
 		}
 		MLX4_GET(modifier, outbox, GET_OP_REQ_MODIFIER_OFFSET);
 		MLX4_GET(token, outbox, GET_OP_REQ_TOKEN_OFFSET);


