Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D26C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 08:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A8942187F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 08:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EL9i9GO6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgAOIUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 03:20:30 -0500
Received: from mail-eopbgr60044.outbound.protection.outlook.com ([40.107.6.44]:51742
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726088AbgAOIUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 03:20:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ns3a1+jenXkR21DDTorj5n6NaIPqwgge9jD2mta1K9YRlNe/XjXgzb2X4PJIQkWVSoMm031QDDU9g7xfDCW1ztQgbB8dJnSBNI3Q8bt3JtAtWv5H38Z+GtWg7zzzbfb8Zx2JLrEkZlBoNXH01v+XEfffxVWCqtvrMCvwrw1Vvc1s+1D6M/qaZRP90Z+m0FVt9KC0wJFRGLB6Rpv2Cbo2lwXg6cXf+DnWdMe9bJgmkzQXSojKIHv9OHZk9pdJT1CuMehmHzceI5QnhoeKXG2WXoXsTuYwE9/M5bv12R0sooATy2nxzAiSCcK8CBZ2f96Hnw6KAGa1k/elj2lSIKClzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8P/1bBsMizf18xKGUvsl7n50Tlwh3qk5JowztDRWSPo=;
 b=Ed/IIyVSUYVm1Q4Xi5I8EVkSOnEvngkG35X251ZQy7H04yL0rTE3cpZw6JhQIoOzGtkmNBK9vYRfXxSzl1vpCK4aC4G2P+9L7TPxjICXAnnhmykadNAG9MbwKWCSbH7Xsm8+uyUQZEDmuFyM46hgUOGEAHO2h66aRzlQ4kfwm2mPZ5HsXDxCcQPlymE4+I3THisAlrlRrJLYJJ4RMFHmVz8tG55pr55LzmyusZKZJvtdVttdJoyLWkWFSl9LRygvS/qtSPclO7OryCQgWr7+AHGs4MmgDgg5cC7Yqnpv4lXPliaCmtDX1tDoHBb/VHFF58TZ3EGcToqwxqEgRz7G6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8P/1bBsMizf18xKGUvsl7n50Tlwh3qk5JowztDRWSPo=;
 b=EL9i9GO6BstgOPlbV7CGt0jC7A6UJ8NU7ByhPSIWr9lkZ3ZSsiKG/WOuwuu4UayVozm2Nldx6pk1mG0hAT1VPTBfZ6A+5JSDoieWr+YPJHkQev6/1HY8ib9ZlLKKX/PAiK/LNPh6H95AJgAEuEEGiqn/Falxfy/IYX1YZoqjkhI=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5748.eurprd04.prod.outlook.com (20.178.117.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.12; Wed, 15 Jan 2020 08:20:26 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2623.015; Wed, 15 Jan 2020
 08:20:26 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH V2] firmware: arm_scmi: Make scmi core independent of
 transport type
Thread-Topic: [PATCH V2] firmware: arm_scmi: Make scmi core independent of
 transport type
Thread-Index: AQHVx5pwG3O6xvtPWkmuLxJSz4SzNKfjv3MAgARqcACAAFI/AIABbf+AgAAIYwCAABTtAIAAAcMAgAFgVLA=
Date:   Wed, 15 Jan 2020 08:20:26 +0000
Message-ID: <AM0PR04MB448109C21B4C6A2C923FF4D988370@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <3f5567ec928e20963d729350e6d674c4acb0c7a0.1578648530.git.viresh.kumar@linaro.org>
 <CAK8P3a1MLyP4ooyEDiBF1fE0BJGocgDmO1f5Qrvn_W5eqahz8g@mail.gmail.com>
 <20200113064156.lt3xxpzygattz3he@vireshk-i7>
 <CAK8P3a2u6s4MAM_9bOqSt5NwVc4XrXs9W36tp-7rWWTXx0+pRg@mail.gmail.com>
 <20200114092615.nvj6mkwkplub5ul7@vireshk-i7>
 <CAK8P3a0jXyJArzQFd+u68iRvXNnXb_oHbWF9-abvvFuqhpi-NA@mail.gmail.com>
 <20200114111110.jhkj2y47ncp5233r@vireshk-i7>
 <CAK8P3a1cByQrhKV=8gRASNy74p8=WKfi1ZU13S2OpFQRjohUsg@mail.gmail.com>
In-Reply-To: <CAK8P3a1cByQrhKV=8gRASNy74p8=WKfi1ZU13S2OpFQRjohUsg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d8b22db7-c830-4d57-fb7c-08d79993c692
x-ms-traffictypediagnostic: AM0PR04MB5748:
x-microsoft-antispam-prvs: <AM0PR04MB57481D30FE80C0078E2C18AC88370@AM0PR04MB5748.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(199004)(189003)(52536014)(5660300002)(966005)(45080400002)(8936002)(478600001)(71200400001)(316002)(81156014)(54906003)(9686003)(44832011)(110136005)(55016002)(8676002)(81166006)(4326008)(186003)(7696005)(53546011)(26005)(86362001)(76116006)(2906002)(66556008)(66476007)(66446008)(6506007)(33656002)(66946007)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5748;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IQCYCVIcllljiKpsiounXCD/3cyu9Jw6oTNBe+pLNyOlj/tMkt7YVOgjNByMB85FSQnPlPUtJMhIaWGzu0zyVsm6FCDtZtJoTzNrYDyBW9+7ZQ8MgyRI1ZkgrcG3imSp4I1h7njkiDWMDL+eCdPgQsEOXu/+1usSzetPFV5QPlCdWXL+lzsfl6SQUQTL6+ISUEc+eR0gYMF4D5pk87YT/7cSsZRaIIxYjhLLIngu7w+Ua+gEtbdNUNv/FfosBZCPM+vr8W/92siT6lcuAQ9oByXAbOH6ASly6fe/WOK8Xox/gabS5qWjQTfpbLmXOYRmcPUdoAOYRqzZ1C9e/3TxUf7KdCcmIGGOrcbiAVXrCo8PqOh/yBjOXgYzjy1TNW5yblnXzuF+srWCRg3iNGlq4rdfjc6h43MXLRN5v+59BS517cJWAIrN7P61zb4ZtFazNvYnIPgkrr3WTHdKTBpnrzUcXgD7ADb7gxbfamodIg4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b22db7-c830-4d57-fb7c-08d79993c692
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 08:20:26.4519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZZTPiKwkSVvuuNWtOtC+vuOvuqjQs1SbGrNfRzvGdUlrZxFuX1TC6LWGHAnURXKCXaCHRmS1xDJWD7D2HRkatQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5748
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V2] firmware: arm_scmi: Make scmi core independent of
> transport type
>=20
> On Tue, Jan 14, 2020 at 12:11 PM Viresh Kumar <viresh.kumar@linaro.org>
> wrote:
> >
> > On 14-01-20, 10:56, Arnd Bergmann wrote:
> > > My point was that you cannot mix __iomem accesses with pointer
> > > accesses. As I understood it, the current version uses a pointer to
> > > a
> >
> > The current version is stupid as I misunderstood the whole __iomem
> > thing and just dropped it :)
> >
> > > hardware mailbox with structured data, so you have to use ioremap()
> > > to get a token you can pass into ioread(), but (some of) the new
> > > transport types would just be backed by regular RAM, on which this
> > > is not a well-defined operation and you have to use memremap() and
> > > memcpy() instead.
> >
> > Okay, I think I understand that a bit now. So here are the things
> > which I may need to do now:
> >
> > - Maybe move payload to struct scmi_mailbox structure, as that is the
> >   transport dependent structure..
> >
> > - Do ioremap, etc in mailbox.c only instead of driver.c
> >
> > - Provide more ops in struct scmi_transport_ops to provide read/write
> >   helpers to the payload and implement the ones based on
> >   ioread/iowrite in mailbox.c ..
> >
> > Am I thinking in the right direction now ?
>=20
> That sounds about right. What I'm still not sure about is whether the cur=
rent
> kernel code is actually correct and should use iomeap() in the first plac=
e. Can
> you confirm that all current hardware implementations actually use MMIO
> type registers here rather than just rely on a buffer in RAM?

i.MX8(alought not use SCMI) use MU(message unit) to transfer data between
Acore and Mcore firmware, not using shared memory.

Thanks,
Peng.

>=20
>       Arnd
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Flists.=
infr
> adead.org%2Fmailman%2Flistinfo%2Flinux-arm-kernel&amp;data=3D02%7C01
> %7Cpeng.fan%40nxp.com%7C1b3e0ec89bde469abfd008d798e36c89%7C686
> ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637145974848395212&a
> mp;sdata=3DPKDDHvz0M45%2B31vSfWCxwxiDEEY8tQxkmL9AzfzRoSM%3D&a
> mp;reserved=3D0
