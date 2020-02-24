Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27819C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23B320838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgBXRlf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:41:35 -0500
Received: from mail-oln040092253048.outbound.protection.outlook.com ([40.92.253.48]:3042
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727108AbgBXRlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:41:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IssB8YMASMk4zHe6uzbb11vyLmtpkWQAdijUu4we9y0K3ePN2Esqzvvj9Bbn4EudyfmOkj3+Jm3avXtGzJtPUtqBEEx5iGNWTXlIeGGB3OVQ3zeb4g88Fg0EhyjBdE2FsEtgv5zlu2dKz0coTqMh9F59ypvoOI026er//UwFAdLQwbcAgpYAVwxlzf5PmPROsR4KsZyA03p/dh7beRi1U3KE6J17tNNJtF79CQcHw5lrUsh0SBELPCJOJxYIOjc2cEZFSITUGLa1LNM6LXzEM60RA6oqs2MJd8HmWhqo0rK0RnAY2haMZZ0lv4z9m5SPWX/giYi7C/2AizKB0Jg6jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSBnHgGhkpwZZX1J+LmpmXL2RcXs62FDjpl1W8/fQRs=;
 b=iVI+NywUm7dDQ4IJaFnj+dOnY1lYYTkxFmII+2vCq3Uv8kQ4JbK8EhTNFprzbGqPX7ofIMYe1m82rj6HLqqRSGlW3MOkP3+ywYscqd/eoK+EVcNGw3FRuvj1zOB8I4U1iVe3QMNnZ8FoMS4mhmLy4aEsrHFD7cOUutaY52A6BFQVRB3i4xUvgNu2e21I52EdOLiZe6puFAwx13jzHdp274vOr75jiuywPFxO9sHp/mNOzmkYMh607imffR2gTLIU17lZ6frw82wIDCD4hjecOGTTiV8ufKhsZMQnxGces1P+Z4hT6gVHjpwKRm44PyY2EoJiEM5IESTYJIMsxnCD9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT063.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebd::39) by
 SG2APC01HT094.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebd::406)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.19; Mon, 24 Feb
 2020 17:41:30 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.250.56) by
 SG2APC01FT063.mail.protection.outlook.com (10.152.251.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Mon, 24 Feb 2020 17:41:30 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2%7]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 17:41:30 +0000
Received: from nicholas-dell-linux (2001:44b8:6065:1c:6059:d44:6861:fae2) by ME2PR01CA0168.ausprd01.prod.outlook.com (2603:10c6:201:2f::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Mon, 24 Feb 2020 17:41:28 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v1 0/3] nvmem: Add support for write-only instances, and
 clean-up
Thread-Topic: [PATCH v1 0/3] nvmem: Add support for write-only instances, and
 clean-up
Thread-Index: AQHV6zml/lsHzrfInUOXwCupSAP1TQ==
Date:   Mon, 24 Feb 2020 17:41:30 +0000
Message-ID: <PSXP216MB043899D4B8F693E1E5C3ECCE80EC0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0168.ausprd01.prod.outlook.com
 (2603:10c6:201:2f::36) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:3A99595262EFCE974F49FFF5C7C6930DB2BC3146F838F029544504691909DB8F;UpperCasedChecksum:42C0B7F69CC2765735B347B06DE20C478D7F4AA1499FCDCDD7F4F0B5F3E59605;SizeAsReceived:7726;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [4mUZlQKDR0p4ZAE15jshWF2Mq9Dpkq/HFZQ82XQkiNwGYEYqs5K41vC3Gon3j4DJ]
