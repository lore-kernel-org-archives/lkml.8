Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC3DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 21:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CCF2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 21:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="p2jX4ak2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgA1VgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 16:36:17 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:54864 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726211AbgA1VgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 16:36:17 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00SLZ7kV030238;
        Tue, 28 Jan 2020 16:35:52 -0500
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by mx0b-00128a01.pphosted.com with ESMTP id 2xs6a5g17s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jan 2020 16:35:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCtQ7WokKp1PFUBvEtd8wWtXpy1yXfGhuIV9gVxBTsgOFAl0i0FFacdbqrs7CWy3M158Xq+3XzDsOX0gVB+I0Bkm5qJAp8pd4KaJgvpsztj9YRWGka/oau/YV8no0TcmEJAgpJ8DaINVbBIy+5Hx4iBT9vm09zr4bg7K6ypjmRkVW8cs8laPMvyzymjB9xFKIKucF3FL0qBqcI+zxYBuu0zlm9oVtUir2X7sHePDcngFsN6LWLsCcnE1NQigYUF4x8td3d/8nVTKo9NFFFXnlw4O41KSLjKJU5TcB5nkg5z/P1eWuZoPd510OjJlM/Xhf0nWYyUqII1aoUX/0EM1Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkCy8jlaeTJjIVRuBqRYp/LQGyQiJqLPmC6m9MmOziQ=;
 b=lGM1FVPeyd76j9HeAmVouIInanqqJBc9lfCSLnIxXfLxOlIeBGi5UdNdfubvQGFP/Bjautke3eSQNH62+QMmdib9Qufcrsb6cl6HliUKQH9DPx6wiDjk0UX3cf+YzBPreU7I5cBeAjZZnVZlTqd7VkeIxAUviLnm9CTsstHJC79bgOplmuhT3pAMQnWI38Nv+X8jhzjvHhdHKj42IAtWPLsrKq4Qj4F+ILDRgI/E/AO8r4NqHjNrVE81F5WbPC1H7f0wftBVUT+hPv9u8x7sS9oQpssXyZj5FXEHjncD/Q9E3rkhj1eENvjihFRPBpJfcfH2UwxdfdGAvZxLaacMWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkCy8jlaeTJjIVRuBqRYp/LQGyQiJqLPmC6m9MmOziQ=;
 b=p2jX4ak2C/lUgcBtr/PRYgSI5SehxYk6mwnRt+/sNthIHRr7MZr0Jk6fHfTjfGFyhNmoHacWu+Uod2fWhTKPXBePjSvawDMwEHNmrpyF2nrkAslbHI9BNuRgnVTMf514f6WK2rDYRQctvhDfs5YtS/zhVC/ArNRJSMjC0v95388=
