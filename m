Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92741C54E8E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72F37206D3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lbhHhuyO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbgELMyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 08:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730012AbgELMyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 08:54:17 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D43C05BD0E
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 05:54:13 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id v12so15191388wrp.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 05:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DiGkcP4eFfexy4SQNg7ufjBEY09YfamROxya/IRuOvI=;
        b=lbhHhuyOPtBdd3q/gIrXbLMkzPLkug63EWPG7QItNwgksACc7MSj/9kF1UPQ8MLJqh
         unxRTRIW1DyZxi2DdzBndiS1VPS62K39G9g8zOpKDjNfZbU47NFi6qoTXe1K9wkyrUS/
         DlJJxWVA3GKMxyWwBnDpZwuudkuOYYk762HkMYAvvUaso/D+8paTno94nFhGa/kn3FlL
         NcfHo42OmU9PCgj51w+Axe4g/w5EGoa69wsjmd0tSFkBF9ZCZpqaNqiD/+xJ8DDYSxbT
         XzMtZEv2QGvk8VdHoxSUgZOr9n5N6drn6eUY8W0MFprKVglnYkSkBnDkYDwm0998PhHQ
         uxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DiGkcP4eFfexy4SQNg7ufjBEY09YfamROxya/IRuOvI=;
        b=F4NS+HdAjGHqz1AWX2MFrIDIDqA4+G0A3fI4OypNn4Xyu5ixA2gAdEa7PRDPUbFcdR
         AC3R3hKhHf+TUCLeb1IbPc2eFuQQ+s6eVbWIKHbm7dBT0fvOofGWAtLmM2BwpQpSLBPn
         2guIt7L3rCMIsfaK1Nu0UG+ItN+P1HQBVoRsuxSZ84kSnUqsbzthL+gSja8jczfj2Px+
         AyohiHErjhLs4Yg1usKvRXa072MiFUeYsdz0saDonrYn3Re+EOKrjiELlqiETx7b45qi
         ryEcLFmOAC3tkA8aF34r5q8aZZduF7st8BjiuI6QmnhK1VfnffCP5ue6w7cPe34E18XF
         NjbQ==
X-Gm-Message-State: AOAM530atUacr8lYByxF4h/XtVEZMl2B+e9zfG2pyAwlAwvhkEbAJEIM
        2IUMJI3izxCbCu9cZPUC5PmYhg==
X-Google-Smtp-Source: ABdhPJxcybAIvGXBrRlxlNGIKrgxSDZXtYzJGmC8jFI2UV/YzTeoWr1beziqnC7jrJDlyfrzn/I/bQ==
X-Received: by 2002:a5d:4491:: with SMTP id j17mr2147301wrq.41.1589288052058;
        Tue, 12 May 2020 05:54:12 -0700 (PDT)
Received: from localhost.localdomain (212-39-89-66.ip.btc-net.bg. [212.39.89.66])
        by smtp.googlemail.com with ESMTPSA id n13sm2433938wrs.2.2020.05.12.05.54.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 05:54:11 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, rjw@rjwysocki.net,
        saravanak@google.com, sibis@codeaurora.org, mka@chromium.org
Cc:     robh+dt@kernel.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        jcrouse@codeaurora.org, evgreen@chromium.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v8 09/10] dt-bindings: interconnect: Add interconnect-tags bindings
Date:   Tue, 12 May 2020 15:53:26 +0300
Message-Id: <20200512125327.1868-10-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512125327.1868-1-georgi.djakov@linaro.org>
References: <20200512125327.1868-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sibi Sankar <sibis@codeaurora.org>

Add interconnect-tags bindings to enable passing of optional
tag information to the interconnect framework.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
v8:
* New patch, picked from here:
  https://lore.kernel.org/r/20200504202243.5476-10-sibis@codeaurora.org

 .../devicetree/bindings/interconnect/interconnect.txt        | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
index 6f5d23a605b7..c1a226a934e5 100644
--- a/Documentation/devicetree/bindings/interconnect/interconnect.txt
+++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
@@ -55,6 +55,11 @@ interconnect-names : List of interconnect path name strings sorted in the same
 			 * dma-mem: Path from the device to the main memory of
 			            the system
 
+interconnect-tags : List of interconnect path tags sorted in the same order as the
+		    interconnects property. Consumers can append a specific tag to
+		    the path and pass this information to the interconnect framework
+		    to do aggregation based on the attached tag.
+
 Example:
 
 	sdhci@7864000 {
