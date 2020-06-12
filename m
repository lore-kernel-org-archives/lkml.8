Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0903C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C079B20801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="v5LIkUnU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgFLNEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 09:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgFLNEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 09:04:07 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96265C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 06:04:06 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e18so4099098pgn.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 06:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XxDkda8O67HgHGJSLFTrtV7JMSfXrWrn5BJlGMpDUew=;
        b=v5LIkUnUnF2+bxJwj82k5O3Ugtx+V+dOnpssvRtDYX+KsvElv43rxkxrOOUV/zuGnN
         bm54gsNjWwVP4WCpw5aBqG3GjMIVZH6QB6WYJ5fJk0Ri2vbBVR/ZWwoE775ZJ2mNzs1L
         Xi9bznFrxDfQwG3cqR4VwmgWt2Y7PJNlj0x6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XxDkda8O67HgHGJSLFTrtV7JMSfXrWrn5BJlGMpDUew=;
        b=oLo/t/qsQYRnlumwFzgiWHhYb1KogyDzehxBQ8pLUTC3skIZH+zxo5vTwEmzSlMeIc
         I/Ak7DZeaqEnoM2lAfvsO1K6btroqsrGhgiKsPcAG9pHidhn6kYZYBcaa4FlYIj5vHp3
         9RdFiOfgTCMIuXanczb4pddUPmCWsbGfRURcAuv12V5AsQYVUedmcPjYvOr5im1eOpjj
         ASiqjk6O81/kDKy38iPUo99H4goNjPjxawomxJOIFfwHm889Acv8dtEpB7O+hkFRWAWF
         p+F9LcrOUlhINVp65RlS2x250R3ElZ4PKuHoCm6/42PH8cq0UpcP8kaGSJjPPc7Cht7U
         KpWA==
X-Gm-Message-State: AOAM533JmINrOyLVq1H08Ezer4Cb+whk10pYUxQCn027J9Raa6z8oe5t
        9xVFHH2Bx3sp8caYBkh9SJXt+d7I14oGDA==
X-Google-Smtp-Source: ABdhPJytiIJDeVXmChbd5bb89VuMarC4J8a0f2CzkWR4+onp+oE0ehGtriSY+VxWyDm+C4WNZXHdkg==
X-Received: by 2002:aa7:9f10:: with SMTP id g16mr11840277pfr.47.1591967045681;
        Fri, 12 Jun 2020 06:04:05 -0700 (PDT)
Received: from shiro.work (p1285116-ipngn200805sizuokaden.shizuoka.ocn.ne.jp. [114.171.61.116])
        by smtp.googlemail.com with ESMTPSA id k12sm5481939pgm.11.2020.06.12.06.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 06:04:04 -0700 (PDT)
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
        Mike Rapoport <rppt@kernel.org>,
        Doug Anderson <armlinux@m.disordat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Will Deacon <will@kernel.org>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 03/12] dt-bindings: vendor-prefixes: Add 70mai vendor prefix
Date:   Fri, 12 Jun 2020 22:00:03 +0900
Message-Id: <20200612130032.3905240-4-daniel@0x0f.com>
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

Add prefix for 70mai Co., Ltd

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 314a2ddcb6a0..7c45b4c6fe40 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -23,6 +23,8 @@ patternProperties:
   "^(simple-audio-card|simple-graph-card|st-plgpio|st-spics|ts),.*": true
 
   # Keep list in alphabetical order.
+  "^70mai,.*":
+    description: 70mai Co., Ltd.
   "^abilis,.*":
     description: Abilis Systems
   "^abracon,.*":
-- 
2.27.0.rc0

