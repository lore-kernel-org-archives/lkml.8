Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CE2C2D0FD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DEE320575
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589363964;
	bh=EnnBG/aX6Kg6Mk78SEPquxSEbjde6dpFg9+8Mqr0Sik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v4+vXeL2iPy/d7i3cQsk8UoBMkxu45Wq2XQAaVKmiOASnkO473/GReu5DcTmK5Kvu
	 +ImMtA0nyB6O19es0mmLU/taJmZlYUnHmNkxNUhM0zSm9QOt1ZYqR/Vw7FYPVZCPpo
	 XWWAYnIfdx2tK6uoCOpdX0QF+WEFaZjHjMSBhfE0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387961AbgEMJxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:53:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:55422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732590AbgEMJxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:53:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D68C2312A;
        Wed, 13 May 2020 09:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363604;
        bh=EnnBG/aX6Kg6Mk78SEPquxSEbjde6dpFg9+8Mqr0Sik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IvQ3aA2+YBUt8wkzZWP6i0SGWhzM6snfYvRZrxs9Zw9CrYBm9bTe+ToJGVXjAALOx
         pPz6tk2XuTyM7o2s32ENnk0Iw7J3dVpW3DDI/CpXSTIxLRlEoByDt2CuIdMMaXc7NP
         4QFBRuivNiFKwbjFbZRTcgbWWsyxRuQdfUj7ffvk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.6 051/118] net: mvpp2: cls: Prevent buffer overflow in mvpp2_ethtool_cls_rule_del()
Date:   Wed, 13 May 2020 11:44:30 +0200
Message-Id: <20200513094421.611319013@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513094417.618129545@linuxfoundation.org>
References: <20200513094417.618129545@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 722c0f00d4feea77475a5dc943b53d60824a1e4e ]

The "info->fs.location" is a u32 that comes from the user via the
ethtool_set_rxnfc() function.  We need to check for invalid values to
prevent a buffer overflow.

I copy and pasted this check from the mvpp2_ethtool_cls_rule_ins()
function.

Fixes: 90b509b39ac9 ("net: mvpp2: cls: Add Classification offload support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
@@ -1422,6 +1422,9 @@ int mvpp2_ethtool_cls_rule_del(struct mv
 	struct mvpp2_ethtool_fs *efs;
 	int ret;
 
+	if (info->fs.location >= MVPP2_N_RFS_ENTRIES_PER_FLOW)
+		return -EINVAL;
+
 	efs = port->rfs_rules[info->fs.location];
 	if (!efs)
 		return -EINVAL;


