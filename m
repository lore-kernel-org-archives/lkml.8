Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B063C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 575D920775
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KXtFgSRW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgGPFQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 01:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgGPFQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 01:16:08 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F37C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 22:16:08 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id z5so4261223pgb.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 22:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y82s5J6jGeE+1WkQgClg6fF8GkRM6k30eJBmLEIoHho=;
        b=KXtFgSRWIDabNM0L7WxgGCj81mvHpXozzo3Lh5uiL5segDJXmzAmhO7LtFilDnCiFV
         VCb6APzS/iKl7Iz/JPtBo2M3G4M/mYH3mdSZ0qc9XFLlHw3/VV52KYOQ1XgdjMFp872x
         8yupOmZqRwAp9T9ZcV0YIa9B48kZCg+cq0Yu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y82s5J6jGeE+1WkQgClg6fF8GkRM6k30eJBmLEIoHho=;
        b=bTCSKYNDqxjUmmszg5O7fhyPZ5GWb3tr1v5p8iDFu365BFFGvn3kKW1ZKR57CzyrVz
         xZzI1FZ5nWgKdDAaX0qM7oB0m97C9BmOfXxblcDWL82H/XLHn9H6pZAr0/ddgefwj9lK
         bJtlGdZUtebvUsi/OKQw6Ii23YnCGzzZTNsWMFrGsZhz4yDeQxbxc+WwLP2w7QSfmbRa
         UFukCcuW5zwL3/ugbGce7bhJeY0rhIZogWUZ2QpkbvoE39qjaJ6pzdEoVq8BKRJuXDHm
         OKCBbRSuLM6EXghNb0Jzp/koZNgH3Rkrhglw4mpZRjkLoDzm3wBZyqn8zxc97NqMeGOk
         nwlg==
X-Gm-Message-State: AOAM533cyA7pE56GLTN089SfILqmfy+0CQYkkM9pqEAbBJJ28cCWuyGk
        FdkKbhcu1bwhIWC4xKaHrGUfIQ==
X-Google-Smtp-Source: ABdhPJwXILHXfYYnoTMFXqMHeqxiwrG/soe4t9GpW7yqRWRGtYHxu1CHGk67bfLwW5pMqKEWrUB+YQ==
X-Received: by 2002:a05:6a00:14ce:: with SMTP id w14mr2279149pfu.121.1594876568096;
        Wed, 15 Jul 2020 22:16:08 -0700 (PDT)
Received: from bhanumaiya-glaptop.hsd1.ca.comcast.net ([2601:646:9500:590:250:b6ff:fe8e:b459])
        by smtp.gmail.com with ESMTPSA id r8sm3493401pfh.29.2020.07.15.22.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 22:16:07 -0700 (PDT)
From:   Bhanu Prakash Maiya <bhanumaiya@chromium.org>
X-Google-Original-From: Bhanu Prakash Maiya <bhanumaiya@google.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Furquan Shaikh <furquan@chromium.org>,
        Raul E Rangel <rrangel@chromium.org>,
        Eric Peers <epeers@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.Kernel.org
Subject: [PATCH v3 2/2] dt-bindings: mfd: Add DT compatible string "google,cros_ec_uart"
Date:   Wed, 15 Jul 2020 22:16:04 -0700
Message-Id: <20200715221150.v3.2.I113cdbaf66d48b37ac0faefb9b845480d122f3b9@changeid>
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhanu Prakash Maiya <bhanumaiya@chromium.org>

Add DT compatible string in
Documentation/devicetree/bindings/mfd/cros_ec.txt

Signed-off-by: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
---

Changes in v3:
- Rebased changes on google,cros-ec.yaml

Changes in v2:
- No change

 Documentation/devicetree/bindings/mfd/google,cros-ec.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
index 6a7279a85ec1c..552d1c9bf3de4 100644
--- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
+++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
@@ -10,11 +10,12 @@ maintainers:
   - Benson Leung <bleung@chromium.org>
   - Enric Balletbo i Serra <enric.balletbo@collabora.com>
   - Guenter Roeck <groeck@chromium.org>
+  - Bhanu Prakash Maiya <bhanumaiya@chromium.org>
 
 description:
   Google's ChromeOS EC is a microcontroller which talks to the AP and
   implements various functions such as keyboard and battery charging.
-  The EC can be connected through various interfaces (I2C, SPI, and others)
+  The EC can be connected through various interfaces (I2C, SPI, UART and others)
   and the compatible string specifies which interface is being used.
 
 properties:
@@ -29,6 +30,9 @@ properties:
       - description:
           For implementations of the EC is connected through RPMSG.
         const: google,cros-ec-rpmsg
+      - description:
+          For implementations of the EC is connected through UART.
+        const: google,cros-ec-uart
 
   google,cros-ec-spi-pre-delay:
     description:
-- 
2.26.2

