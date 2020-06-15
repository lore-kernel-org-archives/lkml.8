Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC9AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26BE620663
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwBqsCO4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbgFOJCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 05:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbgFOJCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 05:02:36 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DA1C061A0E;
        Mon, 15 Jun 2020 02:02:35 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t18so16244350wru.6;
        Mon, 15 Jun 2020 02:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KsmsxYavbvBSrD5sd3Cy2FdQfI+TGdNIP59/SdH1Mm4=;
        b=XwBqsCO46r6OWhyhznF6Z/MhW6Ua8eoX38PDoHAEMn14q9mq59VjfkDz1eUN5y/yeg
         mSkLoRQyrDTeF8AmMj14+2AhyRAswUUrQp2A8gLDGVDGNwfL5Lvcpa9CIHnyUUq/twgz
         psPXqAvyG/7IoMQP0SuHOWH5oSJEFOmPt1toEtWojywbnueZb/IA1qu5aALFKiXVWdDC
         AbcvfsqaGseFN7g3IKw0xRibgtp/vQWU0tp5TtCasjp+IeJ7gZPvpD4xC+JwFeUqvZku
         TQ5JfcqArjlKbKKZWF+L6H57EvgMotIk0dKN277WMVaJ7KZAKkMQiSlfBvi22IApd3qw
         lCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KsmsxYavbvBSrD5sd3Cy2FdQfI+TGdNIP59/SdH1Mm4=;
        b=X4zvWwEAyU8LPz9T333TgyF1natnjvcEFVE6vG2p4Qkkw8xNN/5ZGsQidesB1sd9JS
         rzaFe8Hk1HKmJvEd3S5wTgxhGqq/5WFp9rm6OFjxomvigYwGyE6EFm1QIE4PExes4qCu
         LOD8vYXFz9XSGemv+L8CFJwVwZgGFNz8/wUj3q7rUH9UGi9t98vtE2II4YJcWbxJwEtr
         WaitpTftN6hu1ak0SHX47rVSLpODOAUBToPhvDkoVBoyXk1ZTPIeu7+/gkeHxvZ8kb5a
         zMQpr00gu8wHBQbva+5sRN9IAqOrnixsY6m4F5G6gLQlCA/TyaW8mePirrWny5CvLnV8
         TeuA==
X-Gm-Message-State: AOAM531JHzC3FVp3CtiMUNMIR+fWiRTD1Ebq1h8aQ9qyg2df/0muTdAP
        Lv2EIMgT1gu0/nVqKaUCMPI=
X-Google-Smtp-Source: ABdhPJz1qkel+LJCwlq+pVLtp371uDu4QDVVHHKTJSDLwykQvem70/CFBM7n0bsJ+1YdNRoatC4oWw==
X-Received: by 2002:a5d:630f:: with SMTP id i15mr27280895wru.309.1592211753326;
        Mon, 15 Jun 2020 02:02:33 -0700 (PDT)
Received: from skynet.lan (168.red-88-20-188.staticip.rima-tde.net. [88.20.188.168])
        by smtp.gmail.com with ESMTPSA id o15sm24089516wrv.48.2020.06.15.02.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 02:02:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, robh+dt@kernel.org,
        julia.lawall@lip6.fr, jonas.gorski@gmail.com, lkp@intel.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 0/8] clk: bcm63xx-gate: introduce dt-bindings definitions
Date:   Mon, 15 Jun 2020 11:02:23 +0200
Message-Id: <20200615090231.2932696-1-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add header files for bcm63xx-gate clock definitions in order
to be able to use them in bcm63xx-gate controller driver and BMIPS device
trees.

"clk: bcm63xx-gate: add BCM6318 support" is required to correctly apply
these patches.

Álvaro Fernández Rojas (8):
  mips: bmips: add BCM3368 clock definitions
  mips: bmips: add BCM6318 clock definitions
  mips: bmips: add BCM6328 clock definitions
  mips: bmips: add BCM6358 clock definitions
  mips: bmips: add BCM6362 clock definitions
  mips: bmips: add BCM6368 clock definitions
  mips: bmips: add BCM63268 clock definitions
  clk: bcm63xx-gate: switch to dt-bindings definitions

 drivers/clk/bcm/clk-bcm63xx-gate.c         | 580 ++++++++++++++++-----
 include/dt-bindings/clock/bcm3368-clock.h  |  24 +
 include/dt-bindings/clock/bcm6318-clock.h  |  42 ++
 include/dt-bindings/clock/bcm63268-clock.h |  30 ++
 include/dt-bindings/clock/bcm6328-clock.h  |  19 +
 include/dt-bindings/clock/bcm6358-clock.h  |  18 +
 include/dt-bindings/clock/bcm6362-clock.h  |  26 +
 include/dt-bindings/clock/bcm6368-clock.h  |  24 +
 8 files changed, 622 insertions(+), 141 deletions(-)
 create mode 100644 include/dt-bindings/clock/bcm3368-clock.h
 create mode 100644 include/dt-bindings/clock/bcm6318-clock.h
 create mode 100644 include/dt-bindings/clock/bcm63268-clock.h
 create mode 100644 include/dt-bindings/clock/bcm6328-clock.h
 create mode 100644 include/dt-bindings/clock/bcm6358-clock.h
 create mode 100644 include/dt-bindings/clock/bcm6362-clock.h
 create mode 100644 include/dt-bindings/clock/bcm6368-clock.h

-- 
2.27.0

