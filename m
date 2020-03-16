Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1C5C2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660A620575
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTSg24jq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731573AbgCPOdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:33:54 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33949 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731535AbgCPOdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:33:54 -0400
Received: by mail-lj1-f196.google.com with SMTP id s13so18921520ljm.1;
        Mon, 16 Mar 2020 07:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ze2fZQQej6uS2QviuuQ6/4nfx3KKsQROZMmrRSSZ7Mo=;
        b=WTSg24jq5f01YWvW8xwVD7FeWVKRz0ev4TrAtFnCp7bQttppRvY61XPKhpHSPTpJxa
         Jqt0OkgtbYRv/kB2p3JPMJwQsUhWVOHReNRhcUwHwrbbR1B2Mj7WBR5AzhGZ4G9HEjDM
         Fe0twJ1FTBDULVIH52D/u4zws9crwTPxXQTJ/8FDaqJJQvkwD6cRpYStxmGtNuCgllq3
         6/FDqNggxXFSlY+QpIhbKD0fb+xNsmzLIeRgE72Zj7gY377+3ihNuZu+x+LL/TFG2Zky
         4K/3TXWoPvGGXSK+W3z3ALoKJt2EZWFnGROZppSCFc5NNooE4Oly8G/OnD34XmlOCZNq
         0W/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ze2fZQQej6uS2QviuuQ6/4nfx3KKsQROZMmrRSSZ7Mo=;
        b=Fw752n+/XgF+5qi/dOl5G2dA6XYO2PZeXiIn2kDTSKiKpCLwax1+NECfHD4uCJF5Ti
         HDINhUHUou4qzCS0YBuLmied80BkBfWVnongb2xveRRIEH5bjiLroXcCk8SKBATP9m2D
         DdOOBFM+krKKfPFWS3MsDEeeO042+4zi2CDSU5TEzut6J7WTJGqnFjgUpatSuB21yIuv
         T/JhZz2sS2He/jgF622VE9x1saDS7/bv0Dna5zg5nqZggUS/rAHDocGvRcM7Adb7EZb/
         NypGaphqNY8iESOIh2P5niMARRC7KYL14jN30Mde7dX421HhoD8rJEXA3l9Dhe5r6jm0
         hUMw==
X-Gm-Message-State: ANhLgQ14TBbp+WFJws330/HM5W+sn/+uQ4wWZPKXImtxo6elrGnqbJL8
        C0zZES3VfUc89Fc1SwN4ubA=
X-Google-Smtp-Source: ADFU+vuBwvid4HuMhjL8+kI1y+c4AzWbZXr1n+ZWQpJcTKm+LxnZytIGS/gy+1StNbKlROkMPPPB3Q==
X-Received: by 2002:a05:651c:112c:: with SMTP id e12mr17521019ljo.7.1584369231861;
        Mon, 16 Mar 2020 07:33:51 -0700 (PDT)
Received: from localhost (host-176-37-176-139.la.net.ua. [176.37.176.139])
        by smtp.gmail.com with ESMTPSA id w3sm60540lfe.9.2020.03.16.07.33.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Mar 2020 07:33:51 -0700 (PDT)
From:   Igor Opaniuk <igor.opaniuk@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Jones <rjones@gateworks.com>,
        =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] dt-bindings: arm: fsl: add nxp based toradex colibri bindings
Date:   Mon, 16 Mar 2020 16:33:44 +0200
Message-Id: <20200316143345.30823-1-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Opaniuk <igor.opaniuk@toradex.com>

Document Colibri iMX6S/DL V1.1x re-design devicetree binding.

Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>
---

 Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 0e17e1f6fb80..7342097056c3 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -169,7 +169,9 @@ properties:
               - technologic,imx6dl-ts4900
               - technologic,imx6dl-ts7970
               - toradex,colibri_imx6dl          # Colibri iMX6 Module
+              - toradex,colibri_imx6dl-v1_1     # Colibri iMX6 Module V1.1
               - toradex,colibri_imx6dl-eval-v3  # Colibri iMX6 Module on Colibri Evaluation Board V3
+              - toradex,colibri_imx6dl-v1_1-eval-v3 # Colibri iMX6 Module V1.1 on Colibri Evaluation Board V3
               - ysoft,imx6dl-yapp4-draco  # i.MX6 DualLite Y Soft IOTA Draco board
               - ysoft,imx6dl-yapp4-hydra  # i.MX6 DualLite Y Soft IOTA Hydra board
               - ysoft,imx6dl-yapp4-ursa   # i.MX6 Solo Y Soft IOTA Ursa board
-- 
2.17.1

