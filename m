Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D41C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 23:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9212E2071A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 23:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjTbA6AX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgGWXFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 19:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbgGWXFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 19:05:50 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA16C0619D3;
        Thu, 23 Jul 2020 16:05:50 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id b9so3381969plx.6;
        Thu, 23 Jul 2020 16:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F2Pqk4mRzkFzX9xFSRvFyyP3SBKlsXCsdPwtf6+8Ajo=;
        b=VjTbA6AXBoaB0RDzYmJ3E0ciocAanVmLtik4kiAq/W3OZ8a+Tk3/9TfQT7UZUKQ1FH
         0XMjd0X1PbRuix6Bd/doMNqBaQhPt8KpJCR4TQKZr0kpzi4DdrWCIDsRPwro4sol/rrC
         gLZMXonkP8qcFTn+SaHNNwJYEmsAAGJNliCU0Sil7g9HVd0NgnvUrqIHXVF4bKOwqR98
         y2+uW8U1pg60HJ7kI+7A746BawLg3pY9NOW2FB7i78gOZBkmqmyyM7h4HDLlsesIfX6p
         ctqj45kqdvxgF8iGptdR1pf1ZCK6EmHgd0FPa/tm570emRMcZCwhkUuLJZ1tKg21nwp1
         i84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F2Pqk4mRzkFzX9xFSRvFyyP3SBKlsXCsdPwtf6+8Ajo=;
        b=aWBU9Zj8TZ5oVGPAvf7QK84zpp3uHV2T63GDwNuBRy2v3Hhv1qjlVkyeqZEQpD6eBl
         2DALdQvGi/JBCMYIfi7Ev4HUPyMyot+z4XU4upmFh2zo3BmXusKKxqrEs2d41gX2Hun8
         yvppDImxCBdu/jsagItmv8Q+3LZcCs9rP2PsvR9MifL7Tx/gR0KJbuph4OwjYzj4a+Gc
         2KAvBPM7oVvyk27+iPSc8fGE2GUJ2YeSGXnZNGeAwfR/mxfIEiJO8H3fu9JoWa6mQMrb
         pus/jxamamLsMnsQFKVFETREzDfHubaq+TFzG1CBU+Gf+eWkp1o9XzBCQ8Ff/8xiAqun
         FUvw==
X-Gm-Message-State: AOAM533srt4xvf4ZydFsqsY32mPeGRzIxDyptcRmI6TGE1Q02HkZ2HZh
        vf3RPhgAtYqRd0xwr9+8AYw=
X-Google-Smtp-Source: ABdhPJxz4fyUslV21YIicSuEUXWODmfGNTJc5KJGMBlAZ1KMU5eHtvAW2G8fxTbZHRjaRg8ywL8E2Q==
X-Received: by 2002:a17:902:b113:: with SMTP id q19mr5771431plr.170.1595545549701;
        Thu, 23 Jul 2020 16:05:49 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id gn5sm3644742pjb.23.2020.07.23.16.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 16:05:49 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v2 1/3] ARM: dts: aspeed: wedge40: disable a few i2c controllers
Date:   Thu, 23 Jul 2020 16:05:37 -0700
Message-Id: <20200723230539.17860-2-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200723230539.17860-1-rentao.bupt@gmail.com>
References: <20200723230539.17860-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Disable i2c bus #9, #10 and #13 as these i2c controllers are not used on
Wedge40.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 Changes in v2:
   - Nothing changed. Resending the patch just in case the previous
     email was not delivered.

 arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
index 54e508530dce..aea23c313088 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
@@ -115,14 +115,6 @@
 	status = "okay";
 };
 
-&i2c9 {
-	status = "okay";
-};
-
-&i2c10 {
-	status = "okay";
-};
-
 &i2c11 {
 	status = "okay";
 };
@@ -131,10 +123,6 @@
 	status = "okay";
 };
 
-&i2c13 {
-	status = "okay";
-};
-
 &vhub {
 	status = "okay";
 };
-- 
2.17.1

