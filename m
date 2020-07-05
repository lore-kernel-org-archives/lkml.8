Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44B0C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 13:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A54C720786
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 13:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="EGeMbSyR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgGENah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 09:30:37 -0400
Received: from mail-eopbgr20126.outbound.protection.outlook.com ([40.107.2.126]:37127
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726833AbgGENag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 09:30:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWxVSOWgsWY71PrU0TzByWCRQNlze1FMGuIUpWTFANTHibgWw9lDx8RbSZ6CCTzv6lo1MR00G/ioZ7uS2ExQ+VrPTDv0Uy0rBKyFGEJNMAvn5y2uk324m9dTDjJch/hQQIJopnIG7Od9vqJ8KBqyVm/eX/d4RcWsXF8nD0Jg0rJCb7KU1SytLjwKmBhuZ+w0QsK4tkLSi09xjqNqLUGJU8bbi2u18jknbG1BAUTDfK9tJuaKaABPIqvj31V6PcVbChsSKPoNwmfXBRCTvkAY6MbnWHH5YfSTUYtLrL5NHc0lLC7ksxCdBKJDk5rCNHDiefgVgoUfh7jwMrg9PKxTUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1oZc/NEmWzR2TGZhSbPQL07NhV6l8NfFDVmI60dGCkY=;
 b=AHj+5XCTXgOwjG6Mz4PbLkScEi51/ViAZETEtGnWhuhMzW6cVR9JTHX8f6wTPoS8qIx2wTHGJnNzP7aD6rWFmlpjdZd2qOfKQkIxhYKsBYx/MxVffpJ9PBj6CNSdAiUPoHRORFNCAwkhBJwXrLeqX9MNAWcsl8wjwkoUSrTPyMTZCQI3+Qu0AIZojSk6Xh6T8ea2OcjHE4MCcK+gsg92U5DztV5s4DYjap2JYqUrSy4Vj7tIl9jNVu/tEiL3TGybhJEmSFjyQcrh9dUBXZsHTWyuxldBsPZT/AafHs+4Knw0sB6c/j7Cs3FeVWLXpTYE/GFigUgj5ndUKzD2C1GL/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1oZc/NEmWzR2TGZhSbPQL07NhV6l8NfFDVmI60dGCkY=;
 b=EGeMbSyRSVbITdnHRP4jHDR3Fn1BAN6Jy5JnYlJcqlUznw46g6xQCG+CmIDr5ti0QuaOvxaug6llPXlluouZsY2roBNfYBx3gBmt+7Y+yqcXoWpN7xB/1MOZfcfAUEJbc2Rw9NuGvVp+gwyKN9C1bZ0+bKJfINTckbqO82a8mKA=
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com (2603:10a6:10:ef::22)
 by DB8PR02MB5578.eurprd02.prod.outlook.com (2603:10a6:10:38::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Sun, 5 Jul
 2020 13:30:34 +0000
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::68d4:6b:d077:19a9]) by DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::68d4:6b:d077:19a9%4]) with mapi id 15.20.3153.029; Sun, 5 Jul 2020
 13:30:34 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SW_Drivers <SW_Drivers@habana.ai>
Subject: RE: [PATCH 7/9] habanalabs: remove soft-reset support from GAUDI
Thread-Topic: [PATCH 7/9] habanalabs: remove soft-reset support from GAUDI
Thread-Index: AQHWUs4BXNMBcmF480SSu8gZ3JMVdKj4+zDQ
Date:   Sun, 5 Jul 2020 13:30:33 +0000
Message-ID: <DB8PR02MB546850AE9B7C57F3539A674DD2680@DB8PR02MB5468.eurprd02.prod.outlook.com>
References: <20200705131245.9368-1-oded.gabbay@gmail.com>
 <20200705131245.9368-7-oded.gabbay@gmail.com>
In-Reply-To: <20200705131245.9368-7-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
x-originating-ip: [93.172.67.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9885aeac-576c-4e59-c661-08d820e79882
x-ms-traffictypediagnostic: DB8PR02MB5578:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR02MB55781B1AD1ACF1EE18EAC03BD2680@DB8PR02MB5578.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 045584D28C
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TKl/r7bUWe/ptx223+zLu4KB2NR8dR/9eRWKd7z7sJMRu9GjJgqGF0zdmsSktEf29hWBH72xLvm9QKfMqqRgyCSpPX6Xd2eo+rmOtHM92NiRcmNFm52X0dXVr/qi3J9k8ymGitG63i2beKCEyamlML39wX/+/ch/I8Bg/49UAcLH84gbOhNXKazoIMgOeRZhQEy5PyPK5mIM3Jt1SSJ1cCPTtZ8YJGgDU5jya6sAQ/xrAod8As5IIdoqTkhYpdYjLrLZ184FhyG1kAMA4e/FHE44z2+miIPKocz1dwtsR77i5Ye5Zw5Zjo8CjSQpxSPN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5468.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(396003)(366004)(136003)(346002)(39850400004)(71200400001)(6636002)(316002)(76116006)(64756008)(66446008)(66556008)(66476007)(110136005)(66946007)(9686003)(478600001)(55016002)(8676002)(7696005)(558084003)(33656002)(5660300002)(2906002)(52536014)(186003)(8936002)(53546011)(6506007)(86362001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: bZ4FlUy6yNvpWP0J4mTk78UGzafJPN7zEE5W8emTMLVt8Dctx6D/5I+tOSqBKNOjVGWj7pFsQFlOsiSqzrMwAMj8SdLBE85j/a+vA3rrWeEmCPALvbPv1cQZGxSPaIDy+QouTlIi8fL3scXNJoN5nX9UEc2WOoLbcEJn00qcH9HGlps82A3smMPSOAFiGz2IvQdwjpEm9MiQ/ZawgRRm6NxUfj/rwNFyy95HpO0/2YND7nXeAGH2Oxq9c+CmlOoGwTzwH9DWbXsCkMh89FFRdlXenGbg2e6ft+Fa0e4tYqFLKmeIEdv32W2gLMMG+c5L4/73pLV9hTGfI7kY6FqPksSuSNbYrc2Myanv8GiDcQ2ms9nycr35R4mPf6fMcQlu+zVh8vrzA8o5UWULt3iVuviMpkzOJ4Tdhsh+p9LMbUBymL+6AtMrKylgjcqiJCMGx6HeJ1ywroyWvMct1GTVhFBhylgLC9kzTZSB5wr4cMg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5468.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9885aeac-576c-4e59-c661-08d820e79882
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2020 13:30:33.9897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8XsbMLGGrB9UtaaMmU7gWTKtVmdpIewf2jSSTchIuZN92HPGifkFqMZMpZzULWyRv/MMc5U4ZhYuTAeVrdwmSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5578
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 5, 2020 at 16:13 Oded Gabbay <oded.gabbay@gmail.com> wrote:
> Soft-reset isn't supported in GAUDI. Remove the code that performs it and
> print error in case the user wants to do it via sysfs.
>=20
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Reviewed-by: Tomer Tayar <ttayar@habana.ai>
