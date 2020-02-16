Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B5FC76199
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 17:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738C320857
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 17:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pOWFF8mP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgBPRe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 12:34:57 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44587 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbgBPRe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 12:34:57 -0500
Received: by mail-pg1-f194.google.com with SMTP id g3so7666113pgs.11;
        Sun, 16 Feb 2020 09:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UxaHOVEn7LlLsxvk22jYigXq5kYWEUT+TigdtVf+Dag=;
        b=pOWFF8mP+uUa5RzOE5JdYiL2dsq+GZUQ/RCtEQwsOV8POFSR//vy64zKVTnvUjDVUO
         BoVRxVhFDuJUa2pzViEnEmFalZPLkoYjqo6eVdIzl0cXFcukrFDy1D/DXJNsIy0a1mru
         bo5hQwu9olFbkJKMyXoClmJv7n9CM1nXtjAMb5z/+u4BuTBon6z1s+94Ifcy4V1suKhi
         AnL5PhIGKbzl/J2YkNTVN7u/WlErmPllrFwbLzJ8Ul8l52PHg6Ya/1scFAyBu8R8quQA
         UNuY4XiRPVFc0EIhCMnsKT0czXWwhYV3HyUjm2kUd+qr/jxta02hLW+H2wsKAFOi0V28
         Ve7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UxaHOVEn7LlLsxvk22jYigXq5kYWEUT+TigdtVf+Dag=;
        b=IFjZBbMSi//4gl8mvcffHjDXpkkFobqozXVcjDZno7yromkjoru+NjpZOVTuTb2WE2
         vJvGoBxidHhnkag2E5yU6FibodBSvaP3T3HELWMfJzv0h2UmRw90sRb+ypKW9IbEcNmM
         ZISof2wCjEjHWAzgw1zxn1JgAex1OTK4L7eTFl+O78RIQLccT0jfqHUXOu/txnVXT3rL
         0SEpS5x+IAPcjZuUTWK3KAl4/80pdZk68rQVEW+9gLpClxk4OZsSbMA1Wmx482wXx72b
         Jrp1t3kHSjp3yxbw/9mViaojMRLax4hRncj1sKgNaCgOhmeZTlOAHwFkB6x0q4K17vg5
         NM6A==
X-Gm-Message-State: APjAAAU99r84sAQXoRbijac7Pim74N0oX8bpPAe+N2Z6pB4sUFCV2Vau
        I7xRNXDq0hduYq+csK7Es54=
X-Google-Smtp-Source: APXvYqzIF1eNE+9kSnylg1WQyiY6aJJsMIBumzSzxu/FK/ciU3XfRBQWJbl+oi3csP2R7aOw7licJw==
X-Received: by 2002:aa7:874b:: with SMTP id g11mr13499452pfo.225.1581874495024;
        Sun, 16 Feb 2020 09:34:55 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.127])
        by smtp.gmail.com with ESMTPSA id a36sm14284724pga.32.2020.02.16.09.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 09:34:54 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCHv1 0/3] Odroid N2 failes to boot using upstream kernel using microSD card
Date:   Sun, 16 Feb 2020 17:34:43 +0000
Message-Id: <20200216173446.1823-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We am trying to build the upstream u-boot and upstream kernel,
but it fails to pass the initialization of PWM_MESON driver.
So these patches help boot the kernel on microSD card.

Fix the clk driver help booting of the kernel.
Any more suggestion or inputs are welcome.

Changes since RFCv1
[0] https://lore.kernel.org/linux-amlogic/20191007131649.1768-1-linux.amoon@gmail.com/
drop some patches and fix the clk driver as suggested by Neil.

-Anand

Anand Moon (3):
  arm64: dts: meson: Add missing regulator linked to VDDAO_3V3 regulator
    to FLASH_VDD
  arm64: dts: meson: Add missing regulator linked to VCCV5 regulator to
    VDDIO_C/TF_IO
  clk: meson: g12a: set cpu clock divider flags too CLK_IS_CRITICAL

 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts | 6 ++++++
 drivers/clk/meson/g12a.c                             | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.25.0

