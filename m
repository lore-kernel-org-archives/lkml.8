Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C95DC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0443D24693
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844860;
	bh=zWETaLoF3P9WxIFHo1I7CF9gPRCLgj9bgSHy5PC6HSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q1peltc/kqRVOvywiMZU6YYwZMNbenpk9e9OToyhwGq8Qh9a7MSt8WYQZOG+LcWF3
	 LLp2VBccWHMNE8YjiTBgLJQOKb2QHnXoswD6Xb4U1E0REuWAXwuoaLRCPkt1JNZ/8s
	 L0FcTDJ9Cgg6+umI9UzMJcAIek3qzXTIp61sdNZg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbgCJMyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:54:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729314AbgCJMyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:54:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CE2720674;
        Tue, 10 Mar 2020 12:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844854;
        bh=zWETaLoF3P9WxIFHo1I7CF9gPRCLgj9bgSHy5PC6HSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KxitnYFIJgrZGVqEEPcl9cMahdD+T6l8plTTx6L6mo5BYX0XF6+DdcsQZG29RUzvF
         RxW731W357AZdW28Tx4OMWTOFgS9AaTjwuZaiXii/18ev/IvQikVgnWbX67y6wMzdp
         wH2egG9YW1+72murTWomR+XRVOKE3GCEO0JA+mww=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leonard Crestez <leonard.crestez@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 5.4 142/168] firmware: imx: scu-pd: Align imx sc msg structs to 4
Date:   Tue, 10 Mar 2020 13:39:48 +0100
Message-Id: <20200310123649.874392033@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123635.322799692@linuxfoundation.org>
References: <20200310123635.322799692@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leonard Crestez <leonard.crestez@nxp.com>

commit 7c1a1c814ccc858633c761951c2546041202b24e upstream.

The imx SC api strongly assumes that messages are composed out of
4-bytes words but some of our message structs have odd sizeofs.

This produces many oopses with CONFIG_KASAN=y.

Fix by marking with __aligned(4).

Fixes: c800cd7824bd ("firmware: imx: add SCU power domain driver")
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/firmware/imx/scu-pd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -61,7 +61,7 @@ struct imx_sc_msg_req_set_resource_power
 	struct imx_sc_rpc_msg hdr;
 	u16 resource;
 	u8 mode;
-} __packed;
+} __packed __aligned(4);
 
 #define IMX_SCU_PD_NAME_SIZE 20
 struct imx_sc_pm_domain {


