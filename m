Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B3CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 01:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 078CF2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 01:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="dnGRrZss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgESBRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 21:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728229AbgESBRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 21:17:03 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7578DC05BD0A
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 18:17:03 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id v5so9731039lfp.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 18:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=P9lg9epxYOzkosVwby4Ch0c5f3sEFwO/BYfn6STJCRA=;
        b=dnGRrZssVumc5SEFAZDBsPOY9hvFC40lYXZykyXE9HitinWK3gVLHaowFu/ndnKf3E
         Eahvt7emsbSwgH5KfQC284+soIz189FhkiiyMymQ7DVuc15qQRLJUc/fYYb2hYtGD3l4
         4O3u+RWaTI3idfzHkF6+PIDzS/vf8ZOFoBhhc5Q/T5JncefXj3qg0DRf8tB7GkLN6422
         Ktp0rBPJY7jQGlixyD+2soZN+Fc1/INvkzy2KS4vAPK7/V4T4OIcYFq4YdF6cVF2rQJq
         ZPhF6si4grS3QFHFkGPXKaJmjos/q1wd/T06xCeYhm8yy05tie3ptyUQZOs0QGiB/PgC
         aQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=P9lg9epxYOzkosVwby4Ch0c5f3sEFwO/BYfn6STJCRA=;
        b=qYvU+ZmSaGaqH7aVz2Qmhp0JappWJ/78dJss2m0GmRsajgTrA0IexT8oMch0GEq4Fu
         H1RxP84NQY0a60z+s314LkmFVINvCDCQfKEGGZc1Xe4FKugW1HPsjTHe5hcDOl2/e5ni
         iphUf3BmSWDzOCWIMQ6aq453508FgUw4jBr6GonBCc87t70hR7UJSy4wrgiKiXWJQOK0
         ZtpLYCXklMWh1Dq3O0JQm0ZU1wfmzxYc/t8R3DFjAeCMo6Idx3gKmt4343DgdtC4OtXK
         Gb+5sWR93vguXDfq/xzvidWZRcDyI7m/8DYsIq2Iq1MHxm46PoykzicAtKaZ4ujXSQQ0
         2Yew==
X-Gm-Message-State: AOAM533IkCUdBInkhE6nMlbvsrHSbhl+81DhQco3JVt9gnF9Rr6tgr46
        KxsKlQP5TXpBK87LcnoNLJZT6BPtfVBA1w==
X-Google-Smtp-Source: ABdhPJxUWZSHm+8W4zyIHf+3MNavCDTyvyl8RtkB0iPvNIiUOFO5Nejen8EZS1lW4DYxSFMygiHsoQ==
X-Received: by 2002:a19:c311:: with SMTP id t17mr7309705lff.58.1589851021800;
        Mon, 18 May 2020 18:17:01 -0700 (PDT)
Received: from localhost.localdomain ([159.224.5.60])
        by smtp.googlemail.com with ESMTPSA id i8sm4764244lfl.72.2020.05.18.18.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 18:17:01 -0700 (PDT)
From:   Roman Kovalivskyi <roman.kovalivskyi@globallogic.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Cc:     Luis Oliveira <lolivei@synopsys.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Michael Rodin <mrodin@de.adit-jv.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hugues Fruchet <hugues.fruchet@st.com>,
        Maxime Ripard <mripard@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        Todor Tomov <todor.tomov@linaro.org>,
        Suresh Udipi <sudipi@jp.adit-jv.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.org>,
        Roman Kovalivskyi <roman.kovalivskyi@globallogic.com>
Subject: [PATCH v2 5/6] media: dt-bindings: ov5647: Add property for PWDN control
Date:   Tue, 19 May 2020 04:16:20 +0300
Message-Id: <c81da93a9aa97c3cfd208a84d0391c856e5fcbcd.1589850165.git.roman.kovalivskyi@globallogic.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1589847910.git.roman.kovalivskyi@globallogic.com>
References: <cover.1589847910.git.roman.kovalivskyi@globallogic.com>
In-Reply-To: <cover.1589850165.git.roman.kovalivskyi@globallogic.com>
References: <cover.1589850165.git.roman.kovalivskyi@globallogic.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Stevenson <dave.stevenson@raspberrypi.org>

Add optional GPIO pwdn to connect to the PWDN line on the sensor.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
Signed-off-by: Roman Kovalivskyi <roman.kovalivskyi@globallogic.com>
---
 Documentation/devicetree/bindings/media/i2c/ov5647.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/i2c/ov5647.txt b/Documentation/devicetree/bindings/media/i2c/ov5647.txt
index 22e44945b661..70f06c24f470 100644
--- a/Documentation/devicetree/bindings/media/i2c/ov5647.txt
+++ b/Documentation/devicetree/bindings/media/i2c/ov5647.txt
@@ -10,6 +10,9 @@ Required properties:
 - reg			: I2C slave address of the sensor.
 - clocks		: Reference to the xclk clock.
 
+Optional Properties:
+- pwdn-gpios: reference to the GPIO connected to the pwdn pin, if any.
+
 The common video interfaces bindings (see video-interfaces.txt) should be
 used to specify link to the image data receiver. The OV5647 device
 node should contain one 'port' child node with an 'endpoint' subnode.
@@ -26,6 +29,7 @@ Example:
 			compatible = "ovti,ov5647";
 			reg = <0x36>;
 			clocks = <&camera_clk>;
+			pwdn-gpios = <&pioE 29 GPIO_ACTIVE_HIGH>;
 			port {
 				camera_1: endpoint {
 					remote-endpoint = <&csi1_ep1>;
-- 
2.17.1

