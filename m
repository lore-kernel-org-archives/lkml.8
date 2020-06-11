Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D04CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 23:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1715F2075F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 23:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GVPFQnfH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hetV+ATt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgFKXCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 19:02:45 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:6498 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgFKXCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 19:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591916563; x=1623452563;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=LusZqFmV/LpCzdobhiRgOtpG2WvPIWVHQrbj6u2mvu8=;
  b=GVPFQnfHyQKGHBqM6PQyeUtGCnkBnsKy8HXng5gAulB0/zc41YvGPRcu
   WU6hlmHyHu1u7mSWROwp0iIjLJ2r6NS109Q/YOUzKOR8P0rCJs8AxU7gp
   3s7UnZ4uLVtf4qZ2NuWxpwjzWzMC9TXBbrtCsTCaJvcOOEyIWGlKzJhcj
   495f9hXE9oCDxlzkdaupOyShmTh4MajvJgMBpP3gIGtCRCDmo7iZYca1X
   9tf8nNaOI66VmrzUiiWVOrOKjrGnS0SpoWXNqdXu9ucnDX6ppvvBGhdXV
   dJcKwQ/xhn5FQ2T22FJHGbBxNqAC5DGFH4MRddV3cpMCuXZNVYYvYpvC6
   A==;
IronPort-SDR: sGS50NpzUgo0UkRzy15PtSwTtxwXulYs5yrqNvAf/CGPlciVVpiWoMcS0IiVR4xGc1Wg2L2Pmw
 g5YvrP0QF0m1JUY168oIIQXrKgEB7teE6UgGWbEutZ4S/3uNHTWR2raOJjchmNzqCaHw+Q7kQm
 dw7jVg4tOnfQmJFdZD4EZag7JE/VkcT1HwKqadUBSoIwIH26JCT358myJb/0QoP6wGxiLCKdU8
 MAguuvwmFgAx09hhRxdG4ogJBCLDTZ3aK+da5IVDfOP3eA4//ZmV7qpxMxYQBqC1/8yX0S/9Ec
 RNI=
X-IronPort-AV: E=Sophos;i="5.73,501,1583164800"; 
   d="scan'208";a="140060735"
Received: from mail-bn3nam04lp2058.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.58])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jun 2020 07:02:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=daLeeEDYp9rGgFJrGxr5nHfxdsDIbMlHgFpsvcafQHLC9Vdhbt4v9yid9ry9mxWCI65B+0vMs0tGWPno2jEMK6Eg5duzKESFXUb/Cp9ZMX/ykIhsNy89lZWmFU+rKW12CgPMnmWWpR0WHP+b+uSESs94AFcwQfB3CVSC93zK3jI9ypyu0FaLvIjpTUHb1NoNcHW6e2/GERmFKMB2pZfjo+1rsW+71t2J+t5hzGPboAeWRZVPZ89SkR33bByebJhOAOxdswuVifRlSV9VzFEFZ6ttRb7TpMHqAtZm2y8r/+bTlGQdQNg3FBxs9yPN+YCc2ZHPdZ4AFJCpAnM8pXpfAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+6jevJ/vKvmtJBAqThT1cHgma+N9JhysefUG7fp5hU=;
 b=erWSJNeMMPERSx03K7Bb1r5W5VH5vsYTZW990TJjAEikIi893mxTcxzoMQMAFur1SFqO9TZgHUXUpZ7+CYvC9JOP7kRCtOx9PYMqIHpAWfUQ6ZXBsj5PiSybDAVRlHY1JCoK3eDfOinYxdi6rR3daSzoo9v5b+pP/Ndp99YE5jmZvMm2y2Vq8uVXeAP5aM/GYtBmbSGg72sIfoXGy3kbeQar+wy1PvG+Wu7+2jMZ1KJfTW/krL16NAoA6yFu/F/UFinYIbLRl+La0TGAkrM7PW15g5cvUjDC4Brlk0kOvgBI4gBQdltnWcCdyHkgQBf5urObcaRH3juTAPG8jhU+oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+6jevJ/vKvmtJBAqThT1cHgma+N9JhysefUG7fp5hU=;
 b=hetV+ATtBw4gFAfqRBxqXtbbWqvSKuPE/p40YvBuvqyYWjBL7PnyeOZ+nb4uJaEvTwVJ28YrPtblGBrUq6LIrqtyAJ8rsmniAw2TcGEaYAW6UaINPCZQDrCJSKo+mMtDxkWusAaHavkKGeFCYZqcYWRSjOqzuBPXVw162uZ6e8o=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6884.namprd04.prod.outlook.com (2603:10b6:a03:222::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Thu, 11 Jun
 2020 23:02:40 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 23:02:40 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v13 5/9] nvme-core: Introduce nvme_ctrl_get_by_path()
