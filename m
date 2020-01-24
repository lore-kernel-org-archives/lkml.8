Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA54C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C83214DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579863902;
	bh=MZybGdJlM213r2t3wD1EpjiuBzvm690e2krq9nvSH0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KVx1AJ15cAp8QmTts2g2LrzRXqxcmHdz72II2fxwNP7rIit1gL+1VUChPNZ1/pHCU
	 6ExMz1zW9cNN+4sH9Ia71ssm/mP5EQc9/FKVBpEMmQGm3ROxhn3pslWC8/Le7RhUFn
	 V1biypgDhDX9QAYkP6SbHz8Ujx6tpL/eJC2EYHrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388754AbgAXLFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:05:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:39224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387981AbgAXLE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:04:59 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BD8C2071A;
        Fri, 24 Jan 2020 11:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579863898;
        bh=MZybGdJlM213r2t3wD1EpjiuBzvm690e2krq9nvSH0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=szQ2m0Uw+s+UsZYbvC0XtDa56RqRAj6keXfq+8S26VdoazcCIrO3yeNG4LYYOKxAz
         iRQkIzsGfTn52376NNHZMXfe/gwLBo4aOI7Ej7VlUEnXYnXnJDXeEK+XEW0C/1xG7L
         TB+Osq/AsgcwF0U1nrbWPm6AU0fpoXk/N2HNQmNY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 109/639] clk: vf610: fix refcount leak in vf610_clocks_init()
Date:   Fri, 24 Jan 2020 10:24:39 +0100
Message-Id: <20200124093101.002722045@linuxfoundation.org>
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



