Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2687EC35673
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 20:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EADAF206E0
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 20:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuHthbSm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgBWUr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 15:47:28 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38711 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgBWUr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 15:47:27 -0500
Received: by mail-wm1-f67.google.com with SMTP id a9so7268365wmj.3;
        Sun, 23 Feb 2020 12:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Kar0BRIwm/hkV7Y2Od/fnxSzLiibs0hSODGpZL5AmGo=;
        b=AuHthbSmvxmJ/eHHRobyzfyT3x0GMa8h0b9YbF3YbleYlK/HCOcSKFaVgM0yZLKhwV
         0xD2V5AThd1rp0oBVq+tjwKXT7kITDy5OfKItSDfcFLxStiGX+3uSXEDR3029zSazzkG
         To7YbHcTFCPaivlKLs4gY6JHEKREZIOyr9ResqxNr50nlTbzB6khc4yIGKAS+dn1fmmn
         4nh5BsMv3GSj9o5zp01TcUstj3RFV/+IpwFA+FTsMib9jJVBPeNv2aqiLEdhaIqRMOpr
         y/85Q/mFloAeqxvNb5cyUMcNMwt3JqSJ3mYSehj/TchJFwhaWz4asVc3PDqX6GIwVHSr
         /g5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Kar0BRIwm/hkV7Y2Od/fnxSzLiibs0hSODGpZL5AmGo=;
        b=gbsL3HUXQ3+ykphlVn6744moXunKhZZd5d/n/oVNaFwsH6gI4mh+XEE9HLvZauYVvH
         V0y6eYRyN98GCFHn5246AoxIGFJsFVPys0WVMx9L1sT3AV0KGgFCMjmkABej6WZ2/zjO
         F+EsjlcpJ/IK+P4MhDmALMfVhpKvQSZEHtCB7FhKazaDZ4W+HjiMxj84hhKfwwfc80F4
         bNFxKi5XC/aDLs/ZlEu1HPtSmqq+jRFo0vrXfpVsXEKALhOHURE0FjX//zr0+EpMcHRc
         +0hf0KblYa86q5Kanc6pHOR/JKzIhDKvN+J0h1Zid4U+cE5lxcSwaGFceATakNw/5FdQ
         qu9g==
X-Gm-Message-State: APjAAAWoTrBXPFsBmMBAS/Rw+LLTs/C5WjsLFdk4YOMh6+mt68CAwus6
        OSnXoxLg4Cx9g165p5yIBno=
X-Google-Smtp-Source: APXvYqzGICNTpRBiKAyl2HfGJxtb9L9b1P2a9dGGqxYvQxNg52zh/zCKokjt6JgpnXaK0BU0eEfChQ==
X-Received: by 2002:a7b:cf39:: with SMTP id m25mr17563385wmg.146.1582490844660;
        Sun, 23 Feb 2020 12:47:24 -0800 (PST)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id z8sm14817927wrq.22.2020.02.23.12.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 12:47:24 -0800 (PST)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        alexandru.marginean@nxp.com, claudiu.manoil@nxp.com,
        michael@walle.cc, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 devicetree 1/6] arm64: dts: fsl: ls1028a: delete extraneous #interrupt-cells for ENETC RCIE
Date:   Sun, 23 Feb 2020 22:47:11 +0200
Message-Id: <20200223204716.26170-2-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200223204716.26170-1-olteanv@gmail.com>
References: <20200223204716.26170-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

This specifier overrides the interrupt specifier with 3 cells from gic
(/interrupt-controller@6000000), but in fact ENETC is not an interrupt
controller, so the property is bogus.

Interrupts used by the children of the ENETC RCIE must use the full
3-cell specifier required by the GIC.

The issue has no functional consequence so there is no real reason to
port the patch to stable trees.

Fixes: 927d7f857542 ("arm64: dts: fsl: ls1028a: Add PCI IERC node and ENETC endpoints")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Michael Walle <michael@walle.cc>
---
Changes in v3:
None.

Changes in v2:
None.

 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 0bf375ec959b..dfead691e509 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -683,7 +683,6 @@
 			reg = <0x01 0xf0000000 0x0 0x100000>;
 			#address-cells = <3>;
 			#size-cells = <2>;
-			#interrupt-cells = <1>;
 			msi-parent = <&its>;
 			device_type = "pci";
 			bus-range = <0x0 0x0>;
-- 
2.17.1

