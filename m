Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B69C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 14:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884072051A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 14:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=teoenmingcorp.onmicrosoft.com header.i=@teoenmingcorp.onmicrosoft.com header.b="iPmke2xh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgA3OUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 09:20:34 -0500
Received: from mail-eopbgr1310080.outbound.protection.outlook.com ([40.107.131.80]:14944
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727107AbgA3OUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 09:20:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSTYb0NfRk2Ce2UmdLB4vRhIZ7c8L3wPp51ZZ8dGidqXQzFEsr8QBKtEKV6fihkVMnny5UfqUFGq89opy1AAmLCmlCfcEUsekXVHCNrZquLRpKVftgMDS9789QQ6wL8j2xRRMYVF6pGzaDGpVjKAJsi5QNNf5nfaKSa0eCPAEbFR+YRLpL6UQl1FddCBQrCLd5GMAIE6yGRVxLAKcKTcyu0JRDKXWsvo5ROxv5enjhmy2enMqCx0wEs1eQT7Q7ZoLnaF8oCW3drZJlpjjOVMdfzVb1YW1COMSGRemwd9wxDWQhKV2dAtBMLOxuqh+ReUfk7DO2ZRCSPoWJBqXX1pSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOLFKbzHJwBniFqz2cEyokB/67PSH6EovdDzki3eVyU=;
 b=jzXYk8lf/TEVJV3oDyfdU2Tjp621Jp5LJhAyEaie0m/VBorrUHjOu1Fdmx531lVxlllSn8AI/f726k2gTxKxrWUhPQdT2YZqcIEFN5+AiH2JAYslZyCYJX0LenBhGDj4dCSQXo6tZMmnWfw95CA5iwaV9AP9GYERO3X747xV1WECBwtitatP2oMX68F2IODonQKO4kUJ7VNk8xsLW7q+ulkJf8sF5JxZXHZTWrwXoLydEA0SIupdQVVeL7ESdmYTwMsrzMeZtNiv02LSevhi8B3VEgnYuWxBZVjtf46BOnFFdoCTa80093lQ08hp9MzCrYT/c3hkzB51GS3HwMQ6zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teo-en-ming-corp.com; dmarc=pass action=none
 header.from=teo-en-ming-corp.com; dkim=pass header.d=teo-en-ming-corp.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector2-teoenmingcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOLFKbzHJwBniFqz2cEyokB/67PSH6EovdDzki3eVyU=;
 b=iPmke2xhrDig8NU9jJrkTo7lz17TTk817f+MZPzFMGA7Q7frYqaILFT960NfCfqMBZGnn0thuXshef2xwybZmWgAKrB5VELaEQOL8qLHQAVVotvMovAikrzFjEpRzZry4ESS1Zwe1NnOyr71ab98XXYghiH6V28qVGmCnndAZfM=
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com (10.170.143.19) by
 SG2PR01MB1967.apcprd01.prod.exchangelabs.com (52.133.140.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.23; Thu, 30 Jan 2020 14:20:31 +0000
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::81e9:67b1:74eb:2853]) by SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::81e9:67b1:74eb:2853%3]) with mapi id 15.20.2665.027; Thu, 30 Jan 2020
 14:20:31 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: Teo En Ming's Setting Up Ubuntu 18.04.3 LTS with Samba 4.11.6 as
 Active Directory Domain Controller PDF Manual
Thread-Topic: Teo En Ming's Setting Up Ubuntu 18.04.3 LTS with Samba 4.11.6 as
 Active Directory Domain Controller PDF Manual
