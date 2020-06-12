Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A03C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DE8420792
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="A3WWYsIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgFLNFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 09:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgFLNFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 09:05:03 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAD5C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 06:05:02 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id ne5so3620001pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 06:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4vHmV15pvTuxcnNHNJqFUF5syqcXyyEAOXSJ5/cf22M=;
        b=A3WWYsImEEOqMez/ZJ06SYg+jhnolFaaDZqe7H+eYUw0R75IoOwbW2fIBQJSXMVGFs
         4uVMyzTwq6676zRYmMsAYtRvgYtI67TvzvRRlpozn+hQxow1jei1Z8N28yVpXH4ETxVR
         qnWiAA6O5D6SWdZkpZgstkYmP8B8eL6Equ/Mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4vHmV15pvTuxcnNHNJqFUF5syqcXyyEAOXSJ5/cf22M=;
        b=GRHsBXi0tvN4A74/nT62Z+A1aziKTfW6rCaePftJmGPvYDmmmyTEeSp5itHKqw04fN
         EOyzLTOF+f1TkDwJhOVsVk4rmcYolUCkSUzRI1B/+d1ajH0VxFKvxmx3e5ZlS819Jdjd
         qqTw4nBxJF8V+PBInyj0/TedhvI/sfqAkhSwSR9FtQ+D9CFavN8Jhy7CnZx4zeNOLmQJ
         gq2xixKY8RYiP1TzkvvWd8YvgeLHWD4EG4wMeqFf9XdoUzsT3wef5gz20bIMdMDRqix/
         AbtOxOeq0qAxQCGyMggTuSzslLQwDGSIOBlFaxMUuFUdfofT9vgC1fPn5Pn/813FC+dx
         xi2g==
X-Gm-Message-State: AOAM531f6kVfImcQ+D4CJTcYV4PdOfk2P8UUqL0urLs2J+LwsE9EOL8p
        /DHI5zHPXlMt6A82ynApzwT/UzhHqMk79Q==
X-Google-Smtp-Source: ABdhPJxqETrV/iuA8Ip8gK6XEQz+Oa4LZk63JEndPG/JrYOaZDGEFgqbuBRuBHxe/r4eEHuEHgprwg==
X-Received: by 2002:a17:90b:3d7:: with SMTP id go23mr12862528pjb.157.1591967101454;
        Fri, 12 Jun 2020 06:05:01 -0700 (PDT)
Received: from shiro.work (p1285116-ipngn200805sizuokaden.shizuoka.ocn.ne.jp. [114.171.61.116])
        by smtp.googlemail.com with ESMTPSA id k12sm5481939pgm.11.2020.06.12.06.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 06:05:00 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-kernel@vger.kernel.org
Cc:     daniel@0x0f.com, afaerber@suse.de, devicetree@vger.kernel.org,
        Daniel Palmer <daniel@thingy.jp>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Doug Anderson <armlinux@m.disordat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Christian Lamparter <chunkeey@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 05/12] dt-bindings: dt-bindings: arm: Add mstar YAML schema
Date:   Fri, 12 Jun 2020 22:00:05 +0900
Message-Id: <20200612130032.3905240-6-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20200612130032.3905240-1-daniel@0x0f.com>
References: <20200610090421.3428945-1-daniel@0x0f.com>
 <20200612130032.3905240-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds some intial boards for Armv7 based mstar platforms.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 .../devicetree/bindings/arm/mstar.yaml        | 33 +++++++++++++++++++
 MAINTAINERS                                   |  7 ++++
 2 files changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mstar.yaml

diff --git a/Documentation/devicetree/bindings/arm/mstar.yaml b/Documentation/devicetree/bindings/arm/mstar.yaml
new file mode 100644
index 000000000000..633e89f415cb
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mstar.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/mstar.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MStar platforms device tree bindings
+
+maintainers:
+  - Daniel Palmer <daniel@thingy.jp>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+        # infinity boards
+        items:
+          - enum:
+              - thingyjp,breadbee-crust # thingy.jp BreadBee Crust
+          - const: mstar,infinity
+
+        # infinity3 boards
+        items:
+          - enum:
+              - thingyjp,breadbee # thingy.jp BreadBee
+          - const: mstar,infinity3
+
+        # mercury5 boards
+        items:
+          - enum:
+              - 70mai,midrived08 # 70mai midrive d08
+          - const: mstar,mercury5
diff --git a/MAINTAINERS b/MAINTAINERS
index 77a3fa5e3edd..c44070f76a1b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2110,6 +2110,13 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-pxa/mioa701.c
 
+ARM/MStar/Sigmastar Armv7 SoC support
+M:	Daniel Palmer <daniel@thingy.jp>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+W:	http://linux-chenxing.org/
+F:	Documentation/devicetree/bindings/arm/mstar.yaml
+
 ARM/NEC MOBILEPRO 900/c MACHINE SUPPORT
 M:	Michael Petchkovsky <mkpetch@internode.on.net>
 S:	Maintained
-- 
2.27.0.rc0

