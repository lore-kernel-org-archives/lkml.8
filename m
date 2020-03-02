Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56C3C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 11:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0B221D56
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 11:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezO+T8QR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgCBL6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 06:58:25 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34974 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbgCBL6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 06:58:23 -0500
Received: by mail-wm1-f66.google.com with SMTP id m3so10402084wmi.0;
        Mon, 02 Mar 2020 03:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iflJIvqjKSNmZN001KRyauVV1RXmgC8qmOhi3NV99NM=;
        b=ezO+T8QRjR4ODnmGvsIE0lrcK6rPy0G8gECUFGVgsrkx9JZfsEO7a1N/l0qa1g3+3p
         n9fZhznzVJPWvdHdzTKWt4uKBQTOsdfsAOso0ewM9QgdzzEMceDBMZsX826sdfKXe8ZG
         B0aBxChJaMHAsWd1ZQ9PD6AajioSEiqiT+OPFhIXg5ikIs5Hf9K+OljC6iNLuYcyYOdU
         rs66rtLbIgtaBWhiSmd6Bxd8LD5D/FBkgec5bocLw+MQ/kOHyMp0+yqKdGL3qZA+bNkv
         8b8lTMr+fkYRhnAhL7lb5Qx3cI1OsfiGnIUStELGJr7jdeLSbvQIDJaOZtftoP+b26pI
         U24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iflJIvqjKSNmZN001KRyauVV1RXmgC8qmOhi3NV99NM=;
        b=eoKvr2xkuToQfqml/TTzIsXSASnK/b+VGQMjUUTr9YiWOiFMuWt2ziv2Rp0ikjqutc
         2F1LqCJQbtNkIMpg5VjtBll8QypU1Yj4Uzssi834xvsmD3RDyeZVM3OuJCvCxVvhPPbf
         orqsrFFRvOOqD3fW+iCwjQhEPJB0fAwdpWE/dJ9tIiJh9XLWy6Mz1Y5TjEqNVfcqcaOG
         fZn/8bH+KIdKprBk5Kna1k5HgK8Tf4dIK5n7YtjmK43hdxEUKI8J3vEaGfd557NxjnTe
         JfZmW7ol1Flme6Zhb05JegNEY39gC4PFVGWIh4lQwrKLw4WfRf7GoS/EFA343gpHXQ+7
         u4VQ==
X-Gm-Message-State: ANhLgQ1/r8HtMt3R94foibwptxqc6Zf265PYyaxaCiyO2uTXYg0enjMt
        6tXNuRUTFifxT6PcOP1YYSzcVnxO
X-Google-Smtp-Source: ADFU+vuOFSIJepvCdWl91GQTBHdvvIeCtHEsEkk20T6cmsn+Xd75wm81zY1l1J8AeghRp+J1fjLtQQ==
X-Received: by 2002:a1c:9d0d:: with SMTP id g13mr5238660wme.111.1583150300592;
        Mon, 02 Mar 2020 03:58:20 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id o16sm12653303wrj.5.2020.03.02.03.58.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2020 03:58:20 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: usb: dwc2: add compatible property for rk3368 usb
Date:   Mon,  2 Mar 2020 12:58:12 +0100
Message-Id: <20200302115812.7207-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200302115812.7207-1-jbx6244@gmail.com>
References: <20200302115812.7207-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives these errors:

arch/arm64/boot/dts/rockchip/rk3368-evb-act8846.dt.yaml: usb@ff580000: compatible:
['rockchip,rk3368-usb', 'rockchip,rk3066-usb', 'snps,dwc2']
is not valid under any of the given schemas
arch/arm64/boot/dts/rockchip/rk3368-geekbox.dt.yaml: usb@ff580000: compatible:
['rockchip,rk3368-usb', 'rockchip,rk3066-usb', 'snps,dwc2']
is not valid under any of the given schemas
arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dt.yaml: usb@ff580000: compatible:
['rockchip,rk3368-usb', 'rockchip,rk3066-usb', 'snps,dwc2']
is not valid under any of the given schemas
arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dt.yaml: usb@ff580000: compatible:
['rockchip,rk3368-usb', 'rockchip,rk3066-usb', 'snps,dwc2']
is not valid under any of the given schemas
arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dt.yaml: usb@ff580000: compatible:
['rockchip,rk3368-usb', 'rockchip,rk3066-usb', 'snps,dwc2']
is not valid under any of the given schemas
arch/arm64/boot/dts/rockchip/rk3368-r88.dt.yaml: usb@ff580000: compatible:
['rockchip,rk3368-usb', 'rockchip,rk3066-usb', 'snps,dwc2']
is not valid under any of the given schemas

The compatible property for rk3368 dwc2 usb was somehow never added to
the documention. Fix this error by adding
'rockchip,rk3368-usb', 'rockchip,rk3066-usb', 'snps,dwc2'
to dwc2.yaml.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/usb/dwc2.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/usb/dwc2.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml b/Documentation/devicetree/bindings/usb/dwc2.yaml
index e9f4cea21..14aeb67e8 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.yaml
+++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
@@ -45,6 +45,10 @@ properties:
           - const: rockchip,rk3328-usb
           - const: rockchip,rk3066-usb
           - const: snps,dwc2
+      - items:
+          - const: rockchip,rk3368-usb
+          - const: rockchip,rk3066-usb
+          - const: snps,dwc2
       - const: lantiq,arx100-usb
       - const: lantiq,xrx200-usb
       - items:
-- 
2.11.0

