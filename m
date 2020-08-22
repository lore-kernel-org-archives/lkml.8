Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EA0C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 03:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B65D2071A
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 03:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598066748;
	bh=xlhQkGmI3gqs8Rn+xfQZmEbO8eg97WedoOV5mkmLgZg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Qy8A9Jr+gTwdLJL5Nm793foWeF0S1jIu67tWHsoHZ3gvPW+R8ed/gTies2dlxQWKI
	 l0bBRpCz/b+LXPOVyf+gSwSvA2rcIYXwTvTILYruH0gnu1Y5uCAekd3Qb57z1oC0Qp
	 1LQ+88A+609Y+K08AiBqKtqf+kqynl0f4yH58tnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgHVDZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 23:25:46 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:33522 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgHVDZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 23:25:45 -0400
Received: by mail-il1-f193.google.com with SMTP id r13so3058395iln.0;
        Fri, 21 Aug 2020 20:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=qSqyCkB8+mSR0rZwtTlPRNJYmpR982y/9gGfbXhSmyM=;
        b=B4Ad5fd0AybT41vd0oQZqajw7EyzUnyIxhgsemWMw8ArsdZ2QJWaCnmdWu+7fZHw5O
         LipRByrPI9ig5ypU8DyQRYw5Q/GcAfRmM3z0/aNJEXXw+CxKJT+vagB16A7M5JjrjI5p
         IlPHSTdpFX3b3xN8Rtn7oCmvYC00/Qi3sl3vGsZX4gBGVw/+8xlQ0GSxUiBIf7S0GGhj
         uBWJW2aBMK799KnDyo2GuK/g798p66pLNoEx79tw2SsY71hNowsPy9ZDj5ruxtZ4LyDA
         XmpEjg8YzsrtPie5XVvAC9VRevGUxr3RG/4I9FV4wn2fr1qOimjgR4ci6aL6RYWJTqZj
         nfxg==
X-Gm-Message-State: AOAM5321t6yKeZJxo5Pju6QVWiV1BeLIBf9LJznrnDpc1RDE1++ryoTj
        ek9zp4hmQs8WmH7HxC+YQg==
X-Google-Smtp-Source: ABdhPJyrjLJDcHhwycd/UHxrLz/TRh62kzDFH4kLAmu7MDEwiPhBoLX59cpjoDc69tBscL/O8b2GrA==
X-Received: by 2002:a92:1b85:: with SMTP id f5mr4699106ill.308.1598066744001;
        Fri, 21 Aug 2020 20:25:44 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id a9sm2415256iol.9.2020.08.21.20.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 20:25:43 -0700 (PDT)
Received: (nullmailer pid 2217434 invoked by uid 1000);
        Sat, 22 Aug 2020 03:25:40 -0000
Date:   Fri, 21 Aug 2020 21:25:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] Devicetree fixes for v5.9, take 2
Message-ID: <20200822032540.GA2215775@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull another set of DT fixes.

Rob


The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.9-2

for you to fetch changes up to 5cd841d2676a702e5f79a8bacbfbae3bfc2411f7:

  dt-bindings: vendor-prefixes: Remove trailing whitespace (2020-08-21 16:27:57 -0600)

----------------------------------------------------------------
Devicetree fixes for v5.9, take 2:

- Restore range parsing error check

- Workaround PCI range parsing with missing 'device_type' now required

- Correct description of 'phy-connection-type'

- Fix erroneous matching on 'snps,dw-pcie' by 'intel,lgm-pcie' schema

- A couple of grammar and whitespace fixes

- Update Shawn Guo's email

----------------------------------------------------------------
Colin Ian King (1):
      of/address: check for invalid range.cpu_addr

Fabio Estevam (1):
      dt-bindings: Use Shawn Guo's preferred e-mail for i.MX bindings

Geert Uytterhoeven (2):
      dt: writing-schema: Miscellaneous grammar fixes
      dt-bindings: vendor-prefixes: Remove trailing whitespace

Madalin Bucur (1):
      dt-bindings: net: correct description of phy-connection-type

Marc Zyngier (1):
      of: address: Work around missing device_type property in pcie nodes

Rob Herring (1):
      dt-bindings: PCI: intel,lgm-pcie: Fix matching on all snps,dw-pcie instances

 .../devicetree/bindings/clock/imx23-clock.yaml      |  2 +-
 .../devicetree/bindings/clock/imx28-clock.yaml      |  2 +-
 .../devicetree/bindings/gpio/gpio-mxs.yaml          |  2 +-
 Documentation/devicetree/bindings/i2c/i2c-mxs.yaml  |  2 +-
 .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml      |  2 +-
 Documentation/devicetree/bindings/mmc/mxs-mmc.yaml  |  2 +-
 .../bindings/net/ethernet-controller.yaml           |  3 ++-
 .../devicetree/bindings/pci/intel-gw-pcie.yaml      |  8 ++++++++
 Documentation/devicetree/bindings/pwm/mxs-pwm.yaml  |  2 +-
 .../devicetree/bindings/spi/fsl-imx-cspi.yaml       |  2 +-
 .../devicetree/bindings/thermal/imx-thermal.yaml    |  2 +-
 .../devicetree/bindings/vendor-prefixes.yaml        |  2 +-
 Documentation/devicetree/writing-schema.rst         |  4 ++--
 drivers/of/address.c                                | 21 ++++++++++++++++++++-
 14 files changed, 42 insertions(+), 14 deletions(-)
