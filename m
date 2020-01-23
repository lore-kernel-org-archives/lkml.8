Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC4BC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 22:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B4721569
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 22:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="ZyK74Fnf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbgAWWFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 17:05:54 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:37880 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbgAWWFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 17:05:54 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id CD44C891D9;
        Fri, 24 Jan 2020 11:05:48 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1579817148;
        bh=WO13ClqfBqySSvlIKB1e/PxZvIMLi66jh4efx2lXHVQ=;
        h=From:To:Cc:Subject:Date;
        b=ZyK74FnfyvMf812op+Upjt7rQO5MYg/wXtBIvJrxtUwOgPWktma4pCs7Vqf+G+LdZ
         3sRSLZ72WvaSKzqMZLmaepoBsruxsrMlRd8jdoE2M9CSD5mj8U4o7iNkYqVncyTVqr
         VXCsQsu1qM6C/DePus38nR/PzWj/0bsyBVkJ0TPnho50oK8Jr2+xEMlSMlEhbs0mO8
         yemDSuDB3sqZBQ3OI0/H0v8QEKe6oY3cHBZUvgHJ4fbZsTSrVX4X+9lIGHIz2hsZ3l
         FNjRQWSbR9yyxirMeH5zmsVHC95Nl4rJ8yvCxhoqRWUhSLCqAoD/uD5iDgr/OXP/ZD
         xncUzoQnJQDwg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e2a18bb0000>; Fri, 24 Jan 2020 11:05:48 +1300
Received: from logans-dl.ws.atlnz.lc (logans-dl.ws.atlnz.lc [10.33.25.61])
        by smtp (Postfix) with ESMTP id C211C13EEC9;
        Fri, 24 Jan 2020 11:05:45 +1300 (NZDT)
Received: by logans-dl.ws.atlnz.lc (Postfix, from userid 1820)
        id D8394C0DF6; Fri, 24 Jan 2020 11:05:47 +1300 (NZDT)
From:   Logan Shaw <logan.shaw@alliedtelesis.co.nz>
To:     linux@roeck-us.net, jdelvare@suse.com, robh+dt@kernel.org
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Joshua.Scott@alliedtelesis.co.nz,
        Chris.Packham@alliedtelesis.co.nz, logan.shaw@alliedtelesis.co.nz
Subject: [PATCH v5 0/2] hwmon: (adt7475) Added attenuator bypass support
Date:   Fri, 24 Jan 2020 11:05:31 +1300
Message-Id: <20200123220533.2228-1-logan.shaw@alliedtelesis.co.nz>
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

* v5
- modified adt7475.yaml to remove dt_binding_check errors
- made various alignment fixes to adt7475.c to improve style.
- renamed function modify_config_from_dts_prop to modify_config
- changed return type of function modify_config to void
- function modify_config error return code modified no longer override
  the dependent functions i2c_smbus_write_byte_data error.
- renamed function load_all_bypass_attenuators to load_attenuators
- in function load_attenuators the two local variables config2_copy
  and config4_copy have been combined into one: conf_copy.

* v4
- fixed a small error in file adt7475.yaml (duplicate property names).

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
  dt-bindings: hwmon: (adt7475) Added missing adt7475 doccumentation

 .../devicetree/bindings/hwmon/adt7475.yaml    | 95 +++++++++++++++++++
 drivers/hwmon/adt7475.c                       | 68 +++++++++++++
 2 files changed, 163 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adt7475.yaml

--=20
2.25.0

