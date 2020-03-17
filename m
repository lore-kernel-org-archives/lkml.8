Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DDEC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9EDB20714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443113;
	bh=eQo3vOkdx+gbyH57SiasHpKgrg8xrYXjhCMuRy2WDGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o52gKswzh4xLAtTL5mmuFL0yRQv23S2B2ekt3kzUwibiRaA4u+2bIj4Ndk4DULw/h
	 5SHLUHwdd2FcrWcZ8hNdgbEtm3/IuDufVz461z+fTdKKA0ZKbPYEZ1G+j7sxyG1YpV
	 ulnDN6jrc3KqDeOw+UPJM3+UiGUslwn6606JCDPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgCQLFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:05:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727999AbgCQLFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:05:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C16A720714;
        Tue, 17 Mar 2020 11:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443106;
        bh=eQo3vOkdx+gbyH57SiasHpKgrg8xrYXjhCMuRy2WDGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eU0O/Jdc3Egxd+/RqVMx6yj1v6yrik/afJWD/tYFpNSkclzISyXSIFnNHLYBOYstJ
         Ks+gZxGgeoEzeQ3T2DoVSMlmDeNV8rZZKVnXamTcgKSqTzXSTRgTae6wR1WgrtjliC
         XlM4O3IOvV7xFCuH3voptpHKGlBgs0QbUbUrJGfo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 5.4 098/123] clk: imx8mn: Fix incorrect clock defines
Date:   Tue, 17 Mar 2020 11:55:25 +0100
Message-Id: <20200317103317.734391046@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103307.343627747@linuxfoundation.org>
References: <20200317103307.343627747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

commit 5eb40257047fb11085d582b7b9ccd0bffe900726 upstream.

IMX8MN_CLK_I2C4 and IMX8MN_CLK_UART1's index definitions are incorrect,
fix them.

Fixes: 1e80936a42e1 ("dt-bindings: imx: Add clock binding doc for i.MX8MN")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/dt-bindings/clock/imx8mn-clock.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/dt-bindings/clock/imx8mn-clock.h
+++ b/include/dt-bindings/clock/imx8mn-clock.h
@@ -122,8 +122,8 @@
 #define IMX8MN_CLK_I2C1				105
 #define IMX8MN_CLK_I2C2				106
 #define IMX8MN_CLK_I2C3				107
-#define IMX8MN_CLK_I2C4				118
-#define IMX8MN_CLK_UART1			119
+#define IMX8MN_CLK_I2C4				108
+#define IMX8MN_CLK_UART1			109
 #define IMX8MN_CLK_UART2			110
 #define IMX8MN_CLK_UART3			111
 #define IMX8MN_CLK_UART4			112


