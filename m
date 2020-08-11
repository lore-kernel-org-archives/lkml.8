Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87134C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 06:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53BE2207DE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 06:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="F5nqGLyW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="k7Y8rG6u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgHKGnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 02:43:35 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:65437 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728167AbgHKGne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 02:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1597128213; x=1628664213;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=U49r4I1lDQLUgTabmIHp8Y2JyapUHa4WpJMMFFud1Fg=;
  b=F5nqGLyWkIUx7aTvHDVGiwQADTicsxsarVHrI06am0hZHEl9HlMf+cNx
   VuJHhJlLFEA1KLSkkuUx1+k9imxDlRXruw7nfJdBgAf7Uc+OlHSVWtpwy
   MlFdeklhYSYQxNoO9wq4hvHSihPiqlI/FNk1zEE4Y/BO28k8vpixosk8U
   n/BXXRV1ECBMUHwTtaPUH68NS4Qx4iAolXh/1tI4Ue6xTcqB94JTFJJta
   3DA/1nLvevK/l4tVBAaA9ke3FWT/NrCUdx7hmIAMcW3J6MBwBD6OYzYF/
   TAwCnV/YqlJnttsmks5L8WdllxSkqvHhP3Ui7pB1n8z3TOHlEM3UPZrUy
   g==;
IronPort-SDR: 5Iw5noI7cCHmrRqvbhScvITdE11NH860KYpoOCt2o5OOWVk0PlKxQeGTLHp/6dORdECZV8ruLW
 MCUCqTSusRVdceDSelHJwk/kozWasf86NR9VGI8VG17dzPmFK/M8l4AhHkFoz+TFf+f1h8LIxg
 blOVcck+67nPv3e0xE5Ad/A1/x3nwBcyY5du2acNKsLQVKzvUHD/mzb/z7WSVnjEHdiPapS/EY
 1eqYdFHtftT+gS/p+tbbQx6NiKgz22tG+0a3MMeYL6uz2JhGBwL5/XBbk8pSWLYubGQIMKsu4b
 Im0=
