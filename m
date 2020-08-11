Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C411CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 06:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ECA820781
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 06:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="o1T4l3f5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kbzeEjF5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgHKGmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 02:42:18 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:62656 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbgHKGmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 02:42:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1597128138; x=1628664138;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PaJNur4bzP8imrJFj9C8XwlzrtfCsMKk7zDevcvlapI=;
  b=o1T4l3f5ZpekPEUELqA/eMx386v0M+MTM33LqoYZC58hMU4HMEBK33tK
   Is828qPON0ziCt2STosXTvUBkd52pr4n1Jm2D8PQ+LqNBj/F5alspBH1Y
   3YGPLbkhej5JCHFXVeZp8BtH24nghjz7C2M1sMPC4HK59ip5AEhittQIa
   idNlIleUWPW+T143pOnLt2GiMP7DmHrvAa3JzofxRnolxGjk7csQT2l28
   VwecRP82wwH1eeT5bQ5QKcEu3BksGDNXeHJuSkawLqBkK1B+HhE7SSwNq
   jURDW8noSsafJwzQanlwh7h7H2yaRzMioSqfyYycoWQQvzIXBQN5FJlOw
   A==;
IronPort-SDR: Kh4yspYkKRlqzFgZccwQChwqpqMyaRZ7NRQrBYm8TvHlmlx4PMVh6jcNkgjVY1GChT0SkUgaCA
 B/oN9M09u8hnlMmRo0TdQ6bu17h31RQmvMSLECx7pfcWf3HZ8qH3vWJLfeNkNyeg79YUhHpsSy
 h1YuX+LGoUAk++JPR1l5d1F/ttlG+24uX0gWN0MjYW98qzPDHKVpcH8jYWywz4qSjWuZJowXeH
 x1ApfFakvqSqk1j8Yx3VydQAPItgzHvy50+daAfpNu9mh0Xs1L4qYLFMuznoKi+4/2wqAYjLqy
 rO8=
X-IronPort-AV: E=Sophos;i="5.75,460,1589212800"; 
   d="scan'208";a="144692250"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 14:42:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SphO2ar0Df89ABVs58m+E9WMQP8+YNFRqsBgiY/kgwU6+Ykr+ju3e64pyVaGGtuPkIXVt5WXm0wHYjsROXT6775odhC/bblWlsNNoB1NrAj7WR7Wsncx/mTOTrPwCw72ag8qOJajtiFHy2fI9LgdZj0OyT9Fy4y1+SIr84KZrkQfmhmclVV3yIW+ZofZvGCGB6DAbPnMC00SSzJJLKqMxamI4EEqcJm8y8xKSa1ZE7wVMij2k6YmbeueZX2fcgzuOP5y7SSOKJyoJG68uMWfINuHTF0MPNEtZDG3c0EF8VzOJL7l4+B/KF9j/3EBu0O9WD+vDDRJ2v/QBI2R8ZrNWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQAIWCcdnTBacU+umg+nbFUjQZp0qqOywQ88jvgQFBc=;
 b=X6Fyy/YTT3WGApnxFko4A8jLaYZhJysjzV4fo3wFvAuRYm2eEIqkxKQ+M5H7Z731XwRAtPpIjIHyRDKhLbssWTdLcuLojJRIJkuul6Sb3FzKJPpn7YjmblDuG00PwddpbKdWT512PXTXRA6PkWdtSXmaOKG/9sQ5m6vwAxNwk5hjtRKgU2K5KROFIh1wwsGI47T3bR3wFsOAraBcw8hPiCEZ8vEZDD7Mcf6PXo7GPr7VMkuneWNNfKvnoN6x0FpKtdImbUDShJOAF2UXxxl3OFJBkytIiNjkaalVnzwOun4T/H6OU8L4YldwUL4HJxb1yPaE/z6/f/udMTkVXIprMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQAIWCcdnTBacU+umg+nbFUjQZp0qqOywQ88jvgQFBc=;
 b=kbzeEjF5k20tOzbMgv8DZNu3wFjlkgXAfVZs7l1Ake6tDNTb8VrKPuiUQc0ObYkRy/95yRih2RQsIQOuvGDSgTJ7CguWuQAOpN8fOcOFcBWmzHX6efKIpW6MNfg+nuPJefyqPhMh9xnTfvSq6/C4FwxW4jWJfj0RQP1vc76Hr4o=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (10.172.142.14) by
 CY4PR04MB1257.namprd04.prod.outlook.com (10.171.245.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19; Tue, 11 Aug 2020 06:42:15 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2%12]) with mapi id 15.20.3261.024; Tue, 11 Aug
 2020 06:42:15 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Qiu Wenbo <qiuwenbo@phytium.com.cn>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
CC:     Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Zong Li <zong.li@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: Setup exception vector for K210 properly
Thread-Topic: [PATCH] riscv: Setup exception vector for K210 properly
Thread-Index: AQHWb6n+97W98+gJfk6zRY9oCnz7uQ==
Date:   Tue, 11 Aug 2020 06:42:15 +0000
Message-ID: <CY4PR04MB375124E6D2AD38BF1D71C1D5E7450@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200811063659.284088-1-qiuwenbo@phytium.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: phytium.com.cn; dkim=none (message not signed)
 header.d=none;phytium.com.cn; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.47.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c4ae553c-2d66-430c-1869-08d83dc1af8a
