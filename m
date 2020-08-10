Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01313C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFDC122D6F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597073944;
	bh=gQWng/bO5oR+BA08SNco2VcnZgToS77LbevgmS+C7z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zqfg+N9STJQVJs+qnq9HXg8edQXwg1+kqHCDxoUhVpBEgi+QHZVjKHAv2UB00J6n0
	 M0vINq408/Jr8eaXVXBBkmfYDDXxyjmTjZRA085yIaIMofd23U1WUhoOSWY9TqogEn
	 Pkw95XAvSsqIoJpe6/UdE4Lfpasex0JCFbF8A7zg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbgHJPjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:39:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728515AbgHJPZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:25:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A936D2177B;
        Mon, 10 Aug 2020 15:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597073120;
        bh=gQWng/bO5oR+BA08SNco2VcnZgToS77LbevgmS+C7z4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M2MsDR/mgy+GY1zdE3fCH/e44HbUVY0B15+NvJmdHaRlIlDiH9w/LGNql2SykRLQw
         qq97XvdXQUeSshQ0XJU3KEStj9+s5El/83LEUNptBbOz35lm2XhH4D4RVX5LfV7/JJ
         LosVcbXydg40MlCPrK80fy5RKJk4zCNtcFZ9zKTE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Alain Volmat <alain.volmat@st.com>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 43/79] i2c: slave: add sanity check when unregistering
Date:   Mon, 10 Aug 2020 17:21:02 +0200
Message-Id: <20200810151814.399625446@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810151812.114485777@linuxfoundation.org>
References: <20200810151812.114485777@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit 8808981baf96e1b3dea1f08461e4d958aa0dbde1 ]

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Alain Volmat <alain.volmat@st.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-slave.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/i2c-core-slave.c b/drivers/i2c/i2c-core-slave.c
index 549751347e6c7..1589179d5eb92 100644
--- a/drivers/i2c/i2c-core-slave.c
+++ b/drivers/i2c/i2c-core-slave.c
@@ -58,6 +58,9 @@ int i2c_slave_unregister(struct i2c_client *client)
 {
 	int ret;
 
+	if (IS_ERR_OR_NULL(client))
+		return -EINVAL;
+
 	if (!client->adapter->algo->unreg_slave) {
 		dev_err(&client->dev, "%s: not supported by adapter\n", __func__);
 		return -EOPNOTSUPP;
-- 
2.25.1



