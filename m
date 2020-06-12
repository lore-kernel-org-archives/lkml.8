Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A50C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81D6A2081A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="AefmMVNZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgFLNEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 09:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgFLNEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 09:04:36 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C79C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 06:04:35 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id i12so3622715pju.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 06:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5vxKjtaR9J5KXw5QvNfVo9XkT2kELkwD9L/tBPahe7I=;
        b=AefmMVNZ/R+ZqcrsoxXAe4nIIuONGTsrV7IQ1oz2RDMIshK+C621Y6I6MwPTR7UvBe
         HTqpxVp0yg3Sv4F8pKf5X4XHgrSGA/PlMqqKjvzcZ6+dLlOAnwv4rLV8cfKYTWalwLtm
         MeF9TU73seMmRuTndpqMJ9IoeFI6F7+aCVqxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5vxKjtaR9J5KXw5QvNfVo9XkT2kELkwD9L/tBPahe7I=;
        b=RUUPxWu/ylAg0W8sjedvlFyVz5lJoXJ81X+Y7FLZDXsEJDPHMYdf4GCfSe/pIPXA5s
         dAH/4d8OmgIk0dLRfAERg1gNfG1sF9r6dCRjkn4TX9XpaOrozOxK1FYWlkteIM8MKpFP
         65GWvpprQg/FpY4wTZ/5L/p1xsTFKRmT2wMmxN7nzA4ODdOUTJs7umGZTkE4olkVD3tp
         H0dD/G9LZ/D1T+5nFE2NuQ0p0i64b/FEmmjNucs+f7bWxuhq8axvhDmuSDEcZjuuumIq
         K5A412flJcdou+ttmGVD78TefAitPXl2yXpkSqix+Ti85hcyzTcdeApSJc+gMooWGmET
         dlhg==
X-Gm-Message-State: AOAM5309st5ntRuYLN0iknSBsIAi9frMskakgwHAec58Rtk0Qu/3/078
        zbXpLK10sQ54uyxXdPRCh+dB6bF9noi7WA==
X-Google-Smtp-Source: ABdhPJwg76Eyt9sWMuI/3fYjUtxebHMP7gP8S+d0oooT1BSuAMCR7x5yEpWVIIRXwQDocI8k8yXCYA==
X-Received: by 2002:a17:902:82ca:: with SMTP id u10mr11301620plz.294.1591967073370;
        Fri, 12 Jun 2020 06:04:33 -0700 (PDT)
Received: from shiro.work (p1285116-ipngn200805sizuokaden.shizuoka.ocn.ne.jp. [114.171.61.116])
        by smtp.googlemail.com with ESMTPSA id k12sm5481939pgm.11.2020.06.12.06.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 06:04:32 -0700 (PDT)
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
        Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
        Doug Anderson <armlinux@m.disordat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Will Deacon <will@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 04/12] dt-bindings: vendor-prefixes: Add thingy.jp prefix
Date:   Fri, 12 Jun 2020 22:00:04 +0900
Message-Id: <20200612130032.3905240-5-daniel@0x0f.com>
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

Add prefix for thingy.jp

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 7c45b4c6fe40..70a8f2696427 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1036,6 +1036,8 @@ patternProperties:
     description: Three Five Corp
   "^thine,.*":
     description: THine Electronics, Inc.
+  "^thingyjp,.*":
+    description: thingy.jp
   "^ti,.*":
     description: Texas Instruments
   "^tianma,.*":
-- 
2.27.0.rc0

