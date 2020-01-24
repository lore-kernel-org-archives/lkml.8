Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AEEC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0439208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579859257;
	bh=8d1nX4LAdMKqvkj0dwYAfO3ahLDhbe83T0nZz4dS5sQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xgA3/zac5Cnf2eIBm/9YjXjT9ZCUg1x03fv4sQBGkprNIUwoMecAlZukaBJCHf+pf
	 rqwwj2wiVh/oqVF2Khahb4L/kZFtRMDYBKV8bIOmet4TL/QUt4QVuUBUozes8DG/UO
	 QffBIxXAcXhZPswd4sooTUmnfIcMwCmTjDUnoh+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387652AbgAXJrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:47:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:47368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387394AbgAXJrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:47:33 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BCD120718;
        Fri, 24 Jan 2020 09:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579859253;
        bh=8d1nX4LAdMKqvkj0dwYAfO3ahLDhbe83T0nZz4dS5sQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TxZCGtDlgDvlVou0e2WKgZMBNXYvm1kqNcCnOxuyjqQrVgHvmzg5no9ZIrNsbhjfs
         1yTbamOn+0XP3yC3DmiJ/L9Li+5S831r/5HXS2NKCzqMXWtwvG4+/XtDLa5HQy8jK9
         +CTtQt5T+pdDCwAkBZNIhtlH7ib80zF82QudzZyM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 054/343] clk: mv98dx3236: fix refcount leak in mv98dx3236_clk_init()
Date:   Fri, 24 Jan 2020 10:27:52 +0100
Message-Id: <20200124092926.856809475@linuxfoundation.org>
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

[ Upstream commit 9b4eedf627045ae5ddcff60a484200cdd554c413 ]

The of_find_compatible_node() returns a node pointer with refcount
incremented, but there is the lack of use of the of_node_put() when
done. Add the missing of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Fixes: 337072604224 ("clk: mvebu: Expand mv98dx3236-core-clock support")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/mvebu/mv98dx3236.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mvebu/mv98dx3236.c b/drivers/clk/mvebu/mv98dx3236.c
index 6e203af73cac1..c8a0d03d2cd60 100644
--- a/drivers/clk/mvebu/mv98dx3236.c
+++ b/drivers/clk/mvebu/mv98dx3236.c
@@ -174,7 +174,9 @@ static void __init mv98dx3236_clk_init(struct device_node *np)
 
 	mvebu_coreclk_setup(np, &mv98dx3236_core_clocks);
 
-	if (cgnp)
+	if (cgnp) {
 		mvebu_clk_gating_setup(cgnp, mv98dx3236_gating_desc);
+		of_node_put(cgnp);
+	}
 }
 CLK_OF_DECLARE(mv98dx3236_clk, "marvell,mv98dx3236-core-clock", mv98dx3236_clk_init);
-- 
2.20.1



