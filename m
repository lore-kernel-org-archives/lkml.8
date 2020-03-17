Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61968C5ACC0
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D8120724
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=flowbird.group header.i=@flowbird.group header.b="SCcPbUq3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgCQQuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 12:50:12 -0400
Received: from mail-wr1-f99.google.com ([209.85.221.99]:35182 "EHLO
        mail-wr1-f99.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbgCQQuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 12:50:11 -0400
Received: by mail-wr1-f99.google.com with SMTP id h4so6012708wru.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 09:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W+6ZKJBJf+pKwV43v7D0zXLM6cx+OowEeRYTF5Vw6ZI=;
        b=SCcPbUq30tR/prj61InCo+jM2BXD3s60F25UdjYzuRQplgzUsltf69ymeBoRzIGEb0
         vtE9HsnpsSoXPVDZlyYzcw0wOTWlg+LFQ3J4cmoAKvVe2lIGr1AME+wH9LWyl6ECdkVM
         dZcR0yu7xcpgcBAEYF7/IBr6ljO+51N+9D4OUq42XvchQ3rXDK5Z1yO6tMJ3fkuRyrrQ
         8H5jtFeTC+UJNRqFXAqh6mSFAYuiHM6dAeoGBu3GAcae6jdbEIyeO5GKH9FcAUYcCzxe
         BOU+9LH9hJZ2j+o6OLA4qyPooBafGPTkK1WeCO4ri4Q0nEz8bIKVfXgGSOrW91M54usT
         ps9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W+6ZKJBJf+pKwV43v7D0zXLM6cx+OowEeRYTF5Vw6ZI=;
        b=fQwRT7nR/ohzzVJpaCfj7foGrhAAI82daGXMg1XXARywrmuagi4N94ZWhVd1mQxIaZ
         7+MCJUnOjtXCLPYVcPihX0ntnlfq/eSn01TmiNQAn3qNJQZ9RQQRpya+BUsAvW3Kt9iN
         bLCuf3Ib+UkI/oJFUv2ao8Grgna2qogOvufXlx6FpS0PzrJPbZf9tTlmuryC7BU3r5Ki
         6mj6Doz3OK4J+XKRUiSlCh+WJLLb8u5aXXI+jyi7OZRAEEq5jed0luPfYYwD9bRibDLA
         w4wuwJ0c1VCszEMyvNZWY6a82wY/t8x5Q9BADvUOKsV5LOaSifL6hJ80sZE/aCCNQuTu
         80Ng==
X-Gm-Message-State: ANhLgQ3Y2IuOX+6nVuASMw2Sm0WZV4f5IWks13u3O1cRyweC2zaoXuD1
        IJB9Wrgyim/6f6tkc/Mj7fDTcHLZJdt5weqpn2e3B/HkiKB8
X-Google-Smtp-Source: ADFU+vszNHfESmANhggvCujeZijt/jiQU/OqttiEYWULD0g88JMltQ686sxPnonItDyeMlLJfLJPdRvN4SRh
X-Received: by 2002:a5d:52d0:: with SMTP id r16mr6758202wrv.379.1584463810086;
        Tue, 17 Mar 2020 09:50:10 -0700 (PDT)
Received: from mail.besancon.parkeon.com ([185.149.63.251])
        by smtp-relay.gmail.com with ESMTPS id r5sm64059wrt.7.2020.03.17.09.50.09
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 17 Mar 2020 09:50:10 -0700 (PDT)
X-Relaying-Domain: flowbird.group
Received: from [172.16.13.134] (port=56876 helo=PC12445-BES.dynamic.besancon.parkeon.com)
        by mail.besancon.parkeon.com with esmtp (Exim 4.71)
        (envelope-from <martin.fuzzey@flowbird.group>)
        id 1jEFPt-0000dJ-Ml; Tue, 17 Mar 2020 17:50:09 +0100
From:   Martin Fuzzey <martin.fuzzey@flowbird.group>
To:     Fugang Duan <fugang.duan@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org
Subject: [PATCH 3/4] dt-bindings: fec: document the new fsl,stop-mode property
Date:   Tue, 17 Mar 2020 17:50:05 +0100
Message-Id: <1584463806-15788-4-git-send-email-martin.fuzzey@flowbird.group>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1584463806-15788-1-git-send-email-martin.fuzzey@flowbird.group>
References: <1584463806-15788-1-git-send-email-martin.fuzzey@flowbird.group>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property allows the appropriate GPR register bit to be set
for wake on lan support.

Signed-off-by: Martin Fuzzey <martin.fuzzey@flowbird.group>
---
 Documentation/devicetree/bindings/net/fsl-fec.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/fsl-fec.txt b/Documentation/devicetree/bindings/net/fsl-fec.txt
index 5b88fae0..bd0ef5e 100644
--- a/Documentation/devicetree/bindings/net/fsl-fec.txt
+++ b/Documentation/devicetree/bindings/net/fsl-fec.txt
@@ -19,6 +19,11 @@ Optional properties:
   number to 1.
 - fsl,magic-packet : If present, indicates that the hardware supports waking
   up via magic packet.
+- fsl,stop-mode: register bits of stop mode control, the format is
+		 <&gpr reg bit>.
+		 gpr is the phandle to general purpose register node.
+		 reg is the gpr register offset for the stop request.
+		 bit is the bit offset for the stop request.
 - fsl,err006687-workaround-present: If present indicates that the system has
   the hardware workaround for ERR006687 applied and does not need a software
   workaround.
-- 
1.9.1