X-IronPort-AV: E=Sophos;i="5.75,460,1589212800"; 
   d="scan'208";a="144642963"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 14:43:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+Hkb0DBItr1a50EpdxB4O92YYt+N9DD/pLDzgeK/7FnX4U7K9E0qZj1GNVvYbjDz8q/aim88M5SPYRB0+TQI5vh0kMNdOlb3awZZafmjF+rJ5bBxPcYADwDfc9RR9Oc8RvHKlcehS8uKTvi95RXIgqLqyUy/RvZdE0VnEEJtqu20asFh+2sO7b2eFA9K0xiwr+032Ou7BoiIjbvq2bgDfgijzSmB/OwIPzsRLRr/GPBN9e5CrfLh5KtAQoU3534q4toV1B45uiuzepfMN7DDhMkjJ3pEAfvMG918Tqu/hK94l2qsiSsDdNbnqR51QwyfTGqdE8Bsu/Q8+6HXzhkxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4x3t0V1XMnNedfp+feQJcau03P4tzz2Yju7uSJZZTM=;
 b=dNCIROkpNmtqCFaTVM0+vlJTmwNPm9vmtqHXK362vS0AsZS7KCeYEkMbKP2TDNTlOTkLAWfuu+gumeYDssSVii14JOUpOGWiLm89lZzBEZAzfQuIpG330sq5ZcZuisM98TOAAJAS5ZaKuI8A6xITqAyAXrogRyzf35AJ8oeF7MZSz2fn6gOXxVqjLq7T/0VwcpceXjNRkHwio3IDUQqJDu58EB0gurm6gwNvQ9qVBsPWOBdu8LxKNtB8FFS8MjTueDw8tI7PcMYF2Y+7I6xESq3sY7YTUfM/vMjQlfUG8f2MVv8KYUdrl/eQ6BtQdzeOjN/zhdxqdFYFkpTQoKUqMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4x3t0V1XMnNedfp+feQJcau03P4tzz2Yju7uSJZZTM=;
 b=k7Y8rG6uk3BiWbikkVp58brabZc4urgDBimJCjK7CGIte1+Qe/eFyTL5/97V05eEhDpGsDFt1SyReeJemvrE31MFUdbgjHQOIhbk9kJ9ZDMepZfrhNgpcaTuG2uGdV0Mm+sF0tNJ96dhiidntsOCJyxWG6idn8MbIaAtWqR/nFw=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (10.172.142.14) by
 CY4PR04MB1257.namprd04.prod.outlook.com (10.171.245.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19; Tue, 11 Aug 2020 06:43:31 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2%12]) with mapi id 15.20.3261.024; Tue, 11 Aug
 2020 06:43:31 +0000
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
Date:   Tue, 11 Aug 2020 06:43:31 +0000
Message-ID: <CY4PR04MB3751D3007CD1C893979D6286E7450@CY4PR04MB3751.namprd04.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 1528fa37-38e3-43a5-2327-08d83dc1dca0
x-ms-traffictypediagnostic: CY4PR04MB1257:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB1257E58432CC3C554B08C9DAE7450@CY4PR04MB1257.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Coml2ykbNBpcGrwVngn4bsNcbGNbPMqqELyVryqsLuFcvnBlqONa14VUiMgyuTjPcxA1mkny7VJ1Epxdvt8yr2iAodGjjeS7COdmnpo3Hyk/c0dKruxKWTfocNaAs3UnETjgzHEQtn4YdaY71HjuFN1Ri1RILUExsysrZTi4ReorrJNPxSpiICUaWZmIVWqJUntxHfwpxxxysiCEZ2rYQkGSFfq4zW9rH3jMtTRYc7EirlTnFdMAILnSVw8kNdFgM2pyBY4rwB5/YHDjIHqaaMM2QagPhmOGPYQ4Wn4RygFhzj68i6Z6en8U88ypSfZ24Uf4LoqtMpYEgGG278QkkQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(186003)(9686003)(7416002)(52536014)(83380400001)(5660300002)(2906002)(8936002)(66446008)(66556008)(86362001)(64756008)(26005)(55016002)(66946007)(76116006)(66476007)(91956017)(53546011)(110136005)(33656002)(54906003)(6506007)(316002)(7696005)(478600001)(4326008)(71200400001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: oWMV68k2aGqKsqWCdWl9pwrwJKeKhpY1NMF2g9iXhkVvk4KQV/CbRaZjWaZxrrtbxqAXlyg04krVY9pWZzg8mnVUfc8vfCah9IvEhiQSy16LTDUuuNAZaqZsJ86bi2uHodIqGBZoF1SlZjG8hmU5SC308pH3EB1duc6xJYB847e7HsY9/72+H+AXJwCCchnODgP2TmZs8MgnEjfVHkF/vyL+OXjg7scVnOZMMuWCNIje0ytjbfqY4YWzH3wqbxWxsIQpXzqnsoi6d//cseyKpxNKQiK+CjMcwTP4LoawurLUHN9IccVB3T5oXNORZTfgQssPpmPkgUTrtv/0O+6u/fAkBM8g4MthwjFWOjZnKb54ohisCB7rYstj6uLSKg8TbQBqboJhphJIgPYxGr9bRJV8LCtHNbeOF1YY0PvJrjfatCYgSwmUw/ywECyHKOI6i3HMXN5c/hsBmt0E3dOBAvny/LW5PcABvILvmtf3cOwLKbVyGUDXm9BXOZPMarYva+t7b5YG/odncxB9SNZp7efZB4sLYNIRzE9ghURRhPLO5t6CEEg3mMcr3DZWolzHlMA2u5I7YxZE4zdmGq2gABPnNfXAsNtxc+H8m8Nc50TY9US7eywOd/ySKPz/+2MV0vxNS1iwYc1kjYlczgXtqw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1528fa37-38e3-43a5-2327-08d83dc1dca0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2020 06:43:31.0870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V9qZlxWDGmLq511CTG7qLBRAQP70qjLYXuCEQd0/6m6rSAY0xqdcZqUuj4T+blLizwiheNJHTe+wJ91L48nwWQ==
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
=0A=
I think this needs a "Cc: stable@vger.kernel.org #5.8" too.=0A=
=0A=
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
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
