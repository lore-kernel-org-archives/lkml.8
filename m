Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C488C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FB3220774
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7QuDTSV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441979AbgDOUCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 16:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2436756AbgDOUB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 16:01:58 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0774CC061A0C;
        Wed, 15 Apr 2020 13:01:57 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a201so1324036wme.1;
        Wed, 15 Apr 2020 13:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iCP6LoyFxExRJqxqIqO0ZCtpb3X9pIKnl0AtHQmrXjs=;
        b=d7QuDTSV3oT/GjNp4OI65qjAjBfFkEo24nuK8zFcOZnpgc4WHnAIJ8SmZNfPyM+nEw
         f1TGgcn+brikUxKXefZQn5XLEFe0rK7FFcAVWUjox8ZkUarOdcilxFfrVUWuE9dEyMvJ
         Mm/TnZZnifu8z6mOSWxAgjq2gtcWOhmZkGm1szp7nXtwAvD9T4f8gHAEv0QSxAVp9rx3
         HlJMAxZCU4uBPzH5GfScEBZNvTjWjkqjcK+DmgRK19x5a6P7AeVaSjRwcQezDFj+rSci
         xgxzBLKCXrHAGxCEebROVLDuC/030ioyihdjtlwmIY+/HRsocdtcI6JET7qhdqXOynsk
         oKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iCP6LoyFxExRJqxqIqO0ZCtpb3X9pIKnl0AtHQmrXjs=;
        b=hKfsR1V+7EiAQ1kDng4w02aRIxe+/0j95bF/ttlG1zoYLBYcU97ayYORkRNzKASthv
         41LEH8LWaaT+xrFULzdQ7ISMPxy+qESIEJh2zl+Or0O2E3UTBLTPVjY6kGGwFzqSYPcb
         5pld2KgoKjT6H2UoH5MGq6JmzTavZnMiIeCA0upGLChIj6Wzz70Nphekr+QLFesFhg7N
         lhLIsfPLC8Y/W70VFFB+MS9xpsXXun5x9vaLN8g13NSIW5q/IN7ZQ6Ky0HICpDLkWVwh
         oaiuYT190Qp9YXbIginorsl0suATKpkXTck75BDdldjYp2yWEGBn78OhRZofv9x6Wx0M
         MGvA==
X-Gm-Message-State: AGi0PuZgpgJBws8wUPhO2lQlRKqUkY3u8tYm0LJYzHxc2w0dDE8h7fpl
        IRUxSdzKNrKwpG4RiuTYx2k=
X-Google-Smtp-Source: APiQypIZiSysEEnEGOfY5fZpJcuccPWd4eDhfIDnRcThA/tstm0tS7BGJk0WDy4K33IfCgeGWrNurQ==
X-Received: by 2002:a1c:1b58:: with SMTP id b85mr896338wmb.112.1586980916609;
        Wed, 15 Apr 2020 13:01:56 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id s6sm736184wmh.17.2020.04.15.13.01.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2020 13:01:56 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
        hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: net: ethernet-phy: add desciption for ethernet-phy-id1234.d400
Date:   Wed, 15 Apr 2020 22:01:49 +0200
Message-Id: <20200415200149.16986-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The description below is already in use in
'rk3228-evb.dts', 'rk3229-xms6.dts' and 'rk3328.dtsi'
but somehow never added to a document, so add
"ethernet-phy-id1234.d400", "ethernet-phy-ieee802.3-c22"
for ethernet-phy nodes on Rockchip platforms to
'ethernet-phy.yaml'.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/net/ethernet-phy.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index 8927941c7..5aa141ccc 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -45,6 +45,9 @@ properties:
           bits of a vendor specific ID.
       - items:
           - pattern: "^ethernet-phy-id[a-f0-9]{4}\\.[a-f0-9]{4}$"
+          - const: ethernet-phy-ieee802.3-c22
+      - items:
+          - pattern: "^ethernet-phy-id[a-f0-9]{4}\\.[a-f0-9]{4}$"
           - const: ethernet-phy-ieee802.3-c45
 
   reg:
-- 
2.11.0

