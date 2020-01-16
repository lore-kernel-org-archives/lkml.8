Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961E0C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD81206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579201303;
	bh=4Pp4UyDFYiG/ROGt91fvWF9zDwzdijE459rGVCPFR4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yh5fO0mRxSahS5ZSLkAkWEIaU8nTK6/xUX0vSSfZgWYglzOW5Z21e/lPkDvvlFLL2
	 W8NbxyvHY2yt/nmDotnS1Ay+E+ujWqOKZlCAKziTSxceZ01ga1SrWKyB4YbgRv36dt
	 minMlJ70NQMNqoVAu4zrRDZfAIFUBEYaHKE7p7pU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388749AbgAPRFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:05:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:34478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388552AbgAPRFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:05:34 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D413820730;
        Thu, 16 Jan 2020 17:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194333;
        bh=4Pp4UyDFYiG/ROGt91fvWF9zDwzdijE459rGVCPFR4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OULyfUDEeUY8Bx97kTiQO6oZ3yZuoYJBfOA4zAOczvXf8L/4mfe+WNgkLLAzMpZFu
         fPzm+xB1c25vSIwOnsC0XiaT3hPeZCmw5tzzjIHQBc4pqCLrMX7tfvEva8hC+mTexA
         riwvnL7dbIQVqAWMReBmiNZ/06ZrLfaBJ0Me2s7o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 279/671] ehea: Fix a copy-paste err in ehea_init_port_res
Date:   Thu, 16 Jan 2020 11:58:37 -0500
Message-Id: <20200116170509.12787-16-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit c8f191282f819ab4e9b47b22a65c6c29734cefce ]

pr->tx_bytes should be assigned to tx_bytes other than
rx_bytes.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: ce45b873028f ("ehea: Fixing statistics")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ibm/ehea/ehea_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ehea/ehea_main.c b/drivers/net/ethernet/ibm/ehea/ehea_main.c
index e8ee69d4e4d3..0f799e8e093c 100644
--- a/drivers/net/ethernet/ibm/ehea/ehea_main.c
+++ b/drivers/net/ethernet/ibm/ehea/ehea_main.c
@@ -1464,7 +1464,7 @@ static int ehea_init_port_res(struct ehea_port *port, struct ehea_port_res *pr,
 
 	memset(pr, 0, sizeof(struct ehea_port_res));
 
-	pr->tx_bytes = rx_bytes;
+	pr->tx_bytes = tx_bytes;
 	pr->tx_packets = tx_packets;
 	pr->rx_bytes = rx_bytes;
 	pr->rx_packets = rx_packets;
-- 
2.20.1

