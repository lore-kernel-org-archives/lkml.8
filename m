Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413E9C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1376924680
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MX5VY8kt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgANPT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 10:19:29 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44970 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbgANPT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:19:27 -0500
Received: by mail-pg1-f193.google.com with SMTP id x7so6519550pgl.11;
        Tue, 14 Jan 2020 07:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oHR18xSTLKzfXADaEQF/DRKA3JuNk6378Q7TLhUdjGA=;
        b=MX5VY8kt+Tn08+h/fUUpnksMzFRwu9H0e26yWbE8j5DnU0ARn+a7YISb5IkjPzWtO0
         1ZugUunTv+iew4DJKfLLQVK6n/S72uRin1uStVNAFPzXPWGCgx7qyczs1GGFIXpjiCI5
         my1Oo8oejUQdpbuc9GRruc4wo1ctQL4arNvSPOIFwhtwzfJAOtbVicF8gn/nvJ6pO0t1
         T9Db9wXh9I2kE86IGIx7kUzQOoKphmv53dNhNCzUUNjchLxIR+DTuvWUv+7FX7LoENJu
         Iryolc0bS5DHW+6PCdaXdHKP5Z/ex+PYHS/XVoytpycChKkQ3IGFcmP+SS6Ow7x6HUgU
         JlMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oHR18xSTLKzfXADaEQF/DRKA3JuNk6378Q7TLhUdjGA=;
        b=ZL5edLQ2wtdPVFzY/sXfAFrDIsDvBTRd/2CadBg7kmQmwBY//rY9Y2LIYfpCiOUY2b
         Sq+EP0dG0tSGXgdBQAYPUU+XGh6nKcDAtdRRBaXpc4ciY68/W5ga8AfG+ueX7HEFb8hW
         pSNATsTnGu6LaI/O6KgKLSPAGZH28kRE/8tOGMy6HOoy3G9m0nCezHFBnx5gpS1pXF0/
         m3VrbLbGGvMn1eX5fqa5p9VihUMDxftr2rDlGOA+lloTxMUl2cDNF8F6T1H9Z9mMPaxr
         D27oCyz0vee3OCYjQ/8DX4mvLe+74ahh+R0269mwWfrpZeXAcFUt0qBz/QVpXJbn88kU
         XpMw==
X-Gm-Message-State: APjAAAVlz8itTLYbqDsaX4+VTVUNUXoNaW+uR/zV/ir9ktECTf0k/Xui
        s8cUs861gVa1Vc6OI6PXrlg=
X-Google-Smtp-Source: APXvYqz5rxYxys49gaz1iQGzXcuSBUjumrrreqOitO48K/qaFccWPnB47zLTKKj7thqJ7REaulAUpA==
X-Received: by 2002:aa7:982d:: with SMTP id q13mr26222953pfl.152.1579015166342;
        Tue, 14 Jan 2020 07:19:26 -0800 (PST)
Received: from localhost.localdomain (c-67-165-113-11.hsd1.wa.comcast.net. [67.165.113.11])
        by smtp.gmail.com with ESMTPSA id 207sm18834425pfu.88.2020.01.14.07.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 07:19:25 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] ARM: dts: vf610-zii-ssmb-spu3: Add voltage monitor DT node
Date:   Tue, 14 Jan 2020 07:19:02 -0800
Message-Id: <20200114151906.25491-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200114151906.25491-1-andrew.smirnov@gmail.com>
References: <20200114151906.25491-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a DT node for various voltage supply rails connected to SoC's ADC
for voltage monitoring purposes.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
index 453fce80f858..3d05c894bdc0 100644
--- a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
+++ b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
@@ -46,6 +46,14 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
+
+	supply-voltage-monitor {
+		compatible = "iio-hwmon";
+		io-channels = <&adc0 8>, /* 12V_MAIN */
+			      <&adc0 9>, /* +3.3V    */
+			      <&adc1 8>, /* VCC_1V5  */
+			      <&adc1 9>; /* VCC_1V2  */
+	};
 };
 
 &adc0 {
-- 
2.21.0

