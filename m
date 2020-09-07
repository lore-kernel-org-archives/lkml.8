Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7634AC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42E262078E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="fwrikB42"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbgIGP2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 11:28:47 -0400
Received: from mail-eopbgr80108.outbound.protection.outlook.com ([40.107.8.108]:30294
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729900AbgIGPQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 11:16:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5YKXb75vXBwdv80hZ/1otxDVj8uXaw9ewqWNQtzLZBT4/Jf4nC6ySqendhCacATy0aPv6hKXZOAMxhKp6/dDhSoWsvZG5+O+DKlDwn7COnG1UpOEIoPjrkQwQUxguRBOXVBGWx6/mMUXbB/VUWDpDCCWZPOx60EKfjEko+p1cq5m7KIfdTTFFgEJ/baGiOuf2VubL6ylwBz+v8OIGKconscHMl7lFSBOnLCGh9Cx+OAykjK59GvSzL11yYkZznCfaIQdw2Odavrjxl6UnJPGUSfk3vbpH2XUuSdKyMgj6jqOXqNcMG/7B9P0g3kzPlCmBuBCgiAjV43u4qx4s2Fmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p95TCJQvqeAre4CYs+QCuYOxR5gxFNzbDNIGwGhNDqA=;
 b=XjVHlkriv8dqLa9FBtZAgHTHTcaCN1SUJDd48F5U67gbRL/i2VYkpNcQKlcKPJs93WMY6WYhu12eV1hbv/pSGt/KF3ge4ozOUPQU0NL8ekqd0Ju9UbAfP4J2HKzaQuawVbICsIhxTd1++ubW0r8KmlOdwxNQbPbrr0Oewzbxr2MeG2eMTyLdejQcNzTt1Je0yAOAf7rFMTfYKkqoxPoMBXfVHx8PGyLHeUw4W6MZNsLVvX/smmKrSlmir7UwAzzJ76TAZDKhAoFW74gnn2+WkaAbF9fQjLMIYDnCFabIhxcmwaI5f6gpeW8J4G0GqWkUKNZtW+uJpCZRrhv84YoP/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p95TCJQvqeAre4CYs+QCuYOxR5gxFNzbDNIGwGhNDqA=;
 b=fwrikB42y7u+yePcvKkDBEMeZ8eDp0Du6yPAPfDGbpgVCdueiRpdRpHl6fkmIuY+elnVa+xscK9buLSdByJPwLYAMYX/Xn6sbfTEXlgubO3FRQLHhSzAh0aqgJ75tXLKa1e/30PKEvZYi6KtbNBOuYK7cpVZXOGyAv/JRP7ofXw=
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com (2603:10a6:10:ef::22)
 by DB7PR02MB3707.eurprd02.prod.outlook.com (2603:10a6:5:6::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15; Mon, 7 Sep 2020 15:15:55 +0000
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::95e1:b3c:ddde:4c32]) by DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::95e1:b3c:ddde:4c32%4]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 15:15:55 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SW_Drivers <SW_Drivers@habana.ai>
Subject: RE: [PATCH] habanalabs: count dropped CS because max CS in-flight
Thread-Topic: [PATCH] habanalabs: count dropped CS because max CS in-flight
Thread-Index: AQHWgs2oRZM5DZa/r0eCGOjYJuePIKldTbXg
Date:   Mon, 7 Sep 2020 15:15:55 +0000
Message-ID: <DB8PR02MB5468AD45E7F2EC9EF659449AD2280@DB8PR02MB5468.eurprd02.prod.outlook.com>
References: <20200904151119.24224-1-oded.gabbay@gmail.com>
In-Reply-To: <20200904151119.24224-1-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
x-originating-ip: [31.154.181.186]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f2db525-8479-4467-5ed7-08d85340eae1
x-ms-traffictypediagnostic: DB7PR02MB3707:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR02MB3707972C346D90284CFD5EA4D2280@DB7PR02MB3707.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7CF7S8nfVU0qa37AIK0BybrIo1rN33w2ni4N8pILjQeUl9Xjy4HigL8KWpo9Qxlgoi3JbmUm5CpMnIp70HxRD+eidBGTnEXHMkZ1mL2ngqyoNhIie2tOsl7e1jo6bOLuJqgjWwGnHoss0NqprGRu0kcFgC+k3C2XYubgWZuOiFpnowW8Wxrf8n5N5ioFMVtCTatqF2/f43Otq29p0tf90744RgXi7N/FsCCWI6blxlI2M0yopxCqbw6SpLvYjcL5onOV4Uj8a5y1Wp4oXUEkYk6qFQ43IiT7oHxBWFqE2FBlwKseAhx9/XcJ70kdTv8K
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5468.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(136003)(376002)(396003)(366004)(346002)(316002)(26005)(71200400001)(5660300002)(9686003)(53546011)(8676002)(6506007)(55016002)(76116006)(8936002)(52536014)(66446008)(64756008)(86362001)(66476007)(66556008)(66946007)(2906002)(186003)(478600001)(7696005)(110136005)(4744005)(6636002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: sY2mpWAftbi3DRpnc6EtAYULXaV06mquBbNsIKQInvzrtX/d+1sPZxaiY/IuubJAlpmDDFpIzkj9fKjMPwiOeWGiiwpz7ZkQLdUaSE8Csjg7uZ91y4aySEB4/UN2qcIcezPK+b0PpiVu6CwGrp+7jKFNLbgP/+x2NZiRnGeVU+9HktX77284Op3KQdvybcERHuA1Ndcn3G9XqlDUK3lq+BkItquRHPn/6ps3Y/EAiZVtmq6VYF31UrWgBoVKTYJit9TAixl0D48E0LriAmdYFV05PLSL2VipnuAxqyARJfjAiVS1ebK+NMnE0U7nGVOHaogxDx4wKdSwpN6UdwbsEFO4j8f/1fP5JsxaMN+8PDg4W5lXRWQs4y3QlZWLqAfTEh+5izGNtOcH0ULlOrJ0rkrKnxS8ThF/BtEWyjPfZNc0I88gpkgfBpxI2eDPSGJ51TuYDmDLDuIJsnqcXwr/S2lm13/6tI9/Ur2w/+mTlKpBIIYs2H7vL2GZ9UJIYN+EfwiHp/x/saezhJH0QEDL2i5Ax20WbxoKRqPFgJ1ler1X5UXlWeb0ChqCWDtohg+YTvBabDVDQxhoNe4NbEkgBqbIrVVY1Fk6bo1WQNnOBzG2yqf+6tpY/1ducz+9YpMzDXQ4awNQEt7KwqdX6NhVgQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5468.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f2db525-8479-4467-5ed7-08d85340eae1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2020 15:15:55.5716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dwRx4oJzhE8nG4RyCF0qldpLvUJfQi88hoCt+Sm562OnuWjESvqrSQ6Z0bpYiZaifyss70O4MTrPaFmIwZ1Efg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB3707
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 4, 2020 at 18:11 Oded Gabbay <oded.gabbay@gmail.com> wrote:
> There is a case where the user reaches the maximum number of CS in-flight=
.
> In that case, the driver rejects the new CS of the user with EAGAIN. Coun=
t
> that event so the user can query the driver later to see if it happened.
>=20
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Reviewed-by: Tomer Tayar <ttayar@habana.ai>
