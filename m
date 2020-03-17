Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3AFC3F2CE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3588E20736
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lh4VSc3+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgCQKUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 06:20:12 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40500 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgCQKUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 06:20:12 -0400
Received: by mail-lj1-f196.google.com with SMTP id 19so22083569ljj.7;
        Tue, 17 Mar 2020 03:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=is8tu01oI9bVkgZplXk42aSakxSz6rAJ1WcVx3M2ffk=;
        b=Lh4VSc3+3zY/FWLvCzmh0TQNEJUxlEFOlhn1AHPyztxgmZdQxYdF3Apjj2bnBQqdaX
         kbMJHjvAgJ4lcLzKANUoDsCdQjLuIzWAOCPxj6SlInXyrgpjKcQlkeQ3pVJTsE6X924i
         vfN5pUd+8raD956VQCFmvv4ps5PeMcmZtiZQ0cDwQTsTYR8gXoX9dEJAOBsp853q9MuF
         Y6EQjriogTV3pBQz7F1PlQdPKh5YoEGIyvgSaEtn/rnsGdlp/UySXWhrJzzuSbDc4VGb
         v8Te7WkzyfqfAPkLRRuLR7zdMVjuwiTflK1AmT9DYFqQK+PdI1JG/LuvVD7f8gDLKJtJ
         oh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=is8tu01oI9bVkgZplXk42aSakxSz6rAJ1WcVx3M2ffk=;
        b=YbMh5u+mjQk8MhV6IpieV5B4zPVWxwf44g35rKWQiWT+1ghI3CR4ZOC7Zafhc63DxG
         81RSRjunNOYynxcltgY1Hea3orexkxoSPQLg3wrVwfWco5n8eIHVV2e2hGGNQ977dwml
         K/770NTRBBUsGg1I86xnxhkldIH8cmkfNwrYH6kQoWMtpF3duM7ikoKCnPt/dd3h7tic
         rE3FX47wHt6LJ3RIKFXPGIiSUD/pSAMMmUrpZJVjQGOK49LGIa/zq4MivuSdhBwYTXG3
         z3MprftUmRCVfqr8+/rcD1tydfO6lytTbcr3Zg4OZkHJo1PK1PzJjtSD/mobVKCgPXOp
         3orQ==
X-Gm-Message-State: ANhLgQ3rJP0IZEiGXomi7ESFnTqFD9M5gAg+4F/CeJFblvG/XQrHbtDa
        0DQutY4YQHG976M7Tn33fpE=
X-Google-Smtp-Source: ADFU+vu+oVgM5dB35uttw31MKLJJ+4OpDjdkJkebw92io41NHd3XzDdmhOFlBJyapkSiQSd+Wp2Pqw==
X-Received: by 2002:a2e:7806:: with SMTP id t6mr2326054ljc.292.1584440409165;
        Tue, 17 Mar 2020 03:20:09 -0700 (PDT)
Received: from localhost (host-176-37-176-139.la.net.ua. [176.37.176.139])
        by smtp.gmail.com with ESMTPSA id t207sm2422878lff.72.2020.03.17.03.20.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Mar 2020 03:20:08 -0700 (PDT)
From:   Igor Opaniuk <igor.opaniuk@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 2/5] ARM: dt-bindings: clock: imx6: Dual license adding MIT
Date:   Tue, 17 Mar 2020 12:19:44 +0200
Message-Id: <20200317101947.27250-2-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200317101947.27250-1-igor.opaniuk@gmail.com>
References: <20200317101947.27250-1-igor.opaniuk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Opaniuk <igor.opaniuk@toradex.com>

Dual license files adding MIT license, which will permit to re-use
bindings and dependent device tree sources in other non-GPL OSS projects.

Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>
---

 include/dt-bindings/clock/imx6qdl-clock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/imx6qdl-clock.h b/include/dt-bindings/clock/imx6qdl-clock.h
index e20c43cc36f6..e73b4b329c1e 100644
--- a/include/dt-bindings/clock/imx6qdl-clock.h
+++ b/include/dt-bindings/clock/imx6qdl-clock.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
 /*
  * Copyright 2014 Freescale Semiconductor, Inc.
  */
-- 
2.17.1

