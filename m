Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6CDC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 04:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13578206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 04:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="G8S2SApa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387612AbgEWEMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 00:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgEWEMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 00:12:18 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2095CC05BD43
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 21:12:18 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id s1so12794875qkf.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 21:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M5sFOrNXglw9u9oFYHMskJ7NcnM7eaQiBeIqzNjN18A=;
        b=G8S2SApaGaeOZYDOZa/usofyB38IwdN5arOsw90EdNv9M91atUz8HoIeWxnaEavt4k
         lkFN9p2LOH3h5m3Xs2l+BFRL6h+bttLmhu4g6layqGy0qQH/vvmt0xuRgA9+tUBubB5n
         BgyY2K1bBuOVhVgpBcwNx+kAOt75PR3vFAjzILzquIyTRDdkpVzIQyVbEiaV7UaCinVx
         aK/QxWxCdiLGKJZIEKY6FvwbNPrceLumTCs8MeCtVXVfukWKsmCffr1IpGxE8KoSBrVE
         cPds8tntUfOy2kPKViDmFxLcMSFGB16JkJRJ8XVQflrJX2Sfm1vcyCAdUaN+77UQrKon
         4auw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M5sFOrNXglw9u9oFYHMskJ7NcnM7eaQiBeIqzNjN18A=;
        b=Am++LgeTU+MQisCNYG8Eizpp5DizbRWZSgW6x9qcDkEH5bepQVfdqe1HHutcBKQ7fg
         VUGiiCdZqxzHOtH9guoqBD8agwJplOcnjGGy4SKp8IHzwtRUx+6k5t0TxO7HckoaYfe0
         mbXGQE2ScjXQg0hVdInLhYlajUzqKyfP5RWYtZCHMcMs9c/r2ZD3CKzPMgxERfyx/3C2
         ojc8C5H7KtruJJWD+z3hi5SHXoEW+wQmbIfaxlG0i8A0GAWkhYKxCzMyp+XsRU2hIkTc
         FoqO8oMi9t0lk6Gg/97zyYQ5Wco8H5Ym+ES90x0T/L4G6mV0WvY7yitO9eWf09Z56Hqi
         bEvQ==
X-Gm-Message-State: AOAM533JRrsIl93+IEbYaqoRcPnjT7leSJQOrOhozv5yLctY5IfUyUjL
        /wX3IXgTYNtyL3qF3HKqvoS2Ng==
X-Google-Smtp-Source: ABdhPJxRnAIPgMXBVIgY29ESU3hRJT/Hualiru5J/jkGjg0GRLMcQ7/pPTunfbRWCCCveIzowiD7RA==
X-Received: by 2002:ae9:e50d:: with SMTP id w13mr12486140qkf.315.1590207137323;
        Fri, 22 May 2020 21:12:17 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id w21sm10077978qtj.78.2020.05.22.21.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 21:12:16 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm64: dts: qcom: enable pm8150 rtc
Date:   Sat, 23 May 2020 00:12:01 -0400
Message-Id: <20200523041201.32065-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't see any reason for it to be disabled by default.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 arch/arm64/boot/dts/qcom/pm8150.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm8150.dtsi b/arch/arm64/boot/dts/qcom/pm8150.dtsi
index c0b197458665..b738c263f9d1 100644
--- a/arch/arm64/boot/dts/qcom/pm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150.dtsi
@@ -64,8 +64,6 @@ rtc@6000 {
 			reg = <0x6000>;
 			reg-names = "rtc", "alarm";
 			interrupts = <0x0 0x61 0x1 IRQ_TYPE_NONE>;
-
-			status = "disabled";
 		};
 
 		pm8150_gpios: gpio@c000 {
-- 
2.26.1

