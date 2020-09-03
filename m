Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA81C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F27D720767
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599162840;
	bh=P0rEj1OHJTcAo/AOa1NwkT4HC3i3MhAMkpa8XH0S4GU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AiYupCFkBx/Yt5HVPn0J3U0ewhL0VeB0HaQvss08Qbg4s+Nz0ljJtzqBOGChilSkm
	 PsQ/PrKC21RWB5TYmvrcgGxk4M7dybpfVO7bY64EoO87wj/ByYpFXsau+57/wtLvU7
	 hNvDmmIKlr63PSPWTMpU9y1i6sx6COto2sumZwEI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbgICTx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 15:53:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729292AbgICTxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 15:53:51 -0400
Received: from localhost.localdomain (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C14FC20716;
        Thu,  3 Sep 2020 19:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599162831;
        bh=P0rEj1OHJTcAo/AOa1NwkT4HC3i3MhAMkpa8XH0S4GU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fWyC5sgxtPTHg2IGBaQETV9Xks0QoKTb8mCF6PeZ/xPxaoB16XI+u5XCH8dVF4V3n
         nkNykxrJFPWf5Lafv8bGkY6rQ0CdZFNPoEY4Viuk0JCrQ43oMvUhrQCRpu4OuQQNk7
         pUzog0XenOrNnl9MBl27RM2XC3BPFDLt1MtjFqhk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 3/3] MAINTAINERS: Add dt-bindings to mailbox entry
Date:   Thu,  3 Sep 2020 21:53:25 +0200
Message-Id: <20200903195325.5394-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903195325.5394-1-krzk@kernel.org>
References: <20200903195325.5394-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cover the dt-bindings of mailbox drivers by mailbox maintainers entry.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. New patch
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bb0cb31d323b..d3d8dedbaf22 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10417,6 +10417,7 @@ MAILBOX API
 M:	Jassi Brar <jassisinghbrar@gmail.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/mailbox/
 F:	drivers/mailbox/
 F:	include/linux/mailbox_client.h
 F:	include/linux/mailbox_controller.h
-- 
2.17.1

