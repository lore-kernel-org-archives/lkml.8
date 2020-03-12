Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E72C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3262067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=teoenmingcorp.onmicrosoft.com header.i=@teoenmingcorp.onmicrosoft.com header.b="MyXtIA+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbgCLPAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 11:00:41 -0400
Received: from mail-eopbgr1310043.outbound.protection.outlook.com ([40.107.131.43]:43856
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727512AbgCLPAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 11:00:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEn2npwSui5Ge2zatyc15N3+LkqvSVRlR2q9NioAXSeaZw05wWZy1b18Akt4e0o9xmx3M1mnS19hUcQTIFgCJ4oSYvdUN8xjJmSmlxJuN430QMv/d4f8P3v+93hG6Cj7qdfN0+CL/KlDHUOn/G95ayTeyLv3kygVb4Mpo94KmsXHPlw2w9nHLgN1ddrP4bijlrl8mM0q/7/Z4nBN7yb/AHqAPSCCXFhZLA2OpKe9KrzE0Pm46AA4mjJH9iE57PuyqSAAPuuyv4DL/oijy1LG3KKXm2gdYkaniKbge/KtqiU+YSb9ZhsaEEop/ZQw+Nn/9eK4337lanuBZcuN3lTUNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaRC0Dcl9Rpe7zrJyfbuU6j122qFtotn0Scx+r5MAUk=;
 b=WrPoz+SV4dC6cxt1OHKDUZrCuFwrZV/MXB1vAz3JnFfBdU0F3BUMHPvVtD2ckYA5XT4PXGiEVxrocyGy9EAdtO7RQKroEVNBC1ICw1o/LoEhjavTQV0iYJenV86MYZX5QBNGQyTa9CBraMNl+aiFJCGlixDsd61l7qHNSwy77I0NABxbfEx20vBMOs7TQFUHDELU/WFsQMP1pz0oE+tzSDZw8r3I1/Inrg/EVn3ZCqpux5XfBZBUfnv+kXDHcs/0MA0fjtQ5mkX/dAUg7XTbkG34uTc54BytnahipxVwdncJ2AYtnT8NDogfqpf9dSy15GngfdCs889HVBhAkleoPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teo-en-ming-corp.com; dmarc=pass action=none
 header.from=teo-en-ming-corp.com; dkim=pass header.d=teo-en-ming-corp.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector2-teoenmingcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaRC0Dcl9Rpe7zrJyfbuU6j122qFtotn0Scx+r5MAUk=;
 b=MyXtIA+6UZUpgmLcHAdBBhN/aBtQ1wwgKSlyUyG32HGFRYhwwcyyEXw3xH7gvbrRAN5dqAo0r4KEn947KNFcWZ4PrrVdrL8JLqH2m0tzfeVasOXSTpRb7WCUS1RDajs3poWrtGIX/SjhRxkPCpgrGPhHTjATAv14fu7uigmfdNg=
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com (10.170.143.19) by
 SG2PR01MB2427.apcprd01.prod.exchangelabs.com (20.177.82.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Thu, 12 Mar 2020 14:59:46 +0000
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::684a:9e0b:7e12:18bd]) by SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::684a:9e0b:7e12:18bd%4]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 14:59:46 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: Announcing Teo En Ming Linux 2020.03 (FINAL)
Thread-Topic: Announcing Teo En Ming Linux 2020.03 (FINAL)
Thread-Index: AQHV+H7Qnyp1oQ0wikGFEnyap5hYAQ==
Date:   Thu, 12 Mar 2020 14:59:45 +0000
Message-ID: <SG2PR01MB21413EA3DF193D1115DD605987FD0@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [118.189.211.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3e727ab-e889-477d-cff9-08d7c696010d
x-ms-traffictypediagnostic: SG2PR01MB2427:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SG2PR01MB2427BFA24E66D1FC68D7EC1087FD0@SG2PR01MB2427.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(39830400003)(346002)(136003)(199004)(508600001)(8676002)(316002)(86362001)(66946007)(66446008)(66556008)(64756008)(26005)(186003)(76116006)(66476007)(6506007)(81166006)(71200400001)(7696005)(2906002)(52536014)(8936002)(9686003)(81156014)(4326008)(966005)(6916009)(107886003)(33656002)(5660300002)(55016002)(19273905006)(562404015)(563064011);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR01MB2427;H:SG2PR01MB2141.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3qoW8xP72VQgc6LlW1djov0axAtZYKcVpeGikt4uT7OghDIsfQ7Ix5VnChDypKFjO+Wd+QndqQFTYFSkQE8VZ1D5H9KPRbWPOVtz5NAgZ/9CcX0Sr/oFbBrlAvc35/HncdHcmxCdygSN4YuxIAFDShbgGV72nzvqxc+YwXAAPTzd+1p8atn5WqSBbphYgMglyYJsZ4eVEui2tqDzO6nKfvDFvcgVmjZkW2iTHLbb3/aOXjq92JGbe/RV8DzgO3S9VWvCNsQomWPA4Ys+pISBDNwX3J/pm09G9LXKO//WA/F+giFkp2z3YDo+jT0p+V/K5SPlTc6iyRBX9H8BZqNrjI7yVVkxDJAeTq2iq9flG1DERbo+aDp7my8rdrxtj5FrXLP0RbAnkwR1AkqUuWNg2VV2/tJoW8ld6RUResVj83b8RxFmvxCeHPZpeq9ePqB3RpEr75AFEljn1ptqsNEblopGHYoxVKvCPOBrKVVqgjeDenkmnuagfohKyJFsHHyJDIzrtC5tkfvwLTlgu+v/96rPnl8O6QkgTzawBT6DzCa/i59z5Oo70bGM6p60p27tpMaBTdA/CyGSzvtwitTYYg==
x-ms-exchange-antispam-messagedata: CTcieKinq/O9K+Xed+HCMuFHbg9nJi+oWEnOJbIEokZ/j51fkw02OKp0N7KUAuOYWGMqmray5x9pbdgqW5vVc4qKiSnBCXX3CAlmQzetsSWQ7F3Akl40MQOyueJfEWgSm1Jc5rsZRFWxyJoF30u7Vg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e727ab-e889-477d-cff9-08d7c696010d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 14:59:45.8382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s1L3mU2wduviyKo7jelF7oizbZU/iHHVFCGbjBwAZ8lHSvPm54ISmG+rdZ+GTl57I3AlvcdgTd++MCyYQNAbgMe5SCQJZ9bnYFoNbRYLWtw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB2427
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Announcing Teo En Ming Linux 2020.03 (FINAL)=0A=
=0A=
12 MARCH 2020 THURSDAY=0A=
SINGAPORE, SINGAPORE=0A=
=0A=
ANNOUNCEMENT=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
I have just created my own custom Linux distribution called Teo En Ming Lin=
ux 2020.03 (FINAL), which is based on=0A=
Linux From Scratch 20200302-systemd and Linux Kernel 5.5.7, all compiled fr=
om sources.=0A=
=0A=
You may want to watch a short 6-min YouTube video of the live demo of Teo E=
n Ming Linux 2020.03 (FINAL) at the following URL:=0A=
=0A=
https://www.youtube.com/watch?v=3DWfKh2WlmzKo=0A=
=0A=
Redundant YouTube video:=0A=
=0A=
https://www.youtube.com/watch?v=3DU6csdSCrKnI=0A=
=0A=
Live bootable DVD iso will be available for download soon. Stay tuned for d=
ownload links.=0A=
=0A=
REFERENCES=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
[1] Linux From Scratch, Version 20200302-systemd, Published March 2nd, 2020=
=0A=
=0A=
Link: http://www.linuxfromscratch.org/lfs/view/systemd/index.html=0A=
=0A=
[2] Linux kernel version suffix + CONFIG_LOCALVERSION=0A=
=0A=
Link: https://unix.stackexchange.com/questions/194129/linux-kernel-version-=
suffix-config-localversion=0A=
=0A=
[3] [SOLVED] Can not boot lfs=0A=
=0A=
Link: https://www.linuxquestions.org/questions/linux-from-scratch-13/can-no=
t-boot-lfs-4175627243/=0A=
=0A=
[4] USING GRUB ON UEFI (***MOST IMPORTANT TOPIC***)=0A=
=0A=
Link: http://www.linuxfromscratch.org/hints/downloads/files/lfs-uefi.txt=0A=
=0A=
[5] Beyond Linux=AE From Scratch (systemd Edition), Version 2020-03-10=0A=
=0A=
Link: http://www.linuxfromscratch.org/blfs/view/systemd/=0A=
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
