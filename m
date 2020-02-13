Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F476C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25FEA21734
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ok/SoQiv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgBMJYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 04:24:53 -0500
Received: from mail-bn8nam11on2054.outbound.protection.outlook.com ([40.107.236.54]:6174
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729759AbgBMJYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:24:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guXCiZDcFrVc36iAQN9F32QS2bzGcBjNrtbS3GAOsn6oXuyS/AmNT3/wOs7qaYMUoP3UaBnv3kDt00c3ObaHeORec0IZo3Yf37HJ44113zc5YPDSC0muJbVTGHCLPBKVCm1GY2a6fUsthD8YPuxdK6A4kIV4kbHcX5h0GF2oZboJP6mc2/RGXM4+LA/UZ42HP0hacZ5v8yU5qNn70LmB4JndVkyAFszaJ13PMiN+mIb0YUZHUglGEKB/4Yi1QfLWwR1v9YCO0Pp+G/Jxlpvef3Gns6hjPjhu9ZpH/BZdbEHfUyiudOVpJ4/z7tQClXdnAI5uuqOV8/qfZny3IcHNLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iJFBKobC7IVeQRbUQzh4oDfABUlKPdSt2TcYJE0QCo=;
 b=icUdoqlejok6lUXrAjz9Or3gd0beLlVBKr5JL6BD+KsAVmFni+CnvRBmWrNK3k/cBfDkaIX83gOfEbcWS1Td6k8sgIHs5S+9ieAD85yH/K0RI9VA0It5ta6FnsUkjKBLJUZnmWLzoWmCzIDUszxofZcbkpw5Qc6os922obMGe/yq1Jn+oe0eD2AhW3HGB7uYpxyCJaCxlh8gCRmM/pBHllqnO1+hxhiNpjMMXCgCUSwYK0Zl0aMw8cK0koAblI6CulW2BdykgGhyj6H2FidcN80D5pcUChONwmrxm/YuF8bKtbD6l8QLy632vns4b2QtAjsDKBQ5dsBua4Wn6ZHGCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iJFBKobC7IVeQRbUQzh4oDfABUlKPdSt2TcYJE0QCo=;
 b=ok/SoQivHOPW4L5B64VBghN/atueof9y2pwrPooC7VeXZy895gx6VCCR1wrw+ddQaCWNrPA00QGhKoZ52YedPDz73CnalH9zuDh17MOK79ofANjPpneKGSZcA06AERwV+7ULUp3AtQA+rkvJGk8l65TbHgodnSzyGumutwks3gE=
Received: from BYAPR02MB4997.namprd02.prod.outlook.com (20.176.253.206) by
 BYAPR02MB3944.namprd02.prod.outlook.com (52.135.204.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.28; Thu, 13 Feb 2020 09:24:46 +0000
Received: from BYAPR02MB4997.namprd02.prod.outlook.com
 ([fe80::90f6:4723:69e8:56e4]) by BYAPR02MB4997.namprd02.prod.outlook.com
 ([fe80::90f6:4723:69e8:56e4%7]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 09:24:46 +0000
From:   Stefan Asserhall <stefana@xilinx.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Michal Simek <michals@xilinx.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>, git <git@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Will Deacon <will@kernel.org>
Subject: RE: [PATCH 3/7] microblaze: Define SMP safe bit operations
Thread-Topic: [PATCH 3/7] microblaze: Define SMP safe bit operations
Thread-Index: AQHV4bsPPZw9y+9DiE+r7k7+xry4lagXtZWAgAEaGYCAAAMQYIAABNGAgAACQ6A=
Date:   Thu, 13 Feb 2020 09:24:46 +0000
Message-ID: <BYAPR02MB499726A42B20E172E3787C08DD1A0@BYAPR02MB4997.namprd02.prod.outlook.com>
References: <cover.1581522136.git.michal.simek@xilinx.com>
 <6a052c943197ed33db09ad42877e8a2b7dad6b96.1581522136.git.michal.simek@xilinx.com>
 <20200212155309.GA14973@hirez.programming.kicks-ass.net>
 <cd4c6117-bc61-620c-8477-44df6e51d7b8@xilinx.com>
 <BYAPR02MB499729CFF3B9FD7DDDCFBCD8DD1A0@BYAPR02MB4997.namprd02.prod.outlook.com>
 <20200213091101.GM14897@hirez.programming.kicks-ass.net>
In-Reply-To: <20200213091101.GM14897@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stefana@xilinx.com; 
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 09d4f07d-fb20-4748-ac35-08d7b0669148
x-ms-traffictypediagnostic: BYAPR02MB3944:|BYAPR02MB3944:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB394458E90E5DB914C2B235D0DD1A0@BYAPR02MB3944.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(199004)(189003)(5660300002)(86362001)(4326008)(8676002)(316002)(71200400001)(81166006)(8936002)(966005)(66946007)(52536014)(26005)(54906003)(81156014)(110136005)(66556008)(76116006)(2906002)(64756008)(478600001)(55016002)(186003)(6506007)(9686003)(7696005)(6636002)(33656002)(66446008)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB3944;H:BYAPR02MB4997.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LvtFSX6XOxtnn2dOK8HKGAyfiCIpzS4/XeDEDx8L3B0WolRLHMbQU5clGipjW7Oq+Ma+t3z4fiCohZVIE1ChTjV+vDM4/eAooZXXhT88H9EMxpQQG8YEdRHVet5xcyMMKjZ2uvZibpE8l95XPbSoRat/jeKd3aiR8JvG5mWy1CGBxZEx68dpnSf3sW2TiFs0SwO/tTfnGZzeAdxDbW5tbQxHUwdSxo9LCyNm1wWLoKrLkgZiLMGGttfbU3cybDVUhNMi2IChjcwY6Jvd85DrfslFAz1kV7eWdkmS347r2beQx+sle9gthw51f3yR9LaWKoPRAklVyp7RMPD+Lk/3VkLHdqM4lFOvEaHB4PZYdXv7QabkclfquI2TuLU7YriOafs/ZuOSqeWXRS5sbyoRprIx8O812dbbyKMk6U7iMI2Ae2akUOMjSIhKsLW6IhM5ZM96n0sM4m9LeEa9huMm/t2DKUHkBaoKR5GgabVHe7tfdmNVa61zk5jS8s7mxFC+WDRzGXEVJoaKWhmXoA6I4Q==
x-ms-exchange-antispam-messagedata: wFOgeeTI50NcKIGL9rRSzaero9JBinAzyZ3yeNV/62u3ABskc569HQOCO8VgNmdzKKpcJjh7hF1V11hxhcwK7tlXODcv7GMMQL4j7Gnhn8ZhnRtG1coCrznOHBQ+8USNCARxirWKOF6UEPMGVS8pHQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d4f07d-fb20-4748-ac35-08d7b0669148
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 09:24:46.5517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LDyBXp1CdxOweG4TiPmSCz8/CjiuGa4XMgBUY+JBOfzpmOA9+VK+PX9z+TKMLHZr1lOhsZeXbCX4uhbhVYoscg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB3944
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Feb 13, 2020 at 09:01:21AM +0000, Stefan Asserhall wrote:
> > The comment in the generic bitops.h says "You should recode these in
> > the native assembly language, if at all possible". I don't think using
> > the generic implementation will be as efficient as the current arch spe=
cific one.
>=20
> That is a very crusty old recommendation. Please look at the compiler gen=
erated
> code.
>=20
> We've extended the atomic_t operations the past few years and Will wrote =
the
> generic atomic bitops for Arm64, we're looking to convert more LL/SC arch=
s to
> them.
>=20
> There is currently one known issue with it, but Will has a patch-set pend=
ing to
> solve that (IIRC that only matters if you have stack protector on).
>=20
> Also see this thread:
>=20
>   https://lkml.kernel.org/r/875zimp0ay.fsf@mpe.ellerman.id.au
>=20
> And these patches:
>=20
>   https://lkml.kernel.org/r/20200123153341.19947-1-will@kernel.org

Thanks for the links. Sure, I agree that it is better to use the generic=20
implementation if it is as efficient as the arch specific one, but I don't
think we should assume that it is.

Michal, would it be possible to replace the arch specific code and check
what we get?

Stefan

