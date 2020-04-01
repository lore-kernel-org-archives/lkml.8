Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBF8C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7845D20784
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585760211;
	bh=Exro3RBVTcuX8IyxCG+436aDA/mC5fv5PCGXfpK/dw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HwXM2NF3FsvuRabq6BKepn3WPCMiZcqewtB/N39mwvsxFyC3qumvygzTE+UGLkWyR
	 IxNeyAnlQm9szqY1ac2HZf9jDklifOdCsYL2BmtcvOVdDUqZ8bpAfk9G/ml3cmj2Oc
	 LkBUZWN7kDSMzfhr+0d2atk52z+4BjlWQI7HEuzY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387418AbgDAQ4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:56:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732859AbgDAQUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:20:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E204D20658;
        Wed,  1 Apr 2020 16:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758018;
        bh=Exro3RBVTcuX8IyxCG+436aDA/mC5fv5PCGXfpK/dw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bKBKGzU/4o5/rYo5jvnX4gP+ZC0DvWO+7BqVgGpwKjVrNwJAONwFu2C1lW3JzZaXK
         SHID35ElES+/ioCJaGoGo1mvsnzEpr0BfblPErV0h8r/UkgTHD38Y/KdJGnW6Y+QbB
         2bqMD5Xletwyi4/t9eI51b8rma+1aHb9VcVCzsGI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leonard Crestez <leonard.crestez@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 5.5 17/30] clk: imx: Align imx sc clock msg structs to 4
Date:   Wed,  1 Apr 2020 18:17:21 +0200
Message-Id: <20200401161429.287441961@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161414.345528747@linuxfoundation.org>
References: <20200401161414.345528747@linuxfoundation.org>
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


