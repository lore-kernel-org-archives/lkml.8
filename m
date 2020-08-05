Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EE9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 06:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A91D2245C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 06:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FOXpQi+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgHEGbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 02:31:25 -0400
Received: from mail-eopbgr50068.outbound.protection.outlook.com ([40.107.5.68]:7813
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726707AbgHEGbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 02:31:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Osb93d4wfDhzd/w5zdh/FNq/ASV+u/mkdQp+37f4JokdGadPnPpYzOrNTW1IWUGo5n5OuGp4qno7+oLYtBenE22bXjQMr44B1o9rRTx/S7HiFzzWkXeyGZ1Qbm++UanPeNJWtXdqkfuma8GdcEZA+IeL7SXgH5uPqQ3Fcg/+LOaYVCfnx9vwrmdM3pZn6o9qM0KvgTMHFmnCiSvAca9DMfivdF09d3P2TGdZ9mmMRrBHAK2eedCmv6OK2EHpqIJy3d8pREAkFM6IwJImW5+u/BZlQwnGOB1PaAE/jaGJldjuct4Wx7prRpqxsn13YX4TBZKB1oRl416qhH8r23kD7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8u97rKyaixLiucxpM7My+oiZzgMq8Qao9r1yPlpDjE=;
 b=UFKpZb0rdJXg/XC7bOrT1sxnJdQxGP8DKnChO6cdKprPTBNSSeEpNAqjhwMZuwhaiYDNNtg4VsGxRQPT2tQtOFFcY5GYn9aXotuSTUxwPjrb4J0YUDCZ4yGhYFh3WEMxvgGBEAe9p/bubJ8fGItZjn46jR25BHrhh7rhBrqmaT9MFOQSF8E7mNKsw8hRSiGBh5ZX/1D5pV+cA5D/d8Vb7ppqL8JcZW14T7LZfR3tdldzApqn5pAiQnwwFAWNUqRTceFj9Ictwynewhm+wflT9jNSG7B3uYiMsenyg1VaSflLv7mruRz1sBkQuU8ZrfvTicqc2u5w3xNWtwuEhCO3QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8u97rKyaixLiucxpM7My+oiZzgMq8Qao9r1yPlpDjE=;
 b=FOXpQi+3ITcl7+po8edyM/6JQ3rPmKE4hE4erlimib1Uk6Tob0S3vg9iWUSqqi0PV+QU/RqWomtiACTo52UebKEmshy4K1Xi0mxxjuoAbaoEPh0eiv7Eiss7R/mAECv5QJ1H9ye0khNsvDe2+BElcSDp3mbycHm4+ibbDKj1uG0=
Received: from VI1PR0402MB3824.eurprd04.prod.outlook.com
 (2603:10a6:803:22::18) by VI1PR0402MB3664.eurprd04.prod.outlook.com
 (2603:10a6:803:1e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Wed, 5 Aug
 2020 06:31:20 +0000
Received: from VI1PR0402MB3824.eurprd04.prod.outlook.com
 ([fe80::167:b586:586e:e024]) by VI1PR0402MB3824.eurprd04.prod.outlook.com
 ([fe80::167:b586:586e:e024%5]) with mapi id 15.20.3239.021; Wed, 5 Aug 2020
 06:31:20 +0000
From:   Jason Liu <jason.hui.liu@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>, Marc Zyngier <maz@kernel.org>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/1] arm64: kexec: no need to do irq_chip->irq_mask if it
 already masked
Thread-Topic: [PATCH 1/1] arm64: kexec: no need to do irq_chip->irq_mask if it
 already masked
Thread-Index: AQHWaj3ZMAA/XWH8SkmG3qCWNnZEoaknx/iAgAALMQCAAQxYoA==
Date:   Wed, 5 Aug 2020 06:31:20 +0000
Message-ID: <VI1PR0402MB38243230C51FDB1C3F490853AE4B0@VI1PR0402MB3824.eurprd04.prod.outlook.com>
References: <20200804085657.10776-1-jason.hui.liu@nxp.com>
 <b4444c737f9d6fd8fd99dbb809d35a0f@kernel.org> <20200804113850.GB15199@bogus>
In-Reply-To: <20200804113850.GB15199@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d607873e-5a53-4c47-74f7-08d839092a8d
x-ms-traffictypediagnostic: VI1PR0402MB3664:
x-microsoft-antispam-prvs: <VI1PR0402MB3664FB602C0815E8637CE7AEAE4B0@VI1PR0402MB3664.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HDc+LW5BtdGvQj3tNeEOEy4EUu/iu/OhuDBDVOMoHkEEewa+u6vcItnqWbAa0SjRkxzadqXi0sxe4V9pxyrBC0X+AGc21XtTrBC6ElXM1D3dx1uXZb1Pl7DTCR5IXwq+0BUmg4NMQBi8bOj+etfCKECDT+kqLhgGQjmZVP8bQY4WbFZZ6+P/fiUMa46L7B8WQcA2/6UrZhQ/DXsUbkOn7J1QdDTMkdJXIr5h362VYt25ZEoSPHWvo+5m6miC77gHrlni1ImMb6AcTx1tCrkHsiDFljcM5EXRHiPXIUbPs0K4QNfM9yCti2ejqKrPaqKySw4jWanN2iEurNCM9/vKIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3824.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(66946007)(66476007)(64756008)(66556008)(83380400001)(316002)(7696005)(186003)(66446008)(76116006)(52536014)(5660300002)(26005)(2906002)(45080400002)(6506007)(8936002)(53546011)(8676002)(110136005)(4326008)(55016002)(9686003)(71200400001)(478600001)(86362001)(54906003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: WkSU23FDjnhMOdC9O5kZk5+8cBSzv++6nsSL54uLbCRveCV1wLmncE6zqD5tKHn4lvBBdq/4cXyzTvnLw48GjJyQ9vR9/3gyH60LxfKiGOB/kOgxYpf1uVsGm+zu9Re6DUbC+920fJcwmYADiYmzaJA6x8zBCyQkfSWYXtV1iXHqMqPEGJ7GHZ5sJ5EFfX3bgZD3+q9YFl/WEZa1iDVJR4PD80fwkm2jB/ebSwLCk1+Yw8RuJ/blp6GiHWJ/GxnA6SnXNUVaqq2orpYGohUT/+drbupe5/Z/J6DGNcJ5bcq5K2irSpWS4cJiOq9irMJWmT2mrXVw66TnOKcOvJIce3OlJkp5+cNb560WPWbp18JmGWzL6dqJzyCZg/wQ/r4LudqxlG/T97qZvkYQbd894ZY57Ximcb52R4ozt/ZBcvuZGyN27qxMgn7kub1g9aPiOV8xwVDOGy/BMtt9OwEfSXvucdgGv+pxUijcymLn1JcvPjbRU7k7y1zdPloGWDbf1kL/B2furztP+DTM+6Ad+LAdeCkkoOQil1/8ANkQTbXEKKoqHfXpN5jORrVycbWPsoD/qx/p6VJSmXa4WTjwfIurN7xB13lZEuMoLeXdM5kvVG2zA3nVTkj/vKZn4OZdziL1itFCh/vzNESZDC9x6w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3824.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d607873e-5a53-4c47-74f7-08d839092a8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2020 06:31:20.3168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7He+6P9J7Rp3aY4+aF8dhEPy8WTFCtRxIIo05RdGpKUmPlfOX+q0TlZQGA6AkI/0xgs6nSOo1Zxy1/zsWpXODw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3664
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Sudeep Holla <sudeep.holla@arm.com>
> Sent: Tuesday, August 4, 2020 7:39 PM
> To: Marc Zyngier <maz@kernel.org>
> Cc: Jason Liu <jason.hui.liu@nxp.com>; catalin.marinas@arm.com;
> will@kernel.org; linux-kernel@vger.kernel.org; Sudeep Holla
> <sudeep.holla@arm.com>; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 1/1] arm64: kexec: no need to do irq_chip->irq_mask i=
f it
> already masked
>=20
> On Tue, Aug 04, 2020 at 11:58:47AM +0100, Marc Zyngier wrote:
> > On 2020-08-04 09:56, Jason Liu wrote:
> > > No need to do the irq_chip->irq_mask() if it already masked.
> > > BTW, unconditionally do the irq_chip->irq_mask() will also bring
> > > issues when the irq_chip in the runtime PM suspend. Accessing
> > > registers of the irq_chip will bring in the exceptions. For example o=
n the
> i.MX:
> > >
> > > root@imx8qmmek:~# echo c > /proc/sysrq-trigger [  177.796182] sysrq:
> > > Trigger a crash [  177.799596] Kernel panic - not syncing: sysrq
> > > triggered crash [  177.875616] SMP: stopping secondary CPUs [
> > > 177.891936] Internal error: synchronous external abort: 96000210
> > > [#1] PREEMPT SMP [  177.899429] Modules linked in: crct10dif_ce
> > > mxc_jpeg_encdec [  177.905018] CPU: 1 PID: 944 Comm: sh Kdump:
> > > loaded Not tainted [  177.913457] Hardware name: Freescale i.MX8QM
> > > MEK (DT) [  177.918517] pstate: a0000085 (NzCv daIf -PAN -UAO) [
> > > 177.923318] pc : imx_irqsteer_irq_mask+0x50/0x80 [  177.927944] lr :
> > > imx_irqsteer_irq_mask+0x38/0x80 [  177.932561] sp : ffff800011fe3a50
> > > [  177.935880] x29: ffff800011fe3a50 x28: ffff0008f7708e00 [
> > > 177.941196] x27: 0000000000000000 x26: 0000000000000000 [
> > > 177.946513] x25: ffff800011a30c80 x24: 0000000000000000 [
> > > 177.951830] x23: ffff800011fe3af8 x22: ffff0008f24469d4 [
> > > 177.957147] x21: ffff0008f2446880 x20: ffff0008f25f5658 [
> > > 177.962463] x19: ffff800012611004 x18: 0000000000000001 [
> > > 177.967780] x17: 0000000000000000 x16: 0000000000000000 [
> > > 177.973097] x15: ffff0008f7709270 x14: 0000000060000085 [
> > > 177.978414] x13: ffff800010177570 x12: ffff800011fe3ab0 [
> > > 177.983730] x11: ffff80001017749c x10: 0000000000000040 [
> > > 177.989047] x9 : ffff8000119f1c80 x8 : ffff8000119f1c78 [
> > > 177.994364] x7 : ffff0008f46bedf8 x6 : 0000000000000000 [
> > > 177.999681] x5 : ffff0008f46beda0 x4 : 0000000000000000 [
> > > 178.004997] x3 : ffff0008f24469d4 x2 : ffff800012611000 [
> > > 178.010314] x1 : 0000000000000080 x0 : 0000000000000080 [
> > > 178.015630] Call trace:
> > > [  178.018077]  imx_irqsteer_irq_mask+0x50/0x80 [  178.022352]
> > > machine_crash_shutdown+0xa8/0x100 [  178.026802]
> > > __crash_kexec+0x6c/0x118 [  178.030464]  panic+0x19c/0x324 [
> > > 178.033524]  sysrq_handle_reboot+0x0/0x20 [  178.037537]
> > > __handle_sysrq+0x88/0x180 [  178.041290]
> > > write_sysrq_trigger+0x8c/0xb0 [  178.045389]
> > > proc_reg_write+0x78/0xb0 [  178.049055]  __vfs_write+0x18/0x40 [
> > > 178.052461]  vfs_write+0xdc/0x1c8 [  178.055779]
> > > ksys_write+0x68/0xf0 [  178.059098]  __arm64_sys_write+0x18/0x20 [
> > > 178.063027]  el0_svc_common.constprop.0+0x68/0x160
> > > [  178.067821]  el0_svc_handler+0x20/0x80 [  178.071573]
> > > el0_svc+0x8/0xc [  178.074463] Code: 93407e73 91001273 aa0003e1
> > > 8b130053 (b9400260) [  178.080567] ---[ end trace 652333f6c6d6b05d
> > > ]---
> > >
> > > Signed-off-by: Jason Liu <jason.hui.liu@nxp.com>
> > > Cc: <stable@vger.kernel.org>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Sasha Levin <sashal@kernel.org>
> > > ---
> > >  arch/arm64/kernel/machine_kexec.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm64/kernel/machine_kexec.c
> > > b/arch/arm64/kernel/machine_kexec.c
> > > index a0b144cfaea7..8ab263c733bf 100644
> > > --- a/arch/arm64/kernel/machine_kexec.c
> > > +++ b/arch/arm64/kernel/machine_kexec.c
> > > @@ -236,7 +236,7 @@ static void machine_kexec_mask_interrupts(void)
> > >  		    chip->irq_eoi)
> > >  			chip->irq_eoi(&desc->irq_data);
> > >
> > > -		if (chip->irq_mask)
> > > +		if (chip->irq_mask && !irqd_irq_masked(&desc->irq_data))
> > >  			chip->irq_mask(&desc->irq_data);
> > >
> > >  		if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
> >
> > This is pretty dodgy. irq_mask() should be an idempotent action
> > (masking twice must not be harmful).
> >
>=20
> That was my understanding too, but was not totally against adding it here=
.

Yes, masking twice at least a time of waste and really no need to do it. If=
 you look at the common API mask_irq
There did avoid the unnecessary twice or multiple mask. Keep in mind that t=
here are many irqs, so it will
waste time to do the things which is not necessary. So, from this point, IM=
O, this patch is fine.

void mask_irq(struct irq_desc *desc)
{
        if (irqd_irq_masked(&desc->irq_data))
                return;

        if (desc->irq_data.chip->irq_mask) {
                desc->irq_data.chip->irq_mask(&desc->irq_data);
                irq_state_set_masked(desc);
        }
}

>=20
> > Even more, it really isn't obvious to me how this can work at all, as
> > even if the interrupt isn't masked, the irqsteer could well be
> > suspended.
> >
>=20
> Indeed, the runtime PM ops in that driver looks dodgy. Any calls to mask_=
irq
> from drivers or anywhere with irqchip suspended with just blows up the
> system.

If you look at the chip->irq_mask implementation on different platforms, al=
most
all with directly access the register of the irqchip including irqsteer. Th=
ere are fine due to
driver will use the common mask_irq API.

>=20
> > So as is, this change is just papering over a much deeper issue in
> > your driver.
> >
>=20
> Thanks for confirming

No, this patch is not papering over a much deeper issue in the driver. This=
 is just to make things better for the ARM64 kexec.

>=20
> --
> Regards,
> Sudeep