x-ms-traffictypediagnostic: CY4PR04MB1257:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB1257BCDF2C0430130F4D6205E7450@CY4PR04MB1257.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z16NeC7RfO5+hEwrpToSVVmBOrE7GvxkdcRqEEO8bk2ILcxzdwILc3jvIMmEv8Pj/6LSSOJIDy8E/HtyFWW9RoDZ016hIkfm1Zqq0Fj6/IjvIYoxMw5AGC094p9NdOWx3ly8szrpNB46PN/wipc7cwMIxYwpxPGO3OrDaBYaS72ssBMPOh1OYD7hfCriETelevJ6+qizzzBoOPl6tv0nOA2VoDx5ZtIEjFrAcZo8liNyIGRT/IzgSazZrb9337KkA5GaLyI0rcV5ICedcZp5Ue26DpFDfaBv+JYzU3fLwHwIueMBoYChCWfw7T8VUuorY30UBbnvfwvPY1h24UR+ag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(186003)(9686003)(7416002)(52536014)(83380400001)(5660300002)(2906002)(8936002)(66446008)(66556008)(86362001)(64756008)(26005)(55016002)(66946007)(76116006)(66476007)(91956017)(53546011)(110136005)(33656002)(54906003)(6506007)(316002)(7696005)(478600001)(4326008)(71200400001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: zBx9cCNrJv6poPLZPVwizkwD7oeqVGUand05Bxz+sDg3bZgixnSlAhlFGNNpe3eXw9Izqbq5exnmU5zRZu2ESGooHHBmqSCjamSA/EZJHk1b/XFh1b6W1AHpaLeKJBIYrWNxcZIZAzALkjYFp66lI/nyGfWOSZgZQ6s7RNjMO9NONERlBZoXIHzeEYvnGiS25Mtj+5ZVztae7HYrL7h9h+SO4rl0NMkCN//MAWP8WQ/HInDITEc50BAtkkJfIRFKmmcKqoErQK1mRk5by3qsAdpJOwUfbEuTFqMP07gMmQwjr52cxBkz6hCy0OkYn6EPI16IRFSZ8yZLBNzxH2vr+bbE2nV5MqydEpaWpwos6vGGMinRjp1swekKSlAjO1Wvkps8PIk0eBv3nMDkSFKa059QjEzULk9ftfELAHW7qHRiZkIJbOGyQDxJ5cC9klWnLaZiamqBDOZFr/+MHVq/OwXCDMVRO58jKcNAve9EMBPsHmviloBlgPFUPVsMNQ7/Cdou7M/QrWxE8WLd+35JQ8jZ5BsXTYHCdDrtEGg9Z62XNDk+gvNpTjCvTFq2ZPZ7kSn3NjBJxfFW3yt0VmZZC9A0bfnn9Ij46vOZmMjyAd3gfKappRNb2Lno0bDYZyvObWbAZvOOxSwvsuGFRYJ5ow==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ae553c-2d66-430c-1869-08d83dc1af8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2020 06:42:15.3891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ywC6Sp0iXT5uGBdyjeIpzNpeiBmvlLGh6NwFDoSzBdONnbOhrE5D44P08USE2flhseUmFUz4Kb4JangwyatovA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1257
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/08/11 15:38, Qiu Wenbo wrote:=0A=
> Exception vector is missing on nommu platform and it is a big issue.=0A=
> This patch is tested in Sipeed MAIX Bit Dev Board.=0A=
> =0A=
> Fixes: 79b1feba5455 ("RISC-V: Setup exception vector early")=0A=
> Signed-off-by: Qiu Wenbo <qiuwenbo@phytium.com.cn>=0A=
> ---=0A=
>  arch/riscv/kernel/smpboot.c |  1 +=0A=
>  arch/riscv/kernel/traps.c   | 11 ++++++++++-=0A=
>  2 files changed, 11 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c=0A=
> index 356825a57551..23cde0ceb39d 100644=0A=
> --- a/arch/riscv/kernel/smpboot.c=0A=
> +++ b/arch/riscv/kernel/smpboot.c=0A=
> @@ -154,6 +154,7 @@ asmlinkage __visible void smp_callin(void)=0A=
>  	mmgrab(mm);=0A=
>  	current->active_mm =3D mm;=0A=
>  =0A=
> +	trap_init();=0A=
>  	notify_cpu_starting(curr_cpuid);=0A=
>  	update_siblings_masks(curr_cpuid);=0A=
>  	set_cpu_online(curr_cpuid, 1);=0A=
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c=0A=
> index ad14f4466d92..a390239818ae 100644=0A=
> --- a/arch/riscv/kernel/traps.c=0A=
> +++ b/arch/riscv/kernel/traps.c=0A=
> @@ -174,7 +174,16 @@ int is_valid_bugaddr(unsigned long pc)=0A=
>  }=0A=
>  #endif /* CONFIG_GENERIC_BUG */=0A=
>  =0A=
> -/* stvec & scratch is already set from head.S */=0A=
> +/* stvec & scratch is already set from head.S when mmu is enabled */=0A=
>  void trap_init(void)=0A=
>  {=0A=
> +#ifndef CONFIG_MMU=0A=
> +	/*=0A=
> +	 * Set sup0 scratch register to 0, indicating to exception vector=0A=
> +	 * that we are presently executing in the kernel=0A=
> +	 */=0A=
> +	csr_write(CSR_SCRATCH, 0);=0A=
> +	/* Set the exception vector address */=0A=
> +	csr_write(CSR_TVEC, &handle_exception);=0A=
> +#endif=0A=
>  }=0A=
> =0A=
=0A=
Looks OK to me. But out of curiosity, how did you trigger a problem ? I nev=
er=0A=
got any weird exceptions with my busybox userspace.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
