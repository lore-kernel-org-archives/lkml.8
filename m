Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475ABC3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F074206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=displaylink.com header.i=@displaylink.com header.b="GebJhXRc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbgBLJlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:41:19 -0500
Received: from eu-smtp-delivery-167.mimecast.com ([146.101.78.167]:40063 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728637AbgBLJlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:41:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=displaylink.com;
        s=mimecast20151025; t=1581500476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lGeigVNnGWMBXy8P20zvl70+k5sKMFZiRKH515sNoU4=;
        b=GebJhXRcf2/k3XWFHpK+qHuCG2YTKiNCtSchhYO8kH1csDR8a/+xEm16YN/kTgdGbeMq7S
        3EgN8TTKgQRceL+4Re/yVHPt5Y7lUVrEpG/NdZL4TR3Eeqbso5fVNilMSU+l8tZ2UnTsoR
        fOxYSIaIT6APzrOi/JPr8zXhMaPEYUk=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2106.outbound.protection.outlook.com [104.47.18.106])
 (Using TLS) by relay.mimecast.com with ESMTP id
 uk-mtapsc-1-zKyXQSwOMGWfzuatvbC_1Q-1; Wed, 12 Feb 2020 09:41:15 +0000
Received: from VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM (52.134.27.157) by
 VI1PR10MB3328.EURPRD10.PROD.OUTLOOK.COM (52.133.246.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Wed, 12 Feb 2020 09:41:12 +0000
Received: from VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7cc2:599e:25ce:49b2]) by VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7cc2:599e:25ce:49b2%6]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 09:41:12 +0000
Received: from [172.17.183.132] (80.93.235.40) by AM0PR06CA0058.eurprd06.prod.outlook.com (2603:10a6:208:aa::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.23 via Frontend Transport; Wed, 12 Feb 2020 09:41:11 +0000
From:   Vladimir Stankovic <vladimir.stankovic@displaylink.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Petar Kovacevic <petar.kovacevic@displaylink.com>,
        Stefan Lugonjic <stefan.lugonjic@displaylink.com>,
        Nikola Simic <nikola.simic@displaylink.com>,
        Marko Miljkovic <marko.miljkovic@displaylink.com>
Subject: Re: [External] Re: [PATCH 1/1] usb: Add MA USB Host driver
Thread-Topic: [External] Re: [PATCH 1/1] usb: Add MA USB Host driver
Thread-Index: AQHV4OzJT2OJQ4szCkS0GbDThotPEqgWLLMAgAAFAACAAR2DgA==
Date:   Wed, 12 Feb 2020 09:41:12 +0000
Message-ID: <742e4af7-ad70-6607-62b0-81d11cd5b04e@displaylink.com>
References: <VI1PR10MB1965B4B61D7A9808B2EA095591180@VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM>
 <61e63056-31f9-9d4b-60c1-8cbf0372d34f@displaylink.com>
 <20200211163906.GA1931506@kroah.com>
In-Reply-To: <20200211163906.GA1931506@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR06CA0058.eurprd06.prod.outlook.com
 (2603:10a6:208:aa::35) To VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:37::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [80.93.235.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68acc2fc-0cfa-4d4a-e342-08d7af9fb224
x-ms-traffictypediagnostic: VI1PR10MB3328:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR10MB3328F90ACCD50FEB773FDFBB911B0@VI1PR10MB3328.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(366004)(39840400004)(396003)(136003)(199004)(189003)(31686004)(4326008)(107886003)(81156014)(71200400001)(36756003)(16526019)(4744005)(186003)(26005)(81166006)(31696002)(44832011)(54906003)(16576012)(8936002)(6916009)(316002)(6486002)(2616005)(956004)(86362001)(5660300002)(66476007)(66556008)(52116002)(64756008)(2906002)(478600001)(8676002)(66446008)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB3328;H:VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ou16pmzcPLht/28jP65Ou1XvYQTn8b9KUDXHzHIFr+VuSNeSOMViL1DtwejM4LMX+RRd8KFYUmy4Qfjdm15htFnlNShCpM5a/Cm7p2AncSlZ56yjheqGuacCQ/RyyBuj7NwY+Sjt5E9FoHBpoTAI2gyrmns3WwJG2r3YMZhgLzzLq3QT5+j/lKFt+Bw3t2O5U4Ds4Qqw734xVlMk42y8/XkECbkfXXVI66YCmroFYtS08xk35d2KyjjLkQ40zDeNIdbIewU8XUquWGGc45hKWE/kKV9bWLtm4Tekjt2rHPr1UfXGOc1TVDur3SXJUx2kigDuJ4kRB4738zQpOT8Sd1wZDWZ3kjM8r+9gpiWWy2OsPbMxaYPg51WVJ/WAe58mAQmwNy2lIY6l2Ft+HwtmMDYL3jCv/QGU/RTXYTmGvefINYYKjvCU0FljMwktZ9QD
x-ms-exchange-antispam-messagedata: W8NdWN1SpZZPqbUpLckUd064u0UnCmZkklIf6Pkc0r3h3zMTe0wMGfoRWxfzdn/Mt5RnuLgl4sMjt0nBDHxjFZ0UhC0m8tBoEW5GGm2tt0QtxwJkxS6vuPZ2YhP3ub/WpPWRsXW/4vC0OQYqX9btvw==
Content-ID: <8DC8B3362D77D040A48FBE57CF64F311@EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68acc2fc-0cfa-4d4a-e342-08d7af9fb224
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 09:41:12.1606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gYHROD7IomBwiVgqdjH+4cJI1mD/3Ox3lzYT2qsaDYwPiC+L6Ef3iYNGsqkJLOAUJnsHIDE/syhzbWrb0tthg7MDlHem6SrS0Em7qUw+6WpgOqkjCHl6+arW8jDyDxQ+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3328
X-MC-Unique: zKyXQSwOMGWfzuatvbC_1Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: displaylink.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.2.20. 17:39, gregkh@linuxfoundation.org wrote:
> On Tue, Feb 11, 2020 at 04:21:24PM +0000, Vladimir Stankovic wrote:
>>    39 files changed, 8668 insertions(+)
>=20
> This is a bit hard, if not impossible, to review all in one huge patch.
>=20
> Can you resend this as a patch series, breaking it down into logical
> chunks, like all other kernel patches have?
>=20
> Also, why so many individual files?  For only 8k lines, 39 files seems
> like a huge number.
>=20
> thanks,
>=20
> greg k-h
>=20
Will break it down into patch series and resend.

In regards of the file count, our intention was to ease the=20
troubleshooting efforts during development and have a clear separation=20
between logical parts of MA-USB implementation (i.e data in/out, isoch=20
in/out, etc.; each source file representing logical chunk).

Regards,
Vladimir.

