Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AB3C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A5802145D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599503619;
	bh=hF5qOo+c8YduVMjYkX8pXY1qShoCdsqQlH8KvEirjc0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=gqrSgXRcCZBQaEa5F9iBl5OXGcMImnbMOCNf0IKtNHd2XZYm6oE5gU4FyTTUl7UXj
	 vcDFWIUcBHtUj1f6yfUiWmsDCa1Z+VC14LIFT3VsEXHel9LGe+V7N4xqn1IGYjsUql
	 kQb1Lp5vui30HUPe9r83p2xx6IjlKQusOiDv1L/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbgIGSdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 14:33:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:40886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728649AbgIGSdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 14:33:25 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B74662087D;
        Mon,  7 Sep 2020 18:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599503605;
        bh=hF5qOo+c8YduVMjYkX8pXY1qShoCdsqQlH8KvEirjc0=;
        h=From:To:Cc:Subject:Date:From;
        b=ByqyNjZCPL0qV1hBA0kJE4EpOfmRlpLTwOEAp7De7CWk30ty9RK1ERhBQjcZ3D8Au
         qSdi3PbkLAMUsxJ7DYhGK15zT3jdyjtpM71bASZ0c9EhMOEd25PFn1L9C/SONBKR6U
         JWI5LbsjqP7GX+t10am8HHbEnEIlrScR4Fpaj8cc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lihua Yao <ylhuajnu@outlook.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH 00/11] ARM: dts: s3c: dtschema fixes
Date:   Mon,  7 Sep 2020 20:33:02 +0200
Message-Id: <20200907183313.29234-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is last serie of big dtschema cleanups for Samsung DTS.  It fixes
almost all dtschema violations, except:

  s3c6410-mini6410.dt.yaml: srom-cs1-bus@18000000: ethernet@18000000:reg:0: [402653184, 2, 402653188, 2] is too long

which is similar to the case with SMDK5410 (Exynos5410).

The patchset was not tested on HW.

Best regards,
Krzysztof


Krzysztof Kozlowski (11):
  ARM: dts: s5pv210: Correct ethernet unit address in SMDKV210
  ARM: dts: s3c6410: move fixed clocks under root node in Mini6410
  ARM: dts: s3c6410: move fixed clocks under root node in SMDK6410
  ARM: dts: s3c6410: align node SROM bus node name with dtschema in
    Mini6410
  ARM: dts: s3c6410: align node SROM bus node name with dtschema in
    SMDK6410
  ARM: dts: s3c6410: remove additional CPU compatible
  ARM: dts: s3c24xx: fix number of PWM cells
  ARM: dts: s3c24xx: override nods by label
  ARM: dts: s3c24xx: align PWM/timer node name with dtschema
  ARM: dts: s3c24xx: add address to CPU node
  ARM: dts: s3c24xx: move fixed clocks under root node in SMDK2416

 arch/arm/boot/dts/s3c2416-smdk2416.dts |  17 ++--
 arch/arm/boot/dts/s3c2416.dtsi         | 111 +++++++++++++------------
 arch/arm/boot/dts/s3c24xx.dtsi         |  24 +++---
 arch/arm/boot/dts/s3c6410-mini6410.dts |  32 +++----
 arch/arm/boot/dts/s3c6410-smdk6410.dts |  32 +++----
 arch/arm/boot/dts/s3c64xx.dtsi         |   2 +-
 arch/arm/boot/dts/s5pv210-smdkv210.dts |   2 +-
 7 files changed, 101 insertions(+), 119 deletions(-)

-- 
2.17.1

