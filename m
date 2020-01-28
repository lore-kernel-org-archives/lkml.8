Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792E2C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 21:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42FC1207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 21:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="hCesolSZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgA1VRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 16:17:06 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:49442 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726211AbgA1VRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 16:17:06 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00SLDQ4C008347;
        Tue, 28 Jan 2020 16:16:41 -0500
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xrkfaj76c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jan 2020 16:16:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jiVl1JyvkkxwDLdFORX0lCtnfR0GToDwgBsDfrr8sk5ggalT77gnu51k+ziEuLsna2qERrZ9NtyjYeH/ZvP6yk7guKXOA3Q0IuFl5isRVp0FCw8yYpfjzDtZ6F21+7tlUwA5QxPSd5Q6t1ZxQrqg7Gy3QQQfE5EO9pf46UnYlMSefjc/SvnCFJDZZnBRXAXVSTu9M9FCS48luxzG2GDDJwGbP0R0E1bkwqIONvQzTbII570IHmkmcx0ajGhnbzph7ooOWW4N3agegsIB4glaEgiC/FSgKlf8secQR+ijMpkJquhZs+0Xy2jwCQOB1hJYyBEY4Z58WsGNthGPtRfySA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LPa58CUu2yAFQMqJ7HvMcBgEgOfgquVoUado6aB2xE=;
 b=AHapKfqQaVSEakkFxMFhK7HN3iNvxUOe4UsUumevDTjSWkGwQGPyR0lVzGd9OvNM3pIe5/6Cqn/sjv4+NjolVza/yrTwQ5FaJmn/yftMFLYYViYhq11MPVRv7vE8rk+JoJlbydTepbQ6AOn0wjILmq+TGA6vkIC5KIGuHHgdBehGsvDWPPfkgzx+YCCaOKyfdtVfeTTHUkOZ8emhvg9QZ0mhLc2L5P64cIAg0RRodhU/q2zom9tE8u3F0Mbx+Hs/yIIsH3VXrb7h9Ds3wGJHf1B0F1XGZzcwP5X5BLCWhbMaIncU25TqABiviHsDM74T9DVi0pAO4GKBQoNL7F2txQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LPa58CUu2yAFQMqJ7HvMcBgEgOfgquVoUado6aB2xE=;
 b=hCesolSZs8TW2dn3BUMuD8aggGneuC6HfO1YEUMckZeOp1fZ6Xc3+BNZRHo9xodU6JsOO/gjxmYL2DLhV3kEF+J56w96jIN8XzHQxYNe9171Ge9fdtSQAzc1zPhYQ9ldIhOruKp1/hG8XDJiJQT46DEjmp5e03B4aR4mqmAa6aA=
Received: from SN6PR03MB4032.namprd03.prod.outlook.com (52.135.113.74) by
 SN6PR03MB3791.namprd03.prod.outlook.com (52.135.100.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Tue, 28 Jan 2020 21:16:39 +0000
Received: from SN6PR03MB4032.namprd03.prod.outlook.com
 ([fe80::1de8:80b3:fe48:b06]) by SN6PR03MB4032.namprd03.prod.outlook.com
 ([fe80::1de8:80b3:fe48:b06%5]) with mapi id 15.20.2665.026; Tue, 28 Jan 2020
 21:16:39 +0000
From:   "Jones, Michael-A1" <Michael-A1.Jones@analog.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH 2/3] hwmon: (pmbus/ltc2978): Fix PMBus polling of
 MFR_COMMON definitions.
Thread-Topic: [PATCH 2/3] hwmon: (pmbus/ltc2978): Fix PMBus polling of
 MFR_COMMON definitions.
Thread-Index: AQHV1gTot/JzDfvNCUOWfHgeJV02r6gAceYAgAAWS9A=
Date:   Tue, 28 Jan 2020 21:16:39 +0000
Message-ID: <SN6PR03MB40329A1D480256447C4565CDF60A0@SN6PR03MB4032.namprd03.prod.outlook.com>
References: <1580234400-2829-1-git-send-email-michael-a1.jones@analog.com>
 <1580234400-2829-2-git-send-email-michael-a1.jones@analog.com>
 <20200128191306.GA32672@roeck-us.net>