Thread-Topic: [PATCH v13 5/9] nvme-core: Introduce nvme_ctrl_get_by_path()
Thread-Index: AQHWKhRelu9zAfZ7mkO3HQPKQV1k0A==
Date:   Thu, 11 Jun 2020 23:02:40 +0000
Message-ID: <BYAPR04MB4965AE69900A7832EEC4141086800@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200514172253.6445-1-logang@deltatee.com>
 <20200514172253.6445-6-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7c3cc345-a943-45bc-cd83-08d80e5b8a9e
x-ms-traffictypediagnostic: BY5PR04MB6884:
x-microsoft-antispam-prvs: <BY5PR04MB6884774CF575FAFD7E1C18D786800@BY5PR04MB6884.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 0431F981D8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zx0FW1GkV43zh/GobF7fNmLLjUzfmXMVENWm4Z3atiT32EqXsifeX6LFcUQkAr4N473PVLlTqT9rJcP63boAliG3PlGuQIkW70SOxRUZwdn/wexPY36J1NTkhSvjwW+sD5bZD1XSB7MrlvhBzN5MuVIhdT8P6WA9iCxr44WF8J7XW8vuod9o77E8y1TcXY4MDpYIaShYdh9/Oywpo0aOnx1o9PKEZSpG/CMYTgUtN4bOOv/RiQGeVaUxylUQ/jXQI6W8D6Ao1U4kcCOp6b0LBNYhgFDDsNSKtKJBtZ4+zd3UYnjUSeyv4D52DCgI+SU9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(8936002)(8676002)(76116006)(66556008)(55016002)(66946007)(2906002)(66446008)(64756008)(66476007)(86362001)(9686003)(4326008)(33656002)(478600001)(54906003)(186003)(26005)(6506007)(53546011)(7696005)(316002)(110136005)(52536014)(5660300002)(71200400001)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: XrXy9eTrQTKCpRxeocRGmIZ6ZlAyWG1f3Uj7D9RXYEC07RCo/MthYwhiPv7XXlw145jRHAuH6GvQLn6BvFrjfjNUGgJHjvtImpuoRoSBjK5r/IqGwHp9DZsHiEH8d5+kVqKXUE0jrncW7P9hw6B52ZKX0nHAlRbu6F31yRhJfs46w8X00tNOVjZFx9eWsCXzUELqpV9GweRjyLybFAHzVtjfBKoS5/pIE6re0YEbkrPpigiVRiQtj41E1MnmiLbrR4pOUwD8lPmhoR2VAtdk4o6LWR9azZNe6lphQw2+n+C+rD2AVjY4ow9ZtrFCFTsK+zNXcPXKXmKP1wyxvztmzDf2L/DE/k/f9vJ/3eaZjeqodB9QTYMIiu4NHnOQeaDHHzO+W2FyoC9pKu9aQ5GYxmM+HNA+UjgkYKyiHcVisx5sGiOSXTG++7SbJAYGKQ1deAJyEZ5pm+MwiZmh/4UD1dgrInznbqnYAoxLl9vU/yM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c3cc345-a943-45bc-cd83-08d80e5b8a9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2020 23:02:40.1991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jYW9Y6vY0IDkOmHZiRoZHyR3UPrZiPXqqpK7RgGg1XYwXdVCln3JW1ZUNjdi9eU2isTVTdZWtyqjKgVmkXX4nKgJAPY5fE8Q9ntIXL3HpnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6884
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/20 10:23 AM, Logan Gunthorpe wrote:=0A=
> +#ifdef CONFIG_NVME_TARGET_PASSTHRU=0A=
> +/*=0A=
> + * The exports that follow within this ifdef are only for=0A=
> + * use by the nvmet-passthru and should not be used for=0A=
> + * other things.=0A=
> + */=0A=
=0A=
The above comment is duplicate #ifdef is self explanatory and I didn't=0A=
find similar style in existing repo  (e.g. CONFIG_NVME_MULTIPATH,=0A=
CONFIG_BLK_SED_OPAL) so let's not introduce new style which will create=0A=
confusion to future code.=0A=
