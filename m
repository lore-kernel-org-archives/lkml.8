Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70378C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A1C20842
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578738855;
	bh=2JEldexF+q/JsBqhHy+gKCiMmS+qMufmA/AodFp3BsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gb7IwrXGocFfeMICneXWs+ucAfNMW6LjTAzqSvUTC1dJHJm0FW97gjZP0YWuYLlD0
	 nyx0jAJSErISX8CB5S4JI42Q60qVY77UZsouIBGX71HtqwcJETEz9pYQwMk/pPRsk6
	 qrrzQUlHFyikld6wmSPvCCYL6UVoRRNvxUZOnvF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731674AbgAKKeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:34:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:49820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731482AbgAKKeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:34:07 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 979BB2146E;
        Sat, 11 Jan 2020 10:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578738846;
        bh=2JEldexF+q/JsBqhHy+gKCiMmS+qMufmA/AodFp3BsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yvfOBBQLVGF60u8UakzD7sfWHxHf7Vy9AXsu9BwZGb7Bt11Xv395qv/EUBh7F1XQC
         MKIOtmNMYrlbPfA5Fp6AzmQtri39gn0xe5awsAm6IOiriE7UV+JsiXtM9dvstj0lHx
         3wrrT8MpIPGPCMmZFRnoA7uBloEEiJ3wdivLAIZ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eran Ben Elisha <eranbe@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.4 158/165] net/mlx5e: Always print health reporter message to dmesg
Date:   Sat, 11 Jan 2020 10:51:17 +0100
Message-Id: <20200111094942.283510775@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094921.347491861@linuxfoundation.org>
References: <20200111094921.347491861@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eran Ben Elisha <eranbe@mellanox.com>

[ Upstream commit 99cda45426c9a2c59bb2f7cb886a405440282455 ]

In case a reporter exists, error message is logged only to the devlink
tracer. The devlink tracer is a visibility utility only, which user can
choose not to monitor.
After cited patch, 3rd party monitoring tools that tracks these error
message will no longer find them in dmesg, causing a regression.

With this patch, error messages are also logged into the dmesg.

Fixes: c50de4af1d63 ("net/mlx5e: Generalize tx reporter's functionality")
Signed-off-by: Eran Ben Elisha <eranbe@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/health.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/health.c
@@ -197,9 +197,10 @@ int mlx5e_health_report(struct mlx5e_pri
 			struct devlink_health_reporter *reporter, char *err_str,
 			struct mlx5e_err_ctx *err_ctx)
 {
-	if (!reporter) {
-		netdev_err(priv->netdev, err_str);
+	netdev_err(priv->netdev, err_str);
+
+	if (!reporter)
 		return err_ctx->recover(&err_ctx->ctx);
-	}
+
 	return devlink_health_report(reporter, err_str, err_ctx);
 }


