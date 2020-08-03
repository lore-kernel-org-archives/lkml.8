Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAE1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85F972054F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QdS9G0NF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgHCPTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 11:19:04 -0400
Received: from mail-mw2nam12on2136.outbound.protection.outlook.com ([40.107.244.136]:44992
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726770AbgHCPTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:19:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OALnOdLHq0/GdnJUqXCWoPa3m0DMWKinChAXlFls4P6Ms6lbLYJYzeEn9OroMWVJZeesAJzdYIVe0Dyi1JNAdCEztn9lW7l8HmYfGZEcqoZiEYZf+RxQGrxvXVq0cOoCMxGpkEiVkednZpZJibePdgcYWRvSMcw2Xzfaere7QcRgJ0HceQooPG33uH7YmK52QJnlqiUhCiF7Eo7b17pLfQSGbfCI4azX5MXkCDlg5a4DQC8IkioBWsWKTpSjWZH9Q2V2BeRn/UIcFkDXo+gEpT6sfDFlMCBboTeR/xc6N7zC1EaKFpCrzpW8wML02CM40SMzkHed6SVXE6Ke5OqXyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDQswL0HLxniXGC2qI6m0R4UuLNVUo3MLji+9186uMM=;
 b=ihjvLJho/lH2RuRlDutMHRV1Vctj21mJRyDQqFuitGmNKELVV0QFLieIPUnqpKtAYRmc2ILomHllFruG23EjnmcBl8HODBNcai2yFh/YHv0mS9ZMStmZX6MUhasp1NfaQbxlDFb5cMpKfDkvIl+IQQYqaFOfaOCw3CeUqRdu5ZlZWr+ePlCrQvipKfI9ZfX2SK4mdYQbUHtzDBBHeT2Yff6ZSfiXeBPFv8n85iGc2Jo3UUltUqBnKWLTwDAiWK/ImLXH7Ph+ovNSscOoCtMv2tJEzk0k7N5k49p0HZ6FRXbgyAbnSa6dpZnU4Bo6pg8XBym4rVq3OXoasvf9QrmX8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDQswL0HLxniXGC2qI6m0R4UuLNVUo3MLji+9186uMM=;
 b=QdS9G0NFQatOQj9uamGxtHx5eUq2q0N4Xb1WNSl/4HpqMSLnemqmjZ6MuiXUS2QZiH9ax5N3MSptjdK1TJsegpO96lQawxh8C+CoqF69fP6MUqkADlwOsAQTES1Gv8bTvvdlmgj1gEeC9fTBymhtSG23HIFs3MjYNm2SbDbkj9I=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1116.namprd21.prod.outlook.com (2603:10b6:302:a::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.0; Mon, 3 Aug
 2020 15:18:57 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::fc14:3ca6:8a8:7407]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::fc14:3ca6:8a8:7407%9]) with mapi id 15.20.3283.003; Mon, 3 Aug 2020
 15:18:57 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "peterz@infradead.org" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     "mbenes@suse.de" <mbenes@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "jgross@suse.com" <jgross@suse.com>
