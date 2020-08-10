Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D3EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73A9923134
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597073931;
	bh=9MYJ4viWV0IEtWiX47EV+1kFx/B6YnfEQUrVtqU1GEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K7jE/Dzyz7ivPmExuXAqj1/N0TAiTdAwE5rCBh9wgKdnrv/Y8MTaEqypdXgD4dcqg
	 v3NXzVE+rwDRtVP5GeI95YCPSG1WJBSPO/YpSnoW63T64ZT2uN3F3a9au8pCXM9NwO
	 HwG+uyA2ZtBIe0tOhScMfb9175SiYhIM1tXFeP+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgHJPZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:25:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728506AbgHJPZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:25:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D2EB20772;
        Mon, 10 Aug 2020 15:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597073117;
        bh=9MYJ4viWV0IEtWiX47EV+1kFx/B6YnfEQUrVtqU1GEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K1x7tyvkWLzJ6ugYPUnIG378mc2vHt0W572RIDJxUk1cEJJzrJrJlFvC1C9B0R4F2
         Ohj3chpIBJk/uT4ldHzUIKhO3akVzpuKleFDaURY+ZTEzKdpy24YkZEQmhNMJqJJQc
         IhfRLPAohMKvDG1WT0DIHGKr7jaDAt6f46koYpU0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Alain Volmat <alain.volmat@st.com>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 42/79] i2c: slave: improve sanity check when registering
Date:   Mon, 10 Aug 2020 17:21:01 +0200
Message-Id: <20200810151814.351579726@linuxfoundation.org>
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

[ Upstream commit 1b1be3bf27b62f5abcf85c6f3214bdb9c7526685 ]

Add check for ERR_PTR and simplify code while here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Alain Volmat <alain.volmat@st.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-slave.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-core-slave.c b/drivers/i2c/i2c-core-slave.c
index 5427f047faf06..549751347e6c7 100644
--- a/drivers/i2c/i2c-core-slave.c
+++ b/drivers/i2c/i2c-core-slave.c
@@ -18,10 +18,8 @@ int i2c_slave_register(struct i2c_client *client, i2c_slave_cb_t slave_cb)
 {
 	int ret;
 
-	if (!client || !slave_cb) {
-		WARN(1, "insufficient data\n");
+	if (WARN(IS_ERR_OR_NULL(client) || !slave_cb, "insufficient data\n"))
 		return -EINVAL;
-	}
 
 	if (!(client->flags & I2C_CLIENT_SLAVE))
 		dev_warn(&client->dev, "%s: client slave flag not set. You might see address collisions\n",
-- 
2.25.1



