Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744CFC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423FF20656
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581700057;
	bh=EmHy02QxIAceinsrla6/OOJZSbxSoVsrW2LFm6TIsi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m458vIGV1tJIR6/1LMksubP5tAJeAIS3H58Ff3bL7Til8aPNZQw0O+sV5aEgXGe8V
	 aCk1Ub891xQZ5N64prnQvH8XzBjVvKXFjy3dXui6nFZ1WAGJJu7gmMxcBKB6+pIL7n
	 rjuiStxte3vw4/bf+QKo1UI3KsiOgycBO4kulAfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392309AbgBNQOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:14:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:42594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403902AbgBNQNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:13:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15259246CD;
        Fri, 14 Feb 2020 16:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696822;
        bh=EmHy02QxIAceinsrla6/OOJZSbxSoVsrW2LFm6TIsi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D6BdMld1TjSF+DIYeQYluhf0P7VN8SmoquWG97L55MlEBdw0TQUkpObYTusdguRzF
         LCc9Ln+RkY2m28GSuH0w3Q5u2qKBtGC2HpK/dHsEcd8U7XhZKhjMd9lZSJUbYMd9jX
         PNwZgoI6GWZ8cip149cnhEYpgeXnOv0jO0TGqjtg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 089/252] ARM: dts: imx6: rdu2: Limit USBH1 to Full Speed
Date:   Fri, 14 Feb 2020 11:09:04 -0500
Message-Id: <20200214161147.15842-89-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161147.15842-1-sashal@kernel.org>
References: <20200214161147.15842-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

