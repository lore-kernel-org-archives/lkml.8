Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BCBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D48F920835
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824025;
	bh=IFCeppPC26RAzOEVU6L8uY75dIAak+crugsixldxpko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TFKxUKzPk80ShR55FNTtxK2jhIVf+1hwwCSsrbAzBzzNklkNLl3wfhA3b3guwBygP
	 9mYhCmvqJPwkqWAbJhIKaz+H1WzeQwsBK4txXpRJM46YBM7nD1HDg0SD6Sn4pga6gE
	 PksxlctjVjaVmvreGvretc1IMuPA3JspvQeaph+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbgERRrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:47:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730168AbgERRrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:47:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE38B20671;
        Mon, 18 May 2020 17:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824021;
        bh=IFCeppPC26RAzOEVU6L8uY75dIAak+crugsixldxpko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CSQxeD3CMCdqJ0NilANcRiQy2OMF6eXpvkIDcYJxWZL+HNSgPBmPxU7TUbrlnRZU/
         ytCfEIm2/8Ftf8llhAeKr9xybkL2mpC4xAjqrOSjl0v7ucWuCtCzngqLzQjLurfEv6
         0EI7HPy7siIyXC0QKI+Q5ndk0SYhhN7k9ybyJam4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 005/114] net/mlx4_core: Fix use of ENOSPC around mlx4_counter_alloc()
Date:   Mon, 18 May 2020 19:35:37 +0200
Message-Id: <20200518173504.087563815@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173503.033975649@linuxfoundation.org>
References: <20200518173503.033975649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tariq Toukan <tariqt@mellanox.com>

[ Upstream commit 40e473071dbad04316ddc3613c3a3d1c75458299 ]

When ENOSPC is set the idx is still valid and gets set to the global
MLX4_SINK_COUNTER_INDEX.  However gcc's static analysis cannot tell that
ENOSPC is impossible from mlx4_cmd_imm() and gives this warning:

drivers/net/ethernet/mellanox/mlx4/main.c:2552:28: warning: 'idx' may be
used uninitialized in this function [-Wmaybe-uninitialized]
 2552 |    priv->def_counter[port] = idx;

Also, when ENOSPC is returned mlx4_allocate_default_counters should not
fail.

Fixes: 6de5f7f6a1fa ("net/mlx4_core: Allocate default counter per port")
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx4/main.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx4/main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/main.c
@@ -2503,6 +2503,7 @@ static int mlx4_allocate_default_counter
 
 		if (!err || err == -ENOSPC) {
 			priv->def_counter[port] = idx;
+			err = 0;
 		} else if (err == -ENOENT) {
 			err = 0;
 			continue;
@@ -2553,7 +2554,8 @@ int mlx4_counter_alloc(struct mlx4_dev *
 				   MLX4_CMD_TIME_CLASS_A, MLX4_CMD_WRAPPED);
 		if (!err)
 			*idx = get_param_l(&out_param);
-
+		if (WARN_ON(err == -ENOSPC))
+			err = -EINVAL;
 		return err;
 	}
 	return __mlx4_counter_alloc(dev, idx);


