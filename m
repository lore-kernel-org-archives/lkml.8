Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED58C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1B57206D6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pTVuXaPW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgDTSHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 14:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbgDTSHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 14:07:32 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A20CC061A0C;
        Mon, 20 Apr 2020 11:07:32 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ms17so202885pjb.0;
        Mon, 20 Apr 2020 11:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LKaQfIviMbu22B3fqLVbZ9vEpJhoTUYPWzdq2H9LhsU=;
        b=pTVuXaPWR9LFcA59WuIiYCYCo1UJcxJmd2iHegPyriYZanukjb9Owzt0b0oon3FB8t
         i+hCMTsf4yGJtqxDzs5+Lf7aJNsDH0f3HnBG6Q9uckBBSYlG1eXeYQ1S5t811xn3Ol/s
         HYYTW7XVyCO0iqFBhccMr1NqCIdmG9jSFM57hlz81ylQoIADotycpmgUCEgNfcZBp+8t
         SaMtOe+M/GlXWfmDbQkxj0oeroaWFiQOiL5O3UqyAqX46gxCX1nUnIELUdcow/w2703I
         w15JDyF4DDQ+KZ6F1Jlk5yNJk87ruRl6iOp1vXaXY/hlRh6al+la6naBV00kXyGU7RYk
         e6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LKaQfIviMbu22B3fqLVbZ9vEpJhoTUYPWzdq2H9LhsU=;
        b=lt9QM2NbK8Qnoc27jqzssNYIuByMWy4hbW1A7tey17mLxNdLsJRAGUhFzZUusU7oyV
         dX24D1LaNRDorHndhVOf6WOSPXOzhZuCYlhQdi7pnK1W4NQ9TDi+u/LPhAkYtXi4KYe9
         FjvTR4u2mkhV6+H7cg+syotgrOW4r7Dj7T49J3KGOpa1OMimVEx+d9hd0/9NbfzUoFEz
         AL/wP4Y8HwNZLl6bTRzCikopFVF79ZjkDZaDVpVYegpoam/oo5Uyf/Kz3uNyD1FxUgR9
         ye+baIYtwPY0Z8lDrErZDRAvkZrLepxMGSlWW7/Mm6nVNmWRWH1jN0VXkEe7qaIiOpjO
         O0Rg==
X-Gm-Message-State: AGi0PuZbIskQKltveddn4a+dDp9sO1X36D2rGHod+5wg2CUDHjdOmSZe
        tiJQQAA840oUKh71tsAEvAILY3b+
X-Google-Smtp-Source: APiQypIOhxUFH15iPLPaSArM9rdPhEHO484U/yoczwZkNd/bXbgqvEm2xcwnTTxXf8kJ4W6G+jJw7g==
X-Received: by 2002:a17:902:fe17:: with SMTP id g23mr15578009plj.68.1587406051230;
        Mon, 20 Apr 2020 11:07:31 -0700 (PDT)
Received: from localhost.localdomain (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id e7sm131193pfh.161.2020.04.20.11.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 11:07:30 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v3 2/3] dt-bindings: net: mdio: Document common properties
Date:   Mon, 20 Apr 2020 11:07:22 -0700
Message-Id: <20200420180723.27936-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200420180723.27936-1-f.fainelli@gmail.com>
References: <20200420180723.27936-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the properties pertaining to the broken turn around or resets
were only documented in ethernet-phy.yaml while they are applicable
across all MDIO devices and not Ethernet PHYs specifically which are a
superset.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/net/mdio.yaml         | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/mdio.yaml b/Documentation/devicetree/bindings/net/mdio.yaml
index 50c3397a82bc..9efb7d623f0e 100644
--- a/Documentation/devicetree/bindings/net/mdio.yaml
+++ b/Documentation/devicetree/bindings/net/mdio.yaml
@@ -50,6 +50,34 @@ patternProperties:
         description:
           The ID number for the PHY.
 
+      broken-turn-around:
+        $ref: /schemas/types.yaml#definitions/flag
+        description:
+          If set, indicates the MDIO device does not correctly release
+          the turn around line low at end of the control phase of the
+          MDIO transaction.
+
+      resets:
+        maxItems: 1
+
+      reset-names:
+        const: phy
+
+      reset-gpios:
+        maxItems: 1
+        description:
+          The GPIO phandle and specifier for the MDIO reset signal.
+
+      reset-assert-us:
+        description:
+          Delay after the reset was asserted in microseconds. If this
+          property is missing the delay will be skipped.
+
+      reset-deassert-us:
+        description:
+          Delay after the reset was deasserted in microseconds. If
+          this property is missing the delay will be skipped.
+
     required:
       - reg
 
-- 
2.19.1

