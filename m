Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6654CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 14:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319872071E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 14:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=teoenmingcorp.onmicrosoft.com header.i=@teoenmingcorp.onmicrosoft.com header.b="TJkjW8Gm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgAZOSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 09:18:22 -0500
Received: from mail-eopbgr1310044.outbound.protection.outlook.com ([40.107.131.44]:9248
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726275AbgAZOSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 09:18:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGwvmS4CSOq9yVl3hSpI2ZbYWfkgIFf93u0KHyvLSEs4+S6ED2IgGUrTw1w0nuxV1DLPGPQvVhj4qnYdYSbBkgnCBs/zrs23FE6+dTBYlQQfRa7I9Cw3HGHuzPUKbkRqd4YIhq+GK6QO26fMRexvvfzV4WIRd/c+IXqwwl+nZx77jyS7nUciIGFIjB4yU6qvA/k4fDmkPKYNs1+tkJukF2Fm7oTSKZPDTdgY76+T2+J0/AxI47WRQv1NpoIczB1S6aSrzxmHORqwZ/8K2aNuG3ec6wYIJJS0TCFoV7mx7SJiAlBAZb8qGIXcADz3gZ9BVuv0qrL3/m537lLAjTWZQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrGalLvImBvf6t6Gsi60ec+Ta/Z4UEi6KuLM7GdK6AU=;
 b=YecLn2e399S4B1annDvK2aYqGkjkvW1XMcm0M/Am5im+EHsy7Wf8efa4EPeqMG15dxEsW3p7ejh66cYqSCDtMO3T0htn2fNQOFp/MZsRnpy9NHnCepzWkbtU5vzcXQuhBnb0jUcA4OgKL1bmnd0x/apx83/7oSRbWeN84U98AO3xkrvK+Z1fUuYYLpVjpNcpirMZKVIqpY9reO/NKxFDcmtEkoyMbcprdbEcjZwufSc7ThtT6k+moH9RplR/BmYaqUPAnQv5Eo53qAkVwZnuRx3VnsMleQ8NeZkAug+MucV8noUKBUqpweYOUD8v3koXwJbGkA218pNsUOytB6ScTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teo-en-ming-corp.com; dmarc=pass action=none
 header.from=teo-en-ming-corp.com; dkim=pass header.d=teo-en-ming-corp.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector2-teoenmingcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrGalLvImBvf6t6Gsi60ec+Ta/Z4UEi6KuLM7GdK6AU=;
 b=TJkjW8GmqJSq2QZWNbWF58M/W6874iD8fUAKrW3+XDQB2+tukvU9uYO8NP8HXrWlI12cqmVbU5hpKK3E4dDY+zfiz3jZVeXc+LE+jHe1VPk2BOrin0wwIoVsX/hDWgetB4x7RcvF5HdjdSR1Hc2atie5PX5kJN+niylgZ7KLcX4=
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com (10.170.143.19) by
 SG2PR01MB3453.apcprd01.prod.exchangelabs.com (52.132.235.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Sun, 26 Jan 2020 14:18:16 +0000
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::81e9:67b1:74eb:2853]) by SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::81e9:67b1:74eb:2853%3]) with mapi id 15.20.2665.017; Sun, 26 Jan 2020
 14:18:16 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: Teo En Ming's Setting Up Ubuntu 16.04.6 LTS Linux Server with Samba4
 as an Active Directory Domain Controller PDF Manual
Thread-Topic: Teo En Ming's Setting Up Ubuntu 16.04.6 LTS Linux Server with
 Samba4 as an Active Directory Domain Controller PDF Manual
