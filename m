Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C705AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 00:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A46F720780
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 00:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZswfwgE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgF3AJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 20:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgF3AJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 20:09:04 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E093CC061755;
        Mon, 29 Jun 2020 17:09:03 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id 35so7748788ple.0;
        Mon, 29 Jun 2020 17:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eqibuAlbVerKw/zefMiddrebHe1JsCRw3HQfqdX+MX8=;
        b=GZswfwgEpHRnkCLZDWcoi5oj2YnH2/71kUslgS0hEGKRctt7+oWGXAR100Jk3nSNoY
         RVBbfykXXOddSv0OfVfN2rgSEmJ3Wq7bkMD0+St3Lxm4AbVcd6uXuUnu5Y5XqNlWo0mG
         ORxdMawTlko0koyR0spoOv9bocVpjmjlltuP7BSk/BvFymVrhSRwW00Fw2NYIfkbm7as
         1Cc2XUK7+2JDYbjkyC2Stcjr3qKEb8xmlaZxXTJnfB4Sx+eXDwLgR+Xk1G2Nl8OnpS6W
         hY6OIvnclwLsVpTj8CpUpQuI90qsJjqt4tuSZoKVcpuF0CAQ2dy0dvm+OfpCV+HxDGjn
         73YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eqibuAlbVerKw/zefMiddrebHe1JsCRw3HQfqdX+MX8=;
        b=qSdcb6np9LXZNmMKNdPfF9qTiaQ027ZFnwUVOV2YmY2fDUh+1m3pziNSZGhtKEZLcG
         qxcr1mxk0nTBaUctLKr3STg2UP86WEeMm0Cnv1+uGbJ70KTCSgYrpRZMfKNOQqLD7lWw
         qB0Bh9up36Tn+18A9ZNhTazFAbCDd/hs1tyroJZCXwpbbTxxLRO75i314j+FkudO9O83
         6+52bAc3+5+3F2jUBeAxvSCP5yJ5pVEqeFNtUabFvry8jfDors9OySLZyObiUJQW1pb4
         ea3o4AWJ2MUq69XkJ4zldqwLe0Z3pCLhK5um9j6yl7iddc2a9MYfKd0cVJDkJux1VWs9
         vX9g==
X-Gm-Message-State: AOAM530gSJAdR1NHsPgABdKeUlxg/nqWEoej3fMUA4bqnK8i/iQ5LAsr
        9dbwSnR6LQgmo0i48Oh35T4=
X-Google-Smtp-Source: ABdhPJywOKmCFfyQ5L/XOiQUMEjegV1m/9OHXGCYWL5vhYb0EzL028liqixSQqewmEE6FjLYW5NzPQ==
X-Received: by 2002:a17:90a:ff16:: with SMTP id ce22mr20515645pjb.160.1593475743310;
        Mon, 29 Jun 2020 17:09:03 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id m9sm754600pgq.61.2020.06.29.17.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 17:09:02 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 1/3] ARM: dts: aspeed: wedge40: disable a few i2c controllers
Date:   Mon, 29 Jun 2020 17:08:49 -0700
Message-Id: <20200630000851.26879-2-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200630000851.26879-1-rentao.bupt@gmail.com>
References: <20200630000851.26879-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Disable i2c bus #9, #10 and #13 as these i2c controllers are not used on
Wedge40.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
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