In-Reply-To: <20200128191306.GA32672@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWpvbmVzMlxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTc2ZWZjNThkLTQyMTMtMTFlYS1iYTgzLTQ0MWNhOGUxZjg1MFxhbWUtdGVzdFw3NmVmYzU4ZS00MjEzLTExZWEtYmE4My00NDFjYThlMWY4NTBib2R5LnR4dCIgc3o9IjQ0NDEiIHQ9IjEzMjI0NzE5Nzk3MDQwMTk0MyIgaD0iNjRCNVpQT2NZSHJoNUlzdWs5Mk9Rei8wK3VJPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
x-originating-ip: [65.157.77.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d3cd878a-6419-48e2-d4e5-08d7a4375d4f
x-ms-traffictypediagnostic: SN6PR03MB3791:
x-microsoft-antispam-prvs: <SN6PR03MB3791283DDFE3238064E498E5F60A0@SN6PR03MB3791.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 029651C7A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(366004)(396003)(189003)(199004)(81156014)(81166006)(4326008)(8676002)(186003)(26005)(316002)(52536014)(5660300002)(8936002)(54906003)(86362001)(6916009)(71200400001)(66946007)(33656002)(76116006)(66476007)(6506007)(9686003)(7696005)(478600001)(55016002)(64756008)(66574012)(53546011)(66446008)(66556008)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB3791;H:SN6PR03MB4032.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n3qcR13i4I99M9tZjbldtBHxAJFVTxplDw3+YBfgts8iOSMdGLNROHOI7w5V7z0NcQRpHr6HbwFxN9i45ow4RIp+j1JJLW2Qubm9x8BUv9AAwEbbvLL89rx32B+8IysM4F5/OXNbvkd8tQad0K4s4LtzSzhjdYWcsU0JYEaZlKitKdwLGk9qwEGLIw3JhtAH3nSUuPF5qRmdMNNFOpuOHC+gN40620jzBlxdjbIexyj7sk4e9q+xvFzFzXQIQiEDUgB8GMiWTjTp2Czp4pwhzKhKS15nB5OVTMTXuF1h9o49IAI9Ur8IsWSCCtdews72yUdikZg38fqD7/Uqu5kwqPlXQLft37wxg/MMxtu/BY3/9WRm3kEwqvw8jULLlpmUoD5gelEWeh12Ss6Fyz+/b/NT+sXn2iKclsGfzUJjmEgec/UO0DyDC/1bnf143Avx
x-ms-exchange-antispam-messagedata: UgHNUpK91EJ/7Rbs89hfiI6EykyGTv/DRhQx2YvVfD7z55CQRpXQbMv+J3jB8A3g7klbqBQ7xXsp3jexAbgT+E44PmUvwYyviUowjB+JnG1abJDf0iJNNw+BHz+6MOeyh1Y6c3usvZJUpdv6ALmRNQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3cd878a-6419-48e2-d4e5-08d7a4375d4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2020 21:16:39.0964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kWnNllsrGR02uRxrk8o5JPVye6Rj8npT8UPI6+Z8nvJQvqZzisA9JUssYzIBmM8HYu5j6/+s82FFw9tzUTNEO8pt/QovNjAsU9vViGk6qAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3791
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_08:2020-01-28,2020-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 clxscore=1011 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001280159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guenter,

The decision to not poll PEND was based on some other non-driver code based=
 on /dev/i2c that looked like this:

// Set to 0 for LTC3883 which does not support PEND
#define USE_PEND        1

#define NOT_BUSY        1 << 6
#define NOT_TRANS       1 << 4
#if (USE_PEND)
#define NOT_PENDING     1 << 5
#else
#define NOT_PENDING     0
#endif

My recollection is that came from the datasheet, many years ago.

I talked to the designer, and if the above is correct, it has not been corr=
ect since 2012. The designer was not interested in researching artifacts th=
at far back in history. So we know it has been in the part for at least 8 y=
ears.

There seems to be two choices:

A) Leave it as is
B) Poll the PEND bit and possibly break compatibility on ancient hardware

