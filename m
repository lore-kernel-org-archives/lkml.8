Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA37C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5481920772
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkAG+JzI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgGJJyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbgGJJya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:54:30 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A524BC08E6DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:54:30 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f18so5320041wrs.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DFfhRB3CIFp7+b9HYaYFBTlz+H/vZeZ2FswijDgFipc=;
        b=LkAG+JzIcrjWk6wsbbvoJiQ+Dhzfbf1ff68EZ4/MAk9dKnXdHGf5arbiMI5gEIKidJ
         jVLBKwoToirkaWTw8Gymu76RGj5XKW7rDwOKBs9QNf06BqMfOEjBw1kvsOElM+nBV4o2
         9tnPETwBjUFaMKuv4fkTS28qs3Z2qNp4EwUdt/k5gb+/o7aCikBb88sDGxc5aVaGQdvQ
         qSP07OBrupatkzVU+UukYqu2O1THtQAZEg2KKpuXBBLaDjKLWFoZEw/ugKH4jxf3mZ8h
         7XN+0HflMjzoV0c87Bg35XLqlJeC8Hjngypjmw5TzjavELK5bDrnoEPZJQD4RiATXL5l
         BniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DFfhRB3CIFp7+b9HYaYFBTlz+H/vZeZ2FswijDgFipc=;
        b=j5Azg9WnnbvsSjQ7IygpXsLmGgdwdoSQa0KzD0kWqHKoW7+Et61BxcdANoET8VK9sO
         0YPFqD1ej2sAJiUD14uleSvhF2PhJqjkvzVBRS0YU+fF8CuZr8848O24W5c76f/4ca7M
         61xSIn24o6x3L3N9Gs+sMeDm0tGHtiuUsGJJ+jHf+0TJorbXS+VVKK+WA0koL8QPzQ0F
         w2e9nCxml+Vni6DQ5/BvBx8fnJ0muOgAmy02BrLbaGEgKNvtY+AWCpN0nh9WQEYh1Ko2
         3dWc80bxAbPFtH6yagGNXtIaOUMOV/9/xRM5yIn8lqnVy1dCBk3w4laLfRKQXMaNrzIb
         W6FQ==
X-Gm-Message-State: AOAM5335VqgmLvhxifO4MP87Uf4btjSkfUxEAkrwYSU5SHTa8Q0iCnbW
        wlh+Rw0oNTlPtk8FayA9NxY=
X-Google-Smtp-Source: ABdhPJweU8vHChcfF7n6zCNGPvYpioyH/JYFNiQfISKnR8gO0ao1GlphavbGVRCAyGh9bV0XTNYxKg==
X-Received: by 2002:a05:6000:1006:: with SMTP id a6mr64201904wrx.332.1594374869330;
        Fri, 10 Jul 2020 02:54:29 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id u23sm10176092wru.94.2020.07.10.02.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 02:54:28 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v5 14/14] [DO NOT MERGE] arm64: dts: allwinner: force GPU regulator to be always
Date:   Fri, 10 Jul 2020 11:54:09 +0200
Message-Id: <20200710095409.407087-15-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710095409.407087-1-peron.clem@gmail.com>
References: <20200710095409.407087-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index 3f7ceeb1a767..14257f7476b8 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -245,6 +245,7 @@ reg_dcdca: dcdca {
 			};
 
 			reg_dcdcc: dcdcc {
+				regulator-always-on;
 				regulator-enable-ramp-delay = <32000>;
 				regulator-min-microvolt = <810000>;
 				regulator-max-microvolt = <1080000>;
-- 
2.25.1

