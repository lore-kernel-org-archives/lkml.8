Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FADFC54E8A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 19:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB22220A8B
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 19:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjOXiyWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbgEJTiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 15:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729032AbgEJTiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 15:38:18 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CD0C061A0C;
        Sun, 10 May 2020 12:38:18 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x77so3734118pfc.0;
        Sun, 10 May 2020 12:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wyNT5+0GWB8vIh2xGMxe4qbl2cO09ZqT42SZ6diOFEY=;
        b=PjOXiyWPu0oqWeHrYCDi3X1QwA+GDLa4e5lvrQFPnjyyRPZVydFCQJ6a0dVGD/Q8Ub
         BQEUz4VIh6s8xVWZiDVC0vLTaWS9m5GA4QEvgcwkO+5ca8DapHnVtPCyBg79zqZLzAby
         jbhwc7Lv01pdzFiXd1NLfXhp1x3ctp4qQhRPmGxwQYeBkiPhuANO2fyQb4M49jqO8Ph9
         aGNKXG9bTCwh1K8l7i8hnvQaJDzd1AojVYHtb8zSGGwp81/0CfhFHq7whn+yxQQBGJt3
         pXlN7tTM/TUc1qatcrelmcrEmiwnmcWUmq0hk45/HdDqF82Jo44biznLMLchIUbnY8cL
         dUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wyNT5+0GWB8vIh2xGMxe4qbl2cO09ZqT42SZ6diOFEY=;
        b=Y1BJgvFa5dcgooSLp0aInmmrMgk0wbtP4XeH7iSqrKIlswMKb8KbYSHmsvXx+c0qIU
         /gO4ZCefG/4n1fDIfoJWYqpY0VcjYVHcvPrtfFhfZvo2IW+rTO2XrCfyhjATuiaNKEut
         yVq9vT73EnXZELDw33XOTIL5MXoD1R9cBjJPItt1orTpQB9ZD4+ChSCojvbWeD28gFFZ
         F6Cql5t1Fgaroqlm5WSQDhrtjbW1OkttRrKrx25xbIqpBLMF5IKa8VNv1JTCOfHoSafb
         lDv9Ol7YeZQbpKAXlyYD6VF8CNx2mWe1i6x/au176E9vhVo23ZpBa+EY54aEpzyC8Ler
         39Jw==
X-Gm-Message-State: AGi0PuY+IByWMvnk6oCVZo9FT+qU14O5O+qFzXHp3oVMpkaouLxzBtFH
        Nk/2EB0/A/ayhDhPXxe0W7s=
X-Google-Smtp-Source: APiQypJN9G/92uguALDte7otm85YggaP4mvYV6ytD0Ep4efg2S5xrxeFas4aCwEjMLIwtZBsT7eYiQ==
X-Received: by 2002:aa7:8f2c:: with SMTP id y12mr13741489pfr.80.1589139498093;
        Sun, 10 May 2020 12:38:18 -0700 (PDT)
Received: from pr0gr4m-ubuntu.localdomain ([1.240.193.107])
        by smtp.googlemail.com with ESMTPSA id fh18sm21513639pjb.0.2020.05.10.12.38.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 May 2020 12:38:17 -0700 (PDT)
From:   l4stpr0gr4m@gmail.com
To:     trivial@kernel.org
Cc:     michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kangmin Park <l4stpr0gr4m@gmail.com>
Subject: [PATCH] docs/devicetree: mailbox: fix trivial typo
Date:   Mon, 11 May 2020 04:38:11 +0900
Message-Id: <1589139491-6301-1-git-send-email-l4stpr0gr4m@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangmin Park <l4stpr0gr4m@gmail.com>

Fix node id typo in example

Signed-off-by: Kangmin Park <l4stpr0gr4m@gmail.com>
---
 Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
index 4438432..ad76edc 100644
--- a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
+++ b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
@@ -87,7 +87,7 @@ Example:
 		ranges;
 
 		/* APU<->RPU0 IPI mailbox controller */
-		ipi_mailbox_rpu0: mailbox@ff90400 {
+		ipi_mailbox_rpu0: mailbox@ff990400 {
 			reg = <0xff990400 0x20>,
 			      <0xff990420 0x20>,
 			      <0xff990080 0x20>,
-- 
2.7.4

