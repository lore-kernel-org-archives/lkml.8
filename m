Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77FEC3F2D3
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 12:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3A0246AE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 12:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsBF+G4r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgB2MRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 07:17:01 -0500
Received: from mail-lj1-f174.google.com ([209.85.208.174]:40951 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbgB2MRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 07:17:00 -0500
Received: by mail-lj1-f174.google.com with SMTP id 143so6363668ljj.7;
        Sat, 29 Feb 2020 04:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NmeW9ngS8eifN3sjrGPI1hv1F6A8Nf5uvazYyp+BS9k=;
        b=fsBF+G4rrEavnF+deIdP/ZIXTHhFb3889bXztI6LtHsY8wWGlxctMe+BkXmv3Ob2H2
         3yvmUfXu5eevF8q9+7pUZJl+2HysP2echSLEFErLmDwQ4tybS+6SAQ+kkIjCMt1EiIyL
         uqZLIeln4glcBLnvAbjmTIDzAvClK4mCiLpOEMcZ1pipEK1yiWQYM4wmcgxDzzx76dRx
         z5x0x0afGREgGohTSF0X7dUK1m7Hng6MuYGXLbLPPi3hjMhOKq2gdftxc1AwlI0G6lUM
         XkKsljviErQv5OfynUOeaZ6Q5ii6imWqtiSClUrcGyN9Wn3xr5ZDH3M08mPZ5IOupEB/
         cKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NmeW9ngS8eifN3sjrGPI1hv1F6A8Nf5uvazYyp+BS9k=;
        b=T4ocQTZwx9Ruai6YvsCg6MLgzqF0AhoEsalVMGgfqCOneWayxjFi44+I4I9iE6GSPu
         /EEZBQE5PhK/4OTbf5Xoy9LNicRnbl3a2I6e0If5EC1+bCWhFrUkqj3hkVPyFrYnl0kU
         oHwNDXYzs9MSlPBl2hEIQrN7Vbd+lIl6WxxR02SomIrvxsIAXJv1UTDixRdQWymi+jpY
         DxapnlaMrrywRverPHnd36yvyUcuPVTOcG20teun58dvoP4vZS5lwn1uRuhJKeL/vyll
         +LMawhghudS4ylSIL95ToxckYUJd1btLQziT6lFYKdb+utI2//VRiL8OCFc+cshMm0NN
         mz5A==
X-Gm-Message-State: ANhLgQ3qmLv/ORcBEoau0penWxLFcfHsj8OBYA2GETnbvPiM9RfCZQQH
        0QG7jm45MJ5C4bpger7eBhCqdOCz/5JYSA==
X-Google-Smtp-Source: ADFU+vvZe2Fm5iD/DxxWhWMNcaKeu1vbIPgY+k5XIhBFqHSSJoUbfekOeo/upkJ/GuljLDMmof05/g==
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr5935430ljj.97.1582978618295;
        Sat, 29 Feb 2020 04:16:58 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id x1sm6270232lfq.46.2020.02.29.04.16.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Feb 2020 04:16:57 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        =?UTF-8?q?Jer=C3=B4me=20Brunet?= <jbrunet@baylibre.com>
Subject: [PATCH v4 1/3] dt-bindings: add vendor prefix for SmartLabs LLC
Date:   Sat, 29 Feb 2020 16:16:02 +0400
Message-Id: <1582978564-81491-2-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582978564-81491-1-git-send-email-christianshewitt@gmail.com>
References: <1582978564-81491-1-git-send-email-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SmartLabs LLC are a professional integrator of Interactive TV solutions
and IPTV/VOD devices [1].

[1] https://www.smartlabs.tv/en/about/

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9e67944..a34ed82 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -901,6 +901,8 @@ patternProperties:
     description: Sitronix Technology Corporation
   "^skyworks,.*":
     description: Skyworks Solutions, Inc.
+  "^smartlabs,.*":
+    description: SmartLabs LLC
   "^smsc,.*":
     description: Standard Microsystems Corporation
   "^snps,.*":
-- 
2.7.4

