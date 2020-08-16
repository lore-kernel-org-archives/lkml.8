Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB41C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 15:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B01A20735
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 15:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="Ui6mVn6w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgHPPYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 11:24:24 -0400
Received: from mail-db8eur05on2099.outbound.protection.outlook.com ([40.107.20.99]:13792
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726339AbgHPPYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 11:24:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLiikZDSCmRJlV8bMs6AyM7xfjJlg5bl95oGf9br3JlWv6CnrF+PHEDrh03xcTTBwG9HKsqQkhj3bSNOuLXAm6rO7yUuHgJpS8AV82VZUVzWAdZpjqyPFuo0NNQwakD/LoF/+VtFo5kPDWB6vL6nYP32pPuP0BUVCHAeCatorIWZgXPjbtpHIHqxbF2zwF23PrrdE4saqUZ+LXTcIIW9smHfg7PFIJ6aWocGsW+4d/J/FlEuSZhKE65hhjtLUDi3vs8i84b0UJda+2ZIZoYZZtnoQy0BtVigJpDr4hJGg6HoN9p1r5v3Eit24dTOnYkXYjBNl+U/SL1fhC8EabO60Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3uuFUbIHoaTU2u6nAewllkqSt+Nobavs/GWZP9YK74=;
 b=hvVnwyRG17mrZVmryJ5CjpCWUXxRQGHNDNak8+ErGQlie1ETVVWvopw+HAPwcMF2caMtP9Gd/lL09Fp4ebSl6GgtmjV9mJwbl/gEJezRiUhgScOTcHi2Kvuyc16NPKVRMjPeYEsdXPB7PdAmqmmKH+2ye61ovg4rhaV5RHLfTCTwA7zAJBCITnJWDBQZ/BZnsyVCSXCJAOBPHz/lQUftX7fafRJ82plXRpKoDRqw4wtElxTZL0mj2vPpQ+oXBNxDZLuXy//arqrnOSuydfSSocXD0mDyVtcceifeEjAtKA+luIhGuHrlT6Ah829WJjZFu0ugspl2je66b8ai9ixhzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3uuFUbIHoaTU2u6nAewllkqSt+Nobavs/GWZP9YK74=;
 b=Ui6mVn6w+5PFRhHmlutcVrmEFqijN8rFc6NXWsCC3N3afFQzuyEyo7GSqTXJNdZBWji2Nh6EdNIoyuvCLxg72S137kZb0WPugGc7GQjVnYKsW0F/0K4VSx6LZQIHan2wuSzW2hfWdNT30aOOWls8B6vvXKGOBgO15WXRE/Vuk8U=
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com (2603:10a6:10:ef::22)
 by DB3PR0202MB3547.eurprd02.prod.outlook.com (2603:10a6:8:11::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Sun, 16 Aug
 2020 15:24:19 +0000
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::68d4:6b:d077:19a9]) by DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::68d4:6b:d077:19a9%4]) with mapi id 15.20.3283.027; Sun, 16 Aug 2020
 15:24:19 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SW_Drivers <SW_Drivers@habana.ai>
Subject: RE: [PATCH 1/9] habanalabs: change CB's ID to be 64 bits
Thread-Topic: [PATCH 1/9] habanalabs: change CB's ID to be 64 bits
Thread-Index: AQHWcy3aM59q1tQEpEedrTOlSBitE6k6tVLg
Date:   Sun, 16 Aug 2020 15:24:19 +0000
Message-ID: <DB8PR02MB546864405E2E113A0CF2A144D25E0@DB8PR02MB5468.eurprd02.prod.outlook.com>
References: <20200815175938.16619-1-oded.gabbay@gmail.com>
In-Reply-To: <20200815175938.16619-1-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
x-originating-ip: [46.116.96.176]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7e37c2e-876e-43ec-9cc8-08d841f8722f
x-ms-traffictypediagnostic: DB3PR0202MB3547:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0202MB3547A7FE73A0BFC6A4100957D25E0@DB3PR0202MB3547.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LbGduv8WzHFPpqeJxLQx7PnGjZO8bLMbVIUl4V76Gqn2dbQYcGxxIyoIjBixmQlN2CEC2E6jUHYdxSHeb8/fWrZPwdA7yuf2ImexG7DHEXhBtVyIaTjTTIghK3r/Z0GwKBtQk2eHSZM6wFYGyvyvq3Tag01e2UshMFqbsRoUd2QSShsMY9uvlP9T+VJoMr2yAitNwhFCYDtwrCf2wg4ncPLmcZJRefmaHa7Q/H8Zewpq3Buy/406LZosJgb20M5IN+XBOBY07V32JQnculV7jp1znkFl1YzF39wX6V0uOdfpgWPPjoxFE+5VZdp+i3e0RALb9Qq5HFCrMu2pMEJN3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5468.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(366004)(396003)(39850400004)(7696005)(86362001)(4744005)(110136005)(52536014)(76116006)(55016002)(6636002)(8676002)(316002)(9686003)(5660300002)(53546011)(6506007)(8936002)(66556008)(33656002)(2906002)(66476007)(66446008)(26005)(64756008)(478600001)(66946007)(186003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: nWmFrmbvCbrZ+IoAo3BM1xApFB/mtTLEBTP6OgUFII5KeKXeeICwbSzINFPzQOz6ywzrFdevYQD9IbD0NR27oY+byREQbNYiFl77SuXJKh2+UFtwSLC/NvhHHumEs9QcrT3F4KrR5E06oCYdehHnyudKa2Dv1RdfDEXuzskWgbE0xDBqcymqzq0Zee989Ibb3wC5o8WdPxjzAKTrjIAd9cawuqiv7XX+3gLYeNXKVKMhki4WlSZT6apB8C10aA9ST++P5n4LZtpxIvx02BOzK1WdB8GyLlQc5csrvmJvNmQERAP5IBCCywQe3nNXlGb1slaVHJvEozSrkPNItgqmJSQyjzNexI5IndjLssWKeqWVKvrKpLRf8DK6X7lpAfiVxY7eENwjUxFYvdocJFy5uU8OKWYtnOvP8ync6ikNr67ji1KHnVt332nV92MJ56YYeQY8hK798ZroVXAR5vn92eWD4d2J+joImocjM3OxyDePjbz0IiZa+tMqIBZQ6tWP/wSLuYFuMjjp71nvzYO+el1VydkkgPypHR1R30RvUoJvUemUyvA7CbxJNBdmq464LcsUm+Qt1uCfw+Pn1qb/VeC+ll4g2MH0L9OCwt80+9rjq9nVyvxsmsX9eB4Ji6WTZeJGaqdUVWaZFpKn75r4/g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5468.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e37c2e-876e-43ec-9cc8-08d841f8722f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2020 15:24:19.4783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tCffGUvrDzQqwSivZc8BE1iB3Qca9kqQ4hQcRZIE1RnCNZ6N9VsBQNh0uw+UMyNUzjc87HM4qbc3N3IGp2/clw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3547
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 15, 2020 at 21:00 Oded Gabbay <oded.gabbay@gmail.com> wrote:
> Although the possible values for CB's ID are only 32 bits, there are a fe=
w
> places in the code where this field is shifted and passed into a function
> which expects 64 bits.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Reviewed-by: Tomer Tayar <ttayar@habana.ai>
