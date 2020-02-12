Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4892C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B24120848
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="JTg5YtD+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbgBLLOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 06:14:47 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.112]:45416 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725887AbgBLLOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 06:14:47 -0500
Received: from [100.113.4.207] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-b.eu-central-1.aws.symcld.net id 31/86-62111-42ED34E5; Wed, 12 Feb 2020 11:14:44 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIJsWRWlGSWpSXmKPExsWSoc9roqtyzzn
  OoP2hgMXUh0/YLLbuUbX4dqWDyeLyrjlsDiwe6w6qeuycdZfdY9OqTjaPz5vkAliiWDPzkvIr
  ElgzTr6Zx1qwj7fiUXsHUwPjTO4uRi4ORoGlzBLTu/eyQTjHWCSePJjPCuFsZpT43fsTLMMic
  IJZYteVl2AZIYGJTBJXJx9khnDuMkpcnPKKsYuRk4NNwEJi8okHYC0iAusZJe50f2YCSTALOE
  rc3vsWzBYWiJVYt+k2O4gtIhAn0bl/NhuEbSRx8WYnC4jNIqAqMfljHzOIzQtUv3r+arAFQgL
  6EltWPmMFsTkFDCQmPlsPVs8oICvxpXE1M8QucYlbT+aD7ZIQEJBYsuc8M4QtKvHy8T9WiPpU
  iZNNNxgh4joSZ68/gbIVJfacWwjVKytxaX43VNxX4u/TLihbS+JP6zUWCNtCYkl3K5DNAWSrS
  Pw7VAkRzpHY83AZVLmaxNKVG9ggbBmJ1TPXgUNRQmARi8TspY/ZJzAazEJyNoStI7Fg9yc2CF
  tbYtnC18yzwEEhKHFy5hOWBYwsqxgtk4oy0zNKchMzc3QNDQx0DQ2Ndc2BpJleYpVukl5qqW5
  yal5JUSJQVi+xvFivuDI3OSdFLy+1ZBMjMDWlFLKX7GD8sPa93iFGSQ4mJVHeWzec44T4kvJT
  KjMSizPii0pzUosPMcpwcChJ8MbeAcoJFqWmp1akZeYA0yRMWoKDR0mE1+4uUJq3uCAxtzgzH
  SJ1ilGXY8LLuYuYhVjy8vNSpcR5e0FmCIAUZZTmwY2ApexLjLJSwryMDAwMQjwFqUW5mSWo8q
  8YxTkYlYR5d4JM4cnMK4Hb9AroCCagI66bOIAcUZKIkJJqYDK62a27ZJqtqsL+jfITswwnHdx
  8m7X75BzGV+HXi9e7Vu5XP8dVZXGo3POgoeDxe/45UsfTpsQXBeVFfLVKL3SK1b/zgimFt+9w
  le9XP9bmDX92udflLXbqjFwT4N/wvC+Uo+rb6s4zWywWuLW9nvZ/zyVLbdfqnFP7blQxSH7av
  5ZTP8hk57LnD46vVrD/dz//9p0UxTK18JuzdDMfXVlU8+j8I6uvE22vt1p6Fl/q430RLuN9dI
  MC032u5CNHxF9/XXHsamDagR5tp//9p/WcYwOy7G45XdkVwbfzU3N6THiAxRR+bqPWl06fq9a
  ZuisWsZRZ6X8x/XvgBzvb9bObJ9pnqC3eq7MzKH3mJiWW4oxEQy3mouJEAKMMxsdUBAAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-27.tower-249.messagelabs.com!1581506083!2012667!1
X-Originating-IP: [104.47.13.52]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.25; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 9075 invoked from network); 12 Feb 2020 11:14:44 -0000
Received: from mail-he1eur04lp2052.outbound.protection.outlook.com (HELO EUR04-HE1-obe.outbound.protection.outlook.com) (104.47.13.52)
  by server-27.tower-249.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 12 Feb 2020 11:14:44 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0TDJ+Eb24tV7h9lCDWanUWsKFUZXT+SxOeFbZJm6pKENWA5pt0XNr7Bztg8peVvTTY4JV5j/5MGbtBlTqLAHCY5/qvXMkLmXUSD6RQd0us6aQVf5KahRF7gEpJqlgTvDrJeXQdVpIopqSwUQxgfSgHfcIAGl6ZRNP8lQ35HHahD+HlNilUwQAgkkrtMVNxu9QNoNVeiO1wV0PYO43upkQ8r1aMl1L3y4/OCZqwqgPfRzYZGDblRT852NLszJ01gu6sPtNXJ2DKR+XX7EZDc8+zMBzpGUB9VYEv37TO5/hWOLUgRdAi1jo5/DcyEdEgrZueOf3YLATqFTZBsgREA2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yZN2sN/1hNkbtBTMkbdZIASXypWgNoiBIbyfDza86Q=;
 b=X4M9dQcuNcZjyKFv4a+AwD3MbmyUH1SCQpv40lLxSo0dfYt3IdvmIvxiavnm4d/eIdeJIeLBx/HYhHQKDbgxOeYXDXeoMQOdQfRO3MMJskylZtQpb9tMsqNfgphn03ld86gb0yn41r2ipKCRtpvpzpr3Wtw8FBJBfmwMV1682HNktsnLYS7MvZHzvLezePI4piR+es/Twb1KUXxPjaCqLJu3q3K6Uy7Qpk+ioSQ8YbsilswE+ie1T+3RN6PDQBa37ws8xaMUqSJl0nI3Jq8bQn/iJADMGhR/1WSSe/0FV2Q2rAXnC4w+8PzGsgAjvCUxk/7BMYeEPCBKnSsy5VwwFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yZN2sN/1hNkbtBTMkbdZIASXypWgNoiBIbyfDza86Q=;
 b=JTg5YtD+E9EvrApU3jHLi6AV6MYYbX+u7e2TCh93hjHpAgC47VqsArcfka933Xs0hY9XrHUd8as53hbzN8rjc9gbvUJJAbr2r7PKITZmpm6jC8h18mYKeHBAW77h2LlBZBJvfQgvR4iaU68nGPyBBnaQt7QIzsPTOcPY3J+SmdE=
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM (20.177.116.141) by
 AM6PR10MB2391.EURPRD10.PROD.OUTLOOK.COM (20.177.115.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.29; Wed, 12 Feb 2020 11:14:43 +0000
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::993f:cdb5:bb05:b01]) by AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::993f:cdb5:bb05:b01%7]) with mapi id 15.20.2729.021; Wed, 12 Feb 2020
 11:14:43 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] regulator: da9063: Replace zero-length array with
 flexible-array member
