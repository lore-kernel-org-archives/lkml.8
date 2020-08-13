Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2156C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 10:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BEFD20791
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 10:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="nhIEM+Zk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgHMKvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 06:51:13 -0400
Received: from mail-db8eur05on2086.outbound.protection.outlook.com ([40.107.20.86]:43893
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726102AbgHMKvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 06:51:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3tkQC6pp1o0x5R5kxkT9VgrgfP+SJI4nK3DoAjyg+5yUz0gdZn0/uvRpxC0298cAWCQHqKEobBwUvnE6DAYonZqyRKUeoT2n5VzREM1OMq4YUOD0+uDRK2pj5KF5xKosz8aXRmTP5zV9SrXx+WVziGZV2kD0pOaOaJdcJkmVwwjdEyrDuasUbeJuqOOvdULAMDg++4twZt4VRN3nfP3dzuAE0Ar6UFObOiljt+JhlROTnVvC87xk1KQE2AjhRzqkP0/XzbdX32ieoJ8tvb3qOXiCHTMxBudqtyqdT3z/pHI4wJgLKc2imm0W8l/45PAWtD3G0k2s18uihGTeROEVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2s5zmUtM4vtHOT0Pdp0Qchjvk4SrqlWZpuHIdo2yy+g=;
 b=h/jDM8aYjJBNvVgex2i9RD7SEClOTEr89FycsmU+D4HFkIJiDXQD32oO7pybI2VY8N3gpEdh3tYlKF3d33ZJ/jO3Fe2Tny0vof6p7mzRF69wxPbRIyhKBNZq/hsb1t7VN8gnQg7TcCIJ5C+FG3CCPHiJxKRreT87kWQlZ1Q5xv4TFaWf94jwqHlLR8YIR53tUjuZVkCrcMjWliW/NPwpl9VX0Zcs0TwM/uAyLFSgHl7kr/LCc2rhcozf8DhujqwzHjPEvzF8hnuqUcIDE3T8NY6F0wZhh/7xpIoFiMGv4x2/mX6ApbKsS1Lq5fS8/BC2YwjeVHgNk65veauTBR4pMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2s5zmUtM4vtHOT0Pdp0Qchjvk4SrqlWZpuHIdo2yy+g=;
 b=nhIEM+ZkswQS8VruzfmBMp1zdZb4wXFJ37tHUmUICzyorD9j0fYh/KSiOi6FwqAkqPOqvnPvG5s+3PHibRUhgfefQ/c4yxDt+J1h3yW5hBocOoWSZ/tI/ofc+MhN1cCBNQvslNb3oDPmdT/H0cwcUf1qMw2NPg/lLmv2SHXn1fA=
Received: from AM7PR10MB3640.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:135::13)
 by AM5PR1001MB1201.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:203:14::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Thu, 13 Aug
 2020 10:51:09 +0000
Received: from AM7PR10MB3640.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7114:8e7f:c0d1:3aad]) by AM7PR10MB3640.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7114:8e7f:c0d1:3aad%4]) with mapi id 15.20.3261.026; Thu, 13 Aug 2020
 10:51:09 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Daniel Kurtz <djkurtz@chromium.org>
Subject: RE: [PATCH] regulator: da9211: add cache_type
Thread-Topic: [PATCH] regulator: da9211: add cache_type
Thread-Index: AQHWcKzgAmP7mdXiSUeslK25jTXv1ak13KpA
Date:   Thu, 13 Aug 2020 10:51:09 +0000
Message-ID: <AM7PR10MB3640F010AB74DC6E625CD3F180430@AM7PR10MB3640.EURPRD10.PROD.OUTLOOK.COM>
References: <20200812133101.2513317-1-hsinyi@chromium.org>
In-Reply-To: <20200812133101.2513317-1-hsinyi@chromium.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f68f77f6-6441-4f24-09f3-08d83f76c993
x-ms-traffictypediagnostic: AM5PR1001MB1201:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR1001MB1201CCF63475D811AEE60523A7430@AM5PR1001MB1201.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3640.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(4326008)(478600001)(26005)(86362001)(6506007)(53546011)(33656002)(186003)(83380400001)(7696005)(55016002)(64756008)(110136005)(316002)(54906003)(66946007)(66556008)(52536014)(5660300002)(9686003)(8936002)(76116006)(66476007)(66446008)(71200400001)(558084003)(8676002)(2906002);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3640.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f68f77f6-6441-4f24-09f3-08d83f76c993
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2020 10:51:09.1690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AsisLeFHFoCi5uZi/Ajuh+oZj6tE5Q8Cdg1/aAyoZiy8wgcJna8D+jszEqTFYb5D5ZNjEApMWhCGrkHUZ2lgROZstmJodYxG1ZVmlcdFrZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB1201
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 August 2020 14:31, Hsin-Yi Wang wrote:

> Add regmap_cache to reduce wakeups events of interrupt if regulator is
> accessed frequently. This results in saving more power.
>=20
> Suggested-by: Daniel Kurtz <djkurtz@chromium.org>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
