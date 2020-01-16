Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0E0C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41EA024718
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579196627;
	bh=Fsgz/9VP6EDi4Qe3JGhNHsDrrJmBwbbV+bBeJbA/YEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fM50bzy8GpqaNW37rG4v6OxRHb417gwzRxiQgnUPKBDRdvSqC/0DpiuQxMwC0tZaO
	 0lfnOV8eQ3nEyJdi3dgjImJFWVDmKqkEFOVCB3vI5dDDuJxrCOYf78QTfrrd5uEfmY
	 fv0mWO7KHjr4cBtWJjxWSQszFmEDLQ7oLu0vyA80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393985AbgAPRnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:43:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:33568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388744AbgAPRn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:43:28 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E804246C2;
        Thu, 16 Jan 2020 17:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196608;
        bh=Fsgz/9VP6EDi4Qe3JGhNHsDrrJmBwbbV+bBeJbA/YEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K3eTCyOYa7qbyOc0f1ascfzqqT91YcqAXNwN9XEL3HwL7hfT+QGsYW3p6vK/8IK4P
         PrmKCRF8kBl+dqp1Ni9RaPnUJUbOve1LxYJKsdBfQ9iNGZTZJQ0lYZ0jNZR+XCArlu
         f9oWnzKLo6jNWFLQ7Eak6hAB/Q7AbyyOEQYOs27Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 028/174] clk: kirkwood: fix refcount leak in kirkwood_clk_init()
Date:   Thu, 16 Jan 2020 12:40:25 -0500
Message-Id: <20200116174251.24326-28-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116174251.24326-1-sashal@kernel.org>
References: <20200116174251.24326-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

[ Upstream commit e7beeab9c61591cd0e690d8733d534c3f4278ff8 ]

The of_find_compatible_node() returns a node pointer with refcount
incremented, but there is the lack of use of the of_node_put() when
done. Add the missing of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Fixes: 58d516ae95cb ("clk: mvebu: kirkwood: maintain clock init order")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/mvebu/kirkwood.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/mvebu/kirkwood.c b/drivers/clk/mvebu/kirkwood.c
index 99550f25975e..1d2b9a1a9609 100644
--- a/drivers/clk/mvebu/kirkwood.c
+++ b/drivers/clk/mvebu/kirkwood.c
@@ -335,6 +335,8 @@ static void __init kirkwood_clk_init(struct device_node *np)
 	if (cgnp) {
 		mvebu_clk_gating_setup(cgnp, kirkwood_gating_desc);
 		kirkwood_clk_muxing_setup(cgnp, kirkwood_mux_desc);
+
+		of_node_put(cgnp);
 	}
 }
 CLK_OF_DECLARE(kirkwood_clk, "marvell,kirkwood-core-clock",
-- 
2.20.1

