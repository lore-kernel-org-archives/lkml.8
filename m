Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651F0C433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4333F20657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a03ni/S+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbgGOIZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729826AbgGOIZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:25:48 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A666BC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:25:48 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id t11so1758492pfq.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AvUYaZdTBJOJT4skplAAvkJuJ1Wq6R9AP4tH75ZrRy8=;
        b=a03ni/S+QZlAxNdYtn54fZdmDTQtr3DBCOJOCY8BRoSjPtfaoL9nZOJDyXCOWVZFDC
         ADCkB+1YpTIf5E2eCiCBDrnbGDkFRKf+au4RFU01ZmH8oeoETZuTZHG3wKi2MeEBD51D
         kDRgi3ll1SSf0CKFiAluKcYqgUS7NQstGyGYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AvUYaZdTBJOJT4skplAAvkJuJ1Wq6R9AP4tH75ZrRy8=;
        b=U7sxxU6PwNtSaIOtSnHCr2EtKnXZDJ9MFoTUrtBi3gEETBV7Wr5aFdSbPPCcS5hfSq
         82+A3FPNYj4XTc4MVQ9TlnNYE7ogtbZ6er9PnAnNC0ir6wIvEljyliSyxbhwBVfNB6NT
         VdedsvAp4ZrJfr9E/TSCdPuT6pw38vvKArrdjm918JPg7wj2nQq4Xii9k+/qnkRl+Wr0
         I4moveMomdJwHZ1OVbF7/9r3Gg95/qeHUxKIoEoIwRnOlc77tiLKloVb8Fco+KDVrOOm
         q5OShP37Elw0sEx0TtUwGRxDmDPolJwmK5Z7YveAAQJtj0qPUr2L3C5zcy1hf2qrBrha
         gYnA==
X-Gm-Message-State: AOAM531M3lwteXy8LGgAvVMZHp307qN8BnOA81I0oD/gQeDT5ABbMu4m
        s8HX/Cjv2Zt127lsXUyMgT7GRQ==
X-Google-Smtp-Source: ABdhPJw3+nKTM6LEEm7fZCBVsDT/JQ2nZBNipQhAObPQb7nADYjtnszvy9WpDZDlB3q5QahBcnbcQA==
X-Received: by 2002:a63:925a:: with SMTP id s26mr7072727pgn.21.1594801548068;
        Wed, 15 Jul 2020 01:25:48 -0700 (PDT)
Received: from bhanumaiya-glaptop.hsd1.ca.comcast.net ([2601:646:9500:590:250:b6ff:fe8e:b459])
        by smtp.gmail.com with ESMTPSA id y7sm1093627pfq.69.2020.07.15.01.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 01:25:47 -0700 (PDT)
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
        devicetree@vger.kernel.org, linux-kernel@vger.Kernel.org,
        Bhanu Prakash Maiya <bhanumaiya@google.com>
Subject: [PATCH v2 2/2] dt-bindings: mfd: Add DT compatible string "google,cros_ec_uart"
Date:   Wed, 15 Jul 2020 01:25:26 -0700
Message-Id: <20200715082526.1760426-2-bhanumaiya@google.com>
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
In-Reply-To: <20200715082526.1760426-1-bhanumaiya@google.com>
References: <20200715082526.1760426-1-bhanumaiya@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhanu Prakash Maiya <bhanumaiya@chromium.org>

Add DT compatible string in
Documentation/devicetree/bindings/mfd/cros_ec.txt

Series-to: LKML <linux-kernel@vger.kernel.org>
Series-cc: Raul E Rangel <rrangel@chromium.org>, Furquan Shaikh <furquan@chromium.org>, Duncan Laurie <dlaurie@google.com>, Eric Peers <epeers@google.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org

Signed-off-by: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
Change-Id: Icfeab15fa04daaffc61280faf5a75cd9b23ee822
Signed-off-by: Bhanu Prakash Maiya <bhanumaiya@google.com>
---
 Documentation/devicetree/bindings/mfd/cros-ec.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/cros-ec.txt b/Documentation/devicetree/bindings/mfd/cros-ec.txt
index 4860eabd0f729..ec8c5d7ecc266 100644
--- a/Documentation/devicetree/bindings/mfd/cros-ec.txt
+++ b/Documentation/devicetree/bindings/mfd/cros-ec.txt
@@ -3,7 +3,7 @@ ChromeOS Embedded Controller
 Google's ChromeOS EC is a Cortex-M device which talks to the AP and
 implements various function such as keyboard and battery charging.
 
-The EC can be connect through various means (I2C, SPI, LPC, RPMSG) and the
+The EC can be connect through various means (I2C, SPI, UART, LPC, RPMSG) and the
 compatible string used depends on the interface. Each connection method has
 its own driver which connects to the top level interface-agnostic EC driver.
 Other Linux driver (such as cros-ec-keyb for the matrix keyboard) connect to
@@ -17,6 +17,10 @@ Required properties (SPI):
 - compatible: "google,cros-ec-spi"
 - reg: SPI chip select
 
+Required properties (UART):
+- compatible: "google,cros-ec-uart"
+- reg: UART baudrate, flowcontrol
+
 Required properties (RPMSG):
 - compatible: "google,cros-ec-rpmsg"
 
@@ -72,5 +76,6 @@ spi@131b0000 {
 	};
 };
 
-
 Example for LPC is not supplied as it is not yet implemented.
+
+Example for UART is not supplied as it is not yet implemented.
-- 
2.27.0.389.gc38d7665816-goog

