Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A526EC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB32214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="L6JH5SXo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgBEAu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 19:50:57 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:56468 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbgBEAu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 19:50:57 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 5A20F891AB;
        Wed,  5 Feb 2020 13:50:55 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1580863855;
        bh=23yJFb6GZPUoSAat/+vG3OZ3oyRjQX3uCDxb1XUAAPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=L6JH5SXoiK+AmxWG3BAliJ0TY3BGC2xFNnCMgtMNZLHWi30YgkZ2v+2sDU822x6SX
         KBwJOlV91QZM3tjuRN0lIizFfkjQatFUjs1tH5gV99+0lnitVzEaOMldlI6mtytJ1J
         a1Vysn9e9FTwWsPirtUCyC1LCcmJYgo3XdS9orIssT0I4Ep+80U+RCFXabCpHtshkw
         4Li92oJf4KuE0+LWo9uoOz0W1U1er/hiRvsSdSQed89xhY7ZUGgSnDaEZJiOzB/qzH
         fRkpMUdQIWSFYo1QQtGviQD506SEgCECezLDkZI2iNIKJGBPuxtnuwOoaevcrIB+Ph
         SMY5370j2NheA==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e3a116e0000>; Wed, 05 Feb 2020 13:50:55 +1300
Received: from henrys-dl.ws.atlnz.lc (henrys-dl.ws.atlnz.lc [10.33.23.26])
        by smtp (Postfix) with ESMTP id E288F13EEDE;
        Wed,  5 Feb 2020 13:50:53 +1300 (NZDT)
Received: by henrys-dl.ws.atlnz.lc (Postfix, from userid 1052)
        id 5FF184E9819; Wed,  5 Feb 2020 13:50:54 +1300 (NZDT)
From:   Henry Shen <henry.shen@alliedtelesis.co.nz>
To:     mark.rutland@arm.com
Cc:     vadimp@mellanox.com, linux-kernel@vger.kernel.org,
        Henry Shen <henry.shen@alliedtelesis.co.nz>
Subject: [PATCH] dt-bindings: Add TI LM73 as a trivial device
Date:   Wed,  5 Feb 2020 13:49:56 +1300
Message-Id: <20200205004956.28719-2-henry.shen@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200205004956.28719-1-henry.shen@alliedtelesis.co.nz>
References: <20200205004956.28719-1-henry.shen@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Texas Instruments LM73 is a digital temperature sensor with 2-wire
interface. Add LM73 as a trivial device.
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Doc=
umentation/devicetree/bindings/trivial-devices.yaml
index 978de7d37c66..20e6bae68fec 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -350,6 +350,8 @@ properties:
           - ti,ads7830
             # Temperature Monitoring and Fan Control
           - ti,amc6821
+            # Temperature sensor with 2-wire interface
+          - ti,lm73
             # Temperature sensor with integrated fan control
           - ti,lm96000
             # I2C Touch-Screen Controller
--=20
2.25.0

