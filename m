Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A727C18E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17A021655
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrNGJzGF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbgCKMVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 08:21:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37407 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729363AbgCKMVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 08:21:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id a141so1887923wme.2;
        Wed, 11 Mar 2020 05:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Bjy8AO/uhgcJDLcwPUOIt+S4XzlyY0iXNSdbKltQ36A=;
        b=YrNGJzGF8Sz2KBSWeK/hf7PDvkuhUmUPaFUWpED2XjFzw8lBww62twa0MakQBVltJP
         QSVOZsRbcvEHxN3/9nroTf6TmN4ijSRMvcYGRUrD8ILrTI8x02H2uRtst5zkj79NME9f
         fbRMlZ5KFxbjcKsaPAtBbJfRqjFTvqAGdLc7LR4DAX2yJEg7yxfT2JApHkLu+/5BAKgz
         5RPMPL59oa9NJ5mbgSJho8Ku8mD9/LDcWmksukWb9N9YoIVhYOzXYOlZDaiWxSB7SgZW
         RclTYtjNVQsDIyIAiF/Mp11e25GRj2NZOBvAjC4YvjI/ehZiote6WpeYLRczD1+N4Ppz
         0dpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Bjy8AO/uhgcJDLcwPUOIt+S4XzlyY0iXNSdbKltQ36A=;
        b=W9R2/0bG5lUYE3Culp93u1GgbXkYWV4F5Aoza+JgAoSKCIDnaUXaZ7A1iKYMulfeMz
         1s6jKSFl3K2q6kn1T6N3HtmsIpQviI6MrraC7NzbXKBaTysSt6px/10fvOv6re+WUfLl
         hktaLYk+bZqKWyD5mUA3yW4xFKgMgpkxmAz6bHdesQWSf3MYHukEetTi4tLfph7/KiFo
         B+69gvupBzSLKBVzluKohNANw3QK7uVbvmyYqtdc/vMcFJ+zjfMiErx2s8O9aDraoOzY
         P2mH/tu2K7J7UfIJO5zV6WELlfLksA6QJKOaYKI0He5NqJdPQ3bexySx8HZEicsiufWk
         K//A==
X-Gm-Message-State: ANhLgQ1YaFbCre8BK7ThJ+F6ypcb2+kLW9cCnzX8tfTjbZ6UUd/dg/5B
        5ltVCiskvnesXD5H7xjTAGE=
X-Google-Smtp-Source: ADFU+vuoxl7Rnu55mlVmnlycYhZAAsnWZUu9SUYm83N5yQjSKn6nH0w8BR0h43FMBG0sXrWPe1kBGg==
X-Received: by 2002:a05:600c:2214:: with SMTP id z20mr3458638wml.57.1583929289117;
        Wed, 11 Mar 2020 05:21:29 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id u25sm7998875wml.17.2020.03.11.05.21.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Mar 2020 05:21:28 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: usb: dwc2: add compatible property for rk3328 usb
Date:   Wed, 11 Mar 2020 13:21:20 +0100
Message-Id: <20200311122121.8912-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives for example this error:

arch/arm64/boot/dts/rockchip/rk3328-evb.dt.yaml: usb@ff580000:
compatible:
['rockchip,rk3328-usb', 'rockchip,rk3066-usb', 'snps,dwc2']
is not valid under any of the given schemas

The compatible property for rk3328 dwc2 usb was somehow never added to
the documention. Fix this error by adding
'rockchip,rk3328-usb', 'rockchip,rk3066-usb', 'snps,dwc2'
to dwc2.yaml.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/usb/dwc2.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
Changes v2:
  Combine compatible properties with enum.
---
 Documentation/devicetree/bindings/usb/dwc2.yaml | 29 +++++++------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml b/Documentation/devicetree/bindings/usb/dwc2.yaml
index e95ba9373..d8d3c7c22 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.yaml
+++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
@@ -18,27 +18,14 @@ properties:
           - const: rockchip,rk3066-usb
           - const: snps,dwc2
       - items:
-          - const: rockchip,px30-usb
-          - const: rockchip,rk3066-usb
-          - const: snps,dwc2
-      - items:
-          - const: rockchip,rk3036-usb
-          - const: rockchip,rk3066-usb
-          - const: snps,dwc2
-      - items:
-          - const: rockchip,rv1108-usb
-          - const: rockchip,rk3066-usb
-          - const: snps,dwc2
-      - items:
-          - const: rockchip,rk3188-usb
-          - const: rockchip,rk3066-usb
-          - const: snps,dwc2
-      - items:
-          - const: rockchip,rk3228-usb
-          - const: rockchip,rk3066-usb
-          - const: snps,dwc2
-      - items:
-          - const: rockchip,rk3288-usb
+          - enum:
+            - rockchip,px30-usb
+            - rockchip,rk3036-usb
+            - rockchip,rk3188-usb
+            - rockchip,rk3228-usb
+            - rockchip,rk3288-usb
+            - rockchip,rk3328-usb
+            - rockchip,rv1108-usb
           - const: rockchip,rk3066-usb
           - const: snps,dwc2
       - const: lantiq,arx100-usb
-- 
2.11.0