x-microsoft-original-message-id: <20200224174123.GA3529@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 95c6403a-188e-4b5e-702d-08d7b950c7f6
x-ms-exchange-slblob-mailprops: gjx25WM8ZNX0Yn+GlkLgg++2GZLLkjhCFs4BmVC9YOIiGW1jh1Xj87g2enqQ+EVjPyGI6zyJI72lacpmhVHGpSq5ZwC9TcIhFmUkw+RjQdMpfi+9/+HSv0jWEetbK+dhiUKVlw3l+kqIPGssmwcQI8auSPu/IpjwQ0iznsDWpJAsnKKvZdS4eiAACkg4FGX/5Z82K8R2/feEPdmM8Nar+/wywJHwRkHX+eih8XP21dy+qCN+qbZBIlIpsW6AefFY/nZdi/rrBu4pNh7ec++LWOtSabXSZk/KZi+vgn2CHEmf+N3DW0NjaNiRIYFleskDOEljASU0OmknCxvHZRdIK8aGRxOlEsHcSJWRQZdyu7uCCvQQnFsHX9x+aEeMWxM4Emv/A1hYPiZEW9KCuGSA1dxV2IHWQtxAyJkMNlFN4iwDaATrEccylQaXTKzAGmazo/3taHxoAtT1U0l1jmHVoPrztNHsb65Y7Oq1TDP3Yrak9vTmBoEvXoPIrnowcfvXQFqS5ev2NcpRZCpwM35euhBzuKNy5RjR35+9311VOoNGcHNMEz4ET0Erct+gp/WddCInV8iRiZa1t2SuLCh+jDD2rr5JcDW15iWof0HmMnhRikEIsMJ67xfQtujmEAzJb5J2gOCpAvd2uyd9H2YIo+3o5N039DCLJDJswT6a4jZOJ5A5M+2IFvLddvaOafGqcQz6apaupbstdMxSXoyPJNJd72G1KSfOiR/jPWaAizI=
x-ms-traffictypediagnostic: SG2APC01HT094:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KvtLkTBTfsgIuzqXB51kPUeV5keYRCzfVMp/wZEQ4/nHcR3ztzHAauX04goDomw7HajeY9FASDOsM1Ga6c7XRdmY6+IkTlvuyzFo7ycw8HHQHXnxwSBb3bZzjMrKI5IPvqDLmUgFYC/QlMsAqY7q2kuG3SkbHVI9TX0Hr6uls0laucqN4OtTL1Ql0F7TbHZJ
x-ms-exchange-antispam-messagedata: 2F35Dm8iy6RxmCTFlgfbeqoD7+IOizFDgvCPy2i23tz/mYF3Mjxxj4dKgrntuCoXCj3pM2wiJGhJMlKf99bE/ct1poLnjPs+ITVaI6KlIVf4R7WNVCgdU/xm/+KQjZrHtKD08VNAVgUyEWqdw0X+qeJaSYJkuf2yw0QtoM1jSWTk8cgJjTzoRzDGdS17IRACrWfQiLibdGm6XGL1Y6oLdA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <81DCA365029F814DBC8ECE92D1FC09D3@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c6403a-188e-4b5e-702d-08d7b950c7f6
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 17:41:30.5950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Based on Linux v5.6-rc3, does not apply successfully to Linux v5.6-rc2]

Hello all,

I offer the first patch in this series to support write-only instances 
of nvmem. The use-case is the Thunderbolt driver, for which Mika 
Westerberg needs write-only nvmem. Refer to 03cd45d2e219 ("thunderbolt: 
Prevent crash if non-active NVMem file is read").

The second patch in this series reverts the workaround 03cd45d2e219 
("thunderbolt: Prevent crash if non-active NVMem file is read") which 
Mika applied in the mean time to prevent a kernel-mode NULL dereference. 
If Mika wants to do this himself or there is some reason not to apply 
this, that is fine, but in my mind, it is a logical progression to apply 
one after the other in the same series.

The third patch in this series removes the .read_only field, because we 
do not have a .write_only field. It only makes sense to have both or 
neither. Having either of them makes it hard to be consistent - what 
happens if a driver were to set both .read_only and .write_only? And 
there is the question of deciding if the nvmem is read-only because of 
the .read_only, or based on if the .reg_read is not NULL. What if they 
disagree? This patch does touch a lot of files, and I will understand if 
you do not wish to apply it. It is optional and does not need to be 
applied with the first two.

Thank you in advance for reviewing these.

Kind regards,

Nicholas Johnson (3):
  nvmem: Add support for write-only instances
  Revert "thunderbolt: Prevent crash if non-active NVMem file is read"
  nvmem: Remove .read_only field from nvmem_config

 drivers/misc/eeprom/at24.c          |  4 +-
 drivers/misc/eeprom/at25.c          |  4 +-
 drivers/misc/eeprom/eeprom_93xx46.c |  4 +-
 drivers/mtd/mtdcore.c               |  1 -
 drivers/nvmem/bcm-ocotp.c           |  1 -
 drivers/nvmem/core.c                |  5 +-
 drivers/nvmem/imx-iim.c             |  1 -
 drivers/nvmem/imx-ocotp-scu.c       |  1 -
 drivers/nvmem/imx-ocotp.c           |  1 -
 drivers/nvmem/lpc18xx_otp.c         |  1 -
 drivers/nvmem/meson-mx-efuse.c      |  1 -
 drivers/nvmem/nvmem-sysfs.c         | 77 ++++++++++++++++++++++++++---
 drivers/nvmem/nvmem.h               |  1 -
 drivers/nvmem/rockchip-efuse.c      |  1 -
 drivers/nvmem/rockchip-otp.c        |  1 -
 drivers/nvmem/sc27xx-efuse.c        |  1 -
 drivers/nvmem/sprd-efuse.c          |  1 -
 drivers/nvmem/stm32-romem.c         |  1 -
 drivers/nvmem/sunxi_sid.c           |  1 -
 drivers/nvmem/uniphier-efuse.c      |  1 -
 drivers/nvmem/zynqmp_nvmem.c        |  1 -
 drivers/soc/tegra/fuse/fuse-tegra.c |  1 -
 drivers/thunderbolt/switch.c        |  8 ---
 drivers/w1/slaves/w1_ds250x.c       |  1 -
 include/linux/nvmem-provider.h      |  2 -
 25 files changed, 77 insertions(+), 45 deletions(-)

-- 
2.25.1