Generally, unused status bits in this kind are high when reserved or not us=
ed. That is good for polling.

The shipping volume of LTC3888 has always been very low compared to other p=
arts, so exposure is very small, certainly Cisco/Juniper type companies wou=
ld not be effected.

I would feel ok with polling PEND on this part. Let me know your opinion.

On a related matter, bit 4 is asserted low when the output is changing valu=
e. Hwmon cannot cause this because it only performs telemetry.

A user application could change VOUT and cause this to happen. Telemetry wo=
uld reflect the last measured value from a 100ms internal polling loop, whi=
ch may be a before, after, or during value. I have always judged that check=
ing this bit has no value, and it can be problematic. If the part is set to=
 have a very long transition rate, like 5 seconds, this would hang the call=
 for a long time. That seemed bad to me, and is why I did not poll this bit=
.

Mike

-----Original Message-----
From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
Sent: Tuesday, January 28, 2020 12:13 PM
To: Jones, Michael-A1 <Michael-A1.Jones@analog.com>
Cc: linux-hwmon@vger.kernel.org; devicetree@vger.kernel.org; linux-doc@vger=
.kernel.org; linux-kernel@vger.kernel.org; jdelvare@suse.com; robh+dt@kerne=
l.org; corbet@lwn.net
Subject: Re: [PATCH 2/3] hwmon: (pmbus/ltc2978): Fix PMBus polling of MFR_C=
OMMON definitions.

[External]

On Tue, Jan 28, 2020 at 10:59:59AM -0700, Mike Jones wrote:
> Change 21537dc driver PMBus polling of MFR_COMMON from bits 5/4 to=20
> bits 6/5. This fixs a LTC297X family bug where polling always returns=20
> not busy even when the part is busy. This fixes a LTC388X and LTM467X=20
> bug where polling used PEND and NOT_IN_TRANS, and BUSY was not polled,=20
> which can lead to NACKing of commands. LTC388X and LTM467X modules now=20
> poll BUSY and PEND, increasing reliability by eliminating NACKing of=20
> commands.
>=20
> Signed-off-by: Mike Jones <michael-a1.jones@analog.com>

Fixes: e04d1ce9bbb49 ("hwmon: (ltc2978) Add polling for chips requiring it"=
)

> ---
>  drivers/hwmon/pmbus/ltc2978.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hwmon/pmbus/ltc2978.c=20
> b/drivers/hwmon/pmbus/ltc2978.c index f01f488..a91ed01 100644
> --- a/drivers/hwmon/pmbus/ltc2978.c
> +++ b/drivers/hwmon/pmbus/ltc2978.c
> @@ -82,8 +82,8 @@ enum chips { ltc2974, ltc2975, ltc2977, ltc2978,=20
> ltc2980, ltc3880, ltc3882,
> =20
>  #define LTC_POLL_TIMEOUT		100	/* in milli-seconds */
> =20
> -#define LTC_NOT_BUSY			BIT(5)
> -#define LTC_NOT_PENDING			BIT(4)
> +#define LTC_NOT_BUSY			BIT(6)
> +#define LTC_NOT_PENDING			BIT(5)
> =20

In ltc_wait_ready(), we have:

	/*
         * LTC3883 does not support LTC_NOT_PENDING, even though
         * the datasheet claims that it does.
         */
        mask =3D LTC_NOT_BUSY;
        if (data->id !=3D ltc3883)
                mask |=3D LTC_NOT_PENDING;

The semantics of this code is now different: It means that on
LTC3883 only bit 6 is checked; previously, it was bit 5. I agree that the a=
bove change makes sense, but it doesn't seem correct to drop the check for =
bit 5 on LTC3883. Maybe remove the if() above and always check for bit 5 an=
d 6 ? Or should bit 4 be checked on parts other than LTC3883 ?

#define LTC_NOT_TRANSITIONING		BIT(4)
...
        mask =3D LTC_NOT_BUSY | LTC_NOT_PENDING;
        if (data->id !=3D ltc3883)
                mask |=3D LTC_NOT_TRANSITIONING;

Thanks,
Guenter
