Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD5DC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5652063A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585760181;
	bh=Exro3RBVTcuX8IyxCG+436aDA/mC5fv5PCGXfpK/dw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g+PUlRMnRiPony2+jkgs2lgjS/jiIFU9mQlbOhHlZDTTyoHj+11bdgj+/ZKfnrO16
	 UrnDBUFCjinoRcrsRbwSlE6KvXXug+Ao/6kEzQNqesV0C7e5lPuNU9XwLmI6ykelXi
	 biN+jw+oNADDhCF24LUsKbpXsV62wBEaWZ2mawlA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387474AbgDAQ4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:56:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387403AbgDAQVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:21:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 010AB212CC;
        Wed,  1 Apr 2020 16:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758109;
        bh=Exro3RBVTcuX8IyxCG+436aDA/mC5fv5PCGXfpK/dw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YFWjfTvTVkBax6iogs5KOfuAtkdbLAAMNRo+5Gvxkm8tIvvI/sj3M5ao8U3NqLN0s
         wuh8sd0wb0tLM+qppMU0YxuI7A6gcg/a/Qh4knT+FiIQE6qudq0+gdW+YwnbNcnWaa
         nK1GWGRYp/30D9lCepjJErbylF/infmNxGinrZ5o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leonard Crestez <leonard.crestez@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 5.4 15/27] clk: imx: Align imx sc clock msg structs to 4
Date:   Wed,  1 Apr 2020 18:17:43 +0200
Message-Id: <20200401161427.336194111@linuxfoundation.org>
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

commit a0ae04a25650fd51b7106e742d27333e502173c6 upstream.

The imx SC api strongly assumes that messages are composed out of
4-bytes words but some of our message structs have odd sizeofs.

This produces many oopses with CONFIG_KASAN=y.

Fix by marking with __aligned(4).

Fixes: fe37b4820417 ("clk: imx: add scu clock common part")
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Link: https://lkml.kernel.org/r/10e97a04980d933b2cfecb6b124bf9046b6e4f16.1582216144.git.leonard.crestez@nxp.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/imx/clk-scu.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -43,12 +43,12 @@ struct imx_sc_msg_req_set_clock_rate {
 	__le32 rate;
 	__le16 resource;
 	u8 clk;
-} __packed;
+} __packed __aligned(4);
 
 struct req_get_clock_rate {
 	__le16 resource;
 	u8 clk;
-} __packed;
+} __packed __aligned(4);
 
 struct resp_get_clock_rate {
 	__le32 rate;
@@ -121,7 +121,7 @@ struct imx_sc_msg_req_clock_enable {
 	u8 clk;
 	u8 enable;
 	u8 autog;
-} __packed;
+} __packed __aligned(4);
 
 static inline struct clk_scu *to_clk_scu(struct clk_hw *hw)
 {


