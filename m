Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02823C2BB54
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 07:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D076B2082D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 07:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmX2dla9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgDIHF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 03:05:29 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39391 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgDIHF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 03:05:29 -0400
Received: by mail-lf1-f66.google.com with SMTP id m2so7088015lfo.6;
        Thu, 09 Apr 2020 00:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wQ238dmMNO0NeDBy2E+C5WT/Ni8JLUesfjuaRncrKOc=;
        b=UmX2dla9lsoiWLpFQZPC87OMAPuiPk4A9BZjKH2/n71yjovcXvL052YTpoZDWAVj4k
         CPdgi5bK1u2HlPnUo44xb4r7eeJsO0dm7xUJa5jOfwYwdzXKNTb0Ih7O1YpzOmvFDWIs
         Nkh7/XDoWkrWkDcOyF3A9mb/5oHDb3hU6WRy7A61mVcIMnkSNTKq12ngA8Bq617SgptL
         cFVy5RYswS5Qv+4M7DqPGN9KusN/bF1sSNuyCGPRS/cYPbz8Tjm2JeIUuSi/7x11WxmV
         0kNt8UdqxcDOOQ8mF7z5DUJs5ufXTBQsqeArHSo1GvGNBXlZPblW1Rgn8Y5Wnmpxv+Y/
         Ppfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wQ238dmMNO0NeDBy2E+C5WT/Ni8JLUesfjuaRncrKOc=;
        b=tA7YZ/sK6QF2N89wVXkzuI7hIqJ89OJETZi47I29w5vnPGtpnVk8RmH4DT6ZlCRCvy
         /I9hSfxKUZ/W5vuxf1D/ViHY8EkmWhYr8GJjlVr6wf0wmzCTrYlStRhnbEEsHrYttD2j
         e5objvF28tL3Ohkd2oGtxO81vEyQQqyopebsXKbcmwPpIPjU/qRIAxlJuC+MaTYhRkgH
         ikBTsUaqe9E3lA0mza3x/DCWGRDiNWn0KMPcQTO/Y/Kg7jxeNQuYGNdm5fnHpsoXMiJ3
         p0CG5xaFhyhRjHGoi9T9f731tEC0fLptoBa070cFyTwdpbOPfJSLsGtDIIMPw28kqB5e
         gOIw==
X-Gm-Message-State: AGi0Pua/8o14icy50KfHU0NEWvOgiCVTqE/9Ko0dzLIy6idQB10IX6VW
        ET9IiVpyKZomdGNb8qMcpmg=
X-Google-Smtp-Source: APiQypKjqNMu43wzrl8sB/tGmE9+dDeR/o7ssSgVKyc0WJEX5Rl2rA0ujm+vb062Ec2ClF6ZpV8NCQ==
X-Received: by 2002:ac2:58d7:: with SMTP id u23mr6976459lfo.182.1586415927069;
        Thu, 09 Apr 2020 00:05:27 -0700 (PDT)
Received: from localhost.localdomain ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id c22sm16436955lfi.41.2020.04.09.00.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 00:05:26 -0700 (PDT)
From:   Pawel Dembicki <paweldembicki@gmail.com>
Cc:     Pawel Dembicki <paweldembicki@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <mripard@kernel.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] dt-bindings: vendor-prefixes: Add Check Point
Date:   Thu,  9 Apr 2020 09:04:43 +0200
Message-Id: <20200409070448.3209-1-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check Point Software Technologies Ltd. is a company based in Israel and
USA. They manufacture network devices and provide software
products for IT security.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
Changes in v2:
- corrected line order

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index d3891386d671..3819192d035d 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -181,6 +181,8 @@ patternProperties:
     description: CDTech(H.K.) Electronics Limited
   "^ceva,.*":
     description: Ceva, Inc.
+  "^checkpoint,.*":
+    description: Check Point Software Technologies Ltd.
   "^chipidea,.*":
     description: Chipidea, Inc
   "^chipone,.*":
-- 
2.20.1

