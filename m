Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC76C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A00621739
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221064;
	bh=xyUGEFXpyzNFtWfdd8thjkylmfAJL4ZvM6xvi4QDHHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h2yzzacArq8e/8NJSCDvljxDXzeahdFoLk8IHPnZ+GvDlMwOEE1/5FXXr1oPpcfhG
	 uBXt4WgvdNv7pbcapuwl9YuixBQw20A4atOE/H8zEQCTLYTnTzZ1KBjnqd+IKG4YV2
	 xRqxPW2r+U2m5/ZSSTXASqOKE/nF/axFyvkStyy0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbgA1ORm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:17:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:41408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730553AbgA1ORh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:17:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6EA82071E;
        Tue, 28 Jan 2020 14:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221057;
        bh=xyUGEFXpyzNFtWfdd8thjkylmfAJL4ZvM6xvi4QDHHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JED1OnARYiv99e/URdV6RJ13v9RTCa9qJwYtLw4DtqYSIy52+IwLfP5+COUZ2ft2f
         wbxOuPLdgMlOuGtwUuzD+5GPhd2PXqP+5uDuaDFPE+KymzneyVymvCKDgU2hLm4V2k
         8UzeUitp76nsG2T8hMDniOOZgXESUTCrL/eQFAlw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 034/271] clk: armada-370: fix refcount leak in a370_clk_init()
Date:   Tue, 28 Jan 2020 15:03:03 +0100
Message-Id: <20200128135855.220400768@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
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



