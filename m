Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D11C35247
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 14:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E3782075D
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 14:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=teoenmingcorp.onmicrosoft.com header.i=@teoenmingcorp.onmicrosoft.com header.b="EuiEFYME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgAZOKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 09:10:31 -0500
Received: from mail-eopbgr1300051.outbound.protection.outlook.com ([40.107.130.51]:53856
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726323AbgAZOKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 09:10:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iX4a4bQq2+CB+8Z9nmIOf6KEGt6rgqgvTzpNhVktLrUETAFkHJ0MSYBNHwGLKRaSWUyKvNpka1Id16Frg97s6v8I/diYHdQAti4ZPYRPAUUYF34ABM4DMbFhCtXA2F747BIO4JCZQrXmlhgwfMEO5IcUaWDXOGbLjQBDSzIangzbuQnI8esOAj0bo6qvwJZ6C2Z0vqaI50yEz37N/R8pubG/sdTm6/2pRSMycUYaqKQrEFzVdVXHblNShlfaDNM/LihN4yXyKAhO+lRsdbD6Cku5a2RFtubO6XdEtBELRw0SmiwRcHlOJRatu8SXQq7fBb7Ui4TRu1mcCkjcjd7rWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OjBkN9ctKJkl0HO27rbMu2F5Q95oiRJEeJBMos8/+c=;
 b=JKxlliodQFMIzJ/ackQWeLV2p/Zm5UtncweCKAyyBxn6f/kSZxOdeiNz+1A3Nqs/7Oy+Tkolf9KjhTiT1Qzfm6AlX2zqjEZC4eiB9VQe1pychmDudbedDLah5ZlfFptoGDEn7qDE7EfAJk1jnb4SQtmxfMxDokAgbtZ5EWRNjDuvxOxycRiZVqr3N86Mz+659veExXl1wEb+3+A+srt7PavydcOepDWfjBrRKsh70ym3w/qs/fDyTZUnD9LjnpstAbPxY4K8ddpPKnn3qtMX9gjenYblhohP5nRtJEP4WNgihlBvV0kMzx60o9MGv6iGLhiH6trD66KNimJDYZOGJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teo-en-ming-corp.com; dmarc=pass action=none
 header.from=teo-en-ming-corp.com; dkim=pass header.d=teo-en-ming-corp.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector2-teoenmingcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OjBkN9ctKJkl0HO27rbMu2F5Q95oiRJEeJBMos8/+c=;
 b=EuiEFYMEtOLy981jxnpS1dyYZ7rMXPN8eXY/g6DLtnLeyIqrlPlZVOYS9vH6nRnhg9nMPs/s+6WXTC3ETxBK8ZZGL5Ca50BG1jbWqpMi1nOs2RYEyALVzsGyP+TIiX56aGG3lR+SWq99NMWysal27HV7+1EvxhFiC6YrN4BxaV0=
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com (10.170.143.19) by
 SG2PR01MB3318.apcprd01.prod.exchangelabs.com (20.178.152.80) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Sun, 26 Jan 2020 14:10:25 +0000
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::81e9:67b1:74eb:2853]) by SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::81e9:67b1:74eb:2853%3]) with mapi id 15.20.2665.017; Sun, 26 Jan 2020
 14:10:24 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: Teo En Ming's Setting Up Azure Active Directory Synchronization with
 Office 365 for Business PDF Manual
Thread-Topic: Teo En Ming's Setting Up Azure Active Directory Synchronization
 with Office 365 for Business PDF Manual
