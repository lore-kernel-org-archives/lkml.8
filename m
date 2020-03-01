Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC485C3F2CE
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 09:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609C521775
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 09:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=teoenmingcorp.onmicrosoft.com header.i=@teoenmingcorp.onmicrosoft.com header.b="YmDvZn1y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbgCAJPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 04:15:05 -0500
Received: from mail-eopbgr1300058.outbound.protection.outlook.com ([40.107.130.58]:29504
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbgCAJPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 04:15:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHLtUM65WexPmaPuwR3/HfsSLNne4o5oXZhv3e3Z9oF/GYUFTRvNGctN3S5UFEgdTksqDoIt3siUtkHExCmdSl7WcwsH/uml2CT5NbLOFlN5q/lQCwohUFu+MPBqsXOnhEI/38Ykl4ayLuQH0RVR5uJnpRibCsLSDMrTu5zo/kbr85nALKcrzwiooKX+EJkni80+yyYT75EMcEf2G8oKXjDR0gywnAqPigywLSq2kmtYK0iFQPamjNIUTsrfgwHiBKE8M2sVochbRJXG1snrOlz4HlxIbDEEeumvVay/5gn9owGrmLVZUHVKpf4pdzsSxnum6aoxs4hd31S+ny43IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjNdUXovazldeUh57tURnmqcngEnBbI7O3vFajy6Fm4=;
 b=cQEFq+ksaq1WtzAQAgm4GtyiNmb0EqpaXHZ5paimvoy4tY8JBuVJpLt4295gZvuyn4bfsLl9/n5YDrFMHgpZAyspz2zZFM0oYLTs6zrHStCVX+xQ8EXVHvNxEUXtXFh/sSpYW90MJ2/8BkqF7K4s9eOUCst+OJOQ+EDY9qu7u2suqUxI4codIWbdwFh6k5sSHOR6B9UODWgKH7AdzNcQ+9wkO2DTr67qhTlYq4NwTUgY/y07B1GIvVkA4NbQ2JTEkf6SJDPRid+TLeRGEoyPyP/gLbOLWPSaMs74PruQAIpWPJMT4k9l8Gw8VBorCkI3GQv1WUDNYdRJr5lAZgsNVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teo-en-ming-corp.com; dmarc=pass action=none
 header.from=teo-en-ming-corp.com; dkim=pass header.d=teo-en-ming-corp.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector2-teoenmingcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjNdUXovazldeUh57tURnmqcngEnBbI7O3vFajy6Fm4=;
 b=YmDvZn1yMuqfebkJk7GbzJi7pbTToRJPRtXCrIb5e6yfJFXJAAlM6CYyILQny54XdQVx7z3UU0omsKf8uZN8ZBSaIvdYygY8rRgIDDwMlpfa3kEus5n8lto1g82ATOLus1584K3L5/tUn8JqbbqgGTOwMwvNPKpRslvGU9Tjnbk=
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com (10.170.143.19) by
 SG2PR01MB2394.apcprd01.prod.exchangelabs.com (20.177.82.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18; Sun, 1 Mar 2020 09:14:58 +0000
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::684a:9e0b:7e12:18bd]) by SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::684a:9e0b:7e12:18bd%4]) with mapi id 15.20.2772.019; Sun, 1 Mar 2020
 09:14:58 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: I am going to embark on creating my own custom Linux distro called
 Teo En Ming Linux
Thread-Topic: I am going to embark on creating my own custom Linux distro
 called Teo En Ming Linux
Thread-Index: AQHV76nXxRQ9eRFUDUC3pENUaAJvXA==
Date:   Sun, 1 Mar 2020 09:14:58 +0000
Message-ID: <SG2PR01MB2141384043250A95640BDA0F87E60@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [118.189.211.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c31a2da9-dd26-4b7d-ee65-08d7bdc103c6
x-ms-traffictypediagnostic: SG2PR01MB2394:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SG2PR01MB23941B73A798BB09F182055987E60@SG2PR01MB2394.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0329B15C8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39830400003)(366004)(396003)(189003)(199004)(76116006)(86362001)(186003)(66946007)(33656002)(508600001)(966005)(26005)(7696005)(8936002)(52536014)(66446008)(64756008)(66556008)(66476007)(6916009)(81166006)(5660300002)(8676002)(81156014)(9686003)(107886003)(2906002)(316002)(71200400001)(6506007)(55016002)(4326008)(161833001);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR01MB2394;H:SG2PR01MB2141.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5iHuIGme7RyRClRznPWZ4CiLr8XtvUoYb8P3JbszbkCUViYlEiO7VqArJ6hCparhj7yTS3fEK+8jJDH6lORVi4MGonS1malne4KlqXKSmkslrMQqNrYD5EAClha2X8GbgUIjqcay/iB17XFeEsAJHygbxbuCuoRo/ATPUoWrEayxYuDTMFUSnkZ2BG3Rw+fhrx3mF1SdzHjLi79SZVJoCHAdU/FwtQeRteop7dEzhxhX4ThdU8O6Cud0s9YWymEElT3phqSI5kxfY9ArK2T7mgz37nNOnqGw/xEv2ZkQK2tdL9yF7t8lh61WNrFS9jp2MpvDPTHJ/L2xNzh4OSAzp5C/knSTIvzA7Xqoyf7KwmytIkT8maWyDn33rRja8Abb0S9q2z2zx5S9zJOxLwiXFD73el+U5rbOki3ROeyw/7QzuJLz+ZjRbJtU4Mu3LNGeQ+xVWnGpjxV0nUzQ0hR163zWATb884NMv6q8Qe1TIP+aMyj5tu94LO5rqmYl/h1nZsFdoZcTYhUeJuLZA8eF3zR1o09i2YB+mjj2kN4KN3xWYC5hGpT8VkhvuQpXpNNV
x-ms-exchange-antispam-messagedata: EPrgWslJ/mQIogcWjG6GCO0LaCJw1oyUrtSseN3aLVl14uN9CuC7iQRkZBIVsZ1mOu/yMeaiHS27m3LFUJDfoqlQ/EfalhNJBoLYQ5fhpLeCHgcQ7jZr8qUlifM/iFQCjgua5xzu9bAhNejzp2UlNg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c31a2da9-dd26-4b7d-ee65-08d7bdc103c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2020 09:14:58.3142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ASCMAxFbNLd+Iop7aBsBP0QCtlxOyPH2m+MLze4Sh5lE+qCaC+EHM7xAsLHyK9Z99jDe0Qd25Kq0dDrp+yHfuBCrDsTz+KJOkdnO9SVdJnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB2394
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: I am going to embark on creating my own custom Linux distro called=
 Teo En Ming Linux=0A=
=0A=
MR. TURRITOPSIS DOHRNII TEO EN MING, SINGAPORE=0A=
1ST MARCH 2020 SUNDAY=0A=
=0A=
Announcement=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
This is going to be my next Infocomms Technology (ICT) project.=0A=
=0A=
I am going to create my own custom Linux distribution called Teo En Ming Li=
nux.=0A=
=0A=
Basically, I have no idea how long I will take to complete this project. It=
 could be 1 month, 1 year, or 5000 CENTILLION years :)=0A=
=0A=
The Linux From Scratch (LFS) book will form the basis of Teo En Ming Linux.=
=0A=
=0A=
Teo En Ming Linux will have the latest Linux kernel 5.5.7 at the time of th=
is writing.=0A=
=0A=
My hobby is ICT.=0A=
=0A=
Thank you.=0A=
=0A=
End of Announcement.=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
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
