Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB120C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 05:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8313820639
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 05:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="a2cE9JkZ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jPHwQ+Uf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgHMFo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 01:44:29 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:29550 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgHMFo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 01:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1597297465; x=1628833465;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=VPQz8IxI9/oGXrZ1QcjMY9RQIAhAKUkXx2+U9b0cV3Q=;
  b=a2cE9JkZbgyAl8RySlcm4hdO9QYgetvBli6xhalkYfoMmglThYRj2Tjn
   fPAOSvVakEtP1KmffZYP5+xv6iDb/NmGO8IGQ+iEnuAy1SgGR1OM3L3D1
   dKJcMeSTWAHH6rlpdNZHsHIesQ6x7kMWZ6VCKz06BPzmlTyvtJq3GoOfP
   JVN1mw6CJLt7S3QRxT1NITzzqswT1crpSnWdY0b0jCXfEnjXS8yXwWJ2E
   ogdC3r0yT+SzcU8nAU731u8fvq235T9qdLPYkyvIG+ifyg+l4ZKlre+Fz
   90rojjkJ/qdzMhi0k/KnB93wFUhCSPtHmg+xXPTrBmpCKYhwLrNHtO38S
   g==;
IronPort-SDR: 3hgCY5vNACav+kZumUs/VkQWMSqMysKP7xEL3JhTyDLySyH4N1x79h73Q9eaVBJj4DmwPt9CAN
 m9BL30wcdQp518jtnkubW6AiAhK4wQHY1HGCof7+SBaa5ItWo1om+7dJcwql/Ap/IVOe09K2KQ
 foDfw8uGNL4VyeJ0H89RnEaL2KuqiGUuDA235ayBi97IdEvcw12wjJtKMFOJXKEVjKi4znZs56
 wIeAzQ3wxQHrW5wHlL+P1Fz8Z27GXHraRwKkOxxbfVtlXr4tFGjDH5sDEPKWaOkE5OqZLPRqac
 ccE=
X-IronPort-AV: E=Sophos;i="5.76,307,1592841600"; 
   d="scan'208";a="144875969"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2020 13:44:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9dGfFjIvGHdk08rfRiFtfI9NU94yzw1JkE/A7+ntytAWBbjgBpMtoakyxdHnEYuWlXVdqZymvi7SIW/3FaEhWONvAXDVc9lzDO21MHKTPJlcC9OdvRt9IfKSgwEj+EmmWS+wzlhS87pa7rSOKQZB4F4rNvhwBBumGvTKGZyvnRGXMmE/XU/JiuadywsGyqlylo9FvvFZ9teIzhfbh8nFcYGx2cMg/CnypNP5YlO8nEPWEkstzSBUUXk3sZC3Rp1pkd6KSvAsajU/Q6qlZgXY5Ekxrpz5oe7Dak9tK2/tvkmJEOYPvys4Of5Fk7Ggtas3ghnmKii6D9JCXMroD3lcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34xs8n5uYERYa/Yc/CdANBRTaCodMkzjDIoWQw41a6g=;
 b=lLsAdxgfyHcDP0neplgmhZKX4NXv0ANhoIojOewsPdtNuobRBGN+C9/SZaPIp2oTZi6Zsm0gBDIgNOirUzYA8pIQX2dQtB7DWFnQrCN0WI4sVCsnH+RYVfATCEP55/FhyDA3ViPi3lknSoF1pSQEWzlKgMy8C8UKy08VkAbJeyXgIaMl5ArcQHlFxURyD5RI8PlO9HUzv8kuHEYm309il+FfFiQGoLkOjrzCMbbMpiVaVkfcZzi6qtLS0wNoLQXme87Z3NGrMNI6/j0Bx8yS9ehwG7Mh90Gte3a+fZeVhg/QcQ30oDPG4SozUvmqOXRAoEoRGfu3eSYLvlDLOtWTsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34xs8n5uYERYa/Yc/CdANBRTaCodMkzjDIoWQw41a6g=;
 b=jPHwQ+UfX/z17HU8K6YYZp/eEPxM8RRdEKkI74oFUL0L+9WGuN7SpsP6+QHnka0O4W0+CUyEPq+P2i6ax78641mdjCYOu07ydFiPb1ztTJBx4qovhqG5dL2JF6UOMlobgkIUSZ4UF9L2KohLexqCnq6NbK4RvWkrpzb/Sm59ZGI=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR0401MB3634.namprd04.prod.outlook.com (2603:10b6:910:8f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Thu, 13 Aug
 2020 05:44:24 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2%12]) with mapi id 15.20.3283.016; Thu, 13 Aug
 2020 05:44:24 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Qiu Wenbo <qiuwenbo@phytium.com.cn>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