Thread-Index: AdXUUj0/JvA2GaTYRcKJjJpuUUuJuQ==
Date:   Sun, 26 Jan 2020 14:10:24 +0000
Message-ID: <SG2PR01MB214149C6D9D5F5768FB6D99B87080@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [2401:7400:c802:de67:e40f:e55:fa61:178b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41cc21db-5010-4a42-34b0-08d7a2697d0f
x-ms-traffictypediagnostic: SG2PR01MB3318:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SG2PR01MB3318727DF957F11468ED97A287080@SG2PR01MB3318.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 02945962BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(376002)(39830400003)(346002)(47610400004)(189003)(199004)(33656002)(5660300002)(86362001)(81166006)(81156014)(8676002)(8936002)(45080400002)(186003)(64756008)(66476007)(66556008)(66446008)(508600001)(55016002)(9686003)(966005)(7696005)(52536014)(6916009)(107886003)(66946007)(76116006)(6506007)(316002)(71200400001)(4326008)(52230400001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR01MB3318;H:SG2PR01MB2141.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ixfa0V10JwUWJfEa2RTS4Zh8uqGE3W4CX8Npew8PXFonW/FmnzyXMI3ChAf6vTs46JRq8FnHSMjc5dUHq1RGu4jzxcmkoT6uigr1FjcNZlZ9Rqh4mrd0KLeD5n56pQFIc+EHChDqFkm5hcI4n99gWYahLEwbFB4XCV8RocRA6jvxvcw7uvG/paloxFDwQjOA6KzlJoLCbzXgudTLkMxOGFTku3vxjJikw71VBRw55VmNgsT1nxRKEmLbKp1wagoXRtCV8ybq/Uifjomf48tmVkpHSI8pmWXY9S830F8/1SGrUkaPaq6NXzjeV0s6lL7TzUzQ9urPAelbetvP/4kZBKN4kPJBNtSHetbuTu9KjE5WuPuSdn52uewHibMPiCLblyiKRP4o3F3ysr/hzDNtZh03whj2z3E0YnoMhh0Kr6tIJFmai99X6/K6g2cQfBE0QbN3Vg/GYH1mVDGlTvb+UGvjIpfQZSbszw6jq6FOsP50KtUHYrJiHBnKpgdA1jP94RevpN0EhP5M3TGgpHRHfQ==
x-ms-exchange-antispam-messagedata: 97kKr0IHQNwbAcWKKbARb/WwLzcgnox4gLp4wxnFKv9msDnUNhKS9/iBeH5w15KLQCdPACaX4Q2fUuuGquIpLSNwaZr7vE995IN1dN5S0nM5t2wFlj3gCWoanVS3Su2s5gy+0DtDpiM5z/vjHEQOuDvfl37QylonAhD3gUBKca52cSNOES08OP8XAKI7VxsQEwVNuLpVgYNJVFG9pR1t8A==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41cc21db-5010-4a42-34b0-08d7a2697d0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2020 14:10:24.6190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cRYuxsBNAbZxxlllwI9BAYqRMb2gng/ojG8N28IG/iqBn/hU55tHjrNMdtnQ9zVfKGDaPGvKQAAEwZj5SRSPY51Kxnw3BeVftWfoyMscyVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB3318
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Teo En Ming's Setting Up Azure Active Directory Synchronization wi=
th Office 365 for Business PDF Manual

Teo En Ming's 233-page PDF manual.

Blogger link: http://tdtemcerts.blogspot.com/2020/01/setting-up-azure-activ=
e-directory.html

Wordpress link: https://tdtemcerts.wordpress.com/2020/01/25/setting-up-azur=
e-active-directory-synchronization-with-office-365-pdf-manual/

Redundant Google Drive Download links:

[1] https://drive.google.com/open?id=3D1Dq3p3i5xVEo87pVF7SbxVdMmyAg-MMHL

[2] https://drive.google.com/open?id=3D1cAook5_QKm4oi_FuGu__ZvJLUQ8Kqurk

[3] https://drive.google.com/open?id=3D1A96J59cyzzbsJ-1TTjtcESWh4NQ6OpU0

[4] https://drive.google.com/open?id=3D1yKgP8jL6awx3oW81Lomca42dHKHouNEl





-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link:=A0https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microw=
ave.html

***************************************************************************=
*****************

Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic
Qualifications as at 14 Feb 2019 and refugee seeking attempts at the United=
 Nations Refugee Agency Bangkok (21 Mar 2017), in Taiwan (5 Aug 2019) and A=
ustralia (25 Dec 2019 to 9 Jan 2020):

[1]=A0https://tdtemcerts.wordpress.com/

[2]=A0https://tdtemcerts.blogspot.sg/

[3]=A0https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----

