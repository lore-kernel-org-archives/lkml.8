Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1800AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 06:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D83A720656
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 06:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DCEMUVX/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgHMGDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 02:03:18 -0400
Received: from mail-eopbgr30089.outbound.protection.outlook.com ([40.107.3.89]:8773
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726249AbgHMGDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 02:03:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCa0yOI3nhQ/9tnHtWQOmK3MS0XMOb4mz3utBOrqZT8D4hGcR1a6z9Lb8bGvf8ypXf9d7RhCJu+DpVIGSxpzUPuWoFJ0kadBQEWPSNWekNj1Smb6HnNcnO1/XirwtUFIm0JaLsNTn9v6a4xCQnaDFWEN/r69oWmPGUsCdntGc3+qGGLMF0Nv0IUhbbu5NuaSHwkwjx42iBeAuIlWohoIJmmW7wpoR+xxEZTBs7nznXF2AjZ8JnonlysWcW7vtOQQ2r4X7XBrjVfolwShiadFhs7E1NBwNpYwYl4WcMgSv7SX/lbwlJnBMQEoG1HBpx1Z5syyr2CQxVyAYI9TNTBthQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toDH1hd+puHF7bRmC91/5vX5y2gg7cCwI3Tq7tli1po=;
 b=SHgm5fz3hyKoD4+UsO3OHvrIRFSZfriPoRxOvb1v3tk2tjODtHRW/yAdPnalmVjEqjBElyFYaml40xISYmT2qfoOvQFrimq+OLgfQE2srr0zOF7B943fz6MKxbM5Ch0QvG1ZXp4Nm5JnGBMa7BUdaeLFASjuhPOtQym5ZMWnoIT+GY9RywObjBRoOf2IMFYyW74I2DGVzToor2l+LPTJT7xn8SOaHWcWM2nJDKAw396VDV788Z/fg/4v144XLKVh2y7P+4bEQgqDGEH5ZRU6ZjhZmbz9t/fF+2wC1F5zPxikdPLSVwF/x/etvCUS+QJljHGE96sIpxpvfKqeerJ7Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toDH1hd+puHF7bRmC91/5vX5y2gg7cCwI3Tq7tli1po=;
 b=DCEMUVX/8fYthcIM2LQ3SflydsKxlfRYFIbcDuEd21XL40D+bSvd136UdG3zgcWGPVDGYpxOc1PXetLExod6QwlTfcNnN6pIfbppLAGmHwVGEcGmUoJVDh8CCmWdpBsaFO/3g8uwAK5/hkV79NHwhrxVAni3WQoJ7oDBEBRv6uA=
Received: from VI1PR0402MB3824.eurprd04.prod.outlook.com
 (2603:10a6:803:22::18) by VI1PR0402MB3598.eurprd04.prod.outlook.com
 (2603:10a6:803:a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.24; Thu, 13 Aug
 2020 06:03:13 +0000
Received: from VI1PR0402MB3824.eurprd04.prod.outlook.com
 ([fe80::5045:2f5a:2c65:c38c]) by VI1PR0402MB3824.eurprd04.prod.outlook.com
 ([fe80::5045:2f5a:2c65:c38c%5]) with mapi id 15.20.3283.015; Thu, 13 Aug 2020
 06:03:13 +0000
From:   Jason Liu <jason.hui.liu@nxp.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Sudeep Holla <sudeep.holla@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/1] arm64: kexec: no need to do irq_chip->irq_mask if it
 already masked
Thread-Topic: [PATCH 1/1] arm64: kexec: no need to do irq_chip->irq_mask if it
 already masked
Thread-Index: AQHWaj3ZMAA/XWH8SkmG3qCWNnZEoaknx/iAgAALMQCAAQxYoIAATcYAgAGqTLCAAC1PgIAKk02g
Date:   Thu, 13 Aug 2020 06:03:13 +0000
Message-ID: <VI1PR0402MB3824B4D3BF37335FE48A12F1AE430@VI1PR0402MB3824.eurprd04.prod.outlook.com>
References: <20200804085657.10776-1-jason.hui.liu@nxp.com>
 <b4444c737f9d6fd8fd99dbb809d35a0f@kernel.org> <20200804113850.GB15199@bogus>
 <VI1PR0402MB38243230C51FDB1C3F490853AE4B0@VI1PR0402MB3824.eurprd04.prod.outlook.com>
 <3c63ae0cc3a7b5bad5d4638a9870340e@kernel.org>
 <VI1PR0402MB38249815EA37338953E8AAC1AE480@VI1PR0402MB3824.eurprd04.prod.outlook.com>
 <1e4496c263e486be3438f2797630164a@kernel.org>
In-Reply-To: <1e4496c263e486be3438f2797630164a@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f928ba6e-84af-46b4-f232-08d83f4e9097
x-ms-traffictypediagnostic: VI1PR0402MB3598:
x-microsoft-antispam-prvs: <VI1PR0402MB3598D03E800E82EDA31CC683AE430@VI1PR0402MB3598.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FvHbKXrEVh76iZgq6wCnZA9Bmt9jAb9SH28vifvpZei7ok2Do4dbgS9xbfnlf9V/3Z4eFZRMYJO/LhR8iXffS2vM1+/K2fSxyXOadSORYQQrIMhkwFKhsrlfd/TAcDN8/x7vL295s5B0lXMREAZjLU0cK4/vkT0Yx3r0C7nm4zG1oGdehTcSHQToxcoGX5qpclDmzpAlpiiciOm81KVc1H99IQ1eyGOaJ78ttB05wXYy9/zesZGS1tuJhkTyOCPo8kr5hExYSZJzJlpWrJPiULSgG+DxgH9R+pXUlD6qONpDMI65gmaih99U2L6uSCbgYUkiBe0DDAr8bXgBkuSoBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3824.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(5660300002)(4326008)(86362001)(52536014)(8676002)(71200400001)(26005)(6916009)(6506007)(53546011)(83380400001)(186003)(64756008)(66476007)(66556008)(66446008)(7696005)(33656002)(2906002)(66946007)(9686003)(316002)(478600001)(55016002)(54906003)(76116006)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: PzgmTkjKxlNqE2WXRY1inpdZecyzf96wwHniDlWVaxbLVfSRil0BFV9hpJQrAfTj3jvJPqywgtsEdCpKdtAPJTRBExskiegXD+YJCplZgUOEVCozzokcPn0W1sg7YepoxwhEMfu9eSqVCxWfr7CSDUCWtyPeEvlwDb2s05LFOX523hoMFGj5ekMuJ8LhaWjL5ggcnLnK5Un8Npyy/7ANKytzzEmJpLh2pRLk0b/G9Q+eXN0OsHemr7BLZMjAOOEjL6IVQdkGTvjjZTYVhOaMjs4qJwl4+f82Yp4+yyTH9JYlw+J0HGTBddWncRTEg4kj0c+Gdr2aS/5u0mdp2aFx+AGSioeewezxA1PptCG//QdQnqgFb64jzOb7r+lmxwVFzPMTcBn7ll+g9xv7jaGJE2wB1dxS7BQ1qfkWf8akHwlH4gR7bq6IpEIkZcpxluzZOL2BIVOdXfe55NIYTlwfCQY37xfmNVgarHT6/O1gC/d1CEaF5AEBmLyAtOSfad+ua1/R1BHxCaCDq3DBntoetsWJ+Ji8FOOD2tg/7Lwlnhg+9txw8VbxQ8FfVi4p5MiKMs9CNrDet8Kx2GP2qbI2CFs25giAi2K3pbR9HyGlurGM8bhOdq+rq5cM7oHnxdL6x68bU6K2peVchqaJZdgbfw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3824.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f928ba6e-84af-46b4-f232-08d83f4e9097
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2020 06:03:13.7671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QBwELqBt7Oarl9XgtALNqrQ46Iyc2Q4rELL2QGEGUJwow35Dd/L07Ne2K3SPIkoMz48WUvYv87maPSjRmTB9fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3598
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Marc Zyngier <maz@kernel.org>
> Sent: Thursday, August 6, 2020 8:26 PM
> To: Jason Liu <jason.hui.liu@nxp.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>; catalin.marinas@arm.com;
> will@kernel.org; sashal@kernel.org; linux-kernel@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 1/1] arm64: kexec: no need to do irq_chip->irq_mask i=
f it
> already masked
>=20
> On 2020-08-06 11:05, Jason Liu wrote:
> >> -----Original Message-----
> >> From: Marc Zyngier <maz@kernel.org>
>=20
> [...]
>=20
> >> > No, this patch is not papering over a much deeper issue in the drive=
r.
> >> > This is just to make things better for the ARM64 kexec.
> >>
> >> Yes, I'm sure it is... However:
> >>
> >> request_irq()
> >> <goes into suspend, panic somewhere after having turned the irqchip
> >> clock off> if (chip->irq_mask && !irqd_irq_masked(&desc->irq_data))
> >>      <explodes, as the interrupt isn't masked>
> >>
> >> This is because the PM in the irqsteer driver is completely busted:
> >> request_irq() should get a reference on the driver to prevent it from
> >> being suspended. Since you don't implement it correctly, this doesn't
> >> happen and your "improvement" doesn't help at all.
> >
> > The request_irq will get a reference to prevent the irqchip from being
> > suspended due to it call irq_chip_pm_get(). I am pretty sure we have
> > implemented correctly and that is also the common Linux code.
>=20
> Then it seems you cannot read your own driver. At no point do you set the
> parent_device that would give you a fighting chance to get the device clo=
cked
> and powered on. How does it work? Magic?
>=20
> > In order to save power and let the irqchip enter into runtime SUSPEND
> > mode, the driver will call free_irq() When it was not used(idle). Then
> > free_irq() will decrease the reference and let the irqchip enter
> > suspend state.
>=20
> The reference count on *what*? There is nothing to take a reference on. S=
o yes,
> you understand how the core kernel works. But you don't seem to notice th=
at
> there is no link between the irq and the device that implements the contr=
oller.

See the code, it will call irq_chip_pm_put(&desc->irq_data)

/*
 * Internal function to unregister an irqaction - used to free
 * regular and special interrupts that are part of the architecture.
 */
static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
{
..
        irq_chip_pm_put(&desc->irq_data);
        module_put(desc->owner);
        kfree(action->secondary);
        return action;
}

>=20
> > So, when the irqchip entered suspend, which means there is no user for
> > the irqchip and all the irqs were DISABLED + MASKED.
> > Due to the runtimePM support for the irqchip, when kexec runs, it will
> > sometimes meet the situation that the irqchip is suspend due to no
> > users for it. So from either the performance(time cost) or coding
> > logic, the machine_kexec_mask_interrupts() should not do double mask
> > for the irqs which already masked.
>=20
> I strongly suggest you start by fixing the damn driver first.

Our driver does not have issue at all. What to fix?

>=20
> In the meantime, NAK to this patch.

Anyway, it seems don't really understand this issue and you just simply rej=
ect one reasonable fix. Sounds not good at all.

>=20
>          M.
> --
> Jazz is not dead. It just smells funny...
