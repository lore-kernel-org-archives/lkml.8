Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8285FC33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 06:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044CA214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 06:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nUG955hD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgAMGpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 01:45:39 -0500
Received: from mail-eopbgr80043.outbound.protection.outlook.com ([40.107.8.43]:35715
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726399AbgAMGpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 01:45:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXT3NxssAkyOQauTEZknust8+ISQIoCkcTLTnPm5lgJI7TSWyvnlP+44TjGqAUZCUhQ3GSwMB3RZ6qjtbzdlH0QjOckXql6pARWJ/9T+vLJwVofLwpW5nLFyk2V2wwCfG99MtFdkjE5wPI7+UhWoDOBNHaYzfhWbLRhn38nsqfYNi8cP5lBrZMbpozke5Oar52k4EbAaZ+Du6wHJo4GDfB/lFr2jM+vXMMPHCe3aFzhXuwoSstFXeWWfL/WlOahUlVaCGkKmaaN+y66M3R2NDDpfgzxGFI2uAmIjeq5MBXJAPckAwKx/M+mmacrwc1VucqqQn74kxR7D3QJNFAIEUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AqYxbeUjev659w2GF9CDhC1hBk4wSIEV3nAm3LD1e8=;
 b=UjZy6Coo38kp+KywMFravV2eYxvm9AL6b5kjFjsaPaZuS3NCbFKCAmH8sdk3wQIamRxpV/M5rk8v4Q2r2foSLZC2IKsf1qegkZ7NiLaTbqkcZhDZQMgl8VFGlDM/6I1LNZ0oNbLV0K5fQkMYR4zN4tK4GrYoCstXJw3zV27wRukj6NZ5lETR4/tD+F+5eHsGjcl0Z/iB5MzhtEP/dZBdoIKjCkgOvVdOiFnCor1DiYxThVShQ4kpcmImuhR6Zu9PM2eRfj/BLhKEwhUpyiA0CRoDwP87DwzFdHjKseu4KwNHWS1K/hlj65D9mWjfpBG3F+FFtloLGIJmZl3eUgOvsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AqYxbeUjev659w2GF9CDhC1hBk4wSIEV3nAm3LD1e8=;
 b=nUG955hDbmcAWlTxnW92AI+CD7MXizVJdL5e8mzJavKiJrHrwmh03LiB+VaxvRU/XiudFK6WMcsE0i18e/fk9rySovwiT2OWtTY8uARXXC+BXEU/uRvzPblIDJS4jzkrctbplFxMYeH7RYI4rv471HnScqaEcrbpAWMmX49hGuI=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4498.eurprd04.prod.outlook.com (52.135.148.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Mon, 13 Jan 2020 06:45:35 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 06:45:35 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] firmware: arm_scmi: Make scmi core independent of
 transport type
Thread-Topic: [PATCH] firmware: arm_scmi: Make scmi core independent of
 transport type
Thread-Index: AQHVppfygI23RUpETUWFTxolQ+nTs6fiPXoAgAAVYACAAcKWgIAEV0ng
Date:   Mon, 13 Jan 2020 06:45:34 +0000
Message-ID: <AM0PR04MB448197C42958AE684D021FE288350@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <5c545c2866ba075ddb44907940a1dae1d823b8a1.1575019719.git.viresh.kumar@linaro.org>
 <CAK8P3a3=q2zX9xQo7eZKp7e70rAeNB8VoSjg2aE06QJuSw8y3Q@mail.gmail.com>
 <20200109093442.4jt44eu2zlmjaq3f@vireshk-i7> <20200110122725.GB45077@bogus>
In-Reply-To: <20200110122725.GB45077@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c2d4186f-beee-4089-8480-08d797f4313b
x-ms-traffictypediagnostic: AM0PR04MB4498:
x-microsoft-antispam-prvs: <AM0PR04MB4498BA22702923F212DFC4A888350@AM0PR04MB4498.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(199004)(189003)(8936002)(8676002)(86362001)(9686003)(26005)(186003)(55016002)(44832011)(81156014)(81166006)(5660300002)(53546011)(7696005)(6506007)(52536014)(4326008)(54906003)(71200400001)(66446008)(76116006)(33656002)(110136005)(316002)(2906002)(478600001)(66946007)(66476007)(66556008)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4498;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gd2ItDIT2UUcY4WTxKUfUEWTTf8FiQhWhuD6levtnaizW9oPTAT9HAMpb50f7ESAhno5bsEpRTiQ/CdCmewnbWmaLBZ1ylOP0T5gLoCzhq+dTO0IDRIsqWk2GcwO8XtNck/CVkNzuQ0h+QhE9RYzpGA5dTsECgDtZFyX3c94mg7h2lqC/8x+78yqkLsbjZgH6PtWZjHHPcMRGJt+Cj+NexOjMZLiixAorqG1su3Nl2nke4ZJ5uephAkQ7FXFZwWx9jYRsZe0aZ+Ht9iAbuUqjVooYRujqgDiATd+WTpGifvGsU6Ku5ajv9CoX/H0ZZjFSXadYkddli/pEc7T4sU0kUBVeu3kt1fqQCiynCstO4XWnREF5V7J+khW9bPCa6M5kqCP2GX1cdoJtpHBsxLwpxvnxPgaTY+Njz27URhkkCnun1jaZMR0DnjOpZTeZGWx
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d4186f-beee-4089-8480-08d797f4313b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 06:45:34.9193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VDW2P+WcDxt0tuD/d82bvnw9DX8ZJHoHFIDO8rlCsjlFKK4/YzdbtUXB+w5ilGNrCFEepvnCWIK+6W/0lR0GZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4498
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

> Subject: Re: [PATCH] firmware: arm_scmi: Make scmi core independent of
> transport type
>=20
> On Thu, Jan 09, 2020 at 03:04:42PM +0530, Viresh Kumar wrote:
> > On 09-01-20, 09:18, Arnd Bergmann wrote:
> > > On Fri, Nov 29, 2019 at 10:32 AM Viresh Kumar <viresh.kumar@linaro.or=
g>
> wrote:
> > > >
> > > > The SCMI specification is fairly independent of the transport
> > > > protocol, which can be a simple mailbox (already implemented) or
> anything else.
> > > > The current Linux implementation however is very much dependent of
> > > > the mailbox transport layer.
> > > >
> > > > This patch makes the SCMI core code (driver.c) independent of the
> > > > mailbox transport layer and moves all mailbox related code to a
> > > > new
> > > > file: mailbox.c.
> > > >
> > > > We can now implement more transport protocols to transport SCMI
> > > > messages.
> > > >
> > > > The transport protocols just need to provide struct
> > > > scmi_transport_ops, with its version of the callbacks to enable exc=
hange
> of SCMI messages.
> > > >
> > > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > >
> > > Conceptually I think this is fine, but as others have said, it would
> > > be better to have another transport implementation posted along with
> > > this to see if the interfaces actually work out.
> >
> > @Sudeep/Vincent: Do you think we can add another transport
> > implementation something right away for it ?
> >
>=20
> Even if we don't add new transport right away, I would like to see if the
> requirements are met. I will take a look at you v2 with that in mind anyw=
ays.
> We need not wait, we I want to see people think it meets their requiremen=
t. I
> will also add couple of guys working on virtio transport for SCMI when I
> respond to your v2. Thanks for posting it.
>=20
> > @Peng ?
> >
> Peng, Did you get a chance to try this with SMC ? If SCMI was the only
> usecase, you can try this approach instead of mailbox, now that no one ha=
s
> any objects to this approach conceptually. Please use v2 as base and upda=
te
> us.

I will try that, but might be a bit later.

Thanks,
Peng.

>=20
> --
> Regards,
> Sudeep
