Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70D5C34031
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 23:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4895207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 23:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="xogI8Kfr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgBQXrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 18:47:06 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:48784 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgBQXrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 18:47:04 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 292FD8011F;
        Tue, 18 Feb 2020 12:47:00 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1581983220;
        bh=0R6R7PVq0Qu2V5eKj0tD6Mbe1Yvls1XnEy30npEBeps=;
        h=From:To:Cc:Subject:Date;
        b=xogI8KfrGDK8zkp0K0f1Lz1oGY4wIMBDRNbv74vN6Jx3ZMawiQjJ/kxEc86K5IUKO
         xDtMZ5x4qabQQfzH2TdcPi88HFzjAgY7KFska7D1o2SBgY+NVkMSwwOUqZ4jVWOJSr
         bk21ytfJqeXyazCq3WMpK/KEdp+dx2RZVV8R/QAx0XYd49I5i5IRx+m4CHWMyJuicJ
         tsFo9RwqH/4ow3dsKLuIGrrpuPIn8hk6TC0/U0h49ORT0mKGVOg/5N5BFIWvMyb5my
         AZ8tY4vVpv/lLvQk//ok5jHW8pcL+r2/8X5FYfB3VYFuH5lGGzUjdNSK+UyCpvdUU2
         4+5t2N3miGqXw==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e4b25f30000>; Tue, 18 Feb 2020 12:46:59 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 5969713EED4;
        Tue, 18 Feb 2020 12:46:59 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id C66B728006C; Tue, 18 Feb 2020 12:46:59 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     logan.shaw@alliedtelesis.co.nz, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 0/5] hwmon: (adt7475) attenuator bypass and pwm invert
Date:   Tue, 18 Feb 2020 12:46:52 +1300
Message-Id: <20200217234657.9413-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.0
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

This series updates the binding documentation for the adt7475 and adds tw=
o new
sets of properties.

[1] - https://lore.kernel.org/linux-hwmon/20191219033213.30364-1-logan.sh=
aw@alliedtelesis.co.nz/
[2] - https://lore.kernel.org/linux-hwmon/20181107040010.27436-1-chris.pa=
ckham@alliedtelesis.co.nz/

Chris Packham (2):
  dt-bindings: hwmon: Document adt7475 invert-pwm property
  hwmon: (adt7475) Add support for inverting pwm output

Logan Shaw (3):
  dt-bindings: hwmon: Document adt7475 binding
  dt-bindings: hwmon: Document adt7475 bypass-attenuator property
  hwmon: (adt7475) Add attenuator bypass support

 .../devicetree/bindings/hwmon/adt7475.yaml    |  82 ++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |   8 --
 drivers/hwmon/adt7475.c                       | 100 +++++++++++++++++-
 3 files changed, 179 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adt7475.yaml

--=20
2.25.0

