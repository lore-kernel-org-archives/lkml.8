Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD729C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 05:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C69C2078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 05:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qMIbafpg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgE0FhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 01:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725265AbgE0FhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 01:37:04 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F01C061A0F;
        Tue, 26 May 2020 22:37:03 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id f21so8270155pgg.12;
        Tue, 26 May 2020 22:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yq44qY1NsSkf+l5SZ0WYBQFjUQwT8TcW89f6+pzAZf0=;
        b=qMIbafpgUwhgraLG1IhrKxw833gXIe7a+o+OUXBo1IcpvK9PUCOzpFjTMNxLD8E3ZO
         HnOfDSv9/TLkAr+jVdEHGFshSqb7xgm3jy2X9NX+biZJnpSMws7ywcnfZ9Nd51x4+7C9
         lzXSFZv+uiNFJMN3tonD8KOhmo/qjskRAvNo3EU46DtP8nCDgZbzah8CuUQu06666sRR
         b6VcE/R+paid0CZsmGh/put267CbEL60D3k4QJ1TCT2sddJfKYYUKiS6Y15fvb1lFkEq
         Qh0qwjqQocvd4tCrIGBMsQJz290c/X+15rUIW6wsL64tI46bgyzbTbD23TRuVmkVlDUM
         jRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yq44qY1NsSkf+l5SZ0WYBQFjUQwT8TcW89f6+pzAZf0=;
        b=Umx7ZdEmlL5GaTJsbT2fmVJSPYnN/Gptaa2VqUPqgxy3txLSGnsZqn5OPczqlqwcIE
         gW6AFWvKztc25iGQipwZ0wGWN3IRdWziBPxiFfHl9J4ZwQXmiNgOvDNLgEFzs0VQWGH7
         Ym68t8E74/mwuj768QPBL8sBGkOSCreGQocKFjs3hHSbqH/cXtIMWiRY5jq9R7ZygheO
         GVPWbmneHnmWEIhfKRGTh+/ODysS1vutkDkfnKlC0I40Sa7e0floAuTs3I7nAvVQKkX3
         Hd2RFPMH+uBjTrbeOfF9beWViVQbz3odoX3JrKV03jfitsS2z1XVj6PG+pRpBWEx7N5S
         BHdg==
X-Gm-Message-State: AOAM531jX1yALsF/HFaB86/9PwI1YrPB5btqCM9k9D/z2qLnLUTUrfyF
        8g2UiY46BuWiwg14Ih0DfEr1cSADzNs=
X-Google-Smtp-Source: ABdhPJyh4sRwQt7JEbcdHwajRq7Swr6f3jbuPbXSa0TX3DPjdqVFqxwqpM1cs/hr16I6N7e8EFVkMw==
X-Received: by 2002:a62:a50a:: with SMTP id v10mr2392629pfm.134.1590557821917;
        Tue, 26 May 2020 22:37:01 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id r34sm1092406pgl.38.2020.05.26.22.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 22:37:01 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [RESEND PATCH v2 2/4] dt-bindings: clk: sprd: add mipi_csi_xx clocks for SC9863A
Date:   Wed, 27 May 2020 13:36:36 +0800
Message-Id: <20200527053638.31439-3-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200527053638.31439-1-zhang.lyra@gmail.com>
References: <20200527053638.31439-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

mipi_csi_xx clocks are used by camera sensors.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
index bb3a78d8105e..87e8349a539a 100644
--- a/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
+++ b/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
@@ -28,6 +28,7 @@ properties:
       - sprd,sc9863a-rpll
       - sprd,sc9863a-dpll
       - sprd,sc9863a-mm-gate
+      - sprd,sc9863a-mm-clk
       - sprd,sc9863a-apapb-gate
 
   clocks:
-- 
2.20.1

