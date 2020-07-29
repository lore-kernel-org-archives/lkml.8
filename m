Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C07C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D0AC2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fJIzZ43g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgG2Iuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 04:50:40 -0400
Received: from mail-eopbgr30060.outbound.protection.outlook.com ([40.107.3.60]:46250
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726299AbgG2Iui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 04:50:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpXZlEvscJW35Tt2E0OwUM7h1p1JImpYaQJmSqC9lMunbpZVYRDeeK9oFS5koTitQ+xpL4bq+EWKDc0qxya2SUeeshj8Shiu/uRyKcANqxi03rqJ6hbVXXaELUBcImdtg87r7qfCNpaFvPr3OlF4MW6IJmAHYCMTQwZZjorDz4amvcZQyFMULqELa6g3YjAmqI5S/ouPaLziNhyJgPv1Z25E4kTc/GFJVtMLIp+fIN+3G93kF8OPI9wsNNRXOd37ZpM5gVD97olWocFzdY+yNemUnOvEyL4dI8kMk9VVRAQyfCDucne99QpJAcdaCMAOCkcsoDRN//0nzOzZPKg9KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhFejhIxGdZhK17F0ZpEnL62leryHPLWPc7ocY5vRFo=;
 b=I3QTvqj9kmQZgWNM+a9gVPqYKgNdT+mjB3PtYRiTNYqbdoZd9fItJ3XTWb0ETsdO19ViPuieN73IAlBx6k0N3BeFEVCshs+6mwpE39oz0jiZdp1YOdInzTaKe3TMB3+k8KlYhaCDY1y9I4oVoqt7IC/wai0O6atd3okxngAieAS5tiFbx5afbrsFU3D2hl3fcsDzBLc302zznvZ/0jz4xI5VtOTLr+0bH1tNFJFhSnUt3OrAT0veUcFYds/HaJ7jihkpwdVHAAJrnhvRSGaXsJ52mxcBmpy1DmPzAnw4pzGrbS7mPfXny5c1L3A4OFbUmvkUT80ExWWrW23wdvAlUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhFejhIxGdZhK17F0ZpEnL62leryHPLWPc7ocY5vRFo=;
 b=fJIzZ43gV3WEFuLAdwR5Gr65IX261EFDokBZINM6ljnWCEKRbY3bqVWY4kdZfFoENJ3ovjSnrc4/1A5RhhXlf/GPcdMnHm1Ncb6QyEEyfHNSIDUsy8uTJZXa9lMScmTG1xR4/MRyYR5u7aSzegcZyVvAzEFsPvGmAwhDkT/6rFU=
Received: from VI1PR04MB4062.eurprd04.prod.outlook.com (2603:10a6:803:40::32)
 by VI1PR0401MB2672.eurprd04.prod.outlook.com (2603:10a6:800:58::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Wed, 29 Jul
 2020 08:50:35 +0000
Received: from VI1PR04MB4062.eurprd04.prod.outlook.com
 ([fe80::cb8:55e6:977d:605a]) by VI1PR04MB4062.eurprd04.prod.outlook.com
 ([fe80::cb8:55e6:977d:605a%7]) with mapi id 15.20.3239.017; Wed, 29 Jul 2020
 08:50:35 +0000
From:   Alison Wang <alison.wang@nxp.com>
To:     Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "mw@semihalf.com" <mw@semihalf.com>, Leo Li <leoyang.li@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: RE: [EXT] Re: [RFC PATCH] arm64: defconfig: Disable fine-grained task
 level IRQ time accounting
Thread-Topic: [EXT] Re: [RFC PATCH] arm64: defconfig: Disable fine-grained
 task level IRQ time accounting
Thread-Index: AQHWZVrWlVBnE4g2BE+iW33DuXlKV6kePR2AgAABcIA=
Date:   Wed, 29 Jul 2020 08:50:34 +0000
Message-ID: <VI1PR04MB406286E9BF44AAE1339D2174F4700@VI1PR04MB4062.eurprd04.prod.outlook.com>
References: <20200729033934.22349-1-alison.wang@nxp.com> <877dumbtoi.fsf@kurt>
In-Reply-To: <877dumbtoi.fsf@kurt>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ea59d1ee-6240-4d60-0f4d-08d8339c7571
x-ms-traffictypediagnostic: VI1PR0401MB2672:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0401MB267262385C24123F7B949302F4700@VI1PR0401MB2672.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XUI+HXm5m1d36poPiXGykXMFF44X6IBhknKcDH89dD80gg/3kVYjAB1pnizUEPww1J85TxbXgLTa+npe+4VHsjD30ka9357C5AGo/EdfRydePYuwR/DTVbWr962ZjevVbayRP1DEs/vHdFgMTi5PeR31tfkB59gRIhnuE43mtLfJ5c3C+Q34L9lmahWCYN7wXxVsgTF+Bxud7tCmmiAa0knvQeTdeD1lvays5IczaFnfDpnYdUMBeU1+PPiPCV/Oko/IwnEEDUO/iBOvEDVzOBRomN3vgakZHi95qNmI0di+X+BrjJk16XhIWKdA06ZT/SOlHCfIcUc7WX/1R4LfeA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4062.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(5660300002)(478600001)(26005)(8676002)(66476007)(66446008)(66556008)(86362001)(4326008)(66946007)(64756008)(186003)(76116006)(52536014)(7696005)(4744005)(33656002)(6506007)(110136005)(2906002)(44832011)(71200400001)(83380400001)(8936002)(9686003)(55016002)(316002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: dQcdqwFFWIxqeZvEKfoALoawctKppvMjC95U6Lh0tSH68HgqRydFTrrIMwqQoQ6F1toDT7ZmLVmm/L48eXqUJxCwlSw19OQUD/WoAQmriA2EdD1GdVKITgbUNva5sFIlxPdMtUfaZYcVyFw3rRQfSndPbqnUn6TqBsl+nTsmCkK6asG80+nc9Y5+EeGfXVhvmin3gwBlrc32wIDuFs7LuuZleMM7MYmHLBxdW9ajvvhvFVz8YfJEnwEI1Mrrgs3Z5o1ruY6jKM9GXQRR3q6fd7dlxLiSY30BgP5KQYed9hHHPDMYrAB1ELVDlobJ/QqLHZbqeDSb5GKxfPkf1zUuTsrEYM+zX/cC+XpGTuKpO2mdU5cl0KqV2J9+kVU6Ua/iNZc01I7iU++o3eAzzrKlAuqynjuFPn+JYu1KBYctSamSSZya5qNoS6SP8T/FVS8v/8SCPSQx+apu9k7fWEmCP3Ei3E7I/aRYV10+C0YXn2I=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4062.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea59d1ee-6240-4d60-0f4d-08d8339c7571
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2020 08:50:35.0434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ip0hWZqbxQLvRboTnOoBx8Y6qqfYdvfyBPz1SOw6PqZYeOR5LV7vMvD/JmDLUHnCbksBLyYldsBYXIeiyD/U3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2672
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Kurt,

> On Wed Jul 29 2020, Alison Wang wrote:
> > In the current arm64 defconfig, CONFIG_IRQ_TIME_ACCOUNTING is enabled
> > as default. According to my tests on NXP's LayerScape and i.MX
> > platforms, the system hangs when running the command "stress-ng
> > --hrtimers 1" with CONFIG_IRQ_TIME_ACCOUNTING enabled. Disabling this
> > option, the issue disappears. CONFIG_IRQ_TIME_ACCOUNTING causes
> > serious performance impact when running hrtimer stress test at the same
> time.
>=20
> I think instead of disabling the option for all arm64 devices, it might b=
e better
> to analyze the root-cause why the hrtimer test hangs when this option is
> enabled.
>=20
> +Cc hrtimer maintainers: Thomas and Anna-Maria
>=20
[Alison] Yes, I agree. I hope others can give me some clues for the root ca=
use.


Best Regards,
Alison Wang
