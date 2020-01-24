Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BFAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329C92087E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579859172;
	bh=xyUGEFXpyzNFtWfdd8thjkylmfAJL4ZvM6xvi4QDHHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a4WWWuGYY5pvutIZdNBYXrlmR3vRka9Jm98/x4bTGgYvgnClzy9pHxekdGUH+ysUH
	 VHc2OzWsKjuvrqfsFVAkQlxZ/3GgcSA/C3z4TACExP48j0fpEF0jnpOvWa5Qmyi7Ty
	 /ZOkOpZwU2kc07cdwqd9aL1H2A+dalKt3xHtZ89s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387498AbgAXJps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:45:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:44702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732804AbgAXJpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:45:42 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BDDF21569;
        Fri, 24 Jan 2020 09:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579859141;
        bh=xyUGEFXpyzNFtWfdd8thjkylmfAJL4ZvM6xvi4QDHHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QpuQ0xUb4OSQ2sECvmF/FixdHzWBeHObZW/RCPGPA1xfMMLuMuXDxc+QoXyuK/tvF
         pmvEOq8fsbxlXjbuqctgOZ1iNElQFh/SQxIWASQlXQFkU5nEY3D/4k29f/58XW8k1m
         tY17oH48QCftHhm1IBlveONAu2botpNEYbWpwb7Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 051/343] clk: armada-370: fix refcount leak in a370_clk_init()
Date:   Fri, 24 Jan 2020 10:27:49 +0100
Message-Id: <20200124092926.418800840@linuxfoundation.org>
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

[ Upstream commit a3c24050bdf70c958a8d98c2823b66ea761e6a31 ]

The of_find_compatible_node() returns a node pointer with refcount
incremented, but there is the lack of use of the of_node_put() when
done. Add the missing of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Fixes: 07ad6836fa21 ("clk: mvebu: armada-370: maintain clock init order")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/mvebu/armada-370.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mvebu/armada-370.c b/drivers/clk/mvebu/armada-370.c
index 2c7c1085f8830..8fdfa97900cd8 100644
--- a/drivers/clk/mvebu/armada-370.c
+++ b/drivers/clk/mvebu/armada-370.c
@@ -177,8 +177,10 @@ static void __init a370_clk_init(struct device_node *np)
 
 	mvebu_coreclk_setup(np, &a370_coreclks);
 
-	if (cgnp)
+	if (cgnp) {
 		mvebu_clk_gating_setup(cgnp, a370_gating_desc);
+		of_node_put(cgnp);
+	}
 }
 CLK_OF_DECLARE(a370_clk, "marvell,armada-370-core-clock", a370_clk_init);
 
-- 
2.20.1



