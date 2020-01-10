Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0ECBC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 06:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9903D20721
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 06:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRd2vkyU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731633AbgAJGiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 01:38:22 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34183 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731455AbgAJGiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 01:38:21 -0500
Received: by mail-pl1-f195.google.com with SMTP id x17so473661pln.1;
        Thu, 09 Jan 2020 22:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lZLjuNiKXKBszRB9AdXqYYatRC9mjTciQY/Z/lc2mw8=;
        b=lRd2vkyUoebCNgV32K+18GvopptwvprQFnHPBSt0tmgt7yc0xfXaySV3Ug3U3I7i2B
         AZaxQXoDZ3yVEHRF8HgjX3qgO9FxkKrLvdGJcbSf7KhXEKLV0U8nJ/pvab29z+UDvrIC
         NfRGhcX7t0LCCmospFk/2ZppitVpgcrXhQ9Xsfs5rSshurg1rVn8xVpkEEcJHvQ2HANT
         jESDUSo6pAhNdcQsUP6UbUgUOFHKOLOBGtvdsMuQa92PoH38KKcoLMSEZvugCLgeTMtR
         7LT4Z87h9GNxxRBvTedJqesNNM8FuwH2yDDrO58EZfewqMEms8TKL1pfRK9yaAxTy7ZF
         26VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lZLjuNiKXKBszRB9AdXqYYatRC9mjTciQY/Z/lc2mw8=;
        b=X47NGUVNYeZGVggctQLvb78Xkbf7sjfar3oS33XMcz9UNRZSoN41WJiGnJ7r2LEUJb
         Eo2+5eFkD95TaixzwDOWvIW6wBJumrZ8Tsx3tMfxHMKcsy3F6d6jSs/bSlufiqBhobbT
         yO6DO9NR9T0PDXpwpKQq+HZEFulma8q3cxRqWEwJIahKpa6VsmYrdbN5G5LlOT6I5u5r
         O4cdszOvmEeK0W9ELS0hAA+7PlTZN3CLBHlFTelHBvlezg1Z+lbg94CoaGFm62iMUZkK
         Xiv59LDItmiRfwgUgjCnV1aacOhb9odZOO/NRD7LGSk6Xaqiw0e23S0mvR5R0EJIZ7Yo
         YmvA==
X-Gm-Message-State: APjAAAXHqFHchVGDCGPB6nz7IkzfZnZex0U5c2s2Fw1svj6G98rPrkUj
        IqKLgkCs0N6ZMO2l+Clg3qI=
X-Google-Smtp-Source: APXvYqwdzSXe8laAnZLoUWFtrgWDX6TGmkfu2GpXTKn6RsbwxX/p9Y7bPP8wkPndVgnsltKfUVErBw==
X-Received: by 2002:a17:902:6ac2:: with SMTP id i2mr2381014plt.221.1578638300835;
        Thu, 09 Jan 2020 22:38:20 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id m19sm1102021pjv.10.2020.01.09.22.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 22:38:20 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 1/2] dt-bindings: arm: move sprd board file to vendor directory
Date:   Fri, 10 Jan 2020 14:37:54 +0800
Message-Id: <20200110063755.19804-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200110063755.19804-1-zhang.lyra@gmail.com>
References: <20200110063755.19804-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

We've created a vendor directory for sprd, so move the board bindings to
there.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/{ => sprd}/sprd.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/arm/{ => sprd}/sprd.yaml (92%)

diff --git a/Documentation/devicetree/bindings/arm/sprd.yaml b/Documentation/devicetree/bindings/arm/sprd/sprd.yaml
similarity index 92%
rename from Documentation/devicetree/bindings/arm/sprd.yaml
rename to Documentation/devicetree/bindings/arm/sprd/sprd.yaml
index c35fb845ccaa..0258a96bfbde 100644
--- a/Documentation/devicetree/bindings/arm/sprd.yaml
+++ b/Documentation/devicetree/bindings/arm/sprd/sprd.yaml
@@ -2,7 +2,7 @@
 # Copyright 2019 Unisoc Inc.
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/arm/sprd.yaml#
+$id: http://devicetree.org/schemas/arm/sprd/sprd.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Unisoc platforms device tree bindings
-- 
2.20.1

