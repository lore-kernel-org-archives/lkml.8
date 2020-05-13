Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF24DCA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A17FF20575
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589364339;
	bh=BiQugPHdeVjEUkzmuQEKUIIb0sy0sQVRp6LCcQaiv1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LWhivDEPb+TqsBrSQDIr5kKdE8ENFAAkbaRbllVZK+Gxs/G4DMqIWlm/rTCep2/RC
	 0uFw3jEthc+72QJ26Gy6DkqjLI8vX9BBEMYpZzcv9khzuH4hWcdsbPmFobDJNL4tS0
	 J/wgiidYSazVGhX6EdaQWOk4/FWpYCrJRtViC5R0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387578AbgEMKFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 06:05:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732589AbgEMJqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:46:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 147E820753;
        Wed, 13 May 2020 09:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363171;
        bh=BiQugPHdeVjEUkzmuQEKUIIb0sy0sQVRp6LCcQaiv1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eNRszdIJVZNjnp2fDXDq8ULE8jlFC2Z4VbWnlz0RiLGdJms/uxFArcqOvvHLXsqSh
         BiP/oDtbAUOGj/1WgrwWmoHPsRaChBLCsMn03GaVUUAaMTiuhRysMJn2ce2V23LaaD
         KKIZvUCYeB9n+7rqTjh8UcdMy2DGaibmRXLXLgoc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Moshe Shemesh <moshe@mellanox.com>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.19 15/48] net/mlx5: Fix command entry leak in Internal Error State
Date:   Wed, 13 May 2020 11:44:41 +0200
Message-Id: <20200513094355.175804017@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513094351.100352960@linuxfoundation.org>
References: <20200513094351.100352960@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moshe Shemesh <moshe@mellanox.com>

[ Upstream commit cece6f432cca9f18900463ed01b97a152a03600a ]

Processing commands by cmd_work_handler() while already in Internal
Error State will result in entry leak, since the handler process force
completion without doorbell. Forced completion doesn't release the entry
and event completion will never arrive, so entry should be released.

Fixes: 73dd3a4839c1 ("net/mlx5: Avoid using pending command interface slots")
Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
Signed-off-by: Eran Ben Elisha <eranbe@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -896,6 +896,10 @@ static void cmd_work_handler(struct work
 		MLX5_SET(mbox_out, ent->out, syndrome, drv_synd);
 
 		mlx5_cmd_comp_handler(dev, 1UL << ent->idx, true);
+		/* no doorbell, no need to keep the entry */
+		free_ent(cmd, ent->idx);
+		if (ent->callback)
+			free_cmd(ent);
 		return;
 	}
 


