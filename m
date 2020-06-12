Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D90BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FFF02081A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="Bp+EnSjP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgFLNDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 09:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgFLNDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 09:03:13 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AEFC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 06:03:13 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i12so3621379pju.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 06:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zFVtoiNjl4oNMGacca0AXJ3/iXBsqOkayEm+1Qa1zHs=;
        b=Bp+EnSjPOUJ1eV1lT+rQ/Iq2sJb89w6XMqQP1w1VdqIElaVRV2saN62kX3v9tOC2Gq
         GIMz4yxfEZ53TxmZTGwpc4J1DFsyc6GDl+nv9YpIYmSe31OXVi4s6wTEyNxKPWeD0Ncd
         Cz1Ba9KkwWGJpAkXZn7nedykAq6EDC/g6gR6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zFVtoiNjl4oNMGacca0AXJ3/iXBsqOkayEm+1Qa1zHs=;
        b=bRMQBLsGUDAqTEhd1q9J3bslnHS5AHq3x28BWkmp7CD7MrU2ycG5n9aIgiyMzhmi/P
         uaWucFEySWgKpbAz6k0dB/6F0K21BhkHEITetbOIUMHa1fXTpn0VUh26haYU8HD+CICq
         iAxWcbjRj1oHk+IlvN39qalQF1XVvf745UBff/D41fP5f93Hm4ylie82fbaGdQ+Y6c/n
         4tE6hOXXGO1kUxUmnYKu+B8AHZySZt8m7vub3zv1WnE8JVBPT9a3LjthpHGv5dRjZKDJ
         w2ZSTIjk26VwBQi5mGYFjVsH9liFA+l3n4ZGOlidF9H+Qu/n24v10ND07CDq/UssACvu
         Kd6A==
X-Gm-Message-State: AOAM531mb0fsiBXTy7lfUjJLVv2+aECFzBGN+uPN/fc5iKdOYYXcdxPp
        UWU7udGsfy9UVoRySBGLOaQYd7btfMuZNA==
X-Google-Smtp-Source: ABdhPJxLhwaoXhyApJdmwU+cJ78D3efrWpzxB05a1uevQvfO0cfy85Cc2vgBn1EEb0keJzGjIWtnQg==
X-Received: by 2002:a17:902:7c16:: with SMTP id x22mr11291382pll.244.1591966991703;
        Fri, 12 Jun 2020 06:03:11 -0700 (PDT)
Received: from shiro.work (p1285116-ipngn200805sizuokaden.shizuoka.ocn.ne.jp. [114.171.61.116])
        by smtp.googlemail.com with ESMTPSA id k12sm5481939pgm.11.2020.06.12.06.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 06:03:10 -0700 (PDT)
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
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Doug Anderson <armlinux@m.disordat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Will Deacon <will@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 01/12] dt-bindings: vendor-prefixes: Add mstar vendor prefix
Date:   Fri, 12 Jun 2020 22:00:01 +0900
Message-Id: <20200612130032.3905240-2-daniel@0x0f.com>
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

Add prefix for MStar Semiconductor, Inc.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ef6d75b9113a..86b569a0c008 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -678,6 +678,8 @@ patternProperties:
     description: Microsemi Corporation
   "^msi,.*":
     description: Micro-Star International Co. Ltd.
+  "^mstar,.*":
+    description: MStar Semiconductor, Inc. (acquired by MediaTek Inc.)
   "^mti,.*":
     description: Imagination Technologies Ltd. (formerly MIPS Technologies Inc.)
   "^multi-inno,.*":
-- 
2.27.0.rc0

