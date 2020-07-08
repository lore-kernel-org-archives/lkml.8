Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0540AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 23:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFE84206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 23:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiV/nhyz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgGHXZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 19:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgGHXZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 19:25:22 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD69C061A0B;
        Wed,  8 Jul 2020 16:25:22 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id m22so83938pgv.9;
        Wed, 08 Jul 2020 16:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KEmBmUTwNSBWXMQPRmc67sBv10v3F7YWKTzYVbw+TgA=;
        b=SiV/nhyzb7anGw/Bm/QPEtl58g1GiRRq7kwSQbaLqnpoaX8iFL3SXXvZnDxaAudfHF
         vX+neNUcu2/PdQaEzEd0IhCY2s4aBPr9vMIDNA0LenxXh1VXbgHlhEZm+TrrJ0Appk88
         +gTS9K+c7KHSFWSu0eSKjTjSrWuPIp3D3UCTU/6dk4bFQW/cPJhQhPdbcb2VbEsdG92A
         nrqp4rQ3odgYcThIO5VJJtuUCv2R92WQ50h/eOVEK3mq4M6a6QQe2/XrXtySrC0/HGMF
         l3dxHw4F3mmK9E0Ew0SRluMsaFpxi93eLWwkusyX/wKQhFVozLoA+NsIa91DZZowEu9N
         bXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KEmBmUTwNSBWXMQPRmc67sBv10v3F7YWKTzYVbw+TgA=;
        b=o1GcpShgZ9sbJjVD8IthExL0+UKGkpwvqK6w7RbRtLI3meqP+rLvYXyEzW2QLclsLK
         3OS8ng+EJ00H8nmZRfCuxEBqul/QWiE1lnL4BZS826Z/SxmLARaoyyCWntA8AGZ+tqZc
         e1Tkp7WpoUEmtoTEEi3uTrrC6LsOBOuvoj2A5giAOfRCmhCHQNpp8gBybcy4WqrhRAy4
         FRDYdm7NUk3iyCTYrpy1wfi9dkrcwlpBQujmXDnhpuhGshd81KKEBYjRKruYQfBexxO5
         2v8kuMMOyF3vg1hDJDcSIlMeivFfoXgoofvVbo8InqEQXmZWmpvoA/U+5g9VhIZm03mG
         6p1Q==
X-Gm-Message-State: AOAM530Y9rpslBynwWJAVfbAezgGc548kTEGi5Hqk1/FJZrqnSku+iu/
        w3WIXd0CvghZyffUTif24WH9FwupEuVsDw==
X-Google-Smtp-Source: ABdhPJyBQJ7OXv/v/Ze/KPFjhaUgP0nBJ6UaCo3UtgwndeQt3s7FwziqvRWMeNcIO39g1QeMT5oTgw==
X-Received: by 2002:a62:c584:: with SMTP id j126mr31916695pfg.213.1594250721699;
        Wed, 08 Jul 2020 16:25:21 -0700 (PDT)
Received: from localhost.localdomain.com ([2605:e000:160b:911f:a2ce:c8ff:fe03:6cb0])
        by smtp.gmail.com with ESMTPSA id b4sm487793pjo.57.2020.07.08.16.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 16:25:21 -0700 (PDT)
From:   Chris Healy <cphealy@gmail.com>
To:     festevam@gmail.com, andrew@lunn.ch, shawnguo@kernel.org,
        s.hauer@pengutronix.de, stefan@agner.ch, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Chris Healy <cphealy@gmail.com>
Subject: [PATCH v2] ARM: dts: vf610-zii-dev-rev-c: Configure fiber port to 1000BaseX
Date:   Wed,  8 Jul 2020 16:25:01 -0700
Message-Id: <20200708232501.6200-1-cphealy@gmail.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SFF soldered onto the board expects the port to use 1000BaseX.  It
makes no sense to have the port set to SGMII, since it doesn't even
support that mode.

Signed-off-by: Chris Healy <cphealy@gmail.com>
---
v2:
- convert spaces back to tabs
- remove .dts from subject line

 arch/arm/boot/dts/vf610-zii-dev-rev-c.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts b/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
index 778e02c000d1..de79dcfd32e6 100644
--- a/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
+++ b/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
@@ -164,7 +164,7 @@
 					port@9 {
 						reg = <9>;
 						label = "sff2";
-						phy-mode = "sgmii";
+						phy-mode = "1000base-x";
 						managed = "in-band-status";
 						sfp = <&sff2>;
 					};
-- 
2.21.3

