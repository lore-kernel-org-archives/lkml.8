Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97EEC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1681218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579859143;
	bh=MZybGdJlM213r2t3wD1EpjiuBzvm690e2krq9nvSH0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EaKTKNO9LuhwmavTIBsFzSWzr/Svp3idnJi5HZs598fqavTIwKRrWxvBPHQGnZpg2
	 qv43nDMKCwzGAzNgdaWl+DSqKxUjSkeGcJ6N3HqV1LyMHkORxn2UDN6zKK4wZQH0n9
	 1lTEKC03lqax/pbvuesDWJvMjfZgv4HW9JSeQqxA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387480AbgAXJpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:45:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:44610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730712AbgAXJpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:45:38 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F19B21569;
        Fri, 24 Jan 2020 09:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579859138;
        bh=MZybGdJlM213r2t3wD1EpjiuBzvm690e2krq9nvSH0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vNe1D5lydpcO0XcDh6AQjhQ9WcS1MjIW32cOMrF85VRZr+bivIkQW4Rz7IOEnUYas
         Vgplm5y2Vqky2xadz3+2USwrsB3iSQcZLFbLhVptWBxUEgDgiM0N7N8WEe1f5w7kbp
         xDv5SUiHcmjiNYVgw6Eau6RpOtLlyAo7Tplg91kM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 050/343] clk: vf610: fix refcount leak in vf610_clocks_init()
Date:   Fri, 24 Jan 2020 10:27:48 +0100
Message-Id: <20200124092926.302712968@linuxfoundation.org>
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

From: Yangtao Li <tiny.windzz@gmail.com>

[ Upstream commit 567177024e0313e4f0dcba7ba10c0732e50e655d ]

The of_find_compatible_node() returns a node pointer with refcount
incremented, but there is the lack of use of the of_node_put() when
done. Add the missing of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Fixes: 1f2c5fd5f048 ("ARM: imx: add VF610 clock support")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/clk-vf610.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-vf610.c b/drivers/clk/imx/clk-vf610.c
index 6dae54325a91d..a334667c450a1 100644
--- a/drivers/clk/imx/clk-vf610.c
+++ b/drivers/clk/imx/clk-vf610.c
@@ -203,6 +203,7 @@ static void __init vf610_clocks_init(struct device_node *ccm_node)
 	np = of_find_compatible_node(NULL, NULL, "fsl,vf610-anatop");
 	anatop_base = of_iomap(np, 0);
 	BUG_ON(!anatop_base);
+	of_node_put(np);
 
 	np = ccm_node;
 	ccm_base = of_iomap(np, 0);
-- 
2.20.1



