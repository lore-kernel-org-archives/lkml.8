Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE454C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C506F20838
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865650;
	bh=hCci7xL188rP8q58jiWbyf8ua8a7lzyy8rDNwkk9cXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2AgCGRrwWHn9hH+bj8WVjE3w/8rJTYIbeIE4VyI278CV8EeOIbxGzB73Zkq8iFGUX
	 gJZ4fsV6BJQ1aZSV7lRdH2CHR5mLamd7W1jE/jTiRxdbU4/gMk649Vfzta2kXdKEzf
	 Q+OhyJUAIdRwwXChxA05T4EVVnSpmG7OZDmVLzWU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404690AbgAXLeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:34:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:53922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404680AbgAXLeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:34:05 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBFB9206D4;
        Fri, 24 Jan 2020 11:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865645;
        bh=hCci7xL188rP8q58jiWbyf8ua8a7lzyy8rDNwkk9cXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hkUw9YhfronqWyx/yeChn9P54Pt8l4k5NaU+tNXdC0DcPqA3M5sPmtNNQJSQv4E1y
         SIce2g44p/d2cEgD5LFM9RRR1hCTY8psAjNC8Dqw9p/oJqFA37XE75YmWrKdODnA8T
         Zbq9hAgka+CSVusJHJ99pS9SAXgRfqyd0ywcKYBE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 582/639] of: mdio: Fix a signedness bug in of_phy_get_and_connect()
Date:   Fri, 24 Jan 2020 10:32:32 +0100
Message-Id: <20200124093202.379677585@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit d7eb651212fdbafa82d485d8e76095ac3b14c193 ]

The "iface" variable is an enum and in this context GCC treats it as
an unsigned int so the error handling is never triggered.

Fixes: b78624125304 ("of_mdio: Abstract a general interface for phy connect")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/of_mdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
index 5ad1342f56825..7d2bc22680d90 100644
--- a/drivers/of/of_mdio.c
+++ b/drivers/of/of_mdio.c
@@ -370,7 +370,7 @@ struct phy_device *of_phy_get_and_connect(struct net_device *dev,
 	int ret;
 
 	iface = of_get_phy_mode(np);
-	if (iface < 0)
+	if ((int)iface < 0)
 		return NULL;
 	if (of_phy_is_fixed_link(np)) {
 		ret = of_phy_register_fixed_link(np);
-- 
2.20.1



