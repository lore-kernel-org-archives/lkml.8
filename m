Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA203C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B98FE206D6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pC/QH3Mn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgDTSHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 14:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgDTSHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 14:07:30 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8217DC061A0C;
        Mon, 20 Apr 2020 11:07:30 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id d17so5468839pgo.0;
        Mon, 20 Apr 2020 11:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NjbIZ9kXNtH610iEU0/oYrdkcb6b6Mn+yf22ebIwisQ=;
        b=pC/QH3MnIqxV8fIjXPl/Q4XSa3qODVsDaUdtGydW5Az5HhFk9jIrxI/8DYwVk9qc8b
         vKb0X44fx/Um5z0EC2SN4RAJP94VeoQ0YUVLkKdVJ3ajPc4IM5KEggMPRaO1oebzKh9x
         yIm/vPkmm5dixFINI2AloGtN1uYD5LjYwPgG76xA3TcTQlAGl/ZuS7f+jzFZqRG3ddUw
         Hxy7XKaDFQM2Y7OoY9uQeSGJI4Z59ZbNIp3TUskRLnTR50qyVsgCXcS9rA4kTtsjU65G
         +SfZMrOTYULO/CwZvGv9GNyIygvTAROTwIUxm7xmtnz0erhVJvNTavOr+9+8+urtsPbm
         IeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NjbIZ9kXNtH610iEU0/oYrdkcb6b6Mn+yf22ebIwisQ=;
        b=E6/tIx6C1myJMDe6HFycYaokwlMAtkoCeZ99NR5MM3ykbjwcf/7XFlJNg/o0r4ncHv
         nHUrngjwd4q/eIBNf6LeAcOuY0MvxUW/Y2vMs7nEmD/tq14zStPkIqcXjfuJAf0VOiDE
         ZW3Kmxq5YWZFlknFs20xGJvU62eDsCk/xT7EcjcEEIu4cPNJ4dXFVnxuXycC9UHwsGjf
         BcfKP6KVAq6stPwvee4WBRZX5/+PuRz8ReFp7k2kTUSdzdXTW61+dKUVzNSdJf184E6p
         aZik4LwYsi+1nfIloP3ogoX5BeNxDEdkla0DrFdZ6jjaawzGSfh7Q5GKmT8jsS8zYBCZ
         gyzg==
X-Gm-Message-State: AGi0PubmAaTu7ch/ZpeOMrGbvqVB/cDO9R9Dc6+gFOynod/l5tXZalFm
        4DBXAL+UB94jUSpneMzE0QLTFVhf
X-Google-Smtp-Source: APiQypKkoO5Z14ZkGCHBYJTFhJvvyTod6ubuSurjHB94GYvaUi739IFI7INaOKLm/b8Iuy6v327UBQ==
X-Received: by 2002:a62:e80e:: with SMTP id c14mr17303729pfi.83.1587406049673;
        Mon, 20 Apr 2020 11:07:29 -0700 (PDT)
Received: from localhost.localdomain (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id e7sm131193pfh.161.2020.04.20.11.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 11:07:28 -0700 (PDT)
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
Subject: [PATCH net-next v3 1/3] dt-bindings: net: Correct description of 'broken-turn-around'
Date:   Mon, 20 Apr 2020 11:07:21 -0700
Message-Id: <20200420180723.27936-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200420180723.27936-1-f.fainelli@gmail.com>
References: <20200420180723.27936-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The turn around bytes (2) are placed between the control phase of the
MDIO transaction and the data phase, correct the wording to be more
exact.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/devicetree/bindings/net/ethernet-phy.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index 5aa141ccc113..9b1f1147ca36 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -81,7 +81,8 @@ properties:
     $ref: /schemas/types.yaml#definitions/flag
     description:
       If set, indicates the PHY device does not correctly release
-      the turn around line low at the end of a MDIO transaction.
+      the turn around line low at end of the control phase of the
+      MDIO transaction.
 
   enet-phy-lane-swap:
     $ref: /schemas/types.yaml#definitions/flag
-- 
2.19.1