Subject: RE: [RFC][PATCH] objtool,x86_64,paravirt: Add pv_ops[] support
Thread-Topic: [RFC][PATCH] objtool,x86_64,paravirt: Add pv_ops[] support
Thread-Index: AQHWaaMataTupqtrCkGZBJuC2TRAzqkmfhxw
Date:   Mon, 3 Aug 2020 15:18:57 +0000
Message-ID: <MW2PR2101MB10521C4F5E19F12E174623F7D74D0@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200803143231.GE2674@hirez.programming.kicks-ass.net>
In-Reply-To: <20200803143231.GE2674@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-08-03T15:18:55Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fda95f16-6fb4-4765-a491-d2b1e38b8bda;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9f482575-b6ba-46f4-26da-08d837c08aa8
x-ms-traffictypediagnostic: MW2PR2101MB1116:
x-microsoft-antispam-prvs: <MW2PR2101MB1116BFFB7E1EC108A63C71FFD74D0@MW2PR2101MB1116.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:220;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TCh1Om5drRsp7tUxm+MTs1p9Y2w1aW1de8+SWw6HiPMDtGJc4L9qHEcLaW0heoPBghwiyIj7uR9VSS7Yx7q8juAEFw62bguVEwnLW/3Vxir2AUbfPST/Z9iYpDfU0QB5XJPL3HzUgOzF1UkjjouPSfqLQLGq3WC5kxyShqbTp6elzqwAN78CLTBUS+qJAzzhFnCREHulJxYdpsFS4VVaoWEP9aaHPlnOYDc3mEkLfHdWvTgEX/YQzZWSwGEbPq9Rb4nOO0APkibyi6YrTuKfWvQ+pIPYj0FyE5H84g+S9/b2G2ySqu4l054gTc7MAaPP1fulFJTXHyYgdZlYgIll0xEkMQET+BiQkS3DdrvB374YMCwE0ayDgGbBmhsME1Oa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(8676002)(82950400001)(82960400001)(8990500004)(10290500003)(26005)(52536014)(33656002)(186003)(86362001)(76116006)(478600001)(66476007)(66556008)(64756008)(66446008)(6506007)(71200400001)(7696005)(66946007)(4326008)(110136005)(9686003)(2906002)(83380400001)(55016002)(5660300002)(316002)(54906003)(8936002)(142933001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Sqwhiwggqf0FkCDmswInoKRbclZFwVzR/3rQ4nd9zq6vz19Lijh5ffYZWabm8J0rPw+6VxI0GFH59lmksBXzkkzewW6NrBLCgTiFhBcqvXpaVkgSmO1DM0N45UrSDYSYwGY+e0Kzi3YWtMPxyTiaFOXwsC4oCsgX09RjD4Sup/TRGxSsTTYwjR8HQkst31Wk6Z126lO4EQ2jBOPreO3Glz9rMMFkeXl8ar+66YKdRCMr54Y8oA5CTKBtyfvAPI1xuOtS0BRMzDOnXXWjzMFmPHYdO+VlBNXigt5JUbiH2r1ZVkbOoP/OZOVa41qtzuzS8o3v9/4Q4d2wZYWGt6+fIEJO0bpomVyBqk7TTrBOOYVvHESWSL80jYr5kjZwTzVExvTUHCgSj4TNG9yIfdcWfdxcyQLDzSznKbsUcZH5ImHeAb8FhJT/JTUYU2mQgiDiRbzQ8aUsuZIdOCL4TNT2XIgcoF7X69/4dhfUadecJhGRmAXCLCqyWSGX1mE7NNu/Bg5tDxx84Y9MRn38MH8Dj+WwEIfm98ztwDyZU1Mu41tZ4zTU2rV8EGpL8Sti29tj27WS03qxp+42a1QnW25djuyeLAEBySoRxopiwtik9oL51V6vNaZqynYwvKRpjJb7ZbzrkPKDvbI9hxY+I5RYSg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f482575-b6ba-46f4-26da-08d837c08aa8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2020 15:18:57.2109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ilrmMdxgAA7LgvHyICjniuT3/9H1CFOMsXgfrywiLRjIRn6mmagsv/fq0nXMlgmoaCJIBUFC0gHlOIk+VoezoW1dUrW7FeokgCFp8pilruw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: peterz@infradead.org Sent: Monday, August 3, 2020 7:33 AM
>=20
> Thomas wanted paramuck vs noinstr, here goes. Very rough, very nasty,
> mostly works.
>=20
> It requires call sites are the normal indirect call, and not mangled
> retpoison (slow_down_io() had those), it also requires pv_ops[]
> assignments are single instructions and not laundered through some
> pointless intermediate helper (hyperv).
>=20
> It doesn't warn when you get any of that wrong.
>=20
> But if you have it all lined up right, it will warn about noinstr
> violations due to paramuck:
>=20
> $ ./objtool check -afl ../../defconfig-build/vmlinux.o
> ../../defconfig-build/vmlinux.o: warning: objtool: xen_pv_evtchn_do_upcal=
l()+0x69: return
> with instrumentation enabled
> ../../defconfig-build/vmlinux.o: warning: objtool: exc_double_fault()+0x1=
5: call pv_ops[48]
> from noinstr
> ../../defconfig-build/vmlinux.o: warning: objtool: pv_op[48]: xen_read_cr=
2
> ../../defconfig-build/vmlinux.o: warning: objtool: exc_double_fault()+0x1=
5: call to
> {dynamic}() leaves .noinstr.text section
> ../../defconfig-build/vmlinux.o: warning: objtool: exc_debug()+0x29: call=
 pv_ops[4] from
> noinstr
> ../../defconfig-build/vmlinux.o: warning: objtool: pv_op[4]: native_get_d=
ebugreg
> ../../defconfig-build/vmlinux.o: warning: objtool: exc_debug()+0x29: call=
 to {dynamic}()
> leaves .noinstr.text section
> ../../defconfig-build/vmlinux.o: warning: objtool: noist_exc_debug()+0x26=
: call pv_ops[4]
> from noinstr
> ../../defconfig-build/vmlinux.o: warning: objtool: pv_op[4]: native_get_d=
ebugreg
> ../../defconfig-build/vmlinux.o: warning: objtool: noist_exc_debug()+0x26=
: call to
> {dynamic}() leaves .noinstr.text section
> ../../defconfig-build/vmlinux.o: warning: objtool: exc_nmi()+0x3a: call p=
v_ops[48] from
> noinstr
> ../../defconfig-build/vmlinux.o: warning: objtool: pv_op[48]: xen_read_cr=
2
> ../../defconfig-build/vmlinux.o: warning: objtool: exc_nmi()+0x3a: call t=
o {dynamic}() leaves
> .noinstr.text section
> ../../defconfig-build/vmlinux.o: warning: objtool: mce_setup()+0x80: call=
 pv_ops[25] from
> noinstr
> ../../defconfig-build/vmlinux.o: warning: objtool: pv_op[25]: native_cpui=
d
> ../../defconfig-build/vmlinux.o: warning: objtool: mce_setup()+0x80: call=
 to {dynamic}()
> leaves .noinstr.text section
> ../../defconfig-build/vmlinux.o: warning: objtool: do_machine_check()+0x4=
6: call to
> mce_rdmsrl() leaves .noinstr.text section
> ../../defconfig-build/vmlinux.o: warning: objtool: exc_machine_check()+0x=
24: call
> pv_ops[4] from noinstr
> ../../defconfig-build/vmlinux.o: warning: objtool: pv_op[4]: native_get_d=
ebugreg
> ../../defconfig-build/vmlinux.o: warning: objtool: exc_machine_check()+0x=
24: call to
> {dynamic}() leaves .noinstr.text section
> ../../defconfig-build/vmlinux.o: warning: objtool: noist_exc_machine_chec=
k()+0x24: call
> pv_ops[4] from noinstr
> ../../defconfig-build/vmlinux.o: warning: objtool: pv_op[4]: native_get_d=
ebugreg
> ../../defconfig-build/vmlinux.o: warning: objtool: noist_exc_machine_chec=
k()+0x24: call to
> {dynamic}() leaves .noinstr.text section
> ../../defconfig-build/vmlinux.o: warning: objtool: exc_page_fault()+0xe: =
call pv_ops[48]
> from noinstr
> ../../defconfig-build/vmlinux.o: warning: objtool: pv_op[48]: xen_read_cr=
2
> ../../defconfig-build/vmlinux.o: warning: objtool: exc_page_fault()+0xe: =
call to {dynamic}()
> leaves .noinstr.text section
> ../../defconfig-build/vmlinux.o: warning: objtool: .entry.text+0xf17: cal=
l pv_ops[32] from
> noinstr
> ../../defconfig-build/vmlinux.o: warning: objtool: .entry.text+0x12f1: ca=
ll pv_ops[35] from
> noinstr
> ../../defconfig-build/vmlinux.o: warning: objtool: .entry.text+0xf5a: cal=
l pv_ops[32] from
> noinstr
> ../../defconfig-build/vmlinux.o: warning: objtool: .entry.text+0x1002: ca=
ll pv_ops[32] from
> noinstr
> ../../defconfig-build/vmlinux.o: warning: objtool: .entry.text+0x1186: ca=
ll pv_ops[32] from
> noinstr
> ../../defconfig-build/vmlinux.o: warning: objtool: .entry.text+0x12ba: ca=
ll pv_ops[32] from
> noinstr
> ../../defconfig-build/vmlinux.o: warning: objtool: .entry.text+0x12a7: ca=
ll pv_ops[32] from
> noinstr
> ../../defconfig-build/vmlinux.o: warning: objtool: .entry.text+0x124c: ca=
ll pv_ops[32] from
> noinstr
> ../../defconfig-build/vmlinux.o: warning: objtool: .entry.text+0x14f0: ca=
ll pv_ops[32] from
> noinstr
> ../../defconfig-build/vmlinux.o: warning: objtool: .entry.text+0x1683: ca=
ll pv_ops[32] from
> noinstr
>=20
> [ funny that, WTH does x86_64 have IRET pv_ops... ]
>=20
> Requested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/include/asm/paravirt.h    |   8 +--
>  arch/x86/kernel/cpu/mshyperv.c     |   7 ---
>  drivers/clocksource/hyperv_timer.c |   7 +++
>  include/asm-generic/mshyperv.h     |   1 -
>  lib/Kconfig.debug                  |   2 +-
>  tools/objtool/Makefile             |   2 +-
>  tools/objtool/arch.h               |   2 +-
>  tools/objtool/arch/x86/decode.c    |  30 ++++++++-
>  tools/objtool/builtin-check.c      |  10 +--
>  tools/objtool/builtin-orc.c        |  10 +--
>  tools/objtool/check.c              | 126 +++++++++++++++++++++++++++++++=
+++---
>  tools/objtool/elf.h                |   1 +
>  tools/objtool/objtool.c            |  46 ++++++++++++++
>  tools/objtool/objtool.h            |   9 +++
>  14 files changed, 218 insertions(+), 43 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/parav=
irt.h
> index 3d2afecde50c..db30b35f0d59 100644
> --- a/arch/x86/include/asm/paravirt.h
> +++ b/arch/x86/include/asm/paravirt.h
> @@ -39,11 +39,11 @@ static inline u64 paravirt_steal_clock(int cpu)
>  /* The paravirtualized I/O functions */
>  static inline void slow_down_io(void)
>  {
> -	pv_ops.cpu.io_delay();
> +	PVOP_VCALL0(cpu.io_delay);
>  #ifdef REALLY_SLOW_IO
> -	pv_ops.cpu.io_delay();
> -	pv_ops.cpu.io_delay();
> -	pv_ops.cpu.io_delay();
> +	PVOP_VCALL0(cpu.io_delay);
> +	PVOP_VCALL0(cpu.io_delay);
> +	PVOP_VCALL0(cpu.io_delay);
>  #endif
>  }
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index af94f05a5c66..31125448b174 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -361,13 +361,6 @@ static void __init ms_hyperv_init_platform(void)
>  #endif
>  }
>=20
> -void hv_setup_sched_clock(void *sched_clock)
> -{
> -#ifdef CONFIG_PARAVIRT
> -	pv_ops.time.sched_clock =3D sched_clock;
> -#endif
> -}
> -
>  const __initconst struct hypervisor_x86 x86_hyper_ms_hyperv =3D {
>  	.name			=3D "Microsoft Hyper-V",
>  	.detect			=3D ms_hyperv_platform,
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyp=
erv_timer.c
> index 09aa44cb8a91..bed769a84637 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -418,6 +418,13 @@ static struct clocksource hyperv_cs_msr =3D {
>  	.flags	=3D CLOCK_SOURCE_IS_CONTINUOUS,
>  };
>=20
> +static __always_inline void hv_setup_sched_clock(void *sched_clock)
> +{
> +#ifdef CONFIG_PARAVIRT
> +	pv_ops.time.sched_clock =3D sched_clock;
> +#endif
> +}
> +

Moving this function to hyperv_timer.c is problematic because we
want hyperv_timer.c to be architecture independent.  We're in the
process of supporting Linux guests running on Hyper-V on ARM64, and
there's a different implementation of hv_setup_sched_clock() on ARM64.

Michael


>  static bool __init hv_init_tsc_clocksource(void)
>  {
>  	u64		tsc_msr;
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index 1c4fd950f091..c5edc5e08b94 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -168,7 +168,6 @@ void hyperv_report_panic_msg(phys_addr_t pa, size_t s=
ize);
>  bool hv_is_hyperv_initialized(void);
>  bool hv_is_hibernation_supported(void);
>  void hyperv_cleanup(void);
> -void hv_setup_sched_clock(void *sched_clock);
>  #else /* CONFIG_HYPERV */
>  static inline bool hv_is_hyperv_initialized(void) { return false; }
>  static inline bool hv_is_hibernation_supported(void) { return false; }
