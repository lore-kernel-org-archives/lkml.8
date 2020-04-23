Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F3BC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 468C32084D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rznHgGB0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgDWKvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 06:51:40 -0400
Received: from mail-am6eur05on2078.outbound.protection.outlook.com ([40.107.22.78]:29632
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726990AbgDWKvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 06:51:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jusp4tEhyh77iiACfNUhKizeQ5sPd167roB6uwpfJWpu7F9hk1RSF81pLcyF8Hd9STsZIzzvkfXIFhpmzsU7IpJKNwHY+2qSwnjEkws3ol40AXjxgRvRHwvh1DMIFTSXEiWefQ0UEbq+EBBjJA5nLWhmG+NHN18v+5nROKIPoWxjUYnn8Z8M7P//ivhAt85Az+4dA91h6QtWn6Ys3Q0JO6MDTcg4aj02Dgt/HTaBH1hZE/Y5tpcReMKQZlv+KfajlWe2BbfRl/hXGjRrCU+9b9nzFXcrmUHpKUZiwvmM3aHq4g5uvGEncJ4rkDCzzFs0FrS7xuVtoTgOxybSfwFxiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEYnGEOJKCkEHztHpLJWpRgoCjknrwGJa+Ru1g2UInA=;
 b=WrFfyWPXuC2t7lk2DSFX/GITCN+gkUozeCEv2oJLh11JyewRQ6OGwwxZBZaa62JtuJ8OlfF47QSo6hpNjAf+rK1uvO2PFtdGNfvS6GRUFzxQ4SmlLkTGevPZ8n9R39OsUP6O0znF9CucR+yBo7aS+evEE4xby3c2dYebrFyL3+ux9mMSY97uipNnVEOKmBE2Hyxjbawxy0zKzT2RwQVK1m98za3wOZGdQcvjahSs0DAQVeTdTwjN8wK4x41awwl2WckQxDFvoz6qRg2M/s6SR0Hroeoy3WW8C3OKfHsYEsgECZ5kqOpWLs5RnZARw6phw9383+Pflt/hnaDAjJfZjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEYnGEOJKCkEHztHpLJWpRgoCjknrwGJa+Ru1g2UInA=;
 b=rznHgGB0lbTN2v3qOdsceiYqXsoaZEm6S0djUEpaa+t0/TJnXyIOtDz8msJKvZ7YoPtNzdt7oPmnYd/S++gUJldMAdWd1KduFsBFJ3mLKKbfeG+DtoyvUXHtHzA6rutenMZtGrYc+R9e8WzUjEiR/HvLKfqLYKfCCeANDYXohUo=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2757.eurprd04.prod.outlook.com (2603:10a6:4:94::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 23 Apr
 2020 10:51:36 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 10:51:36 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: RE: [PATCH] regmap: mmio: prepare/unprepare clk only when read/write
Thread-Topic: [PATCH] regmap: mmio: prepare/unprepare clk only when read/write
Thread-Index: AQHWGTO9B+V6d2Mrk0mLlfc3ryCDK6iGhKwAgAACseA=
Date:   Thu, 23 Apr 2020 10:51:36 +0000
Message-ID: <DB6PR0402MB27600084E4A040609EF620A088D30@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1587620791-5279-1-git-send-email-peng.fan@nxp.com>
 <20200423104000.GD4808@sirena.org.uk>
In-Reply-To: <20200423104000.GD4808@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 63766426-514b-406e-40c6-08d7e7744b91
x-ms-traffictypediagnostic: DB6PR0402MB2757:|DB6PR0402MB2757:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB27573BF00C62D058316D1DCA88D30@DB6PR0402MB2757.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(86362001)(55016002)(8676002)(66476007)(66556008)(64756008)(66446008)(81156014)(478600001)(76116006)(52536014)(66946007)(54906003)(8936002)(7696005)(4326008)(316002)(186003)(71200400001)(5660300002)(33656002)(4744005)(44832011)(9686003)(6916009)(2906002)(6506007)(26005);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wa2slidC5VHI2jTESx2cSyGwlgmaRjSkqx2nNJjvORhvGKv58sJeCO07TTTyvfoK/WoYTF118b3lkLlGf/a42OYo9DoQflmUoaq9HmbpWOZEG/wdp/n9F7cgDuBJKcxOxhUcIkFEuAm0NBt532MvxW/IOO8jNzhgXEWUM8UKO1EHICvFG/Toqll1WV2gdS7Yi8sA5loK0nEn1vrnaHVLTop7eNmbChoEPieA+KEEpbBYyp8B09XwV9Pcl102xrfe+0zu+IQN0qnLqG//d/rSxpr02FGRWom9LFyRS4sVmzC0GHMqkw2o58WcuNthMqsfKLh8om2K6f+1SGbS2Mp3bmHbD/fOZfASA8nIPPZC79yTaprn0Voo4+jNsP3QEsHz9RLYBcyxiKp5cXHMr0L3OX5W4FIvgSVDGatnK7qfhG96z5MXVDbBcAGisHYNC1Uy
x-ms-exchange-antispam-messagedata: 2rkGirLxnNVsWpVS9pQLxyl4SC3YGS7duOZgGRZztra7rHsmG13l3B0VOIhy5kDImQDuInCDUnkLA6m/FKP/PZJoHYNmUZiUqF8vlm7fewoYjmB2lAcV4LSn/2cUKTYjZvtOs8JYt2o6jPwMljNprw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63766426-514b-406e-40c6-08d7e7744b91
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 10:51:36.4368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xv9ziboUo/Lmdv+/aLH477C4hWUv7+T/VnkoOoWmOmxLUjEPKN2nTY/qyoiT+PL2yRV4qLuybvFvt244ZoOKEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2757
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH] regmap: mmio: prepare/unprepare clk only when
> read/write
>=20
> On Thu, Apr 23, 2020 at 01:46:31PM +0800, peng.fan@nxp.com wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > use clk_prepare at the very beginning will invoke pm runtime resume,
> > if the clk is binded with a power domain. This will cause runtime
> > power high. Let's use clk_prepare_enable and clk_disable_unprepare
> > when read/write to avoid the runtime power issue.
>=20
> This will mean that we're doing clk_prepare() during I/O which isn't good
> since for MMIO regmaps we support I/O operations in atomic contexts.

Ah, yes. Do you have any suggestions? If we use clk_prepare at the very
beginning, the power that binded to the clk device will be always on,
and cause power consumption high.

Thanks,
Peng.
