Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB99CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CBF820575
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589364203;
	bh=x6W/Pxf4cTQTlMo1ktdLzg2nMjER+L4G8RuHBtd4C3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=awiRuXZdzH93CLm/f8/vZysA1bxINYMl9D5JyrquTCIHf4oL+0xCBbz5gcl7yop8w
	 tO2G99ntXrqxSaq5xKg6A7WYdlJHYZGE/IHfgnvK6HUfHewn/RpxOwu6CSAQMlirbW
	 09Sr7bIm1tSzdFafY7mLexcNf8oLG6xSi/GZ6c1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388570AbgEMKDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 06:03:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733189AbgEMJtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:49:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58D8720740;
        Wed, 13 May 2020 09:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363350;
        bh=x6W/Pxf4cTQTlMo1ktdLzg2nMjER+L4G8RuHBtd4C3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r84pG1olKwpQTJw8MQWKLQovAx3enYVMYtZrP22LIybvMFhgtuv5BHvOGkZbZNjcz
         1ghXjwm9CJcfYrPSK8/gu/Fzs6bU/Q51HDFuZ+eqb1M6XhfTYaMDEIE2Or/75XkuZg
         SPT41yBJJ92leD767uswHIA3pvZ7XbFq7ngU41pA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Moshe Shemesh <moshe@mellanox.com>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.4 37/90] net/mlx5: Fix forced completion access non initialized command entry
Date:   Wed, 13 May 2020 11:44:33 +0200
Message-Id: <20200513094412.490041589@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513094408.810028856@linuxfoundation.org>
References: <20200513094408.810028856@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moshe Shemesh <moshe@mellanox.com>

[ Upstream commit f3cb3cebe26ed4c8036adbd9448b372129d3c371 ]

mlx5_cmd_flush() will trigger forced completions to all valid command
entries. Triggered by an asynch event such as fast teardown it can
happen at any stage of the command, including command initialization.
It will trigger forced completion and that can lead to completion on an
uninitialized command entry.

Setting MLX5_CMD_ENT_STATE_PENDING_COMP only after command entry is
initialized will ensure force completion is treated only if command
entry is initialized.

Fixes: 73dd3a4839c1 ("net/mlx5: Avoid using pending command interface slots")
Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
Signed-off-by: Eran Ben Elisha <eranbe@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -888,7 +888,6 @@ static void cmd_work_handler(struct work
 	}
 
 	cmd->ent_arr[ent->idx] = ent;
-	set_bit(MLX5_CMD_ENT_STATE_PENDING_COMP, &ent->state);
 	lay = get_inst(cmd, ent->idx);
 	ent->lay = lay;
 	memset(lay, 0, sizeof(*lay));
@@ -910,6 +909,7 @@ static void cmd_work_handler(struct work
 
 	if (ent->callback)
 		schedule_delayed_work(&ent->cb_timeout_work, cb_timeout);
+	set_bit(MLX5_CMD_ENT_STATE_PENDING_COMP, &ent->state);
 
 	/* Skip sending command to fw if internal error */
 	if (pci_channel_offline(dev->pdev) ||


