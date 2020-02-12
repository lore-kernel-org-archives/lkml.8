Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3AFC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9549720848
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="culn5TrZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbgBLLM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 06:12:27 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.3]:62195 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726135AbgBLLM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 06:12:26 -0500
Received: from [100.113.2.20] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-a.eu-central-1.aws.symcld.net id 58/A6-64587-89DD34E5; Wed, 12 Feb 2020 11:12:24 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDJsWRWlGSWpSXmKPExsWSoc9jojvjrnO
  cQfsBEYupD5+wWWzdo2rx7UoHk8XlXXPYHFg81h1U9dg56y67x6ZVnWwenzfJBbBEsWbmJeVX
  JLBm7FjezVKwm69i4rNrLA2M/7i7GLk4GAWWMktca5nOBOEcY5HY9e0gI4SzmVHid+9PNhCHR
  eAEs8S939uYQRwhgYlMEuePngMq4wRy7jJKtDxTALHZBCwkJp94ANYhIrCeUeJO92cmkASzgK
  PE7b1vwWxhgViJpubnzCC2iECcxOSbz1ghbCOJne8+ANkcQOtUJS5MswIxeYHKr19yglilL3H
  w/mU2EJtTwEDi0ro3LCA2o4CsxJfG1cwQm8Qlbj2ZD7ZJQkBAYsme88wQtqjEy8f/WCHqUyVO
  Nt1ghIjrSJy9/gTKVpTYc24hVK+sxKX53VBxX4m/335BxbUkOg/PYIGwLSSWdLeygJwpIaAi8
  e9QJUQ4R+Lu4t9MEGE1iT2N2hBhGYnVM9exQtiLWCQurU6ewGgwC8nRELaOxILdn9ggbG2JZQ
  tfM4PYvAKCEidnPmFZwMiyitEyqSgzPaMkNzEzR9fQwEDX0NBY1xjIMtNLrNJN1Est1U1OzSs
  pSgTK6iWWF+sVV+Ym56To5aWWbGIEJqSUQuasHYwf177XO8QoycGkJMp764ZznBBfUn5KZUZi
  cUZ8UWlOavEhRhkODiUJ3tg7QDnBotT01Iq0zBxgcoRJS3DwKInw/rwNlOYtLkjMLc5Mh0idY
  tTlmPBy7iJmIZa8/LxUKXFeE5AiAZCijNI8uBGwRH2JUVZKmJeRgYFBiKcgtSg3swRV/hWjOA
  ejkjBvFMgUnsy8ErhNr4COYAI64rqJA8gRJYkIKakGpulqRqfPph4xfD+/fFZ38bwZjN0iV/9
  kRK/9UlQSbzq/Sb2wmdeVXcPIQyWl+rvfyntp1i/Puoru33A+iTe1f1H7MbaKdNUDs9nj1a28
  2FcHmvH+OnJh1f/FAdEHst3bGz9Niqh8vnP9O6e50tYS4S7i2TcVTQ2vR9Z9j7ry53PM2tWvJ
  O1nSMm+4J9UvcTxxVHGSS2yb8+9Wx1/nbfmfur00N5fp+aKzRUSbGIPnr42uFf+nlRwYWL+H7
  aVt+fe46jM31I8/Xje446oRT+6X9gea6paYH/S47O2zpHfC0Pe+vhe7nqb8PvV2UfXT6YnVzz
  +Vz3hYZGk+vE9PnFzZjS6XxHO+uNzZpGOoLh2mRJLcUaioRZzUXEiACIFk6FPBAAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-21.tower-229.messagelabs.com!1581505943!1046122!1
X-Originating-IP: [104.47.12.52]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.25; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 7815 invoked from network); 12 Feb 2020 11:12:24 -0000
Received: from mail-db3eur04lp2052.outbound.protection.outlook.com (HELO EUR04-DB3-obe.outbound.protection.outlook.com) (104.47.12.52)
  by server-21.tower-229.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 12 Feb 2020 11:12:24 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S28gpveadguL9eJwPhPIJNL/wn9q0EUrTlVN9gM9/yJprCzlqrhA7VMoc/de5DOS/5yQlpcue4aud3N+5fmyn7EWkZsyLPmqh2YvY71dKXUIxYLkyt1BJwB8MBQHUzoT0UK1cPX18E96UBj0fG1ysc1TLh2h/yCsd/M9ypmvPrU2l2C8HTW/g4CTSArmJpd9hqZlm1oAMWIETGNO7JY9GgjOZPl3mxDEohnUnncbToCn9dSp795ySHTnaT04nHJz12vEdpZOb4bk+N3e5frq7V293AuvYOvy9UtKLAcaBoqwzXTbUvcasktWZXn4Co7OiTs7FWgnLHawXvNkAnOtvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ww/Ko6+qtqQERRipVcaHT90//s1q9v2+kWNC3HhmvxA=;
 b=Zm37Phm5pozdtzqOsEwcg/byAbEmgWCanhhC+NVMXD12ChU0jpwU2SWGEmA/umA6KA2gvCHbsOvBqhB80ir47nlNSDF8ilOxMA/dGigXa8ULb6IhqmSWKpCiFCYkyKb4IpcZye90AuL0cXawfGQQYdT/LERPBPaGvkAhqD1M/nwglKVHYX903DF43+D43Sy9iDIj0NfeNqsyJaSWWdQv14oHuYp39S8AgWpMIXGduWkXiyZfLYl2A2QQihJ9gdINfAvop5klHpjRY0itPRKkkzKBXBcjKXtp5p9AX1I3eQsrubVhUhAi3hz9SvUiTb1LkleUJcE6u/Qaeux2uIeOsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ww/Ko6+qtqQERRipVcaHT90//s1q9v2+kWNC3HhmvxA=;
 b=culn5TrZc02ORrAb9GI8buwjoD0pm1i8sDK53y5ZKvq+HowysRUtHtLTHKumSpO9b5GG7pwMewfuShfeFIVWkIDMVdIuBk4ut2YABCmj60v9DvwEL/j7kXYL04oSaqAz4IOc5F3MHojvVIB9bTmnpJSCOxzS9brOwcu5yHX43Lk=
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM (20.177.116.141) by
 AM6PR10MB2343.EURPRD10.PROD.OUTLOOK.COM (20.177.113.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.25; Wed, 12 Feb 2020 11:12:22 +0000
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::993f:cdb5:bb05:b01]) by AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::993f:cdb5:bb05:b01%7]) with mapi id 15.20.2729.021; Wed, 12 Feb 2020
 11:12:22 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] regulator: da9062: Replace zero-length array with
 flexible-array member
