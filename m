Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB51C33CB3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 03:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A292083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 03:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="rpQmXwiG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbgAQDuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 22:50:52 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:56312 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbgAQDuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 22:50:51 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 3E687891AC;
        Fri, 17 Jan 2020 16:50:49 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1579233049;
        bh=1PlkYpAjDI6cRvnZgKg4jtVFtrJLjm20i+J1xIr/d1I=;
        h=From:To:Cc:Subject:Date;
        b=rpQmXwiG1QOq16IfyQ+zG53MiR0NmacX6+mJnkHi/YeXpQ3TtK4pd/x8HBOLDE/+w
         kAXh/rl7f0HdE5h7YXXNV9g2/FyJBQxJhOO61hnuO3qD57ciKksi5tCraSzqqr3hxp
         WdeLPdd7fWh0xmQ+eUSFQuPSBh+71L1p69VeIFW1kWxvaZu9xtvJEoeXN+QTfIw7JS
         2H7QEiLifsX6TfXrLFtMMSgltR/b3+njRuZm/Ialyr4SAH7v8h/0WvEArOiredSyZx
         /Ykr09TSZMJIOOEK2vNFo0uGosobBtzdCOKoXrj0c8qTxmwKoBCeawkaEcTyHX84cp
         QOazhfjbImlmQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e212f190000>; Fri, 17 Jan 2020 16:50:49 +1300
Received: from logans-dl.ws.atlnz.lc (logans-dl.ws.atlnz.lc [10.33.25.61])
        by smtp (Postfix) with ESMTP id 8896913EEFE;
        Fri, 17 Jan 2020 16:50:48 +1300 (NZDT)
Received: by logans-dl.ws.atlnz.lc (Postfix, from userid 1820)
        id 05CECC1A8B; Fri, 17 Jan 2020 16:50:49 +1300 (NZDT)
From:   Logan Shaw <logan.shaw@alliedtelesis.co.nz>
To:     linux@roeck-us.net, jdelvare@suse.com, robh+dt@kernel.org
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Joshua.Scott@alliedtelesis.co.nz,
        Chris.Packham@alliedtelesis.co.nz, logan.shaw@alliedtelesis.co.nz
Subject: [PATCH v3 0/2] hwmon: (adt7475) Added attenuator bypass support
Date:   Fri, 17 Jan 2020 16:50:16 +1300
Message-Id: <20200117035018.11985-1-logan.shaw@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ADT7473 and ADT7475 support bypassing voltage input attenuators on
voltage input 1 and the ADT7476 and ADT7490 additionally support
bypassing voltage input attenuators on voltage inputs 0, 3, and 4. This
can be useful to improve measurement resolution when measuring voltages
0 V - 2.25 V.

This patch adds 4 optional devicetree properties to the adt7475
driver, each setting the attenuator bypass (or clearing) on a
specific voltage input.

* v3
- removed the functionality to set the global attenuator bypass.
- added functionality to allow bypassing voltage input 1 on the
	ADT7473 and ADT7475.
- added DTS definition file adt7475.yaml and 4 new properties.
- added the previousely missing newline character to the end of
  	file adt7475.c.=20

* v2
- removed sysfs changes from patch
- removed adt7475_write macro from patch and replaced it by using
	the i2c_smbus_write_byte_data function directly in code.
- removed config4_attenuate_index function from patch and replaced it
	by modifying the function  load_individual_bypass_attenuators
	to use hard coded bit values.
- modified function load_individual_bypass_attenuators to use 4 if
	statements, one for each voltage input, replacing the for loop.
- modified function adt7475_probe to check the device is a ADT7476 or
	ADT7490 (other devices do not support bypassing all or
	individual attenuators), and only then set the relevant bits.
- added new file adt7475.txt to document the new devicetree properties.
- removed c++ style comments.=20

Logan Shaw (2):
  hwmon: (adt7475) Added attenuator bypass support
  hwmon: (adt7475) Added attenuator bypass support

 .../devicetree/bindings/hwmon/adt7475.yaml    | 90 +++++++++++++++++++
 drivers/hwmon/adt7475.c                       | 76 ++++++++++++++++
 2 files changed, 166 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adt7475.yaml

--=20
2.25.0

