Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C7DC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683F8207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gqzCtNfV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgAPQLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:11:21 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40585 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgAPQLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:11:19 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so19729752wrn.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 08:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yB/cveKEfDugm1aujmL3Dw+v3th2OFNUrbTqEnKnF6E=;
        b=gqzCtNfVsZ2ruw6huUbQTmVq3TDMRBX3VMbvJnkVFzs74e6dYVd0KVPCqq1wFhn4Ry
         RKdXZfKtTTi1PuOPbwn+X1sx/pH5E05go00YXz1+lDJ/WeWS/GID4p0ohyDXft0h2/0p
         mIv6isg+JULSnNroFrFFS27eWgKPZE0s0hX6ncW2uJBevqeYosBvNsubLWiozYLjmF00
         WTmMswdVedtdDfRPpFcZe7l59qxpiQXbCkvKeqL5vpGuvy2SSuwfhJAcXgZ3SyEYDm9P
         eav3u8p6CCwjAqgZR9Tn/oC8l6zsBiX5DLvmsPeRGiQi+gsUfZEFUlS/auY5A+t6Etq7
         m0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yB/cveKEfDugm1aujmL3Dw+v3th2OFNUrbTqEnKnF6E=;
        b=lx0iVoQz7yF8GR8RrifKRvhyivU+QUDYcZ/8tlrKbaBhPxrzThFsPMf8J8XDg9I14C
         88MyiU7RZ/Gr/Ez9hCZX3+uYdNFQkj74EccL6lFbFBIJ13VXt41VcbbqZ9XwJjujm2O4
         EtnmIGmh12Z/3VQX+QYlIv+HXoIdfRtOSaD5ic4fPqs1qX634+fPp+Mp+erQ2sJEPr26
         rOD1IaIFPuyMZ5p6chG2bxc6TbsTE0ZU/No2/EvfNicUMCmH2MQMSINFLnk02KLozbDJ
         KUa2lp5WqnCSFiTEra5WUfYPM2Uw8UW0pivOXicb2CCnzsMYy+FEQg7jZggP8luGtz9i
         w3Mw==
X-Gm-Message-State: APjAAAX0V4LcZ+gvv1hVy1XuR0CUwDpdDMkD55HbdTzurxg8xuoBM/xh
        Alds1wdO62nHx95UEnLDxjiLVg==
X-Google-Smtp-Source: APXvYqy3cUEEd8wr7+S7K5LqHQvQsf3GaE+xnn/2gvB5Z3QSKlxM1lvA6aSJCUnzlPKdO+RjWnTwLA==
X-Received: by 2002:a5d:4dc9:: with SMTP id f9mr3858601wru.297.1579191077619;
        Thu, 16 Jan 2020 08:11:17 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id g9sm30075740wro.67.2020.01.16.08.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 08:11:16 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/3] dt-bindings: imx-ocotp: Add i.MX8MP compatible
Date:   Thu, 16 Jan 2020 16:10:58 +0000
Message-Id: <20200116161100.30637-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200116161100.30637-1-srinivas.kandagatla@linaro.org>
References: <20200116161100.30637-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Add compatible and description for i.MX8MP.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/imx-ocotp.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
index 904dadf3d07b..6e346d5cddcf 100644
--- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
+++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
@@ -2,7 +2,7 @@ Freescale i.MX6 On-Chip OTP Controller (OCOTP) device tree bindings
 
 This binding represents the on-chip eFuse OTP controller found on
 i.MX6Q/D, i.MX6DL/S, i.MX6SL, i.MX6SX, i.MX6UL, i.MX6ULL/ULZ, i.MX6SLL,
-i.MX7D/S, i.MX7ULP, i.MX8MQ, i.MX8MM and i.MX8MN SoCs.
+i.MX7D/S, i.MX7ULP, i.MX8MQ, i.MX8MM, i.MX8MN and i.MX8MP SoCs.
 
 Required properties:
 - compatible: should be one of
@@ -17,6 +17,7 @@ Required properties:
 	"fsl,imx8mq-ocotp" (i.MX8MQ),
 	"fsl,imx8mm-ocotp" (i.MX8MM),
 	"fsl,imx8mn-ocotp" (i.MX8MN),
+	"fsl,imx8mp-ocotp" (i.MX8MP),
 	followed by "syscon".
 - #address-cells : Should be 1
 - #size-cells : Should be 1
-- 
2.21.0