Thread-Topic: [PATCH] regulator: da9062: Replace zero-length array with
 flexible-array member
Thread-Index: AQHV4TUreejcs7A9gECFZGoa0zFcsagXZ9LQ
Date:   Wed, 12 Feb 2020 11:12:22 +0000
Message-ID: <AM6PR10MB22630DDD54D581091C3C99A9801B0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
References: <20200211234612.GA28682@embeddedor>
In-Reply-To: <20200211234612.GA28682@embeddedor>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.85]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3dc8f38f-6f45-4549-8192-08d7afac6f12
x-ms-traffictypediagnostic: AM6PR10MB2343:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR10MB2343709DD3A490953E0431DBA71B0@AM6PR10MB2343.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(189003)(199004)(9686003)(316002)(86362001)(7696005)(2906002)(55016002)(110136005)(478600001)(966005)(33656002)(4326008)(8936002)(71200400001)(76116006)(5660300002)(66946007)(66556008)(66476007)(64756008)(66446008)(81156014)(8676002)(81166006)(26005)(52536014)(6506007)(55236004)(53546011)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR10MB2343;H:AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LG2C9bsia90RO8SNz7+pdJXnIfOWCrjZ548RmTP1YWeTL6siV4t4XQCMx4UtWGMG6eraX5GUhm/hZqa4ozX4obiwSGx9bUPXLknvryxP0Tb2SPdjWLe3t5kq7g0hjCdVq5XIVrR9AY5CCMH16S7f72UQWO3Dkh5FkNMStg3+HszWkhn9raeOTQbSkqqScHLuSMK4AnTrd2gsUam4lp3TbySO9hieqVW6Tnl563FEIIgUbdIBdAOL1aB7J2a100VNlwQfzl+q64BaNrR2GcfzJieWDe8JY25PcgM2EkCds/KoDXgZuhVeZRnFAwdA0+NCGuhTWqdtwuVliBGzAx9ocdASGQWQPjSL/O5YcRMTy00V0VylMESvhqkOsKJa9CKh3aT6n4MZFCtpuTcFaimlRsUG/4kV86WxNZKtqWUupLdZfkVRGC8GSctP2mfLIPDs+9IIxiOTYrR7azlk0j/uD4SfnRgtq1Vg+/BfNqypkHgC4rp+E5PVJyoa4tDhk/wl+rb3FUICf1WarvB6u4853g==
x-ms-exchange-antispam-messagedata: OTTp07bNki1P9s3MSjCfQwUnl2lcqU7BfzDDYT2j+GzG3JcxM5qMJkrCrcYS1pvRXnK5GpdrjmU8vw+8fnIvB2SyF7oAfdiGRdaefjaN538VMFhokPbAWuxkzgy4s2BQaYsDFyFzw4wRxx0JORktJw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc8f38f-6f45-4549-8192-08d7afac6f12
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 11:12:22.7294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sEGR3JwYuZI+P1czNAOtV5tRsVLW3UaeVu5PolMNMnNU9PBvDa2Adndr+EmnacjOowZGn39KNFHjkBtxbdYxnYc5qBRbey+4fI1par9NLRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2343
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 February 2020 23:46, Gustavo A. R. Silva wrote:

> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2]=
,
> introduced in C99:
>=20
> struct foo {
>         int stuff;
>         struct boo array[];
> };
>=20
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertenly introduced[3] to the codebase from now on.
>=20
> This issue was found with the help of Coccinelle.
>=20
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/regulator/da9062-regulator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9=
062-
> regulator.c
> index b064d8a19d4c..c3b6ba9bafdf 100644
> --- a/drivers/regulator/da9062-regulator.c
> +++ b/drivers/regulator/da9062-regulator.c
> @@ -86,7 +86,7 @@ struct da9062_regulators {
>  	int					irq_ldo_lim;
>  	unsigned				n_regulators;
>  	/* Array size to be defined during init. Keep at end. */
> -	struct da9062_regulator			regulator[0];
> +	struct da9062_regulator			regulator[];

I don't think is the correct change here for this driver. In the probe
'struct_size()' is used to determine the actual size requested from 'malloc=
()'
when allocating memory for this structure. It's not statically initialised.
Your change will break that code I believe.

>  };
>=20
>  /* BUCK modes */
> --
> 2.25.0

