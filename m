Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B42DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44EDD20709
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579860440;
	bh=TLgWLGJMPFxhpU4L2M6WpUEC5qQvnZZ6/x12ux/rXxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N0xIlaJlUyttTcY3jOVEiS9ZFiTMN1KgfxUTphVb7tPN8clptiCQIZn0Yqj1OtJhL
	 ONXTUSQu2zw1VmYaFBiQbAC0iEq4q6ioDdGhmhUbVaPO9ZUJvcwX7PJdM4tdl5mbHH
	 rrGQTpxySbOl4Ttnn8orgO6G0aEMLlV8G9BCcecQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389366AbgAXKHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 05:07:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:43808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730766AbgAXKHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 05:07:17 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0559206F0;
        Fri, 24 Jan 2020 10:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579860437;
        bh=TLgWLGJMPFxhpU4L2M6WpUEC5qQvnZZ6/x12ux/rXxM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CzhqKuBlqJ+sT4qfM0VNAX5CkyyybzgUzbfjsQ1yJhvNSYvIPLIlv85jUo/ycX4P+
         TGLzGptcWWQiMFpvtdlz/uPnXc8ZeybuUTK97p2oMI8fI9s/N5tjDoRsLP7eKYIAkN
         008zdBlnf8FIKNvo4Lcu4ecDO6PCxMVX81wMmQIw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 313/343] of: mdio: Fix a signedness bug in of_phy_get_and_connect()
Date:   Fri, 24 Jan 2020 10:32:11 +0100
Message-Id: <20200124093001.050336079@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
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
index 8c1819230ed23..fe26697d3bd72 100644
--- a/drivers/of/of_mdio.c
+++ b/drivers/of/of_mdio.c
@@ -358,7 +358,7 @@ struct phy_device *of_phy_get_and_connect(struct net_device *dev,
 	struct phy_device *phy;
 
 	iface = of_get_phy_mode(np);
-	if (iface < 0)
+	if ((int)iface < 0)
 		return NULL;
 
 	phy_np = of_parse_phandle(np, "phy-handle", 0);
-- 
2.20.1