Received: from SN6PR03MB4032.namprd03.prod.outlook.com (52.135.113.74) by
 SN6PR03MB3584.namprd03.prod.outlook.com (52.135.80.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Tue, 28 Jan 2020 21:35:50 +0000
Received: from SN6PR03MB4032.namprd03.prod.outlook.com
 ([fe80::1de8:80b3:fe48:b06]) by SN6PR03MB4032.namprd03.prod.outlook.com
 ([fe80::1de8:80b3:fe48:b06%5]) with mapi id 15.20.2665.026; Tue, 28 Jan 2020
 21:35:50 +0000
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
Thread-Index: AQHV1gTot/JzDfvNCUOWfHgeJV02r6gAceYAgAAWS9CAABBEAIAAAGXw
Date:   Tue, 28 Jan 2020 21:35:49 +0000
Message-ID: <SN6PR03MB403294C0615C0FE2DF49F7DDF60A0@SN6PR03MB4032.namprd03.prod.outlook.com>
References: <1580234400-2829-1-git-send-email-michael-a1.jones@analog.com>
 <1580234400-2829-2-git-send-email-michael-a1.jones@analog.com>
 <20200128191306.GA32672@roeck-us.net>
 <SN6PR03MB40329A1D480256447C4565CDF60A0@SN6PR03MB4032.namprd03.prod.outlook.com>
 <20200128213106.GA30571@roeck-us.net>
In-Reply-To: <20200128213106.GA30571@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWpvbmVzMlxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTI1NmUwZWE2LTQyMTYtMTFlYS1iYTgzLTQ0MWNhOGUxZjg1MFxhbWUtdGVzdFwyNTZlMGVhOC00MjE2LTExZWEtYmE4My00NDFjYThlMWY4NTBib2R5LnR4dCIgc3o9IjU5MjciIHQ9IjEzMjI0NzIwOTQ4NDcyNDYzOSIgaD0iWFc0RnhhdWlFOWZpMWlUOGp5R0JmNEUyTjlFPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
x-originating-ip: [65.157.77.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6da93141-7052-49fd-6ae8-08d7a43a0b62
x-ms-traffictypediagnostic: SN6PR03MB3584:
x-microsoft-antispam-prvs: <SN6PR03MB35848D3E4786DBCF636DF835F60A0@SN6PR03MB3584.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 029651C7A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(52536014)(316002)(26005)(66556008)(66476007)(66446008)(2906002)(478600001)(86362001)(64756008)(7696005)(76116006)(66946007)(4326008)(33656002)(54906003)(55016002)(6506007)(53546011)(5660300002)(8936002)(66574012)(6916009)(81166006)(81156014)(71200400001)(8676002)(186003)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB3584;H:SN6PR03MB4032.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HEssD9KznX0t0lm4Nm7draM76cMCKqotBLS6gQK387R0oYySkB+ie23EbotNvAYdVXOLReZvhZ37nScC4R4J/Dvc7W+ikMCs5w0MkLU2/frO+D3QVYzqiD5+lPF253FaNZFiV3UlO99eQWFpi58xinEuoErXVw5MpgsFW52WLqmB9bd4FxoCLGl/gJGoOGy92/YAWtyJtxH7H/LZdCLJ1LUPMEAVODny3PtWewmQuL8uMh8yRb9yRee72TUexDWWM/UfGLfLc0RhckGTDfRYCVw+VlfFHMw+7BLZYUHxIUjvCF0ez0bsANJlu3+D+qbxSfCWLdR96KNii5qpDu0lX37/Kp8GTbsP2jAFM8YCtXDzt6bf/D6Z8G5yoqxQqGrsSCZ3G04Q+mLPShSZpwPL3xkSdV+FdO5te4N5JtU6dafoaax3Ib4Q18sS1wm0HKBq
x-ms-exchange-antispam-messagedata: Wd8kAebvOYilCo4IANOHnbbQ20d9ujGj0jmkZqz4h6E+kcFiyFExkpsunPLjv9FbjpiIQXqVH73Rf4SMBonKPD8DWLIOCYKC4GJXmBTV4GhV2uAJh+Dq+ivpFy0phb+DHVCu3UzOpKCpAhekqLod5A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da93141-7052-49fd-6ae8-08d7a43a0b62
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2020 21:35:50.0423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GELu2GiCZaNs6OljJ97u8QBrJEEmIxYUKADQHXPwzA/P04TqYUJ1rbIhsCAXVoDEEyI7NGjG72+Bt+wICFJB2aruVSd8IWUWWBBn5ixhkzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3584
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_08:2020-01-28,2020-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1911200001
 definitions=main-2001280161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guentar,

Yes, LTC3883. Slip of the finger.

I am happy as is. If LTC3883 starts selling like hotcakes, I'll update it l=
ater.

This is my first attempt at doing things the linux way, so if you see somet=
hing I should do different, let me know. I left off Tested-by, assuming tha=
t Signed-off-by was good enough. But I do test the changes using a DLN-2 an=
d demo boards.

Mike

-----Original Message-----
From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
Sent: Tuesday, January 28, 2020 2:31 PM
To: Jones, Michael-A1 <Michael-A1.Jones@analog.com>
Cc: linux-hwmon@vger.kernel.org; devicetree@vger.kernel.org; linux-doc@vger=
.kernel.org; linux-kernel@vger.kernel.org; jdelvare@suse.com; robh+dt@kerne=
l.org; corbet@lwn.net
Subject: Re: [PATCH 2/3] hwmon: (pmbus/ltc2978): Fix PMBus polling of MFR_C=
OMMON definitions.

[External]

On Tue, Jan 28, 2020 at 09:16:39PM +0000, Jones, Michael-A1 wrote:
> Guenter,
>=20
> The decision to not poll PEND was based on some other non-driver code bas=
ed on /dev/i2c that looked like this:
>=20
> // Set to 0 for LTC3883 which does not support PEND
> #define USE_PEND        1
>=20
> #define NOT_BUSY        1 << 6
> #define NOT_TRANS       1 << 4
> #if (USE_PEND)
> #define NOT_PENDING     1 << 5
> #else
> #define NOT_PENDING     0
> #endif
>=20
> My recollection is that came from the datasheet, many years ago.
>=20
> I talked to the designer, and if the above is correct, it has not been co=
rrect since 2012. The designer was not interested in researching artifacts =
that far back in history. So we know it has been in the part for at least 8=
 years.
>=20
> There seems to be two choices:
>=20
> A) Leave it as is
> B) Poll the PEND bit and possibly break compatibility on ancient=20
> hardware
>=20
> Generally, unused status bits in this kind are high when reserved or not =
used. That is good for polling.
>=20
> The shipping volume of LTC3888 has always been very low compared to other=
 parts, so exposure is very small, certainly Cisco/Juniper type companies w=
