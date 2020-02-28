Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BE4C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0F6246AF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6h7dQTu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbgB1PyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:54:07 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35146 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgB1PyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:54:05 -0500
Received: by mail-wm1-f66.google.com with SMTP id m3so3750809wmi.0;
        Fri, 28 Feb 2020 07:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OOFEHVj+JcOh+bbozl0BvwwgTaBmwM+LnayM/zLQzRY=;
        b=M6h7dQTuj/gg8vCYZ3Vggdnnr7wbFEV1TH+tu5T5KD2nNjU7WtPHvZdRVhyAYpWZ/L
         xnfTamnFo3oj7YtO4F/kvgE8+w7C+CxSazkfxsaWDG0tJ6TS3twhsSJ94pD0Cmzicq3I
         Is5CddVGCxGWduTM3ZLJSUOPuruxxiGP58SpmEjD2bG/sW7CuyOqZfE09nG9xHC8Tqj7
         jJZH+RSwMg+4aRcWyMjyFKbWSLx5wcQjmvf4KgNw87miNylBzQ/kMSc4/JimNXnYW+yo
         E6Ytq4drArtVGfW55H7PEUNpHlPgOT5/6bbQtONaiDc4UZ9httr4ac9AelT/qOSom6BW
         OmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OOFEHVj+JcOh+bbozl0BvwwgTaBmwM+LnayM/zLQzRY=;
        b=lIGE+tXrnFJ9lmnoT3dY2BQiHapZncN8+WYcfWsS4F39l4atuhEkHSeqzcILfZZbCD
         8VOwe/lFn5EQRz6bAkTFbyg7i3c1nlrUgw/mzc16zrI8iA2ehlcURQHaF0pZfpV7Bj3z
         TZP7dk+LHy4cyjQKMQ4Hn064GSJ/ZOlfj4RAzeBQripAgFo1cnRiXKd1wajmXiehyE4r
         mA6pxds9++vWmzRtuwNhkdpHw0DlQaoYAY+C1hIgs/XhVIS/CA2Ia4ljTFZ9D9NmlnOC
         6q6ls9OkcMV+2XydXC4UOCm1wu3zRI9WdmgDsoXU5IGIqhFYzMJCswFd3p5TMaxmhzvJ
         VQAg==
X-Gm-Message-State: APjAAAWArhaJnpQbSGcxtxsp/tYfAnk7FhoeP0sLPIn/PS/zYjpwjM7k
        wfvUUxAJsHoIpvWSEnunBZs=
X-Google-Smtp-Source: APXvYqxW8XQ8dw2qaGsyhmIsF+VEhmRncnjxrYg06deIVUKojQrTiPK/4JCvhGVEkfnCdLo7Ne1nFQ==
X-Received: by 2002:a05:600c:114d:: with SMTP id z13mr5356877wmz.105.1582905243691;
        Fri, 28 Feb 2020 07:54:03 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id m125sm2706605wmf.8.2020.02.28.07.54.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Feb 2020 07:54:03 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ARM: dts: rockchip: add sram to bus_intmem nodename for rk3036
Date:   Fri, 28 Feb 2020 16:53:53 +0100
Message-Id: <20200228155354.27206-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200228155354.27206-1-jbx6244@gmail.com>
References: <20200228155354.27206-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives these errors:

arch/arm/boot/dts/rk3036-evb.dt.yaml:
bus_intmem@10080000: $nodename:0: 'bus_intmem@10080000'
does not match '^sram(@.*)?'
arch/arm/boot/dts/rk3036-kylin.dt.yaml:
bus_intmem@10080000: $nodename:0: 'bus_intmem@10080000'
does not match '^sram(@.*)?'

Fix this error by adding sram to the bus_intmem nodename
in rk3036.dtsi.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/sram/sram.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3036.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index cf36e2519..b62138563 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -101,7 +101,7 @@
 		#clock-cells = <0>;
 	};
 
-	bus_intmem@10080000 {
+	bus_intmem: sram@10080000 {
 		compatible = "mmio-sram";
 		reg = <0x10080000 0x2000>;
 		#address-cells = <1>;
-- 
2.11.0

