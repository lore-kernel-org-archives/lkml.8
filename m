Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F867C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3923A2089D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U6AY+0Ik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgGBGX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 02:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgGBGXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 02:23:55 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B344C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 23:23:55 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e192so28615971ybf.17
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 23:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Capr5djsyEnhWv3S70+sKnIxhHZKvTK2BCpibA16Fik=;
        b=U6AY+0IkBOoVPB2dSzvaxlfM89ciV2yrEH7+K/7aph/MHWU0rQICZPTeIH4We4nZEM
         lQh+TmddQt/DLQW9PTHOMHjOutneoY9KxRCFcVKFZfj1QfBpGOb49wPJ3YRTUjaVJ751
         v40vf43BI2pl5zr84D0dutjVhDJTAdL/xnmpi4q0siBr09JPhiy8Hpfe0A7wI4qkwR6d
         H50JZc3Ml9AbyVUpYBWk22gKfQntqu6JMD8/vDS7DOO9RrTsbUfXzmP0Fr9ilKR4igq1
         xiLcXoZvgB3t2gtiqW1v7IsWPfbcLyLCv7oOzSL6rGnrVoJtQXsSEI1wNfTgUo3ouaIo
         C/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Capr5djsyEnhWv3S70+sKnIxhHZKvTK2BCpibA16Fik=;
        b=rOk6RcMJDm2BYJodZU91wZVRNkB/MrPewHOVhLlQUy/yhJN7CYtKKRHCdck7dKUug7
         jwkFAHCuJjQFCbCWvF04UpWXL9WKiKMEgIOX1XiCE/9E+hoRkeHanWIz3eC8okkMij2B
         uQX338FGzBpIM2wEbpm2xunrxmw3j1YZoaJNkhsvsgJMWZGFODZDqFX46grp9FsLzAN2
         RlAEhwk3645opgQc9R1Q9GhN4xTt4WoHAyEImrnX4HduwSgY3pnmf5enn4iv8ju5bho5
         XK4ImrJJlywJkr4z+2mdQ2tpBfNelFQiFIDQd/a++f/CM5RY61aFTyTS0vG9ep/Bkesn
         KiCA==
X-Gm-Message-State: AOAM530Dl0JSXL3OgLz+sTj8LUvYCy4Q0Xv4as8tBwgJ4S5kMdbVE1Ml
        TXcwtd2R4GeUaA2L/mHqc6LwFdh7XGAs
X-Google-Smtp-Source: ABdhPJy7W3Ner6I27HbAR57C4mAp+BrPPho3YMhBs5gzoadgRkL+9hBU76n9YuqygWflTzhiTwqEwLmhnULw
X-Received: by 2002:a25:77cb:: with SMTP id s194mr36730723ybc.216.1593671034543;
 Wed, 01 Jul 2020 23:23:54 -0700 (PDT)
Date:   Thu,  2 Jul 2020 16:23:18 +1000
In-Reply-To: <20200702062320.2903147-1-amistry@google.com>
Message-Id: <20200702162231.v2.2.I0a814b246cfe47f8dd1e25553ee881cbcfd0d8eb@changeid>
Mime-Version: 1.0
References: <20200702062320.2903147-1-amistry@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v2 2/4] dt-bindings: regulator: mt6397: Document valid modes
From:   Anand K Mistry <amistry@google.com>
To:     linux-mediatek@lists.infradead.org
Cc:     hsin-hsiung.wang@mediatek.com, drinkcat@chromium.org,
        Anand K Mistry <amistry@google.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document valid mode values for BUCK regulators.

Signed-off-by: Anand K Mistry <amistry@google.com>
---

Changes in v2: None

 .../devicetree/bindings/regulator/mt6397-regulator.txt         | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/mt6397-regulator.txt b/Documentation/devicetree/bindings/regulator/mt6397-regulator.txt
index 01141fb00875..c080086d3e62 100644
--- a/Documentation/devicetree/bindings/regulator/mt6397-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/mt6397-regulator.txt
@@ -16,6 +16,9 @@ LDO:
   ldo_vemc3v3, ldo_vgp1, ldo_vgp2, ldo_vgp3, ldo_vgp4, ldo_vgp5, ldo_vgp6,
   ldo_vibr
 
+BUCK regulators can set regulator-initial-mode and regulator-allowed-modes to
+values specified in dt-bindings/regulator/mediatek,mt6397-regulator.h
+
 Example:
 	pmic {
 		compatible = "mediatek,mt6397";
-- 
2.27.0.212.ge8ba1cc988-goog