ould not be effected.
>=20
I assume you mean LTC3883, not LTC3888.

> I would feel ok with polling PEND on this part. Let me know your opinion.
>=20
> On a related matter, bit 4 is asserted low when the output is changing va=
lue. Hwmon cannot cause this because it only performs telemetry.
>=20
> A user application could change VOUT and cause this to happen. Telemetry =
would reflect the last measured value from a 100ms internal polling loop, w=
hich may be a before, after, or during value. I have always judged that che=
cking this bit has no value, and it can be problematic. If the part is set =
to have a very long transition rate, like 5 seconds, this would hang the ca=
ll for a long time. That seemed bad to me, and is why I did not poll this b=
it.
>=20

Your call, really. My major concern was that bit 5 is no longer polled on L=
TC3883. From the above, it looks like it actually _is_ the pending bit (5) =
that isn't supported on LTC3883. With that in mind, I'll apply the series a=
s-is and add the Fixes: tag myself; no need to resend.

Thanks,
Guenter

> Mike
>=20
> -----Original Message-----
> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> Sent: Tuesday, January 28, 2020 12:13 PM
> To: Jones, Michael-A1 <Michael-A1.Jones@analog.com>
> Cc: linux-hwmon@vger.kernel.org; devicetree@vger.kernel.org;=20
> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;=20
> jdelvare@suse.com; robh+dt@kernel.org; corbet@lwn.net
> Subject: Re: [PATCH 2/3] hwmon: (pmbus/ltc2978): Fix PMBus polling of MFR=
_COMMON definitions.
>=20
> [External]
>=20
> On Tue, Jan 28, 2020 at 10:59:59AM -0700, Mike Jones wrote:
> > Change 21537dc driver PMBus polling of MFR_COMMON from bits 5/4 to=20
> > bits 6/5. This fixs a LTC297X family bug where polling always=20
> > returns not busy even when the part is busy. This fixes a LTC388X=20
> > and LTM467X bug where polling used PEND and NOT_IN_TRANS, and BUSY=20
> > was not polled, which can lead to NACKing of commands. LTC388X and=20
> > LTM467X modules now poll BUSY and PEND, increasing reliability by=20
> > eliminating NACKing of commands.
> >=20
> > Signed-off-by: Mike Jones <michael-a1.jones@analog.com>
>=20
> Fixes: e04d1ce9bbb49 ("hwmon: (ltc2978) Add polling for chips=20
> requiring it")
>=20
> > ---
> >  drivers/hwmon/pmbus/ltc2978.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/hwmon/pmbus/ltc2978.c=20
> > b/drivers/hwmon/pmbus/ltc2978.c index f01f488..a91ed01 100644
> > --- a/drivers/hwmon/pmbus/ltc2978.c
> > +++ b/drivers/hwmon/pmbus/ltc2978.c
> > @@ -82,8 +82,8 @@ enum chips { ltc2974, ltc2975, ltc2977, ltc2978,=20
> > ltc2980, ltc3880, ltc3882,
> > =20
> >  #define LTC_POLL_TIMEOUT		100	/* in milli-seconds */
> > =20
> > -#define LTC_NOT_BUSY			BIT(5)
> > -#define LTC_NOT_PENDING			BIT(4)
> > +#define LTC_NOT_BUSY			BIT(6)
> > +#define LTC_NOT_PENDING			BIT(5)
> > =20
>=20
> In ltc_wait_ready(), we have:
>=20
> 	/*
>          * LTC3883 does not support LTC_NOT_PENDING, even though
>          * the datasheet claims that it does.
>          */
>         mask =3D LTC_NOT_BUSY;
>         if (data->id !=3D ltc3883)
>                 mask |=3D LTC_NOT_PENDING;
>=20
> The semantics of this code is now different: It means that on
> LTC3883 only bit 6 is checked; previously, it was bit 5. I agree that the=
 above change makes sense, but it doesn't seem correct to drop the check fo=
r bit 5 on LTC3883. Maybe remove the if() above and always check for bit 5 =
and 6 ? Or should bit 4 be checked on parts other than LTC3883 ?
>=20
> #define LTC_NOT_TRANSITIONING		BIT(4)
> ...
>         mask =3D LTC_NOT_BUSY | LTC_NOT_PENDING;
>         if (data->id !=3D ltc3883)
>                 mask |=3D LTC_NOT_TRANSITIONING;
>=20
> Thanks,
> Guenter
