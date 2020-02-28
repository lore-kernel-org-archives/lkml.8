Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D557C3F2D3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240E0246AC
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwo5krf+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgB1PyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:54:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56020 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgB1PyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:54:04 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so3665195wmj.5;
        Fri, 28 Feb 2020 07:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UnHHbDAdvtO8h9pXqYzVSvwO5cpEfaizem81sO0+IbY=;
        b=mwo5krf+TP5YBV5kCqHdALropR3rGAaQPQsSeAaFDvT2KfJzzpDpld41PsWOUPu9yR
         SfSsCCsqYezsVUy3MiyzNU/Bnv94YNEc7xPAbPYPs/ltISG4s48rOBM8Scuv7C0/X7Sl
         301ht93Ts+gu42aRFMDDqMLy5R6CcATxiv5ZM45/A3OunnWT1z0oajeks3rZWD758uJx
         4P0u/yGI/UKCdGERRsTcz0nA8T6lDz17A5YvFtVUqPbnxG2yVske1fPD0MHSvsuD+ph7
         MqFPm1AYZ7RAvPVoCGbVfkc6UWR61hqWTALElFQW9P+adRA/er6teHLTFkpo6EzFJrPX
         oPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UnHHbDAdvtO8h9pXqYzVSvwO5cpEfaizem81sO0+IbY=;
        b=WHlO+ocCCdTTP/upibjZe3hEgTvv5wU96bOL4OPTPFAqFjSizUDnyoPXmZLwuW6sdT
         YYqM3N6zrEhtK+yy3eqKcC88+wHAGgrTKdkzZivd3P2gz+Cn5VOAb3dwY7w9nt0Xssah
         GfMPLe0U7gx5D9A7+IkqgbroRt0l/gauLRu5hJfkihAROePUrn2hxL5OhfFQ+gj7VqvF
         xia7wxBMM95W6IJQNvY98VCa4Opgdfch5CdIGX/N7Ht03D2KzSKdBwxzdDmd4Wgtcph/
         G6nmBwLgAuX54uU4PPoj6AsNA4kqeSbIgzdUG5qPCCH/2fweXsrnjGa/NdCASnaTXOfA
         zy/Q==
X-Gm-Message-State: APjAAAUe16pR6Xt0YtyU0WfAVCMX9XEzmilr2atEYx7pimQ+cXxxZq/j
        RX3603YVDc2sa96C70Q2r8A=
X-Google-Smtp-Source: APXvYqy6MHSQi7PXS4Pw8FIuZnkKbkV4byY5sYhJHmJnRPExf678SmIF2GPxvBOpO9OP9PzhBQTIKg==
X-Received: by 2002:a05:600c:414e:: with SMTP id h14mr5324321wmm.179.1582905242754;
        Fri, 28 Feb 2020 07:54:02 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id m125sm2706605wmf.8.2020.02.28.07.54.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Feb 2020 07:54:02 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ARM: dts: rockchip: add sram to bus_intmem nodename for rv1108
Date:   Fri, 28 Feb 2020 16:53:52 +0100
Message-Id: <20200228155354.27206-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives these errors:

arch/arm/boot/dts/rv1108-elgin-r1.dt.yaml:
bus_intmem@10080000: $nodename:0: 'bus_intmem@10080000'
does not match '^sram(@.*)?'
arch/arm/boot/dts/rv1108-evb.dt.yaml:
bus_intmem@10080000: $nodename:0: 'bus_intmem@10080000'
does not match '^sram(@.*)?'

Fix this error by adding sram to the bus_intmem nodename
in rv1108.dtsi.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/sram/sram.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rv1108.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 9bb109d66..c3621b3e6 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -102,7 +102,7 @@
 		};
 	};
 
-	bus_intmem@10080000 {
+	bus_intmem: sram@10080000 {
 		compatible = "mmio-sram";
 		reg = <0x10080000 0x2000>;
 		#address-cells = <1>;
-- 
2.11.0

