Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75855C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4173B2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579863890;
	bh=alnITvoaT/S+HF+A2nMwqwF3MdOxhC+4VAb+/JbW5U8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xRE86c9aU7mwMviOSUCYrPrq0cYeErXSi8ytSKDEYe+M7T2xWUh2qFCLgadKVLqa+
	 X9UM+NVLrwzKvaBvRbuDEuuNXTxSp+6g5wET/tn1YwYa73d4zu5W8nuy2KNmdyHrpA
	 IDGkBs0hfGb+xLdoeQnWMbCmDkSVjOgCXdLp9PrE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387834AbgAXLEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:04:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:38954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388223AbgAXLEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:04:45 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95F4D20838;
        Fri, 24 Jan 2020 11:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579863885;
        bh=alnITvoaT/S+HF+A2nMwqwF3MdOxhC+4VAb+/JbW5U8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ywjx/JcKzEVI+g2Z+I6Mc70bm1MzkrHQFb7JSuMZT8ay++8gnTV9SoGHnrI2A7BLY
         MNrILTt6WoQfUzcQLu4JC/irDv1j9lzPEdJcfGzYFjVD/fNMCvhu5jejCRDpWGZA2o
         KsZsJC0L7dJCvpJvTO1REKhUd+LSPy/kk/H5FXbQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 101/639] clk: highbank: fix refcount leak in hb_clk_init()
Date:   Fri, 24 Jan 2020 10:24:31 +0100
Message-Id: <20200124093100.013834151@linuxfoundation.org>
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

[ Upstream commit 5eb8ba90958de1285120dae5d3a5d2b1a360b3b4 ]

The of_find_compatible_node() returns a node pointer with refcount
incremented, but there is the lack of use of the of_node_put() when
done. Add the missing of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Fixes: 26cae166cff9 ("ARM: highbank: remove custom .init_time hook")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-highbank.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-highbank.c b/drivers/clk/clk-highbank.c
index 727ed8e1bb726..8e4581004695c 100644
--- a/drivers/clk/clk-highbank.c
+++ b/drivers/clk/clk-highbank.c
@@ -293,6 +293,7 @@ static __init struct clk *hb_clk_init(struct device_node *node, const struct clk
 	/* Map system registers */
 	srnp = of_find_compatible_node(NULL, NULL, "calxeda,hb-sregs");
 	hb_clk->reg = of_iomap(srnp, 0);
+	of_node_put(srnp);
 	BUG_ON(!hb_clk->reg);
 	hb_clk->reg += reg;
 
-- 
2.20.1



