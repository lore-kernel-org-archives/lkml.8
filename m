Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD57C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 12:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21931218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 12:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=teoenmingcorp.onmicrosoft.com header.i=@teoenmingcorp.onmicrosoft.com header.b="T1s17Qxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbgBMMi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 07:38:59 -0500
Received: from mail-eopbgr1320082.outbound.protection.outlook.com ([40.107.132.82]:36160
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729511AbgBMMi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 07:38:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuhA6MHE8ojzBNINkjryHPVLryTFrelcrcsadnw7jmZrllY+4hUsQ+n+vzOhJ7c1r5tMXHQPr6LpyjY1vbvMGWX/CJLAiYBxGgWvsQqZ4c2JSQYY9Gz7JjBc3GMPH1jHoTDQh+Uvw3gld2ItkAx9hi8BriMzmMt4IkEb70qR1VMpI8AhWHghSJ6xoM8jUIQe94DAPgl/EZQPNiT+VkX0Ng/sQsON1hxU2bFZkFR3zs308RJgq1mVD6UPyEsZhEfhUKamDi5vLq+zdAKOrTSYKhA3MdriEbKdDuAehYXrWtwDfNl+NkzGahIyjGWHzMSpiQVOtiXXfn+0+9zcRPWgKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbyNlBW5T6428n9rq2kGo4/O+4dlNvrG+9BHgRAb9fw=;
 b=PXEJgjHht6lx0opL13ZoiF//B2f13rL9L9GLCyNUYBcwdUbE5gucAMGONRwz2XCAM71YTiLNZ6Y9dMF1pr1vqwbIh6VH8UeELsRod/eXPu9/lBRPClPBtCT8mqUmoYJTvbabvhupQeKmoruSciplaJr2wgulyja13PBLXBTXYwJmU/9YtXyCDFWth9HmAxgA6z02LUwzCjVEUq2oxsGLgQEpDs5olptSPkyCKhFUh5g5R5eokgfcXY0E0BEthRe7nHMAFEv131xiAkPTACsPUSZs5W/J+R1w0uzrPIPiPJerAbkqTAoJ2XEQK9SuIY6KAllhKzgKQMrVF1p/j9USVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teo-en-ming-corp.com; dmarc=pass action=none
 header.from=teo-en-ming-corp.com; dkim=pass header.d=teo-en-ming-corp.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector2-teoenmingcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbyNlBW5T6428n9rq2kGo4/O+4dlNvrG+9BHgRAb9fw=;
 b=T1s17Qxt+0FtiClWM5054fYnxYKtSc+EKNT97h5zVZ4gWjZWfMvsoL1vk+SDHKJkGeTPD8O/IJk0d0tvPOcLQ4XvuBTCm7gJ3KAU+pw65SBPUGvpJevk31thqybzbcJNaHfzzzDDL7egqbfuCT3GYv1i6ZbtK5x1+ZRWcKtR6fk=
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com (10.170.143.19) by
 SG2PR01MB2540.apcprd01.prod.exchangelabs.com (20.177.82.81) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Thu, 13 Feb 2020 12:38:52 +0000
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::684a:9e0b:7e12:18bd]) by SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::684a:9e0b:7e12:18bd%4]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 12:38:52 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: Teo En Ming's Installing CentOS 8.1 (1911) Linux Server as a QEMU/KVM
 Virtual Machine PDF Manual
Thread-Topic: Teo En Ming's Installing CentOS 8.1 (1911) Linux Server as a
 QEMU/KVM Virtual Machine PDF Manual
