Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF4EC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 10:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E092173E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 10:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Aayw+5g1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbgBMKOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 05:14:17 -0500
Received: from mail-mw2nam12on2075.outbound.protection.outlook.com ([40.107.244.75]:47680
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729428AbgBMKOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 05:14:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FoxuLq1bSsAkcqO3ZN1dBwSD5HCDCDOB4/f1wjjdy/8MP06NritXkUPPBx/+JW+fsa3N5aXUEJgQCDaQy2/MtLGkIlZYDkDBD+JZrp/aMVAVHF53pbiXkG5xaHavI70aZny3dbxWcrYWSi6Bd9JANKbHAZPj7aro0ZKMn8gsCvRKFuhO1OcxfPKh4B9sNsgsEpTtEy+x/kFX06CBH5oIQ5NydNM3IDnjjGsu779PjXVzWv2HQ0PvMBxwVZImSFxv+qgOBY+oKemyyyJ5Pw98XAtcNZPpUD0A35FnNhPriSeUsj3yiw8eGTvdk6ITO/RWMAJVysVM83c/zlZiCEtkTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcpEutY11mKb7TYOqmaKRCFzgCRt28DupzMUSHChYRg=;
 b=lkEQ5QUCU7XWZq3stvGzvpQ0VgBRdTmdhALj/td0xlWBDnUVkrD8xZ8AI0o+Z86maPSjwMsH4ZEF0h9OFYwFfEi49hZTY1xbU2mJydRuO5G0+H4T6D7r9MpyzJ4q9Wef/NTI5vayhWk9gAoqAph3It7IuK9RIi3Xxpku3Sj4M4XwXp2ex9ENAJL3Za62tDFvat7R1wr9letZOJ2Dge0CERAKhsdG0rp37ejwPaUMycaHK6y9wOvSvofxpSLfRUIVNIhzKYaEoMhxRWz3ZYVGNbwFDez2sqXSfU3ciNUkr25dqr3OPBWqC0mVCyfNyLVZVsWJxM2DURSzOd7IFkPXbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcpEutY11mKb7TYOqmaKRCFzgCRt28DupzMUSHChYRg=;
 b=Aayw+5g14rZtQ2zcYwN4XSPWPkusldZ7yOI4c/2K3zYpjfuiVyiZTMf8+S1LEJP4xC60me1daTD2L+2mITAzMZ4b7XoQlA5+KurV4+X9H0UAoA8l1kV7fRbRwbjygL9pPT9xS6y7xOIeQ1Zi98r4nMpISrU4fOfAoQKVq8e1yYs=
Received: from BYAPR02MB4997.namprd02.prod.outlook.com (20.176.253.206) by
 BYAPR02MB5527.namprd02.prod.outlook.com (20.178.0.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Thu, 13 Feb 2020 10:14:13 +0000
Received: from BYAPR02MB4997.namprd02.prod.outlook.com
 ([fe80::90f6:4723:69e8:56e4]) by BYAPR02MB4997.namprd02.prod.outlook.com
 ([fe80::90f6:4723:69e8:56e4%7]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 10:14:13 +0000
From:   Stefan Asserhall <stefana@xilinx.com>
To:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Michal Simek <michals@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>, git <git@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>
Subject: RE: [PATCH 7/7] microblaze: Do atomic operations by using exclusive
 ops
Thread-Topic: [PATCH 7/7] microblaze: Do atomic operations by using exclusive
 ops
Thread-Index: AQHV4bsTNSWG8PcZ4UGUKf7UEuD+JqgXthkAgAEPaACAAA6lgIAABQqAgAANMICAAAERUA==
Date:   Thu, 13 Feb 2020 10:14:13 +0000
Message-ID: <BYAPR02MB4997A184EFBE4DA755BA1C1CDD1A0@BYAPR02MB4997.namprd02.prod.outlook.com>
References: <cover.1581522136.git.michal.simek@xilinx.com>
 <ba3047649af07dadecf1a52e7d815db8f068eb24.1581522136.git.michal.simek@xilinx.com>
 <20200212155500.GB14973@hirez.programming.kicks-ass.net>
 <4b46b33e-14ad-7097-f0db-2915ac772f15@xilinx.com>
 <20200213085849.GL14897@hirez.programming.kicks-ass.net>
 <20200213091651.GA14946@hirez.programming.kicks-ass.net>
 <20200213100403.GA1405@willie-the-truck>
In-Reply-To: <20200213100403.GA1405@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stefana@xilinx.com; 
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 78a856f4-36c9-4aea-9d6f-08d7b06d79c0
x-ms-traffictypediagnostic: BYAPR02MB5527:|BYAPR02MB5527:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB5527231371F52EC8E0ECB591DD1A0@BYAPR02MB5527.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(199004)(189003)(110136005)(54906003)(5660300002)(33656002)(2906002)(316002)(7696005)(26005)(186003)(8936002)(478600001)(8676002)(6506007)(81156014)(81166006)(55016002)(52536014)(9686003)(86362001)(71200400001)(4326008)(66446008)(66946007)(66476007)(66556008)(64756008)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5527;H:BYAPR02MB4997.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mpBU1F4BaWDIVqN2lRhObMbuWHYizRVTrLld9AhIAMD+8x0Az6hw+OhpiUvTL9e6X7ZoOyeEVj4cmaceChMTUj/eN4v5CkNVplxUKnDUzUYbXgfrA7vgKzJfcG4ZpTIdUVZTqvYdX0EweK6nHpQ+1rTZqfbyHIk4deSfzVHV+w5Sx53gvzvjjxrbPs69YRFklpo53io8lArGklWa3HqP9BSqAS0QMiMuluZq3OJvz77/D3kt7xnYAXKAPvU6las5tgi285tB2mCrOD6cvCvQKB7nxQMQflBzIIyUB5T2ghNUC0CC4/BZS5Xpj2+KocsWVQPS7GFdYmRYCJkvCjG/Fvf48RBmu6RE2o7WIAIIm60RsoKeySy8ca6qiJKrQAgtO/WyWo3ao3c/UTr5XeqtWIpcCv6es8MgLq/sHjYRi1iTqGZR+qxCrBSvrbSt7okN
x-ms-exchange-antispam-messagedata: 68XhAwcVZ+2WWl6zkN41Lojb76GG8GDIUlTmMg0D+kuvZWpIt8wtVIPBcFrU+NYllSuU5sv66Ai7jDHVByawPKrKN7rOx3SVI56KPPB73SEOc2cpq6LlW9NQBayHs33vA/r4hGWPYTYpU9LXF0n3hA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a856f4-36c9-4aea-9d6f-08d7b06d79c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 10:14:13.4915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W3OvXa6MsxSAYjUVBq+2oJa8n7pmV7iA9/jJa0DO8cSOlfDDs9WNqhDldEYZy7k40EDoX+9toFn3zH56N9Rnkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5527
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Feb 13, 2020 at 10:16:51AM +0100, Peter Zijlstra wrote:
> > On Thu, Feb 13, 2020 at 09:58:49AM +0100, Peter Zijlstra wrote:
> >
> > > The thing is, your bog standard LL/SC _SHOULD_ fail the SC if
> > > someone else does a regular store to the same variable. See the
> > > example in Documentation/atomic_t.txt.
> > >
> > > That is, a competing SW/SWI should result in the interconnect
> > > responding with something other than EXOKAY, the SWX should fail and
> MSR[C] <- 1.
> >
> > The thing is; we have code that relies on this behaviour. There are a
> > few crusty SMP archs that sorta-kinda limp along (mostly by disabling
> > some of the code and praying the rest doesn't trigger too often), but
> > we really should not allow more broken SMP archs.
>=20
> I did find this in the linked pdf:
>=20
>   | If the store [swx] is successful, the sequence of instructions from
>   | the semaphore load to the semaphore store appear to be executed
>   | atomically - no other device modified the semaphore location between
>   | the read and the update.
>=20
> which sounds like we're ok, although it could be better worded.
>=20
> One part I haven't figured out is what happens if you take an interrupt b=
etween
> the lwx and the swx and whether you can end up succeeding thanks to
> somebody else's reservation. Also, the manual is silent about the interac=
tion
> with TLB invalidation and just refers to "address" when talking about the
> reservation. What happens if a user thread triggers CoW while another is =
in the
> middle of a lwx/swx?
>=20
> Will

The manual says "Reset, interrupts, exceptions, and breaks (including the B=
RK=20
and BRKI instructions) all clear the reservation." In case of a TLB invalid=
ation=20
between lwx and swx, you will get a TLB miss exception when attempting the
swx, and the reservation will be cleared due to the exception.

Stefan

