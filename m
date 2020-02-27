Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E67AC4BA3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A1F2467B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="FXhxleGj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgB0IrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 03:47:02 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:40255 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbgB0Iqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 03:46:54 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E32BC891AA;
        Thu, 27 Feb 2020 21:46:51 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1582793211;
        bh=5ZvCK32jhVQkZ7Gq7Zp6sPOjMydghcdRlycwIcqf2vE=;
        h=From:To:Cc:Subject:Date;
        b=FXhxleGj98+teUVM0Rjd7VSVSZOxwFawHAQ0eKuaW1/QdsJlZ/FMSotg7/0CFlQAA
         b5ldf3Chd8AbtM3BM0dpPsB+bZHT6WdWFUEpPEQlxf3RvTPkoXApEmblymA6iWJPUL
         v8qsLRBbyUfBm5BMIdntlCmqYt1gwnlo1H2vN04PUw4QVkMKo6lOMLXOIafYB1qeBh
         0hkZi7djR+bev9z0HIj9sDVcb8pSp9BunP13E5nrV7lkXl3ORgnsYH/yvYQi/tgkad
         t7VW7/pDsOJ9PB2eYnDEKOg8VkaEtY1i30OsSS9xPcX1AOFyEsDCEHFVGofhS+LjKx
         e/Y7r8aoVSiDw==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e5781fb0000>; Thu, 27 Feb 2020 21:46:51 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id C170013EECD;
        Thu, 27 Feb 2020 21:46:50 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 83E0D280072; Thu, 27 Feb 2020 21:46:51 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     logan.shaw@alliedtelesis.co.nz, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v5 0/5] hwmon: (adt7475) attenuator bypass and pwm invert
Date:   Thu, 27 Feb 2020 21:46:37 +1300
Message-Id: <20200227084642.7057-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've picked up Logan's changes[1] and am combining them with an old serie=
s of
mine[2] to hopefully get them both over the line.

[1] - https://lore.kernel.org/linux-hwmon/20191219033213.30364-1-logan.sh=
aw@alliedtelesis.co.nz/
[2] - https://lore.kernel.org/linux-hwmon/20181107040010.27436-1-chris.pa=
ckham@alliedtelesis.co.nz/

Chris Packham (2):
  dt-bindings: hwmon: Document adt7475 pwm-active-state property
  hwmon: (adt7475) Add support for inverting pwm output

Logan Shaw (3):
  dt-bindings: hwmon: Document adt7475 binding
  dt-bindings: hwmon: Document adt7475 bypass-attenuator property
  hwmon: (adt7475) Add attenuator bypass support

 .../devicetree/bindings/hwmon/adt7475.yaml    | 84 ++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  8 --
 drivers/hwmon/adt7475.c                       | 95 ++++++++++++++++++-
 3 files changed, 176 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adt7475.yaml

--=20
2.25.1

