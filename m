Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E43C2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4BD212CC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758116;
	bh=nnRmublHebH8tVwLmAi+UQ/zgzXNjJ2XDyx3i9qUhW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bAd+TPDTFyHrOMZHydhBnenrXLN1BsAidVjt101lz9LyxTfx2fwtI+FOGCHtF0FXm
	 9upJ8tjJfx4jtb9ewZBMn3XdCAanjDZ8nzCULNag/eQ6dLSNWr2KWMwgMON7t1r8FH
	 g9tzly0WtMa4GSzn0HfDggtG3qBk1ieuYF7/ekvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387424AbgDAQVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:21:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:44840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387415AbgDAQVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:21:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B24321973;
        Wed,  1 Apr 2020 16:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758111;
        bh=nnRmublHebH8tVwLmAi+UQ/zgzXNjJ2XDyx3i9qUhW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wjBpTzb88kTlWa26YHLgB/ri+BXaJbXGxtIZqfBUHz/19y/SnD/o9rYgWRvOeJtD1
         QiIueVBWl7Q1yi572+G97oFl6L2AxrpuuZY544v/n4mtsoyidYnOKVxrW1Yr3oO1e/
         7NP6fjxsfnLcOu4qfA6S2QJRJRg38JAVEdauKyYA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leonard Crestez <leonard.crestez@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 5.4 16/27] clk: imx: Align imx sc clock parent msg structs to 4
Date:   Wed,  1 Apr 2020 18:17:44 +0200
Message-Id: <20200401161428.154540051@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161414.352722470@linuxfoundation.org>
References: <20200401161414.352722470@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leonard Crestez <leonard.crestez@nxp.com>

commit 8400ab8896324641243b57fc49b448023c07409a upstream.

The imx SC api strongly assumes that messages are composed out of
4-bytes words but some of our message structs have odd sizeofs.

This produces many oopses with CONFIG_KASAN=y.

Fix by marking with __aligned(4).

Fixes: 666aed2d13ee ("clk: imx: scu: add set parent support")
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Link: https://lkml.kernel.org/r/aad021e432b3062c142973d09b766656eec18fde.1582216144.git.leonard.crestez@nxp.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/imx/clk-scu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -84,7 +84,7 @@ struct imx_sc_msg_get_clock_parent {
 		struct req_get_clock_parent {
 			__le16 resource;
 			u8 clk;
-		} __packed req;
+		} __packed __aligned(4) req;
 		struct resp_get_clock_parent {
 			u8 parent;
 		} resp;


