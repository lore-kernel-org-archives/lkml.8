Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFB7C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 21:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3762120716
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 21:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Cpdf/RrD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbgAYVhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 16:37:15 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34137 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgAYVhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 16:37:14 -0500
Received: by mail-lj1-f196.google.com with SMTP id x7so6616411ljc.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 13:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=TredOH208DKnhbFDRXnNH5BXYnFDCKQqBXa/FTFb7XA=;
        b=Cpdf/RrDA9RO/ZC4J1eaVFNZhyNsjb75UqcCZ/aMMWhVusr3PZOgZDOcYXp66FXvC3
         IG8Q6b5teFRfa7+jeIrtb11/yQ9ncgnQwagM3+EcX+v2aujd93TLeq2WlALwX2FpF28v
         zGyDNCvYrjI28qHenKlpPqEf1phyky1eylbnOLOSK/vCk+O6Z89LUb529UbXrvF0MIGs
         eEUWZiCnFVVUhca8CiGfS9BMfvnaeW4tfgblHeiH37h0OyVRCU8diZd38kZQ+Q0zl+KJ
         ESSMnyjqmKPxT/ynpJjsuiRx2KcshO1oAGLFnsIgNu6XTSWWtTUw8OAkhoYY6589599b
         YUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=TredOH208DKnhbFDRXnNH5BXYnFDCKQqBXa/FTFb7XA=;
        b=Yimbo+Qzv9s6zIdH1RZop60HDeI+f9dZvngGSWPoO64x7riUcNYhYdOSEGVdRWdLoR
         NxOvkUsAGVk1hDNrreCFIVlJxr68I2MZM7NGZj2Ej963SN1NXTdm0TE1ZeeXEyqwUvQC
         WxqVJtBsFwRdpUtBXMpq3e+3lcanJZg9kYWzI+0d0w8i5oT07bdHmAyQWr2xjmf0oJ9B
         eNRfCWwzuPQI80/vdSAC0w1yPjUBIJxQmWbJgf0tpPX6K8FwKadB9GjHJEWe6RQImnu+
         FXx5g173T5xBpp7lUU1uj7Fh5ItKi5O4fRR/QH8uX9Qq21Ndm/u9uoq9GBN5f3LI9JD7
         6e5A==
X-Gm-Message-State: APjAAAXFnnNK7aPdjV+o39F125rmhyKLE9Xqv0hlFTzD61HweJMvoV2B
        wVt4KM9TjIt0Kyvy/xX9IY1QQg==
X-Google-Smtp-Source: APXvYqxD/TqbPpt3M6oYdLe2qwGJ+NqM//WkrYW9spkhDw6BmeJcjpbyfMxFsfA9IF/01mKAubzLDg==
X-Received: by 2002:a2e:6c13:: with SMTP id h19mr6126118ljc.221.1579988232494;
        Sat, 25 Jan 2020 13:37:12 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id n30sm6494809lfi.54.2020.01.25.13.37.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 Jan 2020 13:37:10 -0800 (PST)
Date:   Sat, 25 Jan 2020 13:37:02 -0800
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     olof@lixom.net, arm@kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20200125213702.tkh5afxz6ao5rsw2@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 70db729fe1b30af89e798d16c1045846753e5448:

  MAINTAINERS: Add myself as the co-maintainer for Actions Semi platforms (2020-01-16 15:49:19 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

for you to fetch changes up to 6716cb162deb9d474095a57d7a515edc13926ea7:

  Merge tag 'omap-for-fixes-whenever-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into arm/fixes (2020-01-24 12:05:33 -0800)

----------------------------------------------------------------
ARM: SoC fixes

A couple of fixes have come in that would be good to include in this
release:

 - A fix for amount of memory on Beaglebone Black. Surfaced now since
   GRUB2 doesn't update memory size in the booted kernel.

 - A fix to make SPI interfaces work on am43x-epos-evm.

 - Small Kconfig fix for OPTEE (adds a depend on MMU) to avoid build
   failures.

----------------------------------------------------------------
Matwey V. Kornilov (1):
      ARM: dts: am335x-boneblack-common: fix memory size

Olof Johansson (2):
      Merge tag 'tee-optee-fix2-for-5.5' of https://git.linaro.org:/people/jens.wiklander/linux-tee into arm/fixes
      Merge tag 'omap-for-fixes-whenever-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/fixes

Raag Jadav (1):
      ARM: dts: am43x-epos-evm: set data pin directions for spi0 and spi1

Vincenzo Frascino (1):
      tee: optee: Fix compilation issue with nommu

 arch/arm/boot/dts/am335x-boneblack-common.dtsi | 5 +++++
 arch/arm/boot/dts/am43x-epos-evm.dts           | 2 ++
 drivers/tee/optee/Kconfig                      | 1 +
 3 files changed, 8 insertions(+)
