Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141D1C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 22:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBB2C2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 22:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/uKHeCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgGOWJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 18:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgGOWJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 18:09:30 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745F1C061755;
        Wed, 15 Jul 2020 15:09:30 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a24so2711957pfc.10;
        Wed, 15 Jul 2020 15:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iXUu1B+e2hu89plusvhYUpAqCkvjgD3XbXtinUQy3AM=;
        b=J/uKHeCUX/uvVp4F0hlELkMzTPPDkIhErFja0Nou/OUYDcxm3S/al0zczKhaWHCWWL
         +qrNf0OhvBTaV+YPEGA9C68OLamKFFbaZ/dcNpGqTKhLe6MJ2Gpg7DBs9GcTqiMoabd4
         hE4TGUTmb/ikmCC5bTyi/9vpt3b5i5ld2m8BscPfRtmodtHjkYfc8xNQiGeiN25vpveZ
         XyE0KKVxv4Sis/kLEFgDi5jv87fqwQBrlliQGIxD9AxeDrFzSjDQsoK0uLmt6Rbtyg22
         JrocBMUolEH3N86iBU+wvx9fMJYeoFK8yF8XNGvOhZv8J3sE26bLslxG01fiIM7clOf8
         +ahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iXUu1B+e2hu89plusvhYUpAqCkvjgD3XbXtinUQy3AM=;
        b=KZIxRODY0jHkvqgjpSQ+4VuL+yDxS/OXI9UnMK9K3wvRbkV4uG2mhv1WniZ5vEPFlD
         TODWbDTjZmcoKTSXd6EbCjSUseZW8O+JLY7pk/e0vqmgx/eeqMFmFWHCcGVyLNf/NwHt
         NMpCpKSnvYkYvgccsfS/zFnz7rtUyIomQj9Ab0aCxwd3kofumVWrMHuEPs2hrJm91Chq
         /4f88onGiCM+QyhAYKuhUqa6a10jruLp+B5ld5wxTC/N2TPQAlcnr2kXCwQhdnoyQmP2
         uYnM9C4hLdl6K2f4ZzH1lhJt4WN+4i88xkf4alebGz1R6Dw5MR+2nWe3i6tKETdmQekx
         v6Ng==
X-Gm-Message-State: AOAM531BGi4M+MyWRWsPzjclBFSyTYHzWLZ9VsIDz81HEQc650+hlJ5I
        eYCQUMy+j1PsWQa9OIQkrAQ=
X-Google-Smtp-Source: ABdhPJwZXIPr+Pj6FB3BWSb0imr4lOp5785AjF1OEkiJwH49VcK9cPl/dzZK/qHuAYLptDbpH6TqDA==
X-Received: by 2002:a62:7bc9:: with SMTP id w192mr1132848pfc.255.1594850969862;
        Wed, 15 Jul 2020 15:09:29 -0700 (PDT)
Received: from localhost.localdomain.com ([2605:e000:160b:911f:a2ce:c8ff:fe03:6cb0])
        by smtp.gmail.com with ESMTPSA id g19sm2744233pfu.183.2020.07.15.15.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 15:09:29 -0700 (PDT)
From:   Chris Healy <cphealy@gmail.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, stefan@agner.ch,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        festevam@gmail.com
Cc:     Chris Healy <cphealy@gmail.com>
Subject: [PATCH] ARM: dts: vf610-zii-ssmb-spu3: Add node for switch watchdog
Date:   Wed, 15 Jul 2020 15:07:58 -0700
Message-Id: <20200715220758.3106-1-cphealy@gmail.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add I2C child node for switch watchdog present on SPU3

Signed-off-by: Chris Healy <cphealy@gmail.com>
---
 arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
index b3d6d4b9fa9c..d55ceb5afe1d 100644
--- a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
+++ b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
@@ -225,6 +225,18 @@
 	};
 };
 
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	watchdog@38 {
+		compatible = "zii,rave-wdt";
+		reg = <0x38>;
+	};
+};
+
 &snvsrtc {
 	status = "disabled";
 };
-- 
2.21.3

