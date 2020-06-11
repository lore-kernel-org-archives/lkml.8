Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91523C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 23:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A55F2075F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 23:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="R7wTRZtV";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DyBpeCLY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgFKXNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 19:13:45 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:7351 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgFKXNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 19:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591917225; x=1623453225;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=/Nt2+kIN712BOJFz4irG0MDhl+bonaw/qcmmc2ryco8=;
  b=R7wTRZtVYU7N6I62uaSoJwhdlTgKI39uz/FDq2bWR/kzZ2/Us9xBoPy+
   A0YPbK/YFg64trjDc6q9x/F0gS3HGa/0ULv1nqsMitXDLwrLJok0RVE4Q
   hI3akQQurrHtQKgFDtkfyD6PasHxfPG9DQCQ7YW2X6TeN/r1gJ9ytSz13
   PzFV66t/VeuWJ7edKS8q2pzCO8z4Ds6uHGVduODkspbeYMlNzFW+9cUXw
   NL38+oObcX+BpAVqhkVQdNK8Hti5VK7rXPnNLmVO9n6QSarZBjrF7vDVs
   AEAW05gxP3UNKj+EAFhzogpjyOpumLbtIC1VW178OypGThrG9O/Or2XwP
   g==;
IronPort-SDR: yGvNtIaeuKVL+SRha3Fw/NPkdtEPOGaTbdb444UVYubiIBPW3nKYkBmmfjuCys4uoXhyyWWi7X
 GXqTFyHGzfZr7oTAdiS2oJIgSHuqKtjnswut+zGRcsAKZfwVgdby4lfh0Y+fFvR+pnwKisiMIJ
 CBUpV5xmrtvp/F0a9pGMU5AksTs6vh7FxAZYhwUHc6jAKjBnmOKfgAx7Kd6EZYYEfnbNOAvxD1
 B15IZLCIGgE4alE42BYlHuOU/jUvcfSHTAA654w9cFZn8SjHdTRbdbfvpUjU3d+cutC9/E7pNU
 HNQ=
X-IronPort-AV: E=Sophos;i="5.73,501,1583164800"; 
   d="scan'208";a="140061670"
Received: from mail-dm6nam11lp2176.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.176])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jun 2020 07:13:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ACMaea4E8H1a4w/L6LeSfYhzG2ExVP9oLF2/Q8QIDcHlbSJouSEGUZkhyLbHboaKQwtyjw5l48G1YnTJ+60sCvmHr96JmJyqxUtsXHBhLHQ3DJthQ3S7cxoad4QXLakAH8PJ/Nt1ZcrNcYOETjwG3uau3TVWZ69kR5tgsn01mXdTvzyWY7ejCAn+EhHbA4e4At6JBmEbd+rC1uTVULsqRYLYfaQAyAISO7YF9wpPM3ksoa61dPrCPmrLBt1jn8hiCdS8jkW5A66GC/8Glfa4B6ErRQNaRkGRZZxaXTQot4/SH7jrBP3cmy67pc7N3Z5JH2LxF4wAtUn4rLXJNUHB+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkoSZkLqbMQf501OjlRv4HDlA8iQHnN2KkxKpL31rg8=;
 b=hdC+pn6x4BXu34jLaqiZ0n+K4+hSOla+U47AXQn/YHRlG6vxlB4X+l6A+4z8TqveeTzNJzKV+Y7MU8vmPKY3y3UAOUW0uAcK/p0Z9cpiqCxjxv+xNWhf2fsR2I3QwjhGuJxs/wg3+c0cgKxPWl52fGsifi/VjtgaK49j/xO8+7Zx0vJKW11l0QKjn2bJX5SNon0vFXzVYgmHeZWaeGUDDUcHZrIP6D3ksb7KN4RJNezCO8b7IYjLbEU/TFrIeTtU1pFEmlmr9g+kqByQJRnOWf8Y9ZDXWI97YNCQgpFTe3C3UmSotuBD28Dugo8VWxp3IN7CwWtW9crHFSBtRSNoww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkoSZkLqbMQf501OjlRv4HDlA8iQHnN2KkxKpL31rg8=;
 b=DyBpeCLYvvvxeiJm+5pDV6XFsUIFvUX254p4EFcIRW8ak9rdcnGUN2VzMM1camdsXNdWEKrIDLOfdHjOs74UTtdGogmjX9Kw+UVTifw8Zk6Wt+Ke8JZVALvxvhEd1iEb1XBm0xUp/qlfSPfkdAHM3piosGxw0D+lvUAL1yVfXX0=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB7123.namprd04.prod.outlook.com (2603:10b6:a03:227::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22; Thu, 11 Jun
 2020 23:13:42 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 23:13:42 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v13 8/9] nvmet-passthru: Add enable/disable helpers
