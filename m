Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C29C43469
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A2EC22D0B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iigmMXWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbgHFKH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 06:07:58 -0400
Received: from mail-eopbgr10062.outbound.protection.outlook.com ([40.107.1.62]:29278
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729309AbgHFKHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 06:07:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Leir/e4fm2Z07dy3c4h6TS/pgBGk+L5WX+EqMPsiZZ3ODChvf5jvUit1z3eHTg0ykKrQImC56vJnFCMmo2uOMrB9YnaGSYVKrnm4k4aCN0HeuI2my6c+lq7q5BUbIjDZfcGlQuWlNwSTjCJr/1DxDhlSTiSrugq1yRQeV0nrYo9jCBRGbGVYAX2pfPuHfH8m0Y++3IT9ipV7svje/EHzgfRGZnmlFMOiVeRXRmpRl6rMHT8Lz5QgM7fHkZ80dBfw62Mb/jcViSGtPmkzgF6XA+pCY/iwRxQqAZw13wwdoVbKp3pKSncwmqAMqrnQwTQDANHAVGdjvbx1UjQN+Z+D+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtwzRSJOQvoryN4aHJ97If9hzagvDp8weaz845Ds2YU=;
 b=OavTIIPj03uMUDhVKKu0MhoaIx9YpasbmCOE1+gW7SfiWAi76n+DKCkkmoQqPshsF23GPi75JA7If1T164+WuUZkeO3PaE30VLu7cmqEWnu3voQImGT+wvnLJLSJCYsmpZ8P0DhZurFsLfeiGyvW3SqRZeSWyJVexdQxReB1B6Eqh5/l2RV2BBV1YyKRCbbnZH19ZOErjsdAagTjcsbosdnpVJ83p5cgn4PwdZC+iYtNTA8afax8gHWsAnQeoBcNvK30eXkqIvDic4vtT9Y2Dzb+iQgMqClMZ9z3ec5YL3uavzJZQI3z/y0uqx2pBQjE4vFJ87Wo+OLusox+KWcxrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtwzRSJOQvoryN4aHJ97If9hzagvDp8weaz845Ds2YU=;
 b=iigmMXWGXbbvre+bdnaTqr1Csn182hK84BvUYmupn28VBUAnTzRjjxhcO3WRpmU27rHSkwUKvObgowSDFRhd2E/RDccvB7YuhXnn5KDzXV9rH5c49u3xq+Dg6mWqLfowrHhjDmklvP6ezvf2PMbozJKUAhGdPLibpQfXDHaYQiA=
Received: from VI1PR0402MB3824.eurprd04.prod.outlook.com
 (2603:10a6:803:22::18) by VI1PR04MB6078.eurprd04.prod.outlook.com
 (2603:10a6:803:f2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Thu, 6 Aug
 2020 10:05:11 +0000
Received: from VI1PR0402MB3824.eurprd04.prod.outlook.com
 ([fe80::167:b586:586e:e024]) by VI1PR0402MB3824.eurprd04.prod.outlook.com
 ([fe80::167:b586:586e:e024%5]) with mapi id 15.20.3261.018; Thu, 6 Aug 2020
 10:05:11 +0000
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
Thread-Index: AQHWaj3ZMAA/XWH8SkmG3qCWNnZEoaknx/iAgAALMQCAAQxYoIAATcYAgAGqTLA=
Date:   Thu, 6 Aug 2020 10:05:10 +0000
Message-ID: <VI1PR0402MB38249815EA37338953E8AAC1AE480@VI1PR0402MB3824.eurprd04.prod.outlook.com>
References: <20200804085657.10776-1-jason.hui.liu@nxp.com>
 <b4444c737f9d6fd8fd99dbb809d35a0f@kernel.org> <20200804113850.GB15199@bogus>
 <VI1PR0402MB38243230C51FDB1C3F490853AE4B0@VI1PR0402MB3824.eurprd04.prod.outlook.com>
 <3c63ae0cc3a7b5bad5d4638a9870340e@kernel.org>
In-Reply-To: <3c63ae0cc3a7b5bad5d4638a9870340e@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 93fd23c7-a8a0-4b6b-233e-08d839f03498
x-ms-traffictypediagnostic: VI1PR04MB6078:
x-microsoft-antispam-prvs: <VI1PR04MB60780086645DEF962B322999AE480@VI1PR04MB6078.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BPDnGcoFB5KYWw3rjMuwJKARBSogDwDCxLW+KXzTRXeRUzB/fvFeL10mutZKGocl8PJul0a5qdLHbmTGOVhzblJxd5Lrzw+YuV8cBl0ueznhMFWk/p6tWbSYKCGT+P4AlI7TAP5qjEJ1QpIkoETCRxu2HjBP41hPEWJyYSSZblsN10pa/5zC0dXXaYdU0KaNYegX5VZmVd3Ee1XDJv/ZCx1SlombglETqBS7UgLPV+REp0RxpOsV9smDQMoKu4kzpK8MeBU8nIRAv1n+IV/sp+lnKMkB1D5OKEXXSgznXUQP0ex1t5eeCHrbr9MGUBtIcX2M9eR7ojfrT42YnZ7DLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3824.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(66476007)(66446008)(64756008)(6506007)(53546011)(66556008)(478600001)(7696005)(54906003)(8676002)(86362001)(76116006)(5660300002)(52536014)(66946007)(71200400001)(6916009)(83380400001)(55016002)(8936002)(9686003)(316002)(33656002)(26005)(186003)(2906002)(45080400002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: X+zw6TS8VKC85xGCVGI8yLOGRtwzIksAiokea5oe3MXD/5uY1n5W2caU+mU5u6bm56fV964wImNcnCZdjno3eHzMDzROxnT5F8zG6OSlHcrQjm689j5Q6eL6l5QeHpPNgXmT23udinmXpPGfIMYuq58ImOgTi05mpHwomREiyPJY3PEmFRqGSzuShNh+6ElxaWWwMHjSmuWsvVAitmob29tYDmX901xhHAEcXO2TdtdA1NPJ3UXzvEJJYIRd+6pyYfB03AdUGIks62vZXSV97el7JuqE2rQXzPtI2YtjKlH7XPEoXGSBzDIuBBjy7XLG6xAqTYJsTnqot8+koB3ufjg7+bbHOg2Cr50z6TOu3p5XGUTaex2852nPvGkrZEegRCpgzIK7CvUBLCcsoEkMunzdoNVCr6DmbbHlsnVfZbLxvJtP+s5L6BSST3opvMkezGp3ZAAJQFR+gf3ISoxdWYF0Rg0jh2gt83+Ht/waGRtPQEE5U47jN51ClWoo2KRda4Em+4DT4dCSLDrj1jlxCltD+VFJurBdATYunFfgKG4iFMD2GPLdXrYHEV9OMYHCl0eT/nyKS9yA6vMK8iHCx23gX5Lgaqh4awBoxJ31whCdVIool1HKAhMyByJAsGrrwiRMYutvTj2lJsr6Py2gXg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3824.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93fd23c7-a8a0-4b6b-233e-08d839f03498
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2020 10:05:10.9065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O6TmNItt/S1S9Gi/9FDFQd9w3rmexAoq3m8mqUGYzfp3nPOPYVazi5vMjzSKSf2xStNa65bD0WZLevf5HRBLpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6078
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Marc Zyngier <maz@kernel.org>
> Sent: Wednesday, August 5, 2020 4:18 PM
> To: Jason Liu <jason.hui.liu@nxp.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>; catalin.marinas@arm.com;
> will@kernel.org; sashal@kernel.org; linux-kernel@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 1/1] arm64: kexec: no need to do irq_chip->irq_mask i=
f it
> already masked
>=20
> On 2020-08-05 07:31, Jason Liu wrote:
> >> -----Original Message-----
> >> From: Sudeep Holla <sudeep.holla@arm.com>
> >> Sent: Tuesday, August 4, 2020 7:39 PM
> >> To: Marc Zyngier <maz@kernel.org>
> >> Cc: Jason Liu <jason.hui.liu@nxp.com>; catalin.marinas@arm.com;
> >> will@kernel.org; linux-kernel@vger.kernel.org; Sudeep Holla
> >> <sudeep.holla@arm.com>; linux-arm-kernel@lists.infradead.org
> >> Subject: Re: [PATCH 1/1] arm64: kexec: no need to do
> >> irq_chip->irq_mask if it already masked
> >>
> >> On Tue, Aug 04, 2020 at 11:58:47AM +0100, Marc Zyngier wrote:
> >> > On 2020-08-04 09:56, Jason Liu wrote:
> >> > > No need to do the irq_chip->irq_mask() if it already masked.
> >> > > BTW, unconditionally do the irq_chip->irq_mask() will also bring
> >> > > issues when the irq_chip in the runtime PM suspend. Accessing
> >> > > registers of the irq_chip will bring in the exceptions. For
> >> > > example on the
> >> i.MX:
> >> > >
> >> > > root@imx8qmmek:~# echo c > /proc/sysrq-trigger [  177.796182] sysr=
q:
> >> > > Trigger a crash [  177.799596] Kernel panic - not syncing: sysrq
> >> > > triggered crash [  177.875616] SMP: stopping secondary CPUs [
> >> > > 177.891936] Internal error: synchronous external abort: 96000210
> >> > > [#1] PREEMPT SMP [  177.899429] Modules linked in: crct10dif_ce
> >> > > mxc_jpeg_encdec [  177.905018] CPU: 1 PID: 944 Comm: sh Kdump:
> >> > > loaded Not tainted [  177.913457] Hardware name: Freescale
> >> > > i.MX8QM MEK (DT) [  177.918517] pstate: a0000085 (NzCv daIf -PAN
> >> > > -UAO) [ 177.923318] pc : imx_irqsteer_irq_mask+0x50/0x80
> [  177.927944] lr :
> >> > > imx_irqsteer_irq_mask+0x38/0x80 [  177.932561] sp :
> >> > > ffff800011fe3a50 [  177.935880] x29: ffff800011fe3a50 x28:
> >> > > ffff0008f7708e00 [ 177.941196] x27: 0000000000000000 x26:
> >> > > 0000000000000000 [ 177.946513] x25: ffff800011a30c80 x24:
> >> > > 0000000000000000 [ 177.951830] x23: ffff800011fe3af8 x22:
> >> > > ffff0008f24469d4 [ 177.957147] x21: ffff0008f2446880 x20:
> >> > > ffff0008f25f5658 [ 177.962463] x19: ffff800012611004 x18:
> >> > > 0000000000000001 [ 177.967780] x17: 0000000000000000 x16:
> >> > > 0000000000000000 [ 177.973097] x15: ffff0008f7709270 x14:
> >> > > 0000000060000085 [ 177.978414] x13: ffff800010177570 x12:
> >> > > ffff800011fe3ab0 [ 177.983730] x11: ffff80001017749c x10:
> >> > > 0000000000000040 [ 177.989047] x9 : ffff8000119f1c80 x8 :
> >> > > ffff8000119f1c78 [ 177.994364] x7 : ffff0008f46bedf8 x6 :
> >> > > 0000000000000000 [ 177.999681] x5 : ffff0008f46beda0 x4 :
> >> > > 0000000000000000 [ 178.004997] x3 : ffff0008f24469d4 x2 :
> >> > > ffff800012611000 [ 178.010314] x1 : 0000000000000080 x0 :
> >> > > 0000000000000080 [ 178.015630] Call trace:
> >> > > [  178.018077]  imx_irqsteer_irq_mask+0x50/0x80 [  178.022352]
> >> > > machine_crash_shutdown+0xa8/0x100 [  178.026802]
> >> > > __crash_kexec+0x6c/0x118 [  178.030464]  panic+0x19c/0x324 [
> >> > > 178.033524]  sysrq_handle_reboot+0x0/0x20 [  178.037537]
> >> > > __handle_sysrq+0x88/0x180 [  178.041290]
> >> > > write_sysrq_trigger+0x8c/0xb0 [  178.045389]
> >> > > proc_reg_write+0x78/0xb0 [  178.049055]  __vfs_write+0x18/0x40 [
> >> > > 178.052461]  vfs_write+0xdc/0x1c8 [  178.055779]
> >> > > ksys_write+0x68/0xf0 [  178.059098]  __arm64_sys_write+0x18/0x20
> >> > > [ 178.063027]  el0_svc_common.constprop.0+0x68/0x160
> >> > > [  178.067821]  el0_svc_handler+0x20/0x80 [  178.071573]
> >> > > el0_svc+0x8/0xc [  178.074463] Code: 93407e73 91001273 aa0003e1
> >> > > 8b130053 (b9400260) [  178.080567] ---[ end trace
> >> > > 652333f6c6d6b05d
> >> > > ]---
> >> > >
> >> > > Signed-off-by: Jason Liu <jason.hui.liu@nxp.com>
> >> > > Cc: <stable@vger.kernel.org>
> >> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> > > Cc: Will Deacon <will@kernel.org>
> >> > > Cc: Sasha Levin <sashal@kernel.org>
> >> > > ---
> >> > >  arch/arm64/kernel/machine_kexec.c | 2 +-
> >> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> > >
> >> > > diff --git a/arch/arm64/kernel/machine_kexec.c
> >> > > b/arch/arm64/kernel/machine_kexec.c
> >> > > index a0b144cfaea7..8ab263c733bf 100644
> >> > > --- a/arch/arm64/kernel/machine_kexec.c
> >> > > +++ b/arch/arm64/kernel/machine_kexec.c
> >> > > @@ -236,7 +236,7 @@ static void
> machine_kexec_mask_interrupts(void)
> >> > >  		    chip->irq_eoi)
> >> > >  			chip->irq_eoi(&desc->irq_data);
> >> > >
> >> > > -		if (chip->irq_mask)
> >> > > +		if (chip->irq_mask && !irqd_irq_masked(&desc->irq_data))
> >> > >  			chip->irq_mask(&desc->irq_data);
> >> > >
> >> > >  		if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
> >> >
> >> > This is pretty dodgy. irq_mask() should be an idempotent action
> >> > (masking twice must not be harmful).
> >> >
> >>
> >> That was my understanding too, but was not totally against adding it
> >> here.
> >
> > Yes, masking twice at least a time of waste and really no need to do
> > it. If you look at the common API mask_irq There did avoid the
> > unnecessary twice or multiple mask. Keep in mind that there are many
> > irqs, so it will waste time to do the things which is not necessary.
> > So, from this point, IMO, this patch is fine.
>=20
> Let's be serious. You are doing a *kexec*. Rebooting the entire system.
> Another 10 or 1000 accesses are completely invisible here.
>=20
> >
> > void mask_irq(struct irq_desc *desc)
> > {
> >         if (irqd_irq_masked(&desc->irq_data))
> >                 return;
> >
> >         if (desc->irq_data.chip->irq_mask) {
> >                 desc->irq_data.chip->irq_mask(&desc->irq_data);
> >                 irq_state_set_masked(desc);
> >         }
> > }
> >
> >>
> >> > Even more, it really isn't obvious to me how this can work at all,
> >> > as even if the interrupt isn't masked, the irqsteer could well be
> >> > suspended.
> >> >
> >>
> >> Indeed, the runtime PM ops in that driver looks dodgy. Any calls to
> >> mask_irq from drivers or anywhere with irqchip suspended with just
> >> blows up the system.
> >
> > If you look at the chip->irq_mask implementation on different
> > platforms, almost all with directly access the register of the irqchip
> > including irqsteer. There are fine due to driver will use the common
> > mask_irq API.
> >
> >>
> >> > So as is, this change is just papering over a much deeper issue in
> >> > your driver.
> >> >
> >>
> >> Thanks for confirming
> >
> > No, this patch is not papering over a much deeper issue in the driver.
> > This is just to make things better for the ARM64 kexec.
>=20
> Yes, I'm sure it is... However:
>=20
> request_irq()
> <goes into suspend, panic somewhere after having turned the irqchip clock=
 off>
> if (chip->irq_mask && !irqd_irq_masked(&desc->irq_data))
>      <explodes, as the interrupt isn't masked>
>=20
> This is because the PM in the irqsteer driver is completely busted:
> request_irq() should get a reference on the driver to prevent it from bei=
ng
> suspended. Since you don't implement it correctly, this doesn't happen an=
d
> your "improvement" doesn't help at all.

The request_irq will get a reference to prevent the irqchip from being susp=
ended due to it call
irq_chip_pm_get(). I am pretty sure we have implemented correctly and that =
is also the common Linux code.
In order to save power and let the irqchip enter into runtime SUSPEND mode,=
 the driver will call free_irq()
When it was not used(idle). Then free_irq() will decrease the reference and=
 let the irqchip enter suspend state.

So, when the irqchip entered suspend, which means there is no user for the =
irqchip and all the irqs were DISABLED + MASKED.
Due to the runtimePM support for the irqchip, when kexec runs, it will some=
times meet the situation that the irqchip is suspend due to
no users for it. So from either the performance(time cost) or coding logic,=
 the machine_kexec_mask_interrupts() should not do
double mask for the irqs which already masked.

>=20
>          M.
> --
> Jazz is not dead. It just smells funny...
