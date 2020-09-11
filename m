Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F171C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 05:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67AE421D90
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 05:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="E3sf/gt1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbgIKFOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 01:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgIKFOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 01:14:20 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72904C061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 22:14:19 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id o8so12047579ejb.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 22:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=8BbSYo1EREAfClRHAeNOhoxiKSLE+6Rb+mYEQ7xMTpQ=;
        b=E3sf/gt1amd1Y+Q31SBtp4NzoMik1iPG9MNUCyHC5P76GqTO9gHBHOI2lKgUNs4lIT
         dKMXFiR7oBc9wbz3JSaUheDfvIPZDtxr3oYWBf59RT9oo4XR38YCDdJuED3nET8KiNuR
         +YTWxjUiyJKSqGf7W5LUPf/4u2HJ2ZjBATZAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=8BbSYo1EREAfClRHAeNOhoxiKSLE+6Rb+mYEQ7xMTpQ=;
        b=HQ0fK6Z9YzAnDW97nsjP8Hue9Xwi8eeeAUc5ImcLUhorQo+PQynPskBIWbVN4J4bT0
         YAQSMSJQvFwsMyHUvd+HyZitSglE3/ajsbv7NOdMCRZn9n2pFr8JhmcutaAv1COHMNIS
         TiBVtWD/0sBcTQJzGylkkZjJ0JLe2E8inBGkioibdhxUo5OS9Ow5aV470TY86V8fb6TU
         lChs1ZTxP09EA96vJNmiZJQRKq324Lpc0AuO6pWgOURD1QWDFNhdKZyQLfWfQQyBfYHl
         OibhJilnZswqYzGtANMh+aRfWUCbEyQYqqeO0k4tk97HDZJpwpJivDvqS3QbZqPTY6cI
         ZXUQ==
X-Gm-Message-State: AOAM533WMlUSPWUziIZhuSlVMt3JBhkvcTBk8NBBT3o46uj561r4srb1
        F2D2bxUfO7rCa7yHaB7q7LclgwVcDdA0j+onoOmsI+xd0MWfOQ==
X-Google-Smtp-Source: ABdhPJy4WmGiPzpllI9ZzOgLrbSdWMs4UVt/+yNaow1pjhbEhxCRhkQJp8T5fFqQzgNekNH2a2X0ale6r3WMMjoGa7I=
X-Received: by 2002:a17:906:fcc7:: with SMTP id qx7mr422294ejb.254.1599801258142;
 Thu, 10 Sep 2020 22:14:18 -0700 (PDT)
MIME-Version: 1.0
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 11 Sep 2020 05:14:05 +0000
Message-ID: <CACPK8XdDHEcbdH2HXeFpL9U+SYmydSMw5jkti_0x+EjQy7RDHg@mail.gmail.com>
Subject: [GIT PULL] FSI changes for 5.10
To:     Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     linux-fsi@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>,
        Eddie James <eajames@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are some FSI changes for the 5.10 merge window.

The following changes since commit 4a851d714eadeabd65c7e321a2e7830f77d945c4:

  fsi: aspeed: Support CFAM reset GPIO (2020-09-10 12:26:43 +0930)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/fsi.git tags/fsi-for-5.10

for you to fetch changes up to 4a851d714eadeabd65c7e321a2e7830f77d945c4:

  fsi: aspeed: Support CFAM reset GPIO (2020-09-10 12:26:43 +0930)

----------------------------------------------------------------
FSI changes for 5.10

 - Misc code cleanups. Thanks to Colin, Xu and Rikard

 - Features for the ASPEED FSI master
  * Detect connection type and routing for Tacoma
  * Run at full speed (200MHz) by default
  * Set bus speed with a parameter
  * CFAM reset GPIO
  * 23 bit addressing

 - Core features
  * Disable unused links
  * Set LBUS ownership

----------------------------------------------------------------

Colin Ian King (1):
      fsi: master-ast-cf: fix spelling mistake "firwmare" -> "firmware"

Eddie James (5):
      fsi: aspeed: Enable 23-bit addressing
      fsi: master: Add boolean parameter to link_enable function
      fsi: core: Disable link when slave init fails
      fsi: core: Set slave local bus ownership during init
      fsi: master: Remove link enable read-back

Joel Stanley (5):
      dt-bindings: fsi: Document gpios
      fsi: aspeed: Support cabled FSI
      fsi: aspeed: Run the bus at maximum speed
      fsi: aspeed: Add module param for bus divisor
      fsi: aspeed: Support CFAM reset GPIO

Rikard Falkeborn (3):
      fsi: master: Constify hub_master_ids
      fsi: sbefifo: Constify sbefifo_ids
      fsi: scom: Constify scom_ids

Xu Wang (1):
      fsi: fsi-occ: fix return value check in occ_probe()

 Documentation/ABI/testing/sysfs-bus-fsi                     |   8 +++++
 Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt |  12 +++++++
 drivers/fsi/fsi-core.c                                      |  31
+++++++++++++++--
 drivers/fsi/fsi-master-aspeed.c                             | 134
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------
 drivers/fsi/fsi-master-ast-cf.c                             |   7 ++--
 drivers/fsi/fsi-master-gpio.c                               |   5 +--
 drivers/fsi/fsi-master-hub.c                                |  15 ++++++---
 drivers/fsi/fsi-master.h                                    |   3 +-
 drivers/fsi/fsi-occ.c                                       |   2 +-
 drivers/fsi/fsi-sbefifo.c                                   |   2 +-
 drivers/fsi/fsi-scom.c                                      |   2 +-
 11 files changed, 188 insertions(+), 33 deletions(-)
