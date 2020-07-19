Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1CBC433E5
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 14:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 386AA21775
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 14:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIm6NKGg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgGSOus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 10:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgGSOur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 10:50:47 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74BDC0619D2;
        Sun, 19 Jul 2020 07:50:46 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q15so19942495wmj.2;
        Sun, 19 Jul 2020 07:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E8fxn8xmoXXxI06WtEo7/3sCgUlbvQ6riq6n1XA5FHw=;
        b=NIm6NKGgHGyUHYKevDq2hMQwYaaIPgjVmvXVlEFgAy59MUOMRJjS8gM/e+/gvuecpp
         nid8rTW6/GcS0VJ2a+hkvAPU/r3x4TXrmpOA0l2hfMJz0EfDFuENIdu6A7ZnLjsWDszs
         uaahIcBQ4md5N4SQBwE6V9mLLP/1Awfpz/GledYxvSM2Hn+Hf3yIKnbn+U7Xlpaw8YEY
         uZKdHg5I47y/Gk2qwsjbIkbPi3ZCSUSc6KXj4PYcSvzQuZR3S+TFVIqneiMVhWSulKFI
         m4oMU/vXl+G8s6mKxOK7zwe9bKZ3Oyp2oVBFWt3xTzBjwupLnIPD67HVVa83Ww4ECbzi
         Jeow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E8fxn8xmoXXxI06WtEo7/3sCgUlbvQ6riq6n1XA5FHw=;
        b=NU0Pohi68KWaYJ2wXS4rGyt4IyMfiYpe7m30Y8vdSjoXj1S5aZwjjjjgwQrm7vek8S
         XLm/pTg0GpFoO5TILeHC+LuT6W7D9klfePAq3nPJDUxwHACSrHroXebi3gYprrwwqpQt
         ZLYqxyYaBXczJJUxbOuvgp2ONdH+okNS54exD/0M7XNcIo171ggGnmbaGh0f4V7U3yqS
         O+38Nv53CM8gWWLYQhp/PZw4uHsfY3OTL8xFL4sevGD4xO1YXtQ0hQAseraTvwYZDNld
         3RVM+FfY8RrARSYRifR1yybc8FgcXJdeOV51L1xUnhJE6M0yXqQAoS7XmZWtflxMTEcr
         GDCg==
X-Gm-Message-State: AOAM531/GgBiN2ertN6kqkzVuvF55d2kjiD9X8iYqpBWYooUtu/QgbM9
        DRQHUhwho4jRPvLVTiStj5U=
X-Google-Smtp-Source: ABdhPJzcjHxQ53y0kPX6NmZGP/nApfZxxY+shJw3ET34cTT4SE9uj9uSlRB/8c9hs5mB0OZJzXMMOA==
X-Received: by 2002:a1c:6a15:: with SMTP id f21mr6479739wmc.159.1595170245600;
        Sun, 19 Jul 2020 07:50:45 -0700 (PDT)
Received: from localhost.localdomain (arl-84-90-179-3.netvisao.pt. [84.90.179.3])
        by smtp.gmail.com with ESMTPSA id d13sm26422755wrq.89.2020.07.19.07.50.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jul 2020 07:50:45 -0700 (PDT)
From:   miguelborgesdefreitas@gmail.com
To:     a.zummo@towertech.it
Cc:     linux@armlinux.org.uk, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        miguelborgesdefreitas@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: imx6qdl-cubox-i: enable DSM for the RTC
Date:   Sun, 19 Jul 2020 15:50:28 +0100
Message-Id: <20200719145028.3370-3-miguelborgesdefreitas@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200719145028.3370-1-miguelborgesdefreitas@gmail.com>
References: <20200719145028.3370-1-miguelborgesdefreitas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miguel Borges de Freitas <miguelborgesdefreitas@gmail.com>

Signed-off-by: Miguel Borges de Freitas <miguelborgesdefreitas@gmail.com>
---
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
index e3be453..a226c4e 100644
--- a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
@@ -144,6 +144,7 @@
 	rtc@68 {
 		compatible = "nxp,pcf8523";
 		reg = <0x68>;
+		pm-enable-dsm;
 	};
 };
 
-- 
1.8.3.1