Thread-Topic: [PATCH v13 8/9] nvmet-passthru: Add enable/disable helpers
Thread-Index: AQHWKhRr7Wm2MqUdeUmSLdzKIjdSIQ==
Date:   Thu, 11 Jun 2020 23:13:42 +0000
Message-ID: <BYAPR04MB496581334E89E2E3086C268286800@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200514172253.6445-1-logang@deltatee.com>
 <20200514172253.6445-9-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 475cb9b7-e807-469e-3c48-08d80e5d1524
x-ms-traffictypediagnostic: BY5PR04MB7123:
x-microsoft-antispam-prvs: <BY5PR04MB7123917BBCCBB3993C0D9AD586800@BY5PR04MB7123.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-forefront-prvs: 0431F981D8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iZSTibywpYg411B7Ce46kku41gnzbCbpZ945HmMQn7J5qC50+Ti34lMF3mcbmZV6cDDgwTA0gvUSNQ5QFJp3IZ+szfJkre+VL4Oge8X3NmLJ4GOWwzmK5JIZbHXt1dg04STmRfwHvL6mwcpn53/RNArL2NV3TDCYBhmZMVEjoRp7ttINU0UtD1Wf8exdPnp/GmypnenhR9bfl4vOWai2//d5FPfatL+2uqdybPcbZQAyllbj94aL+Ut1OjnUYi4fwCCDtTsxkmOBWeivfiteNQfHymg+gTQWVU++spaWU66u2d6RB+KnFKfMn1lMMrRUxH3Yl5U7faWLjvPmouYqmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(8676002)(2906002)(8936002)(4744005)(83380400001)(5660300002)(52536014)(33656002)(86362001)(71200400001)(478600001)(316002)(54906003)(66476007)(66556008)(64756008)(66446008)(110136005)(4326008)(66946007)(26005)(9686003)(53546011)(76116006)(7696005)(55016002)(186003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: m+3XNp5dr7bbj+ezzG/GYcQq65xtVY8fdPDkcAOFh+XtPtETZHBt6w9TMB03HyjIKKUVN9arg/uIAP9TOzCnNCjUdbH+fst0DD887EtL+75ADY1gdoBHn7SOKXQXxspO7Zi+7+Z7Gk05bJMmuOGk3wKU5GC5upu0fGgR6fRuusS1jLaTBIgBIIKkh7thEMaZY7dW4TOSO4iNnP5z0n4JAHZs37JuBfabn6FJzKP0IRKEW1llr9ZF8bkY7G0iDTdRnjjSzVDfxilppFyy5rSSBgxk0PkldTdwbIJRX/Yes6sqD+W+txk/r3Ojbd/pEJB9SsGH+7wA1Z6+cTReHIU5C/hcEwhzycUVJD7ceAdc6Upa9U8C7BgdQ3Z3VulIQHMSNr/OG7jYiaYY6/a657yqbZo83jK0CzVaREosIJYglWMcFAfoXbeXoeMyFJdVjlcw53oLojNLLWZtdW7/8zBa2yizBe8LhZ1aQCBPQJqLp/M=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 475cb9b7-e807-469e-3c48-08d80e5d1524
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2020 23:13:42.0819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Mb0c3wwZ+XXyFuKF7Vm+Em6QNaWENthjGBURdgFLJU9bETYp4dzGpA2UUOC7sbaVuCWEKvbDOnC7WoLueoYqr9BbhCYt6qfT7nwNF2SmbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/20 10:23 AM, Logan Gunthorpe wrote:=0A=
> +	if (subsys->ver < NVME_VS(1, 2, 1)) {=0A=
> +		pr_warn("nvme controller version is too old: %d.%d.%d, advertising 1.2=
.1\n",=0A=
Is it more than 80 char ? can it be ?=0A=
                  pr_warn("nvme controller version is too old: ");=0A=
                  pr_warn("%d.%d.%d, advertising 1.2.1\n",=0A=
> +			(int)NVME_MAJOR(subsys->ver),=0A=
> +			(int)NVME_MINOR(subsys->ver),=0A=
> +			(int)NVME_TERTIARY(subsys->ver));=0A=
> +		subsys->ver =3D NVME_VS(1, 2, 1);=0A=
> +	}=0A=
=0A=
NVMe blktests are running on QEMU based controller. This will generate =0A=
warning every-time.=0A=
=0A=
Also, I didn't understand int type cast, I wonder under what condition =0A=
all these macros will return -ve values since ver of type u64 ?=0A=
