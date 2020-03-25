Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7804CC54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE6320772
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eReNsT3/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgCYKij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 06:38:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36594 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbgCYKij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 06:38:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id 31so2330663wrs.3;
        Wed, 25 Mar 2020 03:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/wgvz2lVpp5+P73ebkZ5cpJlG6NyplWSlH1ZFZco8LM=;
        b=eReNsT3/ql4XtBGPugbUGLIbqp4B391Ps/1xoYiR+OGIUAH8+B72MCrP2HlKPfoWaP
         pqYGsv0O8ZMQL6PQ+IalWVy372tw3azPRtzZgqDbyElePH+Tqh+q33JT2PdJ0HFxNGP5
         qRaT84ztZV1Oows1zWBxj5nUJUo4aoP26PcBpAec19SxZPm2MMk9Uq/svtyyxKJa3orv
         yvka7cvw1E52RdM4qI00bCg31CXx3lSjeUvvg7UbfjpHHVojeBhPr/W/FFRckGeye2FJ
         15R/lKijLyeFma7tkjaxFYbz40cTthdWPkHJoqQNrVmFBJPB1baHaW6/959pOfdz/cVB
         JpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/wgvz2lVpp5+P73ebkZ5cpJlG6NyplWSlH1ZFZco8LM=;
        b=NyQYEg2N4vhWsYaC8KGYmjPs+SxPCb0DZllR1/yTYEkoZr73ORNp8EfRfUdMzLGycG
         nMnaFlDN+hOMXAE+dN/ltwaf60dgjfvtgutq1G0IUMeXHHZecfZaTL7zkArsLgeCmI8a
         Tg9bWzVpSJzjBlwFDrP9cmEfzPUkYqhC2nNGPsl68dBqyQ4Fksq6fvCBvjwj5r60MAIm
         k6eDJRThw7urS3nYy2m+xglpoI3vuOGf93pK+kceFdhYLFjyBAqcFWKtLT0uHXV36rm6
         awVmOhJaky7aI6U7g/Q41AOIB7DMwlkzXq/OzClhUx6MvUIh8u9y10GNMJX0jdVPuU1S
         1sGw==
X-Gm-Message-State: ANhLgQ1qvsd9SnBFxsJ4ohkbcCS2SQOqf1bw5SYY5fQ33ul1FSkD042i
        n9b/NP8sm4kWSkJEbPngynkHytOs
X-Google-Smtp-Source: ADFU+vt2Dw8Gg8y8PXMVIdEPTxwRM9hacRHxiTFN7DEjZdRm/qg5K+XBLFsyyZk6b1ZiLZCI4gwDuw==
X-Received: by 2002:a5d:53d1:: with SMTP id a17mr2871409wrw.41.1585132716907;
        Wed, 25 Mar 2020 03:38:36 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id i21sm9163108wmb.23.2020.03.25.03.38.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 03:38:36 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] dt-bindings: display: rockchip-vop: add additional properties
Date:   Wed, 25 Mar 2020 11:38:28 +0100
Message-Id: <20200325103828.5422-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200325103828.5422-1-jbx6244@gmail.com>
References: <20200325103828.5422-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the old txt situation we add/describe only properties that are used
by the driver/hardware itself. With yaml it also filters things in a
node that are used by other drivers like 'assigned-clocks' and
'assigned-clock-rates' for rk3399 and 'power-domains' for most
Rockchip Socs in 'vop' nodes, so add them to 'rockchip-vop.yaml'.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../devicetree/bindings/display/rockchip/rockchip-vop.yaml    | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.yaml
index bc58c5132..497a9fb2d 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.yaml
@@ -75,9 +75,18 @@ properties:
       A port node with endpoint definitions as defined in
       Documentation/devicetree/bindings/media/video-interfaces.txt.
 
+  assigned-clocks:
+    maxItems: 2
+
+  assigned-clock-rates:
+    maxItems: 2
+
   iommus:
     maxItems: 1
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -95,6 +104,7 @@ examples:
     #include <dt-bindings/clock/rk3288-cru.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/power/rk3288-power.h>
     vopb: vopb@ff930000 {
       compatible = "rockchip,rk3288-vop";
       reg = <0x0 0xff930000 0x0 0x19c>,
@@ -104,6 +114,7 @@ examples:
                <&cru DCLK_VOP0>,
                <&cru HCLK_VOP0>;
       clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
+      power-domains = <&power RK3288_PD_VIO>;
       resets = <&cru SRST_LCDC1_AXI>,
                <&cru SRST_LCDC1_AHB>,
                <&cru SRST_LCDC1_DCLK>;
-- 
2.11.0

