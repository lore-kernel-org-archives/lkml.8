Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91740C43332
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4FE20658
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584624507;
	bh=fRKNYWaBySuvyK4678K2jvcjErVEbPDR7akhgQ08bno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m900QVdcfPC3MrJNYWAbtSrtQxqI3GSHmRpXBgACn7AXQX5MuRozwSoP7vEAq550c
	 pujixZi4tnY3yNL14NA9TdkGyoa3K7kd8G0XVNXJX+E6IMR0l/28zFFFvXdPmD22VV
	 fsxDg+kavBx/e3E0aGyDeuwYTEhn4u6cijZSUlKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgCSN20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:28:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730020AbgCSN1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:27:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF1E420658;
        Thu, 19 Mar 2020 13:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584624432;
        bh=fRKNYWaBySuvyK4678K2jvcjErVEbPDR7akhgQ08bno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FnnQZUOPfVkQcbyJ7XK8cys8ImP3WY8+I13E49O1qTgc569p6v+D4smVqUjg80ZBd
         cjEAk3zdBM/txSgMBVqNR+q2Qm5OZdrIU0E8sU3XUDOHKfffLJoGDMLAspXt+wgjWm
         PTMg3xQm/ASkO6sQS3Gk+eXFTNF0oG6WAMTJ7SJM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 50/65] net: rmnet: do not allow to change mux id if mux id is duplicated
Date:   Thu, 19 Mar 2020 14:04:32 +0100
Message-Id: <20200319123942.069171024@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123926.466988514@linuxfoundation.org>
References: <20200319123926.466988514@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taehee Yoo <ap420073@gmail.com>

[ Upstream commit 1dc49e9d164cd7e11c81279c83db84a147e14740 ]

Basically, duplicate mux id isn't be allowed.
So, the creation of rmnet will be failed if there is duplicate mux id
is existing.
But, changelink routine doesn't check duplicate mux id.

Test commands:
    modprobe rmnet
    ip link add dummy0 type dummy
    ip link add rmnet0 link dummy0 type rmnet mux_id 1
    ip link add rmnet1 link dummy0 type rmnet mux_id 2
    ip link set rmnet1 type rmnet mux_id 1

Fixes: 23790ef12082 ("net: qualcomm: rmnet: Allow to configure flags for existing devices")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index 0ad64aa665925..3c0e6d24d0834 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -306,6 +306,10 @@ static int rmnet_changelink(struct net_device *dev, struct nlattr *tb[],
 
 	if (data[IFLA_RMNET_MUX_ID]) {
 		mux_id = nla_get_u16(data[IFLA_RMNET_MUX_ID]);
+		if (rmnet_get_endpoint(port, mux_id)) {
+			NL_SET_ERR_MSG_MOD(extack, "MUX ID already exists");
+			return -EINVAL;
+		}
 		ep = rmnet_get_endpoint(port, priv->mux_id);
 		if (!ep)
 			return -ENODEV;
-- 
2.20.1



