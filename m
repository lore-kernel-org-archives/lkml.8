Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E15C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EFDE20663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEShK/bK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgCLSv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 14:51:27 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41552 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgCLSv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 14:51:26 -0400
Received: by mail-lj1-f195.google.com with SMTP id o10so7705478ljc.8;
        Thu, 12 Mar 2020 11:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ze2fZQQej6uS2QviuuQ6/4nfx3KKsQROZMmrRSSZ7Mo=;
        b=EEShK/bKtI55I9LpTF1bBN1AfvV7vWXpcSNMyezqvBtUrUAQbz9+etSPkvA0ll731G
         MWA8GaJxGpzwU33ajgRj1ABtyI/g2qCYSCco8vioGY9Wzm6wxf0Em0LEQL5AhtlWnpHU
         chwA/VcJOPyquLt92S/PHV8pkpxUaiiIUS4Bh2WDtCjfWK8/69OXgFeMJhWAUSkoSRMG
         lbJ51oFFr7eF7SCJU+JmYGetDL/txgNVEaqWy5gzObRlWbjk/KGjJ1pq16FdCuCJTEY6
         ol2bn43X0JNpxTwVLyqwhSsjaK+htEzcAqlbpUlRWdYUF2j3fhex/jH8UY5EU9c5RjA6
         +QUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ze2fZQQej6uS2QviuuQ6/4nfx3KKsQROZMmrRSSZ7Mo=;
        b=MwR8QhMgk7ZqnTusdXiVcBdp/PLhfp3qZY9bC2fbAHfIMYe7LHKOCVlpadxrW8P6XX
         wXDraiMHfBgzjsaHlQuooYvW+CC+tB6QBfqDWA27vla8OhusM6lZAqR8Uw2PMs95ahiP
         thFI9lROQl/ZpjcoPXIzuv57yjXD88P91LrdeH6V24F7bXHxhhzOosM6a8E7GzY7tZF8
         KxOrrXE+1tlpQGlLd+Owtj0Z+BzPfwWQ+Mz0VfvaAVVZuxYhnNlX7tQpUmfOatRDBT1q
         PGP6ebphnx7WNF39jmT/6fQFGWmYhug+6xe+a0gwcBQS1gazlxNrFq8CYLlNV9dBVVtG
         0sHg==
X-Gm-Message-State: ANhLgQ2lYSflw2HWuv9+ymGqK6jDUyjPfSSyccc0QdNsbVkRRcE+nWvD
        MEnELObCPjL7FvHmCni56m4=
X-Google-Smtp-Source: ADFU+vtMh2OSYemJX/GMyXuvSTeqDPtfVEegzoT9okAtinRs2tH/jk/rK7jfGUyqFYMckzNwIBcatw==
X-Received: by 2002:a2e:9bc8:: with SMTP id w8mr5794248ljj.227.1584039082702;
        Thu, 12 Mar 2020 11:51:22 -0700 (PDT)
Received: from localhost (host-176-37-176-139.la.net.ua. [176.37.176.139])
        by smtp.gmail.com with ESMTPSA id w14sm13143879lfq.69.2020.03.12.11.51.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Mar 2020 11:51:21 -0700 (PDT)
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
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Jones <rjones@gateworks.com>,
        =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: arm: fsl: add nxp based toradex colibri bindings
Date:   Thu, 12 Mar 2020 20:51:12 +0200
Message-Id: <20200312185113.2504-1-igor.opaniuk@gmail.com>
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

