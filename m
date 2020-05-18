Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDEBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09D8920657
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589823736;
	bh=JPkpRm0BfBT5z2CG2nT7W1EMNek7CBPjCyePZ2NfKok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hFhuE+IRfcx7rEKXnMS+7fBYv3ZXNJ10NcXDgO3mwn7OOVMHaXIj4MrWsi9kO6skf
	 OQM1AXEBeq2BGyhCHTxnTLSuGlUb9n/g464/KgXOf8imNsPKaT9e1IpxAw2W5TtDzp
	 wd3tI/G3UmNsFAIkYascHxbVcq4/QwTpXehFbxgk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbgERRmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:42:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728682AbgERRmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:42:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E86F207C4;
        Mon, 18 May 2020 17:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589823722;
        bh=JPkpRm0BfBT5z2CG2nT7W1EMNek7CBPjCyePZ2NfKok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YbUNPZjiTKarqOw4dsz6b89CXC/8lq7X1mOBeZLW80188mlKvbrBFTDjzn7hIxROC
         tjUksDczJ2SVjPlbQtGwSNSwrcq7VlPgWbohfYcU+kbhJvqlRo+1FDYUhdADDB5l+q
         PUJcgs/7Dh7kiVBy1CyKX1/eHt/ZX8hc5OYhYWR8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Moshe Shemesh <moshe@mellanox.com>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.9 10/90] net/mlx5: Fix forced completion access non initialized command entry
Date:   Mon, 18 May 2020 19:35:48 +0200
Message-Id: <20200518173453.340240579@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173450.930655662@linuxfoundation.org>
References: <20200518173450.930655662@linuxfoundation.org>
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
@@ -813,7 +813,6 @@ static void cmd_work_handler(struct work
 	}
 
 	cmd->ent_arr[ent->idx] = ent;
-	set_bit(MLX5_CMD_ENT_STATE_PENDING_COMP, &ent->state);
 	lay = get_inst(cmd, ent->idx);
 	ent->lay = lay;
 	memset(lay, 0, sizeof(*lay));
@@ -835,6 +834,7 @@ static void cmd_work_handler(struct work
 
 	if (ent->callback)
 		schedule_delayed_work(&ent->cb_timeout_work, cb_timeout);
+	set_bit(MLX5_CMD_ENT_STATE_PENDING_COMP, &ent->state);
 
 	/* Skip sending command to fw if internal error */
 	if (pci_channel_offline(dev->pdev) ||


