Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908BBC11D2E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 04:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBE324653
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 04:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="MTuEMDzO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbgBUEQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 23:16:47 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:58129 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729636AbgBUEQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 23:16:46 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A625D8011F;
        Fri, 21 Feb 2020 17:16:43 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1582258603;
        bh=Bj/yUtJtuMUSIfbO6hdLOETqLtjKJZyMpmoD9BzcvEM=;
        h=From:To:Cc:Subject:Date;
        b=MTuEMDzOMxBBFEJ5JPl0h17hM8RnSNtSePguIo0gDW7jgYAkbaabX7t3Go1fAtVMC
         78HS6XG6HVxzJgNY5+M7RwspWsSr/zvRDC5X413yb1J38gHA4blkS9ld1fz/f7onib
         hs65+HhCEcBZAnKphcjDipKkO9nRc2DQO4pyBJRZzj0SrJYSvFFrbzdqTuH+o9Wepc
         BObJdY965rMhUhsKIOoWO0Su1rejt+ft0yMtsqlJUQmDrN3ETZ+bdIPc8NH52ixWuD
         EZez812fb2M0TTf2VWwKan3knLvR8r88H5edKuVc5E4ESMQHoq0ztZLJ651+++z+NZ
         01j+F1yqImQBw==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e4f59ab0000>; Fri, 21 Feb 2020 17:16:43 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id AB01213EECD;
        Fri, 21 Feb 2020 17:16:42 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 3CE6E28006D; Fri, 21 Feb 2020 17:16:43 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, logan.shaw@alliedtelesis.co.nz,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v4 0/5] hwmon: (adt7475) attenuator bypass and pwm invert
Date:   Fri, 21 Feb 2020 17:16:26 +1300
Message-Id: <20200221041631.10960-1-chris.packham@alliedtelesis.co.nz>
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

[1] - https://lore.kernel.org/linux-hwmon/20191219033213.30364-1-logan.sh=
aw@alliedtelesis.co.nz/
[2] - https://lore.kernel.org/linux-hwmon/20181107040010.27436-1-chris.pa=
ckham@alliedtelesis.co.nz/

I know I caused some confusion with my last series which should have said=
 "v3".
This version (v4) updates the new dt properies based on Rob's feedback.

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