CC:     Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <Anup.Patel@wdc.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] riscv: Setup exception vector for nommu platform
Thread-Topic: [PATCH v2] riscv: Setup exception vector for nommu platform
Thread-Index: AQHWcSODcO8pwfBnAUaNkuIfFTKGFA==
Date:   Thu, 13 Aug 2020 05:44:23 +0000
Message-ID: <CY4PR04MB3751ECCFBE6B590E9D0850B0E7430@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200813033807.19556-1-qiuwenbo@phytium.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: phytium.com.cn; dkim=none (message not signed)
 header.d=none;phytium.com.cn; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:8019:b5ea:f0ff:8b24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 27317199-cc1d-4ee8-c63e-08d83f4bef31
x-ms-traffictypediagnostic: CY4PR0401MB3634:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR0401MB363484B257E91EC54D5DBB9EE7430@CY4PR0401MB3634.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cxwA8otTWIZtDEIq+CHLkRMb8wRFto7ymXp2t4SQCr6gDagvCU1ZiPq6BnnmTewhREe2ibUR+DaannhG3Ru600ovcmv2yKGN1cRf9Y/rRVQVVHPCvdutjcouprSx3wWYgkMH5wxyGmWYVwWzeo8ySmZLgwEi9Ta9ftMqcVYQtqA5H/1AseLB8Hk3ZY+0M7o8k6uW/52AK3NKeZOG/mT4J36MPr8JKU8cN+3Cx+K75D52Ze+Q5iuosC82Q8DTvXjFawwI5AC+ieBy2dsz74AG1/Pvr+EUIutXW6tN7VaZKI/c4Gsox/eRW6qc/vFFkqLdcnCVabgbOYxvPbdTzol3xA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(7696005)(64756008)(66476007)(66556008)(2906002)(76116006)(8676002)(66946007)(66446008)(91956017)(6506007)(8936002)(86362001)(316002)(52536014)(55016002)(71200400001)(33656002)(54906003)(186003)(478600001)(83380400001)(5660300002)(9686003)(110136005)(4326008)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: N9veZa7o5IFv1xX4y/5nEiDcq3aR0qa3caG50DLGHZuuoCBoTK/+f60rvmpG+wwXqh65j+0gwWBboaONGJRX+4yGeUhXobwCVBf7GlnLo8H1xMzLek7f/uRkL09AepXi/SbKy2MwvEn95DPD8EpD2OT/ED+ssNisE3oufozIJr3+tWz7aAph2PFuO2SXgE6s5SWn0gq3WsNl4CjNMN5qaCe176F9R+eVa58is+gF/XQIbGxvmIRfuBlyrqMGfLn+HRmRLrYv0ByLpWnJvITaNg/DBwTk4KkO4l46bPASPUzQQAr2ODjOkRGkTMLljQ2EfY7Zq4UwngBBFbFqzLFZll302P3ZZUUDcZC9wqKAxI950PRDURqc5i5bIa1ZG5tk2TAK1ovbLQW/HwQq1YQu5NAjR0/DNflfIBwnKFVTrWMta5hxmleL89gsRlSO9KDL4+lmNBSq2cf+6GVGIku3Uy3WkQYDwxbJ/e2Bdc1uZyRuFOfndV5wvEWHdaLWYTZPs+wKPRKfDUR/8Ti9IxEmjNRbBWoMryIPWtd83Vaab9N3H+irQIUae7hTJS1Br+auLBzs4QFf+GevfljkQGWbNuvKEpeUi6GuFtzvRlA7Zwa8kVvmrbehRgpmWeQR2tUdodU1CiaCmzvzkjKzDfIh/vvOQ5cH7F2+Xn3OHKtP3SgilLqlyalSzVDRR97Fpd++OXyuR7sLAG7E3bLgvyjG/Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27317199-cc1d-4ee8-c63e-08d83f4bef31
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2020 05:44:23.8989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Jk1F4pwkpRCUNJbdhtJ/yLW+b7T9+kMJvkljsfvx26jfRz0PL5Hcg9ByFDy7OqB3JwyVQEmURqGPyy/4PBeCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3634
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/08/13 12:40, Qiu Wenbo wrote:=0A=
> Exception vector is missing on nommu platform and that is an issue.=0A=
> This patch is tested in Sipeed Maix Bit Dev Board.=0A=
> =0A=
> Fixes: 79b1feba5455 ("RISC-V: Setup exception vector early")=0A=
> Suggested-by: Anup Patel <anup@brainfault.org>=0A=
> Suggested-by: Atish Patra <atishp@atishpatra.org>=0A=
> Signed-off-by: Qiu Wenbo <qiuwenbo@phytium.com.cn>=0A=
=0A=
Please add a cc stable #5.8 tag. Kendryte support is in 5.8 stable.=0A=
=0A=
> ---=0A=
>  arch/riscv/kernel/head.S | 25 +++++++++++++++++--------=0A=
>  1 file changed, 17 insertions(+), 8 deletions(-)=0A=
> =0A=
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S=0A=
> index d0c5c316e9bb..0a4e81b8dc79 100644=0A=
> --- a/arch/riscv/kernel/head.S=0A=
> +++ b/arch/riscv/kernel/head.S=0A=
> @@ -77,16 +77,10 @@ relocate:=0A=
>  	csrw CSR_SATP, a0=0A=
>  .align 2=0A=
>  1:=0A=
> -	/* Set trap vector to exception handler */=0A=
> -	la a0, handle_exception=0A=
> +	/* Set trap vector to spin forever to help debug */=0A=
> +	la a0, .Lsecondary_park=0A=
>  	csrw CSR_TVEC, a0=0A=
>  =0A=
> -	/*=0A=
> -	 * Set sup0 scratch register to 0, indicating to exception vector that=
=0A=
> -	 * we are presently executing in kernel.=0A=
> -	 */=0A=
> -	csrw CSR_SCRATCH, zero=0A=
> -=0A=
>  	/* Reload the global pointer */=0A=
>  .option push=0A=
>  .option norelax=0A=
> @@ -144,9 +138,23 @@ secondary_start_common:=0A=
>  	la a0, swapper_pg_dir=0A=
>  	call relocate=0A=
>  #endif=0A=
> +	call setup_trap_vector=0A=
>  	tail smp_callin=0A=
>  #endif /* CONFIG_SMP */=0A=
>  =0A=
> +.align 2=0A=
> +setup_trap_vector:=0A=
> +	/* Set trap vector to exception handler */=0A=
> +	la a0, handle_exception=0A=
> +	csrw CSR_TVEC, a0=0A=
> +=0A=
> +	/*=0A=
> +	 * Set sup0 scratch register to 0, indicating to exception vector that=
=0A=
> +	 * we are presently executing in kernel.=0A=
> +	 */=0A=
> +	csrw CSR_SCRATCH, zero=0A=
> +	ret=0A=
> +=0A=
>  .Lsecondary_park:=0A=
>  	/* We lack SMP support or have too many harts, so park this hart */=0A=
>  	wfi=0A=
> @@ -240,6 +248,7 @@ clear_bss_done:=0A=
>  	call relocate=0A=
>  #endif /* CONFIG_MMU */=0A=
>  =0A=
> +	call setup_trap_vector=0A=
>  	/* Restore C environment */=0A=
>  	la tp, init_task=0A=
>  	sw zero, TASK_TI_CPU(tp)=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
