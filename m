Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB6CC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C802A206D5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587387297;
	bh=BCsMp6KmgZiVCIqWnfB2eIy61jHp4A1fOmlCIapij5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BO67y3fcIg0e7EAlY88pmO5onmH6zNsHzyhLTR1ADWs3IjbvcZqwtP8l8vCfELWlm
	 7KA9N6OJdAImlK36KBa9Tw5lTKYO0WkGTIr6Fq/1we2OmqafVA/CWfeGVLIT1yN85m
	 QcZSUs+dnmcu4Nen2ObRx/xPY8vM6c5ipFwib6xs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbgDTMqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:46:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728879AbgDTMp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:45:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A44E9206DD;
        Mon, 20 Apr 2020 12:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386758;
        bh=BCsMp6KmgZiVCIqWnfB2eIy61jHp4A1fOmlCIapij5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gM/zodchYYRAtbdcQP0nAvFXatLRF6wBdM0+GHjFTFALtobR+uSN3j3DHbqHME8c+
         IMKJBXc2TwTFTYz0qYmj4uZcVDELlYJZ9jwDsRhQO6iz0F/lghnPU1SYj94PPN6E9M
         eueWckHtNxOTIn2DAwAA16U8x+nWJERtZABSZUvM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmytro Linkin <dmitrolin@mellanox.com>,
        Roi Dayan <roid@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.4 15/60] net/mlx5e: Fix nest_level for vlan pop action
Date:   Mon, 20 Apr 2020 14:38:53 +0200
Message-Id: <20200420121505.524678777@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121500.490651540@linuxfoundation.org>
References: <20200420121500.490651540@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmytro Linkin <dmitrolin@mellanox.com>

[ Upstream commit 70f478ca085deec4d6c1f187f773f5827ddce7e8 ]

Current value of nest_level, assigned from net_device lower_level value,
does not reflect the actual number of vlan headers, needed to pop.
For ex., if we have untagged ingress traffic sended over vlan devices,
instead of one pop action, driver will perform two pop actions.
To fix that, calculate nest_level as difference between vlan device and
parent device lower_levels.

Fixes: f3b0a18bb6cb ("net: remove unnecessary variables and callback")
Signed-off-by: Dmytro Linkin <dmitrolin@mellanox.com>
Signed-off-by: Roi Dayan <roid@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -3181,12 +3181,13 @@ static int add_vlan_pop_action(struct ml
 			       struct mlx5_esw_flow_attr *attr,
 			       u32 *action)
 {
-	int nest_level = attr->parse_attr->filter_dev->lower_level;
 	struct flow_action_entry vlan_act = {
 		.id = FLOW_ACTION_VLAN_POP,
 	};
-	int err = 0;
+	int nest_level, err = 0;
 
+	nest_level = attr->parse_attr->filter_dev->lower_level -
+						priv->netdev->lower_level;
 	while (nest_level--) {
 		err = parse_tc_vlan_action(priv, &vlan_act, attr, action);
 		if (err)


