Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8BAC2D0E0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 02:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1985820796
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 02:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="Om8O6usK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgIGCl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 22:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgIGCl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 22:41:56 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79076C061575
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 19:41:56 -0700 (PDT)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 1058C80719;
        Mon,  7 Sep 2020 14:41:52 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1599446512;
        bh=Hf7VVuMu9cFRktO7FXy7LMQ9Jztv9177X3UOd6CQzZw=;
        h=From:To:Cc:Subject:Date;
        b=Om8O6usK2nM5bUfaAOv4CKKh/Wcwol1+907/PJv+TT4Q8NC/V4t4oyOQ4rRmrtqR6
         9jDcGBzjXZ2aSuI5lKXJjslg6savSSTCxOg6OPN07JuS5A0CerXMx8wkdwkQjcI1XZ
         OWi0seMzaw/k+ZzwZfxu/p7fIjB6jEU6yPqCL/2eX9t8lKVPzAZP+uYBBdp51jSvxa
         LbjcSLxnLVGwsOKXZ4UrkJ06V4y/7+MhVofAHfLOlaP+kCcKAZ6uT7xASPkkso+yjc
         g0gEX3l0at/3fynbSR8C37XDlNmaBsI3sjlmZYsU0OURPxhH9YCkWg3sVjqja3Toav
         7F881PLYoUYjw==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f559def0000>; Mon, 07 Sep 2020 14:41:51 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 8582313EEB7;
        Mon,  7 Sep 2020 14:41:51 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id C36DD280060; Mon,  7 Sep 2020 14:41:51 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jason@lakedaemon.net, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        linus.walleij@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 0/3] 98dx3236 i2c related fixes
Date:   Mon,  7 Sep 2020 14:41:46 +1200
Message-Id: <20200907024149.20001-1-chris.packham@alliedtelesis.co.nz>
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

Chris Packham (3):
  pinctrl: mvebu: Fix i2c sda definition for 98DX3236
  ARM: dts: Remove non-existent i2c1 from 98dx3236
  ARM: dts: Add i2c0 pinctrl information for 98dx3236

 arch/arm/boot/dts/armada-xp-98dx3236.dtsi | 12 +++++++-----
 drivers/pinctrl/mvebu/pinctrl-armada-xp.c |  2 +-
 2 files changed, 8 insertions(+), 6 deletions(-)

--=20
2.28.0

