Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779B3C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 21:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31607217BA
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 21:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="SIr4NBwq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgIGVRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 17:17:24 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:45233 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbgIGVRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 17:17:18 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 9DAF6806B5;
        Tue,  8 Sep 2020 09:17:16 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1599513436;
        bh=+FPj6Py6+yK51QkVI24N9KESTL802Kuzy9arE9yuwb4=;
        h=From:To:Cc:Subject:Date;
        b=SIr4NBwqbpMZ18MPYNB+ayNhznmbbgO2lsBtVirFnVYd1uAi/Avxku8MeYG7mkZim
         Rc9MQ3z8PQ+awobR440kRWppwdwMx1YJ+3q1fTDsmpyj6vwKLOPQQpivaHNT3Kd1hJ
         RftjEHpgciDrAw8MF2ZP40cqdKH/WwLwjylPid5ojxijOy+aIAHETVP0hDjpL3VvGk
         GYuEbkouo5uePrscbjPfwpYnysFxh8vfUUH6yhciRhyOKXSSjADVyPeYOX3IbbRuGr
         IFpjvyeygZEDZTz/GszvbV9quabZP0YbjXH1UKmxzty1JPk2P3pKQ62t/vVNJb1gOH
         /DPR1WCtZ394g==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f56a35c0000>; Tue, 08 Sep 2020 09:17:16 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 4460C13EEBA;
        Tue,  8 Sep 2020 09:17:15 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id E98A5280060; Tue,  8 Sep 2020 09:17:15 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jason@lakedaemon.net, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        linus.walleij@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 0/3] 98dx3236 i2c related fixes
Date:   Tue,  8 Sep 2020 09:17:09 +1200
Message-Id: <20200907211712.9697-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed these while adding support for i2c recovery for a couple of our
boards. They date back to when I initially added support for the 98dx3236=
. They
probably haven't been causing a problem because the HW defaults are corre=
ct and
unless you attempt to use the specific pinctrl functions there won't be a
problem.

Change in v2:
- Fix grammo in patch 2/3
- Add r-by from Andrew

Chris Packham (3):
  pinctrl: mvebu: Fix i2c sda definition for 98DX3236
  ARM: dts: Remove non-existent i2c1 from 98dx3236
  ARM: dts: Add i2c0 pinctrl information for 98dx3236

 arch/arm/boot/dts/armada-xp-98dx3236.dtsi | 12 +++++++-----
 drivers/pinctrl/mvebu/pinctrl-armada-xp.c |  2 +-
 2 files changed, 8 insertions(+), 6 deletions(-)

--=20
2.28.0

