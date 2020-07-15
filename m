Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72B1C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5D2D20663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="RuYIhyy6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgGOHHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 03:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgGOHHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 03:07:01 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11381C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 00:07:01 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h19so1310701ljg.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 00:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=f+OWOpfWyZI+F0HgW7n2hwhFXyMKZItWbfC1yFlsvCc=;
        b=RuYIhyy6Vun1cpT90eal+PKxa32bFtRJ4QJZsVJCnrgQX0fss6A3cp4kx135P7vbO5
         xBGcSD0hKkXa7L5uL2fhiOWgEreLdOaGpLZts88rFUhOIEMdeYo270DHzNNKWnse8pET
         s/r8obiibS+e9uTzvXbGYQN/5/l7eIlyeEpH0UPYC5875GyJm9FveAe4HGs+mlat90kk
         cQ5hxa7Io2yvoTRdrfQ6HOknyLICzTIWPiRaYctpISOCsalAuuLuOJALPhgNrb+tt0yh
         i6B9Cw7bk3T9eURK3leVgsUKSD1xmMuodu6Cdzc9Wgh1IWK1T0s8SL86N1QNdtksWTlA
         hT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f+OWOpfWyZI+F0HgW7n2hwhFXyMKZItWbfC1yFlsvCc=;
        b=kKGs9025uMRzGdER3+9Q29fNsjUsyH/arqN6RqGi9dYjcJ1V8oLvVwpYhl+MDHmD6k
         idv3Nmg7AISVbCAf/zscfb4f16mZZ33zeIxoQIF9NAsr6GZ3NPm80SBoKlsguolPyEdA
         64AB1rE7FO9mQQDHv6WQehcOmsCztOdqX0e5in9uxmXMk3ZoibP97I+elXbRbIGxF3XS
         N9TCRnqhzhcWXhRFQCPIktDWNvwUgE+ALG/j6PNnZF3hBiuu+o7B253V1oRYct/pJ2N3
         JxGsnnuk4UU+JB7S07yXtyTaWkJwDd2HEp45nMhcJDgbKlhfTLhu/ilxLtBRNI9cns5p
         sQ1Q==
X-Gm-Message-State: AOAM533V57DasWK/hbM6CgUsq9enkSKr2SZLEpHUXICbp6v2ADC3GQxF
        dzpk4DUTal79KYkw/P9QKFHOXg==
X-Google-Smtp-Source: ABdhPJySFX/Z8aMMJm+W1T7u3FGwHCXcNbKvVxMytXVqr0/sY0t9GCaz6iJJoGgIyrffm7iJaeHtDg==
X-Received: by 2002:a2e:9dd6:: with SMTP id x22mr4201166ljj.199.1594796819526;
        Wed, 15 Jul 2020 00:06:59 -0700 (PDT)
Received: from localhost.localdomain ([83.68.95.66])
        by smtp.gmail.com with ESMTPSA id 83sm276040ljj.51.2020.07.15.00.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 00:06:58 -0700 (PDT)
From:   Tomasz Nowicki <tn@semihalf.com>
To:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        gregory.clement@bootlin.com, robh+dt@kernel.org, hannah@marvell.com
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, catalin.marinas@arm.com,
        nadavh@marvell.com, linux-arm-kernel@lists.infradead.org,
        mw@semihalf.com, Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH v4 0/4] Add system mmu support for Armada-806
Date:   Wed, 15 Jul 2020 09:06:45 +0200
Message-Id: <20200715070649.18733-1-tn@semihalf.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series is meant to support SMMU for AP806 and a workaround
for accessing ARM SMMU 64bit registers is the gist of it.

For the record, AP-806 can't access SMMU registers with 64bit width.
This patches split the readq/writeq into two 32bit accesses instead
and update DT bindings.

The series was successfully tested on a vanilla v5.8-rc3 kernel and
Intel e1000e PCIe NIC. The same for platform devices like SATA and USB.

For reference, previous versions are listed below:
V1: https://lkml.org/lkml/2018/10/15/373
V2: https://lkml.org/lkml/2019/7/11/426
V3: https://lkml.org/lkml/2020/7/2/1114

v3 -> v4
- call cfg_probe() impl hook a bit earlier which simplifies errata handling
- use hi_lo_readq_relaxed() and hi_lo_writeq_relaxed() for register accessors
- keep SMMU status disabled by default and enable where possible (DTS changes)
- commit logs improvements and other minor fixes

Hanna Hawa (1):
  iommu/arm-smmu: Workaround for Marvell Armada-AP806 SoC erratum
    #582743

Marcin Wojtas (1):
  arm64: dts: marvell: add SMMU support

Tomasz Nowicki (2):
  iommu/arm-smmu: Call configuration impl hook before consuming features
  dt-bindings: arm-smmu: add compatible string for Marvell Armada-AP806
    SMMU-500

 Documentation/arm64/silicon-errata.rst        |  3 ++
 .../devicetree/bindings/iommu/arm,smmu.yaml   |  4 ++
 arch/arm64/boot/dts/marvell/armada-7040.dtsi  | 28 ++++++++++++
 arch/arm64/boot/dts/marvell/armada-8040.dtsi  | 40 +++++++++++++++++
 arch/arm64/boot/dts/marvell/armada-ap80x.dtsi | 18 ++++++++
 drivers/iommu/arm-smmu-impl.c                 | 45 +++++++++++++++++++
 drivers/iommu/arm-smmu.c                      | 11 +++--
 7 files changed, 145 insertions(+), 4 deletions(-)

-- 
2.17.1

