Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35784C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 038E020823
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591725275;
	bh=Nm6Enj1yAA/to0vIuhmN9PTYANqMr4oTBzNdJPmi7wI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Quh8K7NOdqgYxCiwH8HtJw1KACRuI3T9Gbx2xEdWACngSIu5h5hA6y8BH4QCfHmZt
	 mn1I6jpH3y+ufa/YMvjnyg6WvzDBEe9nGuspb9IP5Kj3xN440oZ8aTNCjNz0G4Tq+6
	 KFlpOdSSxBD1ra1FqA9cbbuFUQ5RY7hcRH16EpG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733111AbgFIRyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:54:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732957AbgFIRw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:52:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54D33207C3;
        Tue,  9 Jun 2020 17:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591725178;
        bh=Nm6Enj1yAA/to0vIuhmN9PTYANqMr4oTBzNdJPmi7wI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CWOJ7bREQH891tgca68yKghTqbUBg3R3OK2eU00Fzm7jGU1Ztnw+t9zZWIYaZ7sbh
         y/65KW4LwHbc8zK2jSduYzZ3bf+v7/CfUOSplq7Yz23wv2iaeF0aGhI1HSbLuVlrZ/
         igRQLAcNjL4/9J2QxC8JkOc88Dycgf5a4Sem9CAQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Roi Dayan <roid@mellanox.com>, Mark Bloch <markb@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.4 34/34] Revert "net/mlx5: Annotate mutex destroy for root ns"
Date:   Tue,  9 Jun 2020 19:45:30 +0200
Message-Id: <20200609174058.653317561@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609174052.628006868@linuxfoundation.org>
References: <20200609174052.628006868@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 3f4f034a8676e366857861e76c3ad11ae059b2fb which is
commit 9ca415399dae133b00273a4283ef31d003a6818d upstream.

It was backported incorrectly, Paul writes at:
	https://lore.kernel.org/r/20200607203425.GD23662@windriver.com

	I happened to notice this commit:

	9ca415399dae - "net/mlx5: Annotate mutex destroy for root ns"

	...was backported to 4.19 and 5.4 and v5.6 in linux-stable.

	It patches del_sw_root_ns() - which only exists after v5.7-rc7 from:

	6eb7a268a99b - "net/mlx5: Don't maintain a case of del_sw_func being
	null"

	which creates the one line del_sw_root_ns stub function around
	kfree(node) by breaking it out of tree_put_node().

	In the absense of del_sw_root_ns - the backport finds an identical one
	line kfree stub fcn - named del_sw_prio from this earlier commit:

	139ed6c6c46a - "net/mlx5: Fix steering memory leak"  [in v4.15-rc5]

	and then puts the mutex_destroy() into that (wrong) function, instead of
	putting it into tree_put_node where the root ns case used to be hand

Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Roi Dayan <roid@mellanox.com>
Cc: Mark Bloch <markb@mellanox.com>
Cc: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c |    6 ------
 1 file changed, 6 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -417,12 +417,6 @@ static void del_sw_ns(struct fs_node *no
 
 static void del_sw_prio(struct fs_node *node)
 {
-	struct mlx5_flow_root_namespace *root_ns;
-	struct mlx5_flow_namespace *ns;
-
-	fs_get_obj(ns, node);
-	root_ns = container_of(ns, struct mlx5_flow_root_namespace, ns);
-	mutex_destroy(&root_ns->chain_lock);
 	kfree(node);
 }
 


