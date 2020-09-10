Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70D0C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C6C1221E7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MdGi4QUT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgIJVbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:31:09 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10014 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730983AbgIJNwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 09:52:02 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5a2d560000>; Thu, 10 Sep 2020 06:42:46 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 10 Sep 2020 06:43:00 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 10 Sep 2020 06:43:00 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 10 Sep
 2020 13:42:59 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 10 Sep 2020 13:42:59 +0000
Received: from moonraker.nvidia.com (Not Verified[10.26.73.219]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f5a2d610005>; Thu, 10 Sep 2020 06:42:59 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 1/5] misc: eeprom: at24: Initialise AT24 NVMEM ID field
Date:   Thu, 10 Sep 2020 14:42:35 +0100
Message-ID: <20200910134239.192030-2-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134239.192030-1-jonathanh@nvidia.com>
References: <20200910134239.192030-1-jonathanh@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599745366; bh=eUWz+BUycmtkyBt7NEujKfX09kU6ioD/uAMi+r9OUCI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=MdGi4QUT1wm7d8uBr9LDdiDqw0/09mkzqrRRhSebZWxhOz/o+LWyoWP3XD8kECm88
         nFzbfaT9Bai1qbRewAQBjywYd1IEIX7zAKlo5O9W12Ll00aHVou8U64DV/vz1wNbyH
         lFeREFZ/7L+P0YZ2mjM1lB+YmskHlINI441wnTLWBKEjVEwzBhsTUDIGB3EX2KjfcH
         Bn3bNbupDPm5S6bSBGreLJKthMZS4X99hr3KC3O1rLMlC0atPenHSZAG8X/e6oitpc
         deBXUU7fzkP+EeGnBjGpKsoQ0PbTypXvfovY4KUbcKkvFY0IWn5vJfG10BLCm5d8uf
         CQwQ/57KwWsTg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AT24 EEPROM driver does not initialise the 'id' field of the
nvmem_config structure and because the entire structure is not
initialised, it ends up with a random value. This causes the NVMEM
driver to append the device 'devid' value to name of the NVMEM
device. Although this is not a problem per-se, for I2C devices such as
the AT24, that already have a device unique name, there does not seem
much value in appending an additional 0 to the I2C name. For example,
appending a 0 to an I2C device name such as 1-0050 does not seem
necessary and maybe even a bit confusing. Therefore, fix this by
setting the NVMEM config.id to NVMEM_DEVID_NONE for AT24 EEPROMs.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/misc/eeprom/at24.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index e9df1ca251df..3f7a3bb6a36c 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -715,6 +715,7 @@ static int at24_probe(struct i2c_client *client)
=20
 	nvmem_config.name =3D dev_name(dev);
 	nvmem_config.dev =3D dev;
+	nvmem_config.id =3D NVMEM_DEVID_NONE;
 	nvmem_config.read_only =3D !writable;
 	nvmem_config.root_only =3D !(flags & AT24_FLAG_IRUGO);
 	nvmem_config.owner =3D THIS_MODULE;
--=20
2.25.1

