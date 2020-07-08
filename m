Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F4BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EE3B206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="rCQ92fw8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbgGHMHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:07:01 -0400
Received: from mail-bn8nam12on2056.outbound.protection.outlook.com ([40.107.237.56]:6091
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728790AbgGHMHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:07:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ij1l3p7PQ7Kywlw1FEzYODU2PoltOkyxpOX50ueonjQKKcmuUOlNbE+Dtm+VBe5apq3pB+ZZs4heM/Guq2lBrx/m+0EZZfxYPt0JThecnQr5zovJgNJXrAllv+nvW1iFCa2gVTWWKLVK7aEnlEy2zmZIYtYfz0TpQcYqXTvpQvxZ6goaurlPIth8nOQSW2TAfvbPISpGkmhqUp8AoEyHwx0pMc29HQinRdUqdYx6ewOuO03zH4Yr25qO1TvqHzKaXfG7NpQ04h+5b4iqZ01hsfd6djWeA+sfNhIwsW3FBOWJ8QItkmRe9q7eP7JUcah7qtxTowbH6vjpabQwIu86oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWa6RDOmR4LgvQbN3jwSaEV6lOt/aWWwgtfPsDZjZDM=;
 b=WYOM3qqUK62qb1Rd8pjQkBs9OgwYl72h+8mH6Ldu148bMhsc782SLJIoB2Br2+BErnjx80Rjk+lqNzjQqBznD7NUmc605HHbOjq1Uc1aYAUAbd/aZwdqWoqWXRnFh8m+3E05yGv2q3qYZ4hW7RSfS67bR1oIv6iYpO5ikIAGJDkk+CYeAAoRSZ9Tb1m3lRPrNIkAeGNOtELkye8yHnUmN1Nn3Zi8QdwTJ/0PeYRiEUPoht9LMaLw2jlOhGDdMbtLMUHAIJJWAneSVpfSl/3077M2xKNhGTaFKoj/CMgzwa/Ni7iNSc052C+zAtvyRHjhfwoWGcCtYBBvUIRp9xHPYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWa6RDOmR4LgvQbN3jwSaEV6lOt/aWWwgtfPsDZjZDM=;
 b=rCQ92fw8YG7m6Y/CbZawsl1Rn8VJI6r4RMWwn8wvp+D4vivTaHWFQBMRYF6lcugxU9K3SoIV6LD2uyMY4xuDkIMDOhNZmqa+pI1zC64+ZVzUMzM5tE+6sZ+7J6bpUmmwrT+NRPIIUD368WRIqWSPUjM5K9EXeXnEVKyKwEeFAUw=
Received: from BN6PR1301MB2020.namprd13.prod.outlook.com
 (2603:10b6:405:34::34) by BN6PR13MB1108.namprd13.prod.outlook.com
 (2603:10b6:404:69::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.18; Wed, 8 Jul
 2020 12:06:57 +0000
Received: from BN6PR1301MB2020.namprd13.prod.outlook.com
 ([fe80::481f:d0dc:9069:2c42]) by BN6PR1301MB2020.namprd13.prod.outlook.com
 ([fe80::481f:d0dc:9069:2c42%3]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 12:06:57 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     Andreas Schwab <schwab@suse.de>
CC:     "Paul Walmsley ( Sifive)" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "lollivier@baylibre.com" <lollivier@baylibre.com>,
        Green Wan <green.wan@sifive.com>,
        "atish.patra@wdc.com" <atish.patra@wdc.com>,
        "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
        "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>,
        "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>
Subject: RE: [PATCH 0/3] Dynamic CPU frequency switching for the HiFive
Thread-Topic: [PATCH 0/3] Dynamic CPU frequency switching for the HiFive
Thread-Index: AQHWQ9XZeaoAcUonuUqzTiy5jwwbX6jyoJC5gAsX94A=
Date:   Wed, 8 Jul 2020 12:06:56 +0000
Message-ID: <BN6PR1301MB202019EBD2D08271F877180D8C670@BN6PR1301MB2020.namprd13.prod.outlook.com>
References: <1592308864-30205-1-git-send-email-yash.shah@sifive.com>
 <mvmftabiklh.fsf@suse.de>
In-Reply-To: <mvmftabiklh.fsf@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=sifive.com;
x-originating-ip: [110.5.74.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a52e268-1343-4efa-a8dc-08d823376968
x-ms-traffictypediagnostic: BN6PR13MB1108:
x-ld-processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR13MB1108E20FB5657613A2804E1F8C670@BN6PR13MB1108.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JwhF9epcsRZJTxVVpH5Fe2P4WP81ZwOAP/QGJ53YRsi33QIA4e3FwZNro7joWIAZ38B7MTnjibLUssV9TipDubz+bIXJA14sv8GKv8O2y1CCLpCtlUaqyK7c1vV9loB0MF2UbY1qqJhYSzaqf3TOAtYEQHB2P+hRG/eMRne+8rPXCtJHr20wRAaROGgMEEDBmOS5leQRU1BMhUhVCUK0gFeWVY9bVAkbCNaAdEp7F4u+t07yzySw/PbSPitq5yKo72eUaYJlGzsiuy6Y75vlcJTy38AxWblq8tPInMWzjaxW9SWs3+YcBSdiQR30IYZbcswrQRTU6zx/26sSAFQZyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1301MB2020.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(6029001)(346002)(376002)(396003)(39850400004)(136003)(366004)(8936002)(71200400001)(76116006)(8676002)(66476007)(66946007)(44832011)(33656002)(66556008)(64756008)(66446008)(2906002)(316002)(5660300002)(7696005)(55016002)(478600001)(4326008)(26005)(54906003)(186003)(52536014)(6916009)(83380400001)(7416002)(86362001)(53546011)(6506007)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 3XAjUiBvviMHn9nMcrS/owzjThhZiRv7Wcc6t+66rjxhnsBU0x7y4Oy2vSAaTgJzTfM4zTzf3Kbe/u+vPbgpr0bfG77W+7/AMdKf0X3CByd++CEI/Vq79s35qIQb0Pi/WVQMqrO5awjRFNGST0OnUc2SdMueosDtB2CK9kTe2BQUrjfeO73Y8a4Q3JtffunojfhGxfM3rLMREnCJWuEtA/qT2U34i8bO4dEMQ896AvIfa35BUwmDgfTnrgKzFN3p6VjQ5G6Gn2+jAuyESt7kRJPW+9mRCF9o3By9waYRdn1znRlxBs8oLt7dli8e6GeVKJ8/lv3m0uWfBjo8VhKJ4EwPcGbgOYcatmuR2ZZxWcT9bn8Z5ZUlMHEiRiGnI81pc+AbLdWTeQ2cKzcTgIM9pZwHa49mHI+mvz2Y/9E4kkA0uHk8QZ1ORJ2VJUVIuJ3nqwy62xa1e5bZ+CTshHIKx53VWd1/iXKZvOw8Q3MnVCY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1301MB2020.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a52e268-1343-4efa-a8dc-08d823376968
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 12:06:56.9946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +VF7jIYSVa4ShIcJh5C3wPbSD31f5WOpflZG0VcNm6xWCYhM5cNd7UC6izA6H1oO4V1KutbioBiJCTYqJGz/8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR13MB1108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

> -----Original Message-----
> From: Andreas Schwab <schwab@suse.de>
> Sent: 01 July 2020 16:11
> To: Yash Shah <yash.shah@sifive.com>
> Cc: Paul Walmsley ( Sifive) <paul.walmsley@sifive.com>;
> palmer@dabbelt.com; robh+dt@kernel.org; linux-riscv@lists.infradead.org;
> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; Sachin Ghadi
> <sachin.ghadi@sifive.com>; aou@eecs.berkeley.edu; anup@brainfault.org;
> lollivier@baylibre.com; Green Wan <green.wan@sifive.com>;
> atish.patra@wdc.com; alistair.francis@wdc.com; deepa.kernel@gmail.com;
> bmeng.cn@gmail.com
> Subject: Re: [PATCH 0/3] Dynamic CPU frequency switching for the HiFive
>=20
> [External Email] Do not click links or attachments unless you recognize t=
he
> sender and know the content is safe
>=20
> On Jun 16 2020, Yash Shah wrote:
>=20
> > The patch series adds the support for dynamic CPU frequency switching
> > for FU540-C000 SoC on the HiFive Unleashed board. All the patches are
> > based on Paul Walmsley's work.
> >
> > This series is based on Linux v5.7 and tested on HiFive unleashed board=
.
>=20
> I'm using that patch with 5.7.5.
>=20
> It appears to interfer with serial output when using the ondemand governo=
r.
>=20
> I also see soft lockups when using the performance governor:
>=20
> [  101.587527] rcu: INFO: rcu_sched self-detected stall on CPU
> [  101.592322] rcu:     0-...!: (932 ticks this GP)
> idle=3D11a/1/0x4000000000000004 softirq=3D4301/4301 fqs=3D4
> [  101.601432]  (t=3D6001 jiffies g=3D4017 q=3D859) [  101.605514] rcu: r=
cu_sched
> kthread starved for 5984 jiffies! g4017 f0x0 RCU_GP_WAIT_FQS(5) -
> >state=3D0x0 ->cpu=3D2 [  101.615494] rcu: RCU grace-period kthread stack
> dump:
> [  101.620530] rcu_sched       R  running task        0    10      2 0x00=
000000
> [  101.627560] Call Trace:
> [  101.630004] [<ffffffe00085a7e2>] __schedule+0x25c/0x616 [  101.635205]
> [<ffffffe00085abde>] schedule+0x42/0xb2 [  101.640070]
> [<ffffffe00085d0ba>] schedule_timeout+0x56/0xb8 [  101.645626]
> [<ffffffe000263c34>] rcu_gp_fqs_loop+0x208/0x248 [  101.651266]
> [<ffffffe0002666de>] rcu_gp_kthread+0xc2/0xcc [  101.656651]
> [<ffffffe00022654e>] kthread+0xda/0xec [  101.661426] [<ffffffe00020140a>=
]
> ret_from_exception+0x0/0xc [  101.666977] Task dump for CPU 0:
> [  101.670187] loop0           R  running task        0   655      2 0x00=
000008
> [  101.677218] Call Trace:
> [  101.679657] [<ffffffe0002028ae>] walk_stackframe+0x0/0xaa [
> 101.685036] [<ffffffe000202b76>] show_stack+0x2a/0x34 [  101.690074]
> [<ffffffe0002319b0>] sched_show_task.part.0+0xc2/0xd2 [  101.696154]
> [<ffffffe00022bb9c>] sched_show_task+0x64/0x66 [  101.701618]
> [<ffffffe000231afe>] dump_cpu_task+0x3e/0x48 [  101.706916]
> [<ffffffe000267762>] rcu_dump_cpu_stacks+0x94/0xce [  101.712731]
> [<ffffffe0002631f6>] print_cpu_stall+0x116/0x18a [  101.718375]
> [<ffffffe000264a46>] check_cpu_stall+0xcc/0x1a2 [  101.723929]
> [<ffffffe000264b52>] rcu_pending.constprop.0+0x36/0xaa [  101.730094]
> [<ffffffe000266ab2>] rcu_sched_clock_irq+0xa6/0xea [  101.735913]
> [<ffffffe00026d1be>] update_process_times+0x1e/0x42 [  101.741821]
> [<ffffffe0002793bc>] tick_sched_handle+0x26/0x52 [  101.747456]
> [<ffffffe0002798fe>] tick_sched_timer+0x6a/0xd0 [  101.753015]
> [<ffffffe00026d9be>] __run_hrtimer.constprop.0+0x50/0xe8
> [  101.759353] [<ffffffe00026da9e>] __hrtimer_run_queues+0x48/0x6c [
> 101.765254] [<ffffffe00026e410>] hrtimer_interrupt+0xca/0x1d4 [
> 101.770985] [<ffffffe0006ceef8>] riscv_timer_interrupt+0x32/0x3a [
> 101.776976] [<ffffffe00085e17c>] do_IRQ+0xa4/0xb8 [  101.781663]
> [<ffffffe00020140a>] ret_from_exception+0x0/0xc
>=20
> Andreas.
>=20
> --
> Andreas Schwab, SUSE Labs, schwab@suse.de GPG Key fingerprint =3D 0196
> BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7 "And now for something
> completely different."

I am looking into the issues you reported. I will update soon.
Thanks for testing.

- Yash
