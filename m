Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E38EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 20:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EC26206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 20:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uuGt8bIY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgHLUUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 16:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgHLUUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 16:20:44 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB229C061383;
        Wed, 12 Aug 2020 13:20:44 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id r4so1614999pls.2;
        Wed, 12 Aug 2020 13:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IeO2QX7jX5HpTExQro6Oxo9pVZ7dXOVfRlcfZocSNUA=;
        b=uuGt8bIYTXENPkcGTC/MKsQN6zvk0hjl3gOq4bm9hxP6xc1EFnrxPmD4rltKQYT6QP
         5HHSlX2LxDGP3P/bZoglmL0XCsWyLhmJx2UF2H/GqSEBiPMtWU3blCLJ/VAQKr4GntWe
         ykSznhrG9+l4AEz7abkEAhPDPt1Hk3Kydsb05hQKCmr866aLNYMbvSkw6Umt+ycXEi5W
         zVVuYx3YKDeHtdQaT+JVP2dJpsZxuTeWnNxxNjjdnCvE4vGveI2uy8p2KnW+xUwfW0PR
         sPH30ZlMow4L9IV0XGv3sJ9nD5Kfs9kmeVgz1toBr7KnfXMVplzZOSI+L+QMDXd1avWI
         42mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IeO2QX7jX5HpTExQro6Oxo9pVZ7dXOVfRlcfZocSNUA=;
        b=FapEnFDD7kWEFO8IKEPNx7Nw1meN+LswJkai/lS2TLxsNaIstKGKqzCte2VVISpyek
         JOcn9jaT9hSgQ0YkgTLxD5w77bfonIyyk2ZfnLbhT1hGU7/4o7E5yjJcqlmCH/iAyFwQ
         XwPRMjxH2dAW+cTVp/9gKqlaeyTLb7drjvuqCYDFjk/tBik175fbz8ZNzydxWLGEuB0P
         A0CUQV/ikRDms4xvnDwGXUTTzjW6xOBTCz1FY3EErlg5JcBTypGMnWKBc2mbaLQUqXDF
         sJvy79Df5055TCpRoxf9OUCKmyelL12oSWAvexSDKUqWenH7aQfqtiCflXfMb+aPHFqt
         +TKA==
X-Gm-Message-State: AOAM532R/qtiAb7f2trSKD6QuEJ3hlol1RWiqotm+42pb3FH4McTZ0BB
        Y3m2pg7HkJn3ygTpmtTGUpy4nSql
X-Google-Smtp-Source: ABdhPJxwtx6DE4giBh/lTEgKbmIrZMP/Ul3scI0f2XYaq7kX2E6u67YaYVesBjVrYva0qVCwaujJ5A==
X-Received: by 2002:a17:902:8e89:: with SMTP id bg9mr1025458plb.126.1597263644151;
        Wed, 12 Aug 2020 13:20:44 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id 75sm3292999pfx.187.2020.08.12.13.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 13:20:43 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 0/3] usb: Add driver for USB signal re-mapper
Date:   Wed, 12 Aug 2020 16:20:15 -0400
Message-Id: <20200812202018.49046-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Broadcom 7211 has new functionality that allows some USB low
speed side band signals, that go from the XHCI host controller to
pins on the chip, to be remapped to use any GPIO pin instead of the
limited set selectable by hardware. This can be done without changing
the standard driver for the host controller. There is currently
support for three USB signals, PWRON, VBUS_PRESENT and PWRFLT. This
driver will allow the remapping of any of these three signals based
on settings in the Device Tree node for the driver. The driver was
written so that it could handle additional signals added in the
future by just adding the correct properties to the DT node.

Al Cooper (3):
  dt-bindings: Add support for Broadcom USB pin map driver
  usb: Add driver to allow any GPIO to be used for 7211 USB signals
  usb: Add Kconfig and Makefile changes to build brcmstb-usb-pinmap

 .../bindings/usb/brcm,usb-pinmap.yaml         |  63 ++++
 MAINTAINERS                                   |   8 +
 drivers/usb/host/Kconfig                      |   4 +
 drivers/usb/host/Makefile                     |   1 +
 drivers/usb/host/brcmstb-usb-pinmap.c         | 348 ++++++++++++++++++
 5 files changed, 424 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,usb-pinmap.yaml
 create mode 100644 drivers/usb/host/brcmstb-usb-pinmap.c

-- 
2.17.1

