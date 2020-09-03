Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA622C10DAA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 22:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 613E820709
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 22:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="C2MUXAU6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbgICWAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 18:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgICWAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 18:00:13 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB30C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 15:00:13 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id o2so2082546qvk.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 15:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KPmrddlH7hegcLC7wfZovl1Ciuz3vrrjjRgvVbrEmKs=;
        b=C2MUXAU6eMzKJe3e0Iq4VREm3N3vBhKNRC4FysrWfxnkom4myeeubdh7G+d46xoGiM
         hHHhnQDUj8IJqoyc3++Zezg2QO9sqBQWD6kFJ3LWWxm42upicnBn3HfjYjdW2Zyh7zYn
         WYZqA4O9TooqQNBNzu/AP7mwagq+rGNw3jjhYAJJ46eKBYIVKQbh/FbW76wAjGdJ2htO
         vBVMnBwrzPnodIOLKz97rdMEZYmVVa9I/xj8cRRDS6CVgBs+hVPsvcRowBja7oLO23Iw
         HSXV3tumfnofcKE9mIsotEi8M0jh+vPN7tcP1p+hpDJaIXRpiNjyiMWsSorWBHjif7km
         jeaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KPmrddlH7hegcLC7wfZovl1Ciuz3vrrjjRgvVbrEmKs=;
        b=ua0QbD7h4FmdG44EYbWerodBgSothRN1QNn5S4yXc8WxzJ6k2XkYNd3q7Y9cgNRiF9
         cWC6jzwMIV81O8eXBWHOW4o+gtGDV3JTR/v7vjBAUdnaVSNuZpWV2gsvA0fvz59+9/lp
         tUj4G8CNGwWtIXDJIZZ1/S01jcvSfEbijlT9xkNk59AvTvgcWXOsryKYF0kKHKWNgvxr
         8ARqKXOVW9GVqXqi+/KJTk7p6Nl5QMdPi+FDQyHlWchuLmyFj4fBxU25Cx6y3VgTrUKe
         hDu0uQQaicnh0cwHD5R6ZBjlC4fwYBNxe1VAqpscATDZMiUmZoJTIkVunJ9qgxdNg2x/
         2IGA==
X-Gm-Message-State: AOAM531uzDXY07f2lc+/8oDIjKXxJbTbTRVbT+xXHmPfMmI9QXEFllqs
        IOERMqaQQSETDCx+E/ECtTzenfHz8R6LfeOGUWs=
X-Google-Smtp-Source: ABdhPJwkEH9XtrK3cNQXeyfFSDGVHrAk+oV922w9fIRrc4E/q/w9BXZ8hFz61MBVZS2pgl5Q9FvkdQ==
X-Received: by 2002:a0c:9ade:: with SMTP id k30mr4890094qvf.194.1599170412459;
        Thu, 03 Sep 2020 15:00:12 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id t11sm3052293qtp.32.2020.09.03.15.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:00:12 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm64: dts: qcom: sm8250: use the right clock-freqency for sleep-clk
Date:   Thu,  3 Sep 2020 17:59:23 -0400
Message-Id: <20200903215923.14314-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Downstream has this clock as 32000 rate, but testing shows it is close to
32768.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 81aa1f497b13..2cd38053bcd1 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -75,7 +75,7 @@ xo_board: xo-board {
 
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
-			clock-frequency = <32000>;
+			clock-frequency = <32768>;
 			#clock-cells = <0>;
 		};
 	};
-- 
2.26.1

