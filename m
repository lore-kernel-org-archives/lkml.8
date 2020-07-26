Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC7BC433EB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 04:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D653A204EA
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 04:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="Hq0kueyo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgGZEkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 00:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgGZEkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 00:40:14 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4A5C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 21:40:13 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id k1so7356522pjt.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 21:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D0MdPbFwkc7fKXzhQDxoLKwNc+TslVFTHzNYvgFbJfw=;
        b=Hq0kueyojRMANB+ONzvJX3y94df+VXRUr3vesrMvVO6RaXLyBDCJgSZgzbSYP8fVZg
         blAixup8nOqp7jwKx82A7+ri7wOOWzg0kl9kAm9d+7LM4ggmTuqrNjT3JxjLj11FoaZ6
         lSEqChkComE54IJuXEnoNDJ9/k68NxKfQD99w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D0MdPbFwkc7fKXzhQDxoLKwNc+TslVFTHzNYvgFbJfw=;
        b=H8yEY2o5/Ew6iF9GOdOFwYvuCpoG7JfGRS/15osm35R473lXTwupXySyWXk7M5PmYh
         LrJ2gztpQ9Kj4JRq2GdwyfOUtY1CKiEprmATVbxvzYiclk7zo1Kkl2qt28NvJjSVWnqm
         P2vNxY+VJ2Ck6wo7ala3TsIR1WYfuu+VtTm/Y2mTHMNk7p6RNftcqQvhKuIaVL01jMyU
         FL5CK7bCKLh8DxVe4XrWaz90OnvKrvjVsMmGvp8IeGivNmIcKiq5Et190cMEC1D6urdQ
         BYGWuBpfVNpdJYCeY3T2ry9KI2WPsffY6oUxU9hZ9mO/o1Y++0XYN54tXhzo7UIscktG
         DWlQ==
X-Gm-Message-State: AOAM530+HQybNuKkGmUdZPoBvyWGeu58mfmDm5wdaOt9YGxl9+9b3tAK
        FYUrmDD2dSK1g3/OwjCNO9K3eQ==
X-Google-Smtp-Source: ABdhPJx8UUWAmsUMGBRN15yQo65JR5PFxiqCwTqU5Olv1hgE9e9qsRE+MN6SPRLZX+SrQo3lHeMvJg==
X-Received: by 2002:a17:90a:2d83:: with SMTP id p3mr13088347pjd.124.1595738413058;
        Sat, 25 Jul 2020 21:40:13 -0700 (PDT)
Received: from shiro.work (p532183-ipngn200506sizuokaden.shizuoka.ocn.ne.jp. [153.199.2.183])
        by smtp.googlemail.com with ESMTPSA id t1sm10507372pje.55.2020.07.25.21.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 21:40:12 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 7/7] ARM:mstar: Add reboot support
Date:   Sun, 26 Jul 2020 13:39:48 +0900
Message-Id: <20200726043948.1357573-8-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200726043948.1357573-1-daniel@0x0f.com>
References: <20200726043948.1357573-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MStar v7 SoCs support reset by writing a magic value to a register
in the "pmsleep" area.

This adds a node for using the syscon reboot driver to trigger a reset.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-v7.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
index c8b192569d05..7ac7e649189f 100644
--- a/arch/arm/boot/dts/mstar-v7.dtsi
+++ b/arch/arm/boot/dts/mstar-v7.dtsi
@@ -78,6 +78,13 @@ pmsleep: syscon@1c00 {
 				reg = <0x1c00 0x100>;
 			};
 
+			reboot {
+				compatible = "syscon-reboot";
+				regmap = <&pmsleep>;
+				offset = <0xb8>;
+				mask = <0x79>;
+			};
+
 			l3bridge: l3bridge@204400 {
 				compatible = "mstar,l3bridge";
 				reg = <0x204400 0x200>;
-- 
2.27.0

