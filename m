Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6758DC35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399382468E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582273152;
	bh=EmHy02QxIAceinsrla6/OOJZSbxSoVsrW2LFm6TIsi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pK8i9YWleMopNZtHa0mhFQFgrRroEMtJSLIQH6pL+OR4MtMj7gFXX1vXYw16U+RXV
	 iycGTx4fmopALtBlNsxnuIwSHPagXUHN9ypx7GvtEv3JZvC+16oDppU+SbO8sdW9pa
	 83C/jZbxbgp05JPUZGNry8RZIZe4bnTF/bYIEzTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387961AbgBUITK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:19:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:57242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387502AbgBUITF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:19:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC32724695;
        Fri, 21 Feb 2020 08:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582273144;
        bh=EmHy02QxIAceinsrla6/OOJZSbxSoVsrW2LFm6TIsi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CWO26ji+5QI4r2AObuCCclkE+un5j/shg4+CgyxO0drsxXA8xeH9AXnEgMxCxPQho
         pQWjvW++fzjzQDYT411D9o2mNnbynsKRU0vBo3Q5SFH4qqjN5aUTnuj49aXV9wU9nW
         A/LYIeukfbGCvO3EatrO274OGDlNK4DK7TA2EBIc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 063/191] ARM: dts: imx6: rdu2: Limit USBH1 to Full Speed
Date:   Fri, 21 Feb 2020 08:40:36 +0100
Message-Id: <20200221072258.967997633@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072250.732482588@linuxfoundation.org>
References: <20200221072250.732482588@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Smirnov <andrew.smirnov@gmail.com>

[ Upstream commit 6bb1e09c4c375db29770444f689f35f5cbe696bc ]

Cabling used to connect devices to USBH1 on RDU2 does not meet USB
spec cable quality and cable length requirements to operate at High
Speed, so limit the port to Full Speed only.

Reported-by: Chris Healy <cphealy@gmail.com>
Reviewed-by: Chris Healy <cphealy@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index 56d6e82b75337..bc5f2de02d433 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -804,6 +804,7 @@
 &usbh1 {
 	vbus-supply = <&reg_5p0v_main>;
 	disable-over-current;
+	maximum-speed = "full-speed";
 	status = "okay";
 };
 
-- 
2.20.1



