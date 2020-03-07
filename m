Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7E5C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 13:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA9B42075B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 13:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guNv2u8a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgCGNsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 08:48:55 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55452 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgCGNsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 08:48:54 -0500
Received: by mail-wm1-f68.google.com with SMTP id 6so5383195wmi.5;
        Sat, 07 Mar 2020 05:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2IH7KzQC1elq12VnowpNAipmMQUPET2Kh6DcuNwrX+E=;
        b=guNv2u8aad75h2Dy+CJemJg8fZOWKV4MRdf8+4vmo1vcdNRW4xM0xlxHbfDzcSVTWH
         lpKIilyU+OfrRv9S4WBaa9wGJYEmYtV8cQfsmwHTeKzpchK29R3S/OWZVMtH/DlKV+L+
         wdQvR7I0hckZ/b4y6ewyPLyuhF0n5h1/g1TXJiTwltIOG2NpgAckcU44N0O8PMVaDnpl
         Gr+DAdmg1TUfS0AVs0sDJVJu4PILQ/CYpCEgsqUHZ8ukdPqafisx3oJve9p5h6LMUdM2
         iozvkvfbM2szO74WAIW4QRYDCzVo5E/Pgp/J1w91GdxIGAz7diGsiwe9TAd1siaXorel
         CRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2IH7KzQC1elq12VnowpNAipmMQUPET2Kh6DcuNwrX+E=;
        b=ZMWw+clE1xcUAZL2nsJdXhgiM7ia9QVg4BhmwL+9pWW6cTZMicvtq/Al4L7fWeWZK1
         fd7Ub/J38audLNisn66XadIU2DYAmPQtYt9JC9RPvFwZEByrrPm7oQHX3K51I/ZmJC/6
         +9mnFSLZOtzY37VmDr1vp2WOn7jZjG1poXhpLt1oEFxz7g4eFysnjQXAFuxwB+KkEmgq
         OtTTB1vNuDYB78liM6C4/yEYGV+Lz5msysLDTA3khsl9TE0T5fWJEtyxjdgytMLBTT6/
         3YK67cgZ2znlUNYHLi5Umpe4tZeCqvLzQKv/wXPEJcwJjGQaeqfn6yhVIa7mXdTKeyib
         h6mw==
X-Gm-Message-State: ANhLgQ2Dk/cRPu+VP4Gc1yS3ijOjzWURIrBU43mvOGEXG5bLFHYX4FLL
        o1WuMuoJxw6zst3+1VukhReJL8Xf
X-Google-Smtp-Source: ADFU+vv3PgqIbCaqS+/cHZ/qOpqqVZm0POM2tszTay3g45d6g3SYV6XbuREuuyTf4OoiuGgSVA9FVg==
X-Received: by 2002:a1c:cc11:: with SMTP id h17mr10429280wmb.154.1583588930249;
        Sat, 07 Mar 2020 05:48:50 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id 9sm11767265wmx.32.2020.03.07.05.48.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Mar 2020 05:48:49 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/5] arm64: dts: remove no-emmc from mmc node for Rockchip PX5 EVB
Date:   Sat,  7 Mar 2020 14:48:39 +0100
Message-Id: <20200307134841.13803-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200307134841.13803-1-jbx6244@gmail.com>
References: <20200307134841.13803-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below does not detect all errors
in combination with 'additionalProperties: false' and
allOf:
  - $ref: "synopsys-dw-mshc-common.yaml#"
allOf:
  - $ref: "mmc-controller.yaml#"

'additionalProperties' applies to all properties that are not
accounted-for by 'properties' or 'patternProperties' in
the immediate schema.

First when we combine rockchip-dw-mshc.yaml,
synopsys-dw-mshc-common.yaml and mmc-controller.yaml it gives
this error:

arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dt.yaml: mmc@ff0c0000:
'no-emmc' does not match any of the regexes:
'^.*@[0-9]+$', '^clk-phase-(legacy|sd-hs|mmc-(hs|hs[24]00|ddr52)|
uhs-(sdr(12|25|50|104)|ddr50))$', 'pinctrl-[0-9]+'

'no-emmc' is not a valid property name for mmc nodes,
so remove it.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts b/arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts
index 231db0305..5ffd7b4d3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts
@@ -239,7 +239,6 @@
 	cap-mmc-highspeed;
 	cap-sd-highspeed;
 	card-detect-delay = <200>;
-	no-emmc;
 	no-sdio;
 	sd-uhs-sdr12;
 	sd-uhs-sdr25;
-- 
2.11.0

