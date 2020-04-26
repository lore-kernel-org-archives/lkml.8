Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55441C54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 16:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2416620728
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 16:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="n1KhqnOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgDZQB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 12:01:26 -0400
Received: from mail-bn7nam10on2082.outbound.protection.outlook.com ([40.107.92.82]:44251
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725778AbgDZQBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 12:01:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZmFWxuLG+IDx60utWTxDUv5HRC4L1MirQ33yN5F0tGBKfYXUu32nT0qfNp/6SbvUqEgXogYFJrC2JiwcyC2XBLR/4j+OW/uQPP31GjStvmhFOoZFQaqO0FbW3158a5GwiJIs76EF10c480lrGeBor/wV28nOXMjEyDu8Zs9yNM5pJEoCqXLi3Go1UlqzE6QQTieCBFhhZ+Ynn4jeXK684o410FkCaxwQnPpwNDL+SkN7TlYEejVTgYUK5ec2slzX/XUOlI8Bfz83QSBQbDI84W2RmmdPliZEkib5HOOr/vlZFWR5kL+5sptTzJynjZ0aw3gnss5hO9Enwu1gyZd5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrCnNmadv5mOJ26I51Yq7r6fHXL71+9mnnOzlkYKa/M=;
 b=XfXvVwkUtO4mSIH5agaNBr8xqOUOChOyYBm2Pp6KUogkGTtMJVKR2inEHN/yOqfWOFAsWQoormULcu1EUyOnzkZp7friig0QeJEPqCczShwhGs6XpZG16CtiQEtZd+gk4wHcF/xBUiqPbq/qYoyw9PbWrOZBoKBIWr7fXmHThPhs7EwSBLXe6FWrAFvBd1eQCXPtCYZlVwDKyAE9TlWSxY+p69EgLRo6mClO/jRekvTHZ5XBKbn0tVfteOC+eislR8E9GdKe0EJBhBHpkPjGrk+t8JSPtDNv7k6Hha/HKTfnYC/vBlwErRoag4OFcQ1NRC7AfClgg8Z7Mkg62He/mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrCnNmadv5mOJ26I51Yq7r6fHXL71+9mnnOzlkYKa/M=;
 b=n1KhqnOEPvmk/2gIxtcqCDQQV143ksn++UGv7KcZs2o7/gGLVC1s13yYeD1Q+eCQNhrZ7TGvryQLDWm7BudC+70aIq6t+OlyW+vx4APKZ7hzOdBAaQsJGi2DiWQLFkLmaPXJKX3XwEJkPrSAPCyEzukhp0fOv5qodDw2xN8+/K4=
Received: from DM6PR02MB4140.namprd02.prod.outlook.com (2603:10b6:5:97::21) by
 DM6PR02MB4347.namprd02.prod.outlook.com (2603:10b6:5:2a::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.22; Sun, 26 Apr 2020 16:01:22 +0000
Received: from DM6PR02MB4140.namprd02.prod.outlook.com
 ([fe80::352d:3b22:4eec:d6a5]) by DM6PR02MB4140.namprd02.prod.outlook.com
 ([fe80::352d:3b22:4eec:d6a5%5]) with mapi id 15.20.2937.020; Sun, 26 Apr 2020
 16:01:22 +0000
From:   Dragan Cvetic <draganc@xilinx.com>
To:     Zou Wei <zou_wei@huawei.com>, Derek Kiernan <dkiernan@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Michal Simek <michals@xilinx.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next] misc: xilinx_sdfec: Use memdup_user() as a cleanup
Thread-Topic: [PATCH -next] misc: xilinx_sdfec: Use memdup_user() as a cleanup
Thread-Index: AQHWGFEaoCOIEPhBB0yaxHj1VopCrqiLjvgg
Date:   Sun, 26 Apr 2020 16:01:22 +0000
Message-ID: <DM6PR02MB4140944FA4196DB021A7E276CBAE0@DM6PR02MB4140.namprd02.prod.outlook.com>
References: <1587524330-119776-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1587524330-119776-1-git-send-email-zou_wei@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=draganc@xilinx.com; 
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bcfe80d5-d60f-4769-4d52-08d7e9fb111b
x-ms-traffictypediagnostic: DM6PR02MB4347:|DM6PR02MB4347:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR02MB4347D075B15834A2FFDA4EB3CBAE0@DM6PR02MB4347.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 03853D523D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB4140.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(39850400004)(396003)(376002)(366004)(26005)(8676002)(8936002)(6506007)(2906002)(81156014)(7696005)(53546011)(316002)(186003)(66446008)(66556008)(110136005)(66946007)(54906003)(33656002)(4326008)(5660300002)(71200400001)(76116006)(86362001)(52536014)(9686003)(478600001)(66476007)(55016002)(64756008)(6636002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JpM9UOdItSZu72jD3k+MC1ZeEJQOJ1JQV5dOlEhHky5qeHtZ2i+lg8ZePaf+cDk2OeRwihTdRb3zGNNQ45R5rtK43nJowOSrbk6TE8tPX1jwRdRRD8Yu/TnLG2cBuj8xJ5cX0KWFxBkxtqHJ8wRTGhwXvVqA8HjB2/hu6B4Au9bY1V10g0LS588LiaTRZE6fSq45Y+hquJZI+JncqQ9OxVSCHtWG2Wf3zZpxsIzA7+T5eHy6wI9xMQDj+3hAqhaVfTKo9i4hyqMUOG7MRJzzpMidKvc/3iyN+e8isS7ardpbXTR0nQBnaqiHmO9ljYHwFTW2vrFkBD2pK1y56h1xiADDU6S/ZKwK6x6nZwPNgqFtPQjjviYKdQPwsgvOTRbOPdqUsZBNZOu3g2hsxRP8TjLEhmQRxRF0ga0WnAO4Wb8B1A58QeIuPFoQxaU2VIEb
x-ms-exchange-antispam-messagedata: Qu6WRY+zcD9H7hwhxkLWR2p3Mzw+2GWqIbtymphIYp1GBgG0zEjJ4jWsbZ39fBmXvE/nbB0Q1bEsid8qBrhosENiB1qE/c8e/0rGjbYqtxeWc832Xy+2NI1LxyIccvQ5u0RRoDLdBBEy1/HuktYeqr/BV4I/SJPAz08NgqmcpjsXp7Wxrmb5izxLvGuSRW7rzhLBMYPIcszRf7NfZOfQZX3R9lZrpdQAOY4tq+1qiRyA3vK7cm0HG6SC36FVjf46cXf2C9XLOeXLv6sney7WfSZMPZHZv28YjCkyzqBEkI1Ejv7UtxGOnAl3wnLthZQJUMqu3wwC3qncjjACbujmGlfJHcdvZKlngT6RoQ3RKH4UGss4cFat5c5tN/ZZnATswKzujOCnjQdd2YMvvfTxroPINPudmpoaAZQ7ifToReTLCSZXArjoSUK3QnK5Q3Z52vMazgHrvrE971PiPtKnJSoSXrQFCRoVvGDgRPitBbiSpL2FrcnC6mJux7wrKNXCyn1/UqQozB2D1Eg9iSb1CzavO//nIcQ0VgnVGWoATs59/Ik+X90H8r2/6OWKo/NP/XjefGiWyqexXJWjs1uk6dRUYON5nYUHP90QBLxO3wvz1AwKwjF6M0noqGA16G75cvvUuRjKNcjLsn6Vq+/9hlNtZXi9T8fdqoyeKj9nXdnE7T50bWUQ3YDNvn1LQI5VUPJHdh4GZnidfOsz16u27U/AYSCiHnJhQH7WVm+cypYS8zUYqM+iYwqOJ/+oJn4Nm/yEfgFynxVkT/6yOWtfobw0GPZjSDW4E688FpX5R6M=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcfe80d5-d60f-4769-4d52-08d7e9fb111b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2020 16:01:22.8619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ohqsbWZc3ENUu7iW4E07uhoFiCyGmoIX6+EiN6wDYntIG6FK88uPMLeuQ4Mm2qWWkOrZaEP/kEGoLMRDTDICFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4347
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zou,

Thanks for fixing the warning.

> -----Original Message-----
> From: Zou Wei <zou_wei@huawei.com>
> Sent: Wednesday 22 April 2020 03:59
> To: Derek Kiernan <dkiernan@xilinx.com>; Dragan Cvetic <draganc@xilinx.co=
m>; arnd@arndb.de; gregkh@linuxfoundation.org;
> Michal Simek <michals@xilinx.com>
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Z=
ou Wei <zou_wei@huawei.com>
> Subject: [PATCH -next] misc: xilinx_sdfec: Use memdup_user() as a cleanup
>=20
> Fix coccicheck warning which recommends to use memdup_user().
>=20
> This patch fixes the following coccicheck warnings:
>=20
> drivers/misc/xilinx_sdfec.c:652:8-15: WARNING opportunity for memdup_user
>=20
> Fixes: 20ec628e8007 ("misc: xilinx_sdfec: Add ability to configure LDPC")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/misc/xilinx_sdfec.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
> index 71bbaa5..7a75894 100644
> --- a/drivers/misc/xilinx_sdfec.c
> +++ b/drivers/misc/xilinx_sdfec.c
> @@ -649,14 +649,9 @@ static int xsdfec_add_ldpc(struct xsdfec_dev *xsdfec=
, void __user *arg)
>  	struct xsdfec_ldpc_params *ldpc;
>  	int ret, n;
>=20
> -	ldpc =3D kzalloc(sizeof(*ldpc), GFP_KERNEL);
> -	if (!ldpc)
> -		return -ENOMEM;
> -
> -	if (copy_from_user(ldpc, arg, sizeof(*ldpc))) {
> -		ret =3D -EFAULT;
> -		goto err_out;
> -	}
> +	ldpc =3D memdup_user(arg, sizeof(*ldpc));
> +	if (IS_ERR(ldpc))
> +		return PTR_ERR(ldpc);
>=20
>  	if (xsdfec->config.code =3D=3D XSDFEC_TURBO_CODE) {
>  		ret =3D -EIO;
> --
> 2.6.2

Acked-by: Dragan Cvetic <dragan.cvetic@xilinx.com>


Regards
Dragan