Thread-Index: AdXXeF01aC/b/3rXTqaitaYis/NJJg==
Date:   Thu, 30 Jan 2020 14:20:30 +0000
Message-ID: <SG2PR01MB21418401E77AFA63F1FA31D487040@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [2401:7400:c802:de67:6cec:d2d3:6b97:66f8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2fac4a3-15b9-46c1-c41f-08d7a58f8ff7
x-ms-traffictypediagnostic: SG2PR01MB1967:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SG2PR01MB1967D85637F2EA0C5F02D38687040@SG2PR01MB1967.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 02981BE340
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39830400003)(136003)(366004)(396003)(376002)(199004)(189003)(81166006)(508600001)(6916009)(81156014)(8676002)(107886003)(6506007)(55016002)(8936002)(2906002)(86362001)(71200400001)(9686003)(186003)(5660300002)(966005)(4326008)(316002)(7696005)(66946007)(66446008)(33656002)(66556008)(64756008)(66476007)(52536014)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR01MB1967;H:SG2PR01MB2141.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1SX1n+2Wgl8m0EvEN/yhaDMWfCSknlCgm0m34TAA+Zr6R/JKQLx4bjTIyXmtMdD/rTkKqy0y8La0xTuLPcfoO8sh1WkqZiTLgqiYg2mIxZwVMBEBUqkxXWBEx6OwEjwlnYnSJvchyJ4Mi4L1uNiQFepKy9FkO3XZyt2ogyTqs8cVthemql3Q0HuayIkNzt4N8+/J9u1l+vt2cJPc7P/ocTuY03nJtedPvq0zYh1aNFs42igX+f/8ED82uFgln0V0ZtBEZZEF8gGjwCwq+hTnGeQUGXbLQ0xaEeXtQ9xxV9dSre62QsxffEKwtQpvSH+6Zj5SQ9a73mG9nTr4E+qZmQq/egZRRb6TN1imjbGlihD223FdyavjZ7Pcvq9Ua5F9GqivSc05OqQlt8sGW3PdnMxdnZKBTNCVdP9cbvrkQ4l2EJaiOCCa24RnhgaluPy0YAXldN/qCuETxyWasar4bkV2qiLgAMplSw+PwlTywyAcP5YqFm07oktFc4Kg75QqDbQYaI1f3muiDN8ORIX4yQ==
x-ms-exchange-antispam-messagedata: U5OC49cziGHw9C8HUC3Bas76ise2nOsAWs1PLyDxAOQuKeZMtT6zrdTgbakIpRaZl9rmVFRdKOo0jmcAba9JqkYTe6aXL/vqLQNCAadCHm8jMxIqLjQUiAUZaVLpFXigaaRhC3IUJez9pnO5JcKAPJnoTDki0+awwpIUkWzNvb3qqoPf6KLnLkfylfgZ9mKVxGXNEEeMVYZlL7bBOulJEw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2fac4a3-15b9-46c1-c41f-08d7a58f8ff7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2020 14:20:30.8621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u/3c+JJiWqpupGi5mDpMYmo9zT3UFMmUhktU8MwtOlmfPTXRB2xGwrYF4HCIwQ3nMygGqTR/FHmlzEgWD/+KlfzeIPmweYHVDfiSA7TM+AA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB1967
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Teo En Ming's Setting Up Ubuntu 18.04.3 LTS with Samba 4.11.6 as A=
ctive Directory Domain Controller PDF Manual

Teo En Ming's 100-page PDF manual.

Redundant Blogger and Wordpress Blog Posts:

[1] http://tdtemcerts.blogspot.com/2020/01/teo-en-mings-setting-up-ubuntu-1=
8043.html

[2] https://tdtemcerts.wordpress.com/2020/01/30/teo-en-mings-setting-up-ubu=
ntu-18-04-3-lts-with-samba-4-11-6-as-active-directory-domain-controller-pdf=
-manual/

Redundant Google Drive Download Links:

[1] https://drive.google.com/open?id=3D1kbm762Eq6tu9qAM42ipO6ldUe5qGbSHV

[2] https://drive.google.com/open?id=3D1dsrg_Re-0amQb5Lf7hRmrJYeGTKbFm8i

[3] https://drive.google.com/open?id=3D1D-ynGtyOgY5xKjekGzXoT-XQ4DeYpUJz

[4] https://drive.google.com/open?id=3D1R1rFHIn0_EzLRspxylSE6gG7eErUCDFY




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