Thread-Index: AQHV4mpvsI15a7mb+0aH+Eh9yh4loQ==
Date:   Thu, 13 Feb 2020 12:38:52 +0000
Message-ID: <SG2PR01MB214164F5EE01D2077EC36053871A0@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [2401:7400:c802:de67:6503:9d8e:7d15:6d28]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df0fbaeb-1de1-482b-d43f-08d7b081aea6
x-ms-traffictypediagnostic: SG2PR01MB2540:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SG2PR01MB2540553ED360DC5296E6CE09871A0@SG2PR01MB2540.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39830400003)(376002)(366004)(396003)(136003)(199004)(189003)(33656002)(2906002)(9686003)(8936002)(64756008)(76116006)(66446008)(66556008)(66946007)(55016002)(86362001)(66476007)(508600001)(7696005)(5660300002)(81156014)(71200400001)(6916009)(52536014)(8676002)(81166006)(966005)(6506007)(107886003)(186003)(4326008)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR01MB2540;H:SG2PR01MB2141.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KKq7C//dTRforERbSAEGaxkaqKZQBV9YeItz6ZhNMcY9Vyx59XH7mYzyCi0lftD09y/kNDn3oI0hOG8jsYvMO6oafFfscVk2oqjxJB9jHLf5qpvQf6ou0aNkZyYxm/G4QsfvjHMb4rcDGguAe/nJbzW3mZRMZDGxQp+3fTD1g5FEwRKnf99NXHDh/40qcMady5Gz3/jlP4CC0XmFCds159mFtWfCz02uB36FjWmdjFepW+nvCrDQWgR2Syxtbh8MWyPCbPGRqdGnybZBtsw48IjE81ZVPDHJWR8SGo3EOU/1LjLMMVp09vLqXsZ6wqQ6c6aFWvOwlzIY8x4uWI9QpaiHfPH4fIB0ekr6YSbzq5SH3PiegJxtFlpAy0x9Y/xtROUkGykdpLg+3Xoxvv6z+tujkey8nMbXjoA6C9JvM906cXbC35L9aCdm7mQefp35tf0tV/p9fb0VKziBP8PkHRFAlixIlec0onaPlCshJiw50h9d8ROz32CQeG5Kx0YS69RnzYzE7/e1guQdHiQ5eQ==
x-ms-exchange-antispam-messagedata: t5je9QmsqzUzqfU3P59icZJTC4kRJNEHHzPXlFdAqioG+jeFwNR5z6f/E9T5YkWox/mONFFL1FrwCZiuLckyTczkTggUGf32Prsu8ni/kKpxN8mdvqZ2MpFbkEQqLHJP69kANzqU3YOLuquhSRnFi2yx9xBi0fKOcoLnBk8H94PCX0EfhDZrz3Yr9UhaiVVfllh0PklvNUxISnCTF6gwww==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df0fbaeb-1de1-482b-d43f-08d7b081aea6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 12:38:52.0734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gPVoey5X3CtjbeHdAHPrpulBD80fwvEVxP6w2FM+ayEa3+aBxanubrspHtSJUVND+NJDuoOIa/Bx1hGbUEkLgQLA66BmUmSYmQ8/aCpBx0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB2540
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Teo En Ming's Installing CentOS 8.1 (1911) Linux Server as a QEMU/=
KVM Virtual Machine PDF Manual=0A=
=0A=
Redundant Google Drive download links for my PDF manual:=0A=
=0A=
[1] https://drive.google.com/open?id=3D1BdV3qAjsshiVJoDEhZMQBxAXk2yXzDyY=0A=
=0A=
[2] https://drive.google.com/open?id=3D1mHncd2Ngp1MpQ3T3-zPOweXK5vMeMtJJ=0A=
=0A=
[3] https://drive.google.com/open?id=3D1bsS0F0TkLsrrHTT87jVNHmXJi2AmjLJb=0A=
=0A=
[4] https://drive.google.com/open?id=3D1QzVEDAJUzIkGbb6_XIPYGVKI7n4skeRc=0A=
=0A=
For future updates, please refer to my redundant RAID 1 mirroring Blogger a=
nd Wordpress blogs.=0A=
=0A=
https://tdtemcerts.blogspot.sg=0A=
=0A=
https://tdtemcerts.wordpress.com=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
-----BEGIN EMAIL SIGNATURE-----=0A=
=0A=
The Gospel for all Targeted Individuals (TIs):=0A=
=0A=
[The New York Times] Microwave Weapons Are Prime Suspect in Ills of=0A=
U.S. Embassy Workers=0A=
=0A=
Link: https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwav=
e.html=0A=
=0A=
***************************************************************************=
*****************=0A=
=0A=
=0A=
=0A=
Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic=0A=
Qualifications as at 14 Feb 2019 and refugee seeking attempts at the United=
 Nations Refugee Agency Bangkok (21 Mar 2017), in Taiwan (5 Aug 2019) and A=
ustralia (25 Dec 2019 to 9 Jan 2020):=0A=
=0A=
=0A=
[1] https://tdtemcerts.wordpress.com/=0A=
=0A=
[2] https://tdtemcerts.blogspot.sg/=0A=
=0A=
[3] https://www.scribd.com/user/270125049/Teo-En-Ming=0A=
=0A=
-----END EMAIL SIGNATURE-----=0A=
=0A=
=0A=
=0A=