Thread-Topic: [PATCH] regulator: da9063: Replace zero-length array with
 flexible-array member
Thread-Index: AQHV4TU7XbdeFIRzwE217omIGbXoEqgXaC9Q
Date:   Wed, 12 Feb 2020 11:14:42 +0000
Message-ID: <AM6PR10MB226386E325F5EEA41A1C47BA801B0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
References: <20200211234710.GA29532@embeddedor>
In-Reply-To: <20200211234710.GA29532@embeddedor>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.85]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15214e2c-b641-44a8-f335-08d7afacc29a
x-ms-traffictypediagnostic: AM6PR10MB2391:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR10MB239167C612573EB2650E692BA71B0@AM6PR10MB2391.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(199004)(189003)(33656002)(52536014)(2906002)(4326008)(81166006)(8676002)(966005)(478600001)(5660300002)(9686003)(81156014)(8936002)(316002)(66476007)(186003)(71200400001)(53546011)(110136005)(55236004)(6506007)(7696005)(86362001)(66446008)(66946007)(64756008)(66556008)(76116006)(26005)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR10MB2391;H:AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gjEkDO5lEVXZg0g63WVBZrA44CBrk2X87vk3YUEHXQhbmhTfD0b6oPlp/8QLc4hCacNw1mEabCaDyMywc7lFpvXqfgtLYAq5fx1nv2aivSOAxEeHtdKq63VEIwnTVLodcn9VJLcBMxR4bWgRvvetfohtEKo5AzId8TRILhjN4Miv4QdVTp84JLuMqPwoNfIK21s46q5wLLmFD29cxrmfkNPQXyqUcSN80Mj9CeoytNUAGtct5WY1O9wh6tbrONdHkjGR/QgQYCFWoPwubr/Jj75usouuc7F49ML/elV0oNIrVH2YvlKeWDiJ8DVkLMyb16HxM4+6oQeWWhVWkA/+z1lAVl5r4rt4LaQIXzTu5eVBLnftWLNvjpLHROw6JW7s6qG1T3zf5XqMrX38RZK3zvR6vrd5c3u2EH8uacyZ24Wuv/q+z9NwMdGm14+h+HhKoCSnS0Ix6MDzD4upf/kyhFgNDGqM+/oCKCmIUABMXKTODa0VaG47YpMupMl99HnU0sf9HT1ZUjxDcCbJXYQESQ==
x-ms-exchange-antispam-messagedata: VnWQEsd/qlk/YaUqU/E5PRbEfYhXEd5lZDGFyDCUaUgVCwme4r5IK6GH5vA6uO2DvSXc3ScxHSYPgKA+RDiShNsUrZy/8QlXHNa/yJ/bTbugzexd7pPcdkF/Cv/kE8IEZQE35CXnSN071OT+f7OG5w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15214e2c-b641-44a8-f335-08d7afacc29a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 11:14:42.9175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q9ml36pjuBHaaE735OT1D/E3N1yVeARrZ4Q+al1JoTpDED6R6qZQnRpPuP5y614iZGi1+DQ4gXcU1RGobB9msM81wIj1Q2tnKvvT0LcMMl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2391
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 February 2020 23:47, Gustavo A. R. Silva wrote:

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
>  drivers/regulator/da9063-regulator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9=
063-
> regulator.c
> index 2b0c7a85306a..368f8ad2a9f9 100644
> --- a/drivers/regulator/da9063-regulator.c
> +++ b/drivers/regulator/da9063-regulator.c
> @@ -119,7 +119,7 @@ struct da9063_regulator {
>  struct da9063_regulators {
>  	unsigned				n_regulators;
>  	/* Array size to be defined during init. Keep at end. */
> -	struct da9063_regulator			regulator[0];
> +	struct da9063_regulator			regulator[];

Same comment as for da9062. The probe uses malloc and does not statically
initialise for this struct so this will break the probe.

>  };
>=20
>  /* BUCK modes for DA9063 */
> --
> 2.25.0