Thread-Index: AdXUU2eEAIddTEWOT4SL8bSJm6z+kg==
Date:   Sun, 26 Jan 2020 14:18:16 +0000
Message-ID: <SG2PR01MB2141272CAB5BEC7980CBDE4F87080@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [2401:7400:c802:de67:e40f:e55:fa61:178b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fca80416-e37a-44bf-d44e-08d7a26a964c
x-ms-traffictypediagnostic: SG2PR01MB3453:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SG2PR01MB345390566C60D2D6D57857A187080@SG2PR01MB3453.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 02945962BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39830400003)(346002)(366004)(376002)(136003)(189003)(199004)(316002)(6916009)(71200400001)(86362001)(6506007)(966005)(2906002)(33656002)(9686003)(55016002)(508600001)(8936002)(8676002)(81156014)(81166006)(4326008)(7696005)(66556008)(66476007)(66946007)(76116006)(186003)(52536014)(64756008)(5660300002)(66446008)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR01MB3453;H:SG2PR01MB2141.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k6mxvjxoVxyHWDr4LqqR1JVlSnnbGc4rQxqSeIuv2CSxYuE0EKnG/GEqFcjUpdK7BFqMnp6jbVx403t/29m8qULP+CbLBGdHoVVvoGreXac0kTb7QwAlZqCYZ7n1djhQN6Apt48Vf5JrKbQ+/7sy1CfXWG4x1X/mMOCTZg9iQEjDM9TMbE2ZEYt4bYN7dJ6vs4IKQhulQrJ6NmoYWBNd8Bl3aIqZBSl5unAfFiiihEl4gJYBckCrLpaAEykPJwe9S4QNGPKaKPiZI5mPkAG5E/UZmQlVC138bcePeiPX+FcEhk4sGDLeX6XPbeMDQezztcvnD7KDUkO69um72b4YnSSt7moUnACbz2hyB8geBQqunbrHpE1w24rGmQVBdN+CWZXYSSEMfZ76C86GJPSu+E6JPCJKrVLW08vXVemetbf1gzHXRMSI7KV+WL3sCIcgVKRfShEJyS40xKF9s24WpVqKTbPGWtQzK66CBnC4fpm8JGpx+Bx/QHzH3+KLyiw4rJ44l7thfKmRfci6C7AMNA==
x-ms-exchange-antispam-messagedata: 0T5fLuxN45FuuWoNSkOdQwwjGVxZXg2ec/jmVd0OJ6ggX3i0ZUY5br0rCb/E/eG1SW0ro5IAgsLJBFvJw5Qy5bujV9cZy68SgYy2g5pN0O54eGpziTbbxtU6HcjF6apdl2kI045muKgwKVwAMK0EMxTT2bv/RVPLofx0AucEr1bJJfrD8hS+4vtjH2HKtjpxdXxLq9bp8fzcWZ3Ty4OvwQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fca80416-e37a-44bf-d44e-08d7a26a964c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2020 14:18:16.4177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sajcI04blty7PY65uZV/qa16h+oFFH+G1qD8vNzxHBP3exrqav0CmcqOVEsc/mm32M+EibfBSRS8aWhDUvooxSVGrFCOpoheK+RtUFl9//U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB3453
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Teo En Ming's Setting Up Ubuntu 16.04.6 LTS Linux Server with Samb=
a4 as an Active Directory Domain Controller PDF Manual

Teo En Ming's 115-page PDF manual.

Blogger link: http://tdtemcerts.blogspot.com/2020/01/setting-up-ubuntu-1604=
6-lts-linux.html

Wordpress link: https://tdtemcerts.wordpress.com/2020/01/25/setting-up-ubun=
tu-16-04-6-lts-linux-server-with-samba4-as-an-active-directory-domain-contr=
oller-pdf-manual/

Redundant Google Drive Download links:

[1] https://drive.google.com/open?id=3D1WpzCAFh6AsoKOVzd1cjQAJwjAym3fz_R

[2] https://drive.google.com/open?id=3D1FFZgoSp6QX09QtuIIgB6mRpaJwra7VpJ

[3] https://drive.google.com/open?id=3D1gSzFqnYh1Q91RlWBlvkvcT0acafDJttp

[4] https://drive.google.com/open?id=3D1jO96Jg93qEVftpQVTs8uXm1N4E5FaGKO








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

