Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A54C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 20:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E3ED20724
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 20:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Rq4VdS1d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730997AbgDQU1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 16:27:45 -0400
Received: from mail-bn7nam10on2089.outbound.protection.outlook.com ([40.107.92.89]:44349
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730903AbgDQU1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 16:27:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/ledtY6bA++cbFHMnxHgigtVCmEax8/apM19Y4D/nfXuSs7QAztQDi6wMKDijqlapwXcxGjUNB9ZIlK6ht7AlYaRl0dnVVctXXktj7y82T7hOgcE6FHHmRE8vsom8SHa2eh0psGmU4SDvlk5Rf1BZEwdg7TTpbyD2PPRPhB+4EbaiEoC9vL6ynLC7+0xC0BedG2ZFIEx+MIEo0xgxqne8Rwtb4R93ZaRz/qZISgBtnV08YPdlEE7ub03hdcYkV4jL1qAOStS++91ABSB80zWqfNxXgZJGi+cDRqW2N8mFMn1Ss5eREn0VmFZJmz/MLGmddSogN9/11On7MUCZUn9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnGY2yy9MLmN0gueBemEldDXkxdlnfKFmwnbtycCL6U=;
 b=liRZCstHU+YnJ3QUmYWe8pbzbvG6E5lyOjJ0dASb8HtMBSWi5gMMi/3lr6Ww21gNufJCnqFTmottlv6bXQgSy1gDGD3Gn9C0zp6Kj4im2OvukkVOMrKCOUbdiUQqm3uQm293LKMYpbHoyZ8zfjjw2IArVYTJpB6N2acIo1TY4NjJrgpSF2yxUKY82ZtzLMbfP6vL3Qt5IDy9sGpDdM0rgBdPg7HI7Ysp4oKIUvLR2Eu3z1MtKVkmtpGOMhAwF4D/0MJYkAV/D8pDDELXRyhUSaWIybeA+sfD64isCDn8v1L1YlBb4mNcAIIhrqhmUThyxX9Bbj0YssKegmolG846kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnGY2yy9MLmN0gueBemEldDXkxdlnfKFmwnbtycCL6U=;
 b=Rq4VdS1dsRT5ElSbD4GTk3BlU2F5L0wuTXu9SyyLw+6M7lkc3ZqcYIHn4gQlxURnAlX2Taj3B5C3wMAn77wkia689/Ql6/unwqeT5CMb4YTi2FQIyuoe7lfKr8M5pU5TRiAxafBRIfsKhfKR83zOSGMc3hHQLhEGIusfhvb5MQk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2572.namprd12.prod.outlook.com (2603:10b6:907:6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Fri, 17 Apr
 2020 20:27:35 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 20:27:35 +0000
Date:   Fri, 17 Apr 2020 16:27:28 -0400
From:   Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jann Horn <jannh@google.com>, Leo Li <sunpeng.li@amd.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Harry Wentland <harry.wentland@amd.com>, mhiramat@kernel.org
Subject: Re: AMD DC graphics display code enables -mhard-float, -msse, -msse2
 without any visible FPU state protection
Message-ID: <20200417202728.w2v3frkxqsgutb7h@outlook.office365.com>
References: <CAG48ez2Sx4ELkM94aD_h_J7K7KBOeuGmvZLKRkg3n_f2WoZ_cg@mail.gmail.com>
 <4c5fe55d-9db9-2f61-59b2-1fb2e1b45ed0@amd.com>
 <20200402141308.GB20730@hirez.programming.kicks-ass.net>
 <20200409155956.GQ20760@hirez.programming.kicks-ass.net>
 <20200409170916.GR20760@hirez.programming.kicks-ass.net>
 <87a2f2fc-972d-ab9b-a29d-72f02d94e60e@amd.com>
 <20200409200125.GB2483@worktop.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y4kbkysvpam7ygts"
Content-Disposition: inline
In-Reply-To: <20200409200125.GB2483@worktop.programming.kicks-ass.net>
X-ClientProxiedBy: BN6PR10CA0041.namprd10.prod.outlook.com
 (2603:10b6:404:109::27) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56a0:11a1::2) by BN6PR10CA0041.namprd10.prod.outlook.com (2603:10b6:404:109::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend Transport; Fri, 17 Apr 2020 20:27:33 +0000
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4cc27b4e-8188-461e-8108-08d7e30dc3a7
X-MS-TrafficTypeDiagnostic: MW2PR12MB2572:|MW2PR12MB2572:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2572218D3C25B55607673DB298D90@MW2PR12MB2572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0376ECF4DD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2524.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(30864003)(45080400002)(7696005)(9686003)(81156014)(44144004)(16526019)(6666004)(186003)(5660300002)(8676002)(1076003)(52116002)(86362001)(8936002)(966005)(66574012)(4326008)(66556008)(66946007)(7416002)(6916009)(316002)(478600001)(2906002)(6506007)(54906003)(21480400003)(55016002)(66476007)(2700100001);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oPcUc0WaaIRCShP6HAfR5jmVJkunzl/HUJE+y87wOokK2nQWoGNbln2AMJ8eYg3qoOqxSWJQCd2PMQtBJoesOgn+G80+UpKuH0mmwlslqrXp9lKNM80VcAVcHSDKJTDTHgmyu6OOm7CIaAnc8xqEqFFoT/Yhb+SPT36hTdhLjZk4Icjesgm740FW2EKsaMusmgIkuo0IYwpXNAJpDvzCqf1GIoK1BbiGyxvajehRcBg8yNStqKSm9ZeLx44UpiFTT3hqT0zFzXbsXDdDOtGJfqCT/9txwgfXXvBIojYphO7FYyuIlGQgdw4R76rDuF8xHGNICde7JLjvO43ttcX32fIxAT72nF1aX0CAX6g4jJ8QGbK2Z492kdk6vQD8+GFzgUAH7Anc3QB6BHZI45YYnK/gLgNjAsEQI7FflTjdVGkrZFDQcM8uYAuC8cVcNAaZKDBvs0CmG8sU1QydXpZZyEBulgkURjiLOFbvl27hyEYhNSm2shpAFjdZO7DxNtLCeSNROnhThFGwzqRX5/cHhBVfTbeMCWyV8g3UvTA5Oj4=
X-MS-Exchange-AntiSpam-MessageData: jCSZjozWIGrMdJWsX6cNdDKkFx6dP6DdIZ2NW5LJnO5vsAXvc+QegPUsJ/V/Ix1RL9bXCTJmpBkQQtvWdyqUDhnjSx23oc9Pkgk/jEB4Ox084dSFs961L2BD9rnWcXfjV0PLX56jIv2hOP5IEkjOpAWs3MovLyKvTrctzy3I1P6Pb7Bny60fast9ms7dcWgS4PwrDsJCe/ib40Uh/1tVlsynxN+ej9cNmTRiz4/3Ha+vnXGMbpy3pELV59u739QEdLP61Iisf9px0xsK9wvkptTq2rsDdYAvG6GLn52ErMq7pImFggtUD96dkpBFylPJbGiVlkuocMAMlQ0TcM13Vcy6LMtNF4nWMPbE1Uy4+9Q1hXgmgn8X6H9YhVfdlaKKGirCMl9RAWeX+iEfkzVvNNemgVDOKrh6x+aYpS6pQP8mD0+D9q+4TbwN2uAmfNzt0frA7zbRfcFk29tLC+9QndPBvD4FC1ZndTJjZioD6d+jiSUhPUTLmOkec3hwMv9BGU8YpcmFal5YwMXtrYx/5UOYvkhROcKPjC1ICLbDqR6j2BWpjCLCZP4U17fc7flU0we42RPdHm7By1FQRLMpgwWfczDg6EjLK4Zdr3ph/qKOKJh4i4fgHqBC2TUPGCbFjY0303abHaZrE/IUWEg2ZwyrG04hBNuT/GW9CgB0nLjiaDEim3Bk0jkxekW9JKzuxu84dqIozFIMWHLm0zWXoCLQ7aJtSo4+2cy49/sHBL8AsFOeWyFA4VNLzLRxBvgCG5opSZ29m1EGGHa2yJHOLNnPDvYP9QOvc/DuGxpj1VkSvymLYx35sh+azmUMq/Cf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc27b4e-8188-461e-8108-08d7e30dc3a7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 20:27:35.6157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lw6kvlEJVtNG6AzpcsjhVCKh8FPMYFUVIRE1TNSlpy1fRjRj3YR63BwFKsPk5LaSpt9UShqsiz6c8oCfpKIA6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2572
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--y4kbkysvpam7ygts
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04/09, Peter Zijlstra wrote:
> On Thu, Apr 09, 2020 at 08:15:57PM +0200, Christian K=F6nig wrote:
> > Am 09.04.20 um 19:09 schrieb Peter Zijlstra:
> > > On Thu, Apr 09, 2020 at 05:59:56PM +0200, Peter Zijlstra wrote:
> > > [SNIP]
> > > > I'll need another approach, let me consider.
> > > Christian; it says these files are generated, does that generator know
> > > which functions are wholly in FPU context and which are not?
> >=20
> > Well that "generator" is still a human being :)
> >=20
> > It's just that the formulae for the calculation come from the hardware =
team
> > and we are not able to easily transcript them to fixed point calculatio=
ns.
>=20
> Well, if it's a human, can this human respect the kernel coding style a
> bit more :-) Some of that stuff is atrocious.
>=20
> > > My current thinking is that if I annotate all functions that are whol=
ly
> > > inside kernel_fpu_start() with an __fpu function attribute, then I can
> > > verify that any call from regular text to fpu text only happens inside
> > > kernel_fpu_begin()/end(). And I can ensure that all !__fpu annotation
> > > fuctions only contain !fpu instructions.
> >=20
> > Yeah, that sounds like a good idea to me and should be easily doable.
> >=20
> > > Can that generator add the __fpu function attribute or is that someth=
ing
> > > that would need to be done manually (which seems like it would be
> > > painful, since it is quite a bit of code) ?
> >=20
> > We are currently in the process of moving all the stuff which requires
> > floating point into a single C file(s) and then make sure that we only =
call
> > those within kernel_fpu_begin()/end() blocks.
>=20
> Can you make the build system stick all those .o files in a single
> archive? That's the only way I can do call validation; external
> relocatoin records do not contain the section.
>=20
> > Annotating those function with __fpu or even saying to gcc that all cod=
e of
> > those files should go into a special text.fpu segment shouldn't be much=
 of a
> > problem.
>=20
> Guess what the __fpu attribute does ;-)
>=20
> With the below patch (which is on to of newer versions of the objtool
> patches send earlier, let me know if you want a full set) that only
> converts a few files, but fully converts:
>=20
>   drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c
>=20
> But building it (and this is an absolute pain; when you're reworking
> this, can you pretty please also fix the Makefiles?), we get:

Hi,

I'm going to work on the FPU issues in the display code. In this sense,
could you clarify a little bit more about the Makefile issues?

Also, I applied the patch `[PATCH v4] x86: insn: Add insn_is_fpu()` and
tried to reproduce the warning that you described but I didn't see it.
Could you explain to me how I can check those warnings?

Thanks

>   drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.o: warning: ob=
jtool: dcn_validate_bandwidth()+0x34fa: FPU instruction outside of kernel_f=
pu_{begin,end}()
>=20
> $ ./scripts/faddr2line defconfig-build/drivers/gpu/drm/amd/amdgpu/../disp=
lay/dc/calcs/dcn_calcs.o dcn_validate_bandwidth+0x34fa
> dcn_validate_bandwidth+0x34fa/0x57ce:
> dcn_validate_bandwidth at /usr/src/linux-2.6/defconfig-build/../drivers/g=
pu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:1293 (discriminator 5)
>=20
> # ./objdump-func.sh defconfig-build/drivers/gpu/drm/amd/amdgpu/../display=
/dc/calcs/dcn_calcs.o dcn_validate_bandwidth | grep 34fa
> 34fa     50fa:  f2 0f 10 b5 60 ff ff    movsd  -0xa0(%rbp),%xmm6
>=20
> Which seems to indicate there's still problms with the current code.
>=20
>=20
>=20
> ---
>  arch/x86/include/asm/fpu/api.h                     | 12 +++++++++++
>  arch/x86/kernel/vmlinux.lds.S                      |  1 +
>  .../gpu/drm/amd/display/dc/calcs/dcn_calc_math.c   | 25 +++++++++++-----=
------
>  drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c   |  4 ++--
>  .../display/dc/dml/dcn20/display_rq_dlg_calc_20.c  | 10 ++++-----
>  .../amd/display/dc/dml/display_rq_dlg_helpers.c    |  2 +-
>  .../gpu/drm/amd/display/dc/dml/dml_common_defs.c   |  2 +-
>  drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c        |  2 +-
>  drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c       | 10 ++++-----
>  drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c   |  4 ++--
>  drivers/gpu/drm/amd/display/dc/inc/dcn_calc_math.h |  2 ++
>  tools/objtool/check.c                              |  7 +++++-
>  tools/objtool/elf.h                                |  2 +-
>  13 files changed, 52 insertions(+), 31 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/ap=
i.h
> index 64be4426fda9..19eaf98bbb0a 100644
> --- a/arch/x86/include/asm/fpu/api.h
> +++ b/arch/x86/include/asm/fpu/api.h
> @@ -12,11 +12,23 @@
>  #define _ASM_X86_FPU_API_H
>  #include <linux/bottom_half.h>
>=20
> +#ifdef CONFIG_STACK_VALIDATION
> +
> +#define __fpu __section(".text.fpu")
> +
>  #define _ASM_ANNOTATE_FPU(at)						\
>  		     ".pushsection .discard.fpu_safe\n"			\
>  		     ".long " #at " - .\n"				\
>  		     ".popsection\n"					\
>=20
> +#else
> +
> +#define __fpu
> +
> +#define _ASM_ANNOTATE_FPU(at)
> +
> +#endif /* CONFIG_STACK_VALIDATION */
> +
>  #define annotate_fpu() ({						\
>  	asm volatile("%c0:\n\t"						\
>  		     _ASM_ANNOTATE_FPU(%c0b)				\
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index 1bf7e312361f..8442f8633d07 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -139,6 +139,7 @@ SECTIONS
>  		SOFTIRQENTRY_TEXT
>  		*(.fixup)
>  		*(.gnu.warning)
> +		*(.text.fpu)
>=20
>  #ifdef CONFIG_RETPOLINE
>  		__indirect_thunk_start =3D .;
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.c b/drive=
rs/gpu/drm/amd/display/dc/calcs/dcn_calc_math.c
> index 07d18e78de49..57ab3aafef5a 100644
> --- a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.c
> +++ b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.c
> @@ -36,7 +36,7 @@
>   * remain as-is as it provides us with a guarantee from HW that it is co=
rrect.
>   */
>=20
> -float dcn_bw_mod(const float arg1, const float arg2)
> +__fpu float dcn_bw_mod(const float arg1, const float arg2)
>  {
>  	if (isNaN(arg1))
>  		return arg2;
> @@ -45,7 +45,7 @@ float dcn_bw_mod(const float arg1, const float arg2)
>  	return arg1 - arg1 * ((int) (arg1 / arg2));
>  }
>=20
> -float dcn_bw_min2(const float arg1, const float arg2)
> +__fpu float dcn_bw_min2(const float arg1, const float arg2)
>  {
>  	if (isNaN(arg1))
>  		return arg2;
> @@ -58,7 +58,7 @@ unsigned int dcn_bw_max(const unsigned int arg1, const =
unsigned int arg2)
>  {
>  	return arg1 > arg2 ? arg1 : arg2;
>  }
> -float dcn_bw_max2(const float arg1, const float arg2)
> +__fpu float dcn_bw_max2(const float arg1, const float arg2)
>  {
>  	if (isNaN(arg1))
>  		return arg2;
> @@ -67,25 +67,26 @@ float dcn_bw_max2(const float arg1, const float arg2)
>  	return arg1 > arg2 ? arg1 : arg2;
>  }
>=20
> -float dcn_bw_floor2(const float arg, const float significance)
> +__fpu float dcn_bw_floor2(const float arg, const float significance)
>  {
>  	if (significance =3D=3D 0)
>  		return 0;
>  	return ((int) (arg / significance)) * significance;
>  }
> -float dcn_bw_floor(const float arg)
> +
> +__fpu float dcn_bw_floor(const float arg)
>  {
>  	return ((int) (arg));
>  }
>=20
> -float dcn_bw_ceil(const float arg)
> +__fpu float dcn_bw_ceil(const float arg)
>  {
>  	float flr =3D dcn_bw_floor2(arg, 1);
>=20
>  	return flr + 0.00001 >=3D arg ? arg : flr + 1;
>  }
>=20
> -float dcn_bw_ceil2(const float arg, const float significance)
> +__fpu float dcn_bw_ceil2(const float arg, const float significance)
>  {
>  	float flr =3D dcn_bw_floor2(arg, significance);
>  	if (significance =3D=3D 0)
> @@ -93,17 +94,17 @@ float dcn_bw_ceil2(const float arg, const float signi=
ficance)
>  	return flr + 0.00001 >=3D arg ? arg : flr + significance;
>  }
>=20
> -float dcn_bw_max3(float v1, float v2, float v3)
> +__fpu float dcn_bw_max3(float v1, float v2, float v3)
>  {
>  	return v3 > dcn_bw_max2(v1, v2) ? v3 : dcn_bw_max2(v1, v2);
>  }
>=20
> -float dcn_bw_max5(float v1, float v2, float v3, float v4, float v5)
> +__fpu float dcn_bw_max5(float v1, float v2, float v3, float v4, float v5)
>  {
>  	return dcn_bw_max3(v1, v2, v3) > dcn_bw_max2(v4, v5) ? dcn_bw_max3(v1, =
v2, v3) : dcn_bw_max2(v4, v5);
>  }
>=20
> -float dcn_bw_pow(float a, float exp)
> +__fpu float dcn_bw_pow(float a, float exp)
>  {
>  	float temp;
>  	/*ASSERT(exp =3D=3D (int)exp);*/
> @@ -120,7 +121,7 @@ float dcn_bw_pow(float a, float exp)
>  	}
>  }
>=20
> -double dcn_bw_fabs(double a)
> +__fpu double dcn_bw_fabs(double a)
>  {
>  	if (a > 0)
>  		return (a);
> @@ -129,7 +130,7 @@ double dcn_bw_fabs(double a)
>  }
>=20
>=20
> -float dcn_bw_log(float a, float b)
> +__fpu float dcn_bw_log(float a, float b)
>  {
>  	int * const exp_ptr =3D (int *)(&a);
>  	int x =3D *exp_ptr;
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c b/drivers/g=
pu/drm/amd/display/dc/calcs/dcn_calcs.c
> index 3960a8db94cb..b3e305d9d1c9 100644
> --- a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
> +++ b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
> @@ -435,7 +435,7 @@ static void pipe_ctx_to_e2e_pipe_params (
>=20
>  }
>=20
> -static void dcn_bw_calc_rq_dlg_ttu(
> +static __fpu void dcn_bw_calc_rq_dlg_ttu(
>  		const struct dc *dc,
>  		const struct dcn_bw_internal_vars *v,
>  		struct pipe_ctx *pipe,
> @@ -1388,7 +1388,7 @@ static unsigned int dcn_find_normalized_clock_vdd_L=
evel(
>  	return vdd_level;
>  }
>=20
> -unsigned int dcn_find_dcfclk_suits_all(
> +__fpu unsigned int dcn_find_dcfclk_suits_all(
>  	const struct dc *dc,
>  	struct dc_clocks *clocks)
>  {
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc=
_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
> index ca807846032f..0cbb58fc7fb8 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
> @@ -115,7 +115,7 @@ static bool is_dual_plane(enum source_format_class so=
urce_format)
>  	return ret_val;
>  }
>=20
> -static double get_refcyc_per_delivery(struct display_mode_lib *mode_lib,
> +static __fpu double get_refcyc_per_delivery(struct display_mode_lib *mod=
e_lib,
>  		double refclk_freq_in_mhz,
>  		double pclk_freq_in_mhz,
>  		bool odm_combine,
> @@ -162,7 +162,7 @@ static unsigned int get_blk_size_bytes(const enum sou=
rce_macro_tile_size tile_si
>  		return (4 * 1024);
>  }
>=20
> -static void extract_rq_sizing_regs(struct display_mode_lib *mode_lib,
> +static __fpu void extract_rq_sizing_regs(struct display_mode_lib *mode_l=
ib,
>  		display_data_rq_regs_st *rq_regs,
>  		const display_data_rq_sizing_params_st rq_sizing)
>  {
> @@ -313,7 +313,7 @@ static void handle_det_buf_split(struct display_mode_=
lib *mode_lib,
>  			full_swath_bytes_packed_c);
>  }
>=20
> -static void get_meta_and_pte_attr(struct display_mode_lib *mode_lib,
> +static __fpu void get_meta_and_pte_attr(struct display_mode_lib *mode_li=
b,
>  		display_data_rq_dlg_params_st *rq_dlg_param,
>  		display_data_rq_misc_params_st *rq_misc_param,
>  		display_data_rq_sizing_params_st *rq_sizing_param,
> @@ -763,7 +763,7 @@ void dml20_rq_dlg_get_rq_reg(struct display_mode_lib =
*mode_lib,
>=20
>  // Note: currently taken in as is.
>  // Nice to decouple code from hw register implement and extract code tha=
t are repeated for luma and chroma.
> -static void dml20_rq_dlg_get_dlg_params(struct display_mode_lib *mode_li=
b,
> +static __fpu void dml20_rq_dlg_get_dlg_params(struct display_mode_lib *m=
ode_lib,
>  		const display_e2e_pipe_params_st *e2e_pipe_param,
>  		const unsigned int num_pipes,
>  		const unsigned int pipe_idx,
> @@ -1611,7 +1611,7 @@ void dml20_rq_dlg_get_dlg_reg(struct display_mode_l=
ib *mode_lib,
>  	dml_print("DML_DLG: Calculation for pipe[%d] end\n", pipe_idx);
>  }
>=20
> -static void calculate_ttu_cursor(struct display_mode_lib *mode_lib,
> +static __fpu void calculate_ttu_cursor(struct display_mode_lib *mode_lib,
>  		double *refcyc_per_req_delivery_pre_cur,
>  		double *refcyc_per_req_delivery_cur,
>  		double refclk_freq_in_mhz,
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.c =
b/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.c
> index e2d82aacd3bc..36541cba3894 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.c
> @@ -133,7 +133,7 @@ void print__rq_dlg_params_st(struct display_mode_lib =
*mode_lib, display_rq_dlg_p
>  	dml_print("DML_RQ_DLG_CALC: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
>  }
>=20
> -void print__dlg_sys_params_st(struct display_mode_lib *mode_lib, display=
_dlg_sys_params_st dlg_sys_param)
> +__fpu void print__dlg_sys_params_st(struct display_mode_lib *mode_lib, d=
isplay_dlg_sys_params_st dlg_sys_param)
>  {
>  	dml_print("DML_RQ_DLG_CALC: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
>  	dml_print("DML_RQ_DLG_CALC: DISPLAY_RQ_DLG_PARAM_ST\n");
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml_common_defs.c b/drive=
rs/gpu/drm/amd/display/dc/dml/dml_common_defs.c
> index 723af0b2dda0..e86b1d0128cf 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dml_common_defs.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dml_common_defs.c
> @@ -28,7 +28,7 @@
>=20
>  #include "dml_inline_defs.h"
>=20
> -double dml_round(double a)
> +__fpu double dml_round(double a)
>  {
>  	double round_pt =3D 0.5;
>  	double ceil =3D dml_ceil(a, 1);
> diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/dr=
m/amd/display/dc/dsc/dc_dsc.c
> index 87d682d25278..a0b0eb2f0fe3 100644
> --- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
> @@ -323,7 +323,7 @@ static inline uint32_t calc_dsc_bpp_x16(uint32_t stre=
am_bandwidth_kbps, uint32_t
>  /* Get DSC bandwidth range based on [min_bpp, max_bpp] target bitrate ra=
nge, and timing's pixel clock
>   * and uncompressed bandwidth.
>   */
> -static void get_dsc_bandwidth_range(
> +static __fpu void get_dsc_bandwidth_range(
>  		const uint32_t min_bpp,
>  		const uint32_t max_bpp,
>  		const struct dsc_enc_caps *dsc_caps,
> diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c b/drivers/gpu/d=
rm/amd/display/dc/dsc/rc_calc.c
> index 03ae15946c6d..535770930343 100644
> --- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
> @@ -40,7 +40,7 @@
>  	break
>=20
>=20
> -void get_qp_set(qp_set qps, enum colour_mode cm, enum bits_per_comp bpc,=
 enum max_min max_min, float bpp)
> +__fpu void get_qp_set(qp_set qps, enum colour_mode cm, enum bits_per_com=
p bpc, enum max_min max_min, float bpp)
>  {
>  	int mode =3D MODE_SELECT(444, 422, 420);
>  	int sel =3D table_hash(mode, bpc, max_min);
> @@ -85,7 +85,7 @@ void get_qp_set(qp_set qps, enum colour_mode cm, enum b=
its_per_comp bpc, enum ma
>  	memcpy(qps, table[index].qps, sizeof(qp_set));
>  }
>=20
> -double dsc_roundf(double num)
> +__fpu double dsc_roundf(double num)
>  {
>  	if (num < 0.0)
>  		num =3D num - 0.5;
> @@ -95,7 +95,7 @@ double dsc_roundf(double num)
>  	return (int)(num);
>  }
>=20
> -double dsc_ceil(double num)
> +__fpu double dsc_ceil(double num)
>  {
>  	double retval =3D (int)num;
>=20
> @@ -105,7 +105,7 @@ double dsc_ceil(double num)
>  	return (int)retval;
>  }
>=20
> -void get_ofs_set(qp_set ofs, enum colour_mode mode, float bpp)
> +__fpu void get_ofs_set(qp_set ofs, enum colour_mode mode, float bpp)
>  {
>  	int   *p =3D ofs;
>=20
> @@ -172,7 +172,7 @@ int median3(int a, int b, int c)
>  	return b;
>  }
>=20
> -void calc_rc_params(struct rc_params *rc, enum colour_mode cm, enum bits=
_per_comp bpc, float bpp, int slice_width, int slice_height, int minor_vers=
ion)
> +__fpu void calc_rc_params(struct rc_params *rc, enum colour_mode cm, enu=
m bits_per_comp bpc, float bpp, int slice_width, int slice_height, int mino=
r_version)
>  {
>  	float bpp_group;
>  	float initial_xmit_delay_factor;
> diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c b/drivers/g=
pu/drm/amd/display/dc/dsc/rc_calc_dpi.c
> index 1f6e63b71456..38b3c4ac96dd 100644
> --- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
> +++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
> @@ -98,7 +98,7 @@ static void copy_rc_to_cfg(struct drm_dsc_config *dsc_c=
fg, const struct rc_param
>  		dsc_cfg->rc_buf_thresh[i] =3D rc->rc_buf_thresh[i];
>  }
>=20
> -int dscc_compute_dsc_parameters(const struct drm_dsc_config *pps, struct=
 dsc_parameters *dsc_params)
> +__fpu int dscc_compute_dsc_parameters(const struct drm_dsc_config *pps, =
struct dsc_parameters *dsc_params)
>  {
>  	enum colour_mode  mode =3D pps->convert_rgb ? CM_RGB :
>  							(pps->simple_422  ? CM_444 :
> @@ -115,7 +115,7 @@ int dscc_compute_dsc_parameters(const struct drm_dsc_=
config *pps, struct dsc_par
>=20
>  	double d_bytes_per_pixel =3D dsc_ceil(bpp * slice_width / 8.0) / slice_=
width;
>=20
> -	// TODO: Make sure the formula for calculating this is precise (ceiling=
 vs. floor, and at what point they should be applied)
> +	// TODO: Make sure the formula for calculating this is precise (ceiling=
 vs. floor, and at what point they should be applied
>  	if (pps->native_422 || pps->native_420)
>  		d_bytes_per_pixel /=3D 2;
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/dcn_calc_math.h b/drivers=
/gpu/drm/amd/display/dc/inc/dcn_calc_math.h
> index 45a07eeffbb6..d2ea6cf65f7e 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/dcn_calc_math.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/dcn_calc_math.h
> @@ -26,6 +26,8 @@
>  #ifndef _DCN_CALC_MATH_H_
>  #define _DCN_CALC_MATH_H_
>=20
> +#include <asm/fpu/api.h>
> +
>  float dcn_bw_mod(const float arg1, const float arg2);
>  float dcn_bw_min2(const float arg1, const float arg2);
>  unsigned int dcn_bw_max(const unsigned int arg1, const unsigned int arg2=
);
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 1607a698eccd..02a51fedd031 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -252,6 +252,9 @@ static int decode_instructions(struct objtool_file *f=
ile)
>  		    strncmp(sec->name, ".discard.", 9))
>  			sec->text =3D true;
>=20
> +		if (!strcmp(sec->name, ".text.fpu"))
> +			sec->fpu =3D true;
> +
>  		for (offset =3D 0; offset < sec->len; offset +=3D insn->len) {
>  			insn =3D malloc(sizeof(*insn));
>  			if (!insn) {
> @@ -288,8 +291,10 @@ static int decode_instructions(struct objtool_file *=
file)
>  				return -1;
>  			}
>=20
> -			sym_for_each_insn(file, func, insn)
> +			sym_for_each_insn(file, func, insn) {
>  				insn->func =3D func;
> +				insn->fpu_safe =3D sec->fpu;
> +			}
>  		}
>  	}
>=20
> diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
> index ebbb10c61e24..a743f2f28feb 100644
> --- a/tools/objtool/elf.h
> +++ b/tools/objtool/elf.h
> @@ -39,7 +39,7 @@ struct section {
>  	char *name;
>  	int idx;
>  	unsigned int len;
> -	bool changed, text, rodata;
> +	bool changed, text, rodata, fpu;
>  };
>=20
>  struct symbol {
>=20
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
=2Efreedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CRodr=
igo.Siqueira%40amd.com%7C8224db5fb3164b0f857c08d7dcc217d8%7C3dd8961fe4884e6=
08e11a82d994e183d%7C0%7C0%7C637220598535185983&amp;sdata=3DZp4IQeEXy56dJhG3=
9TsIyvfC%2BYJYEoBuV%2Bna5VVvQpk%3D&amp;reserved=3D0


--y4kbkysvpam7ygts
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl6aERUACgkQWJzP/com
vP8pnRAApcGj0l25cQ+hO0hX4QIq3bNd1x6WLfViX+pD4chGtBbzCbORRHkXycfR
UzDwRwAC9FZbWeLaDevc9O/Mt8C4LTt+XZfaiE56xRbEIvq/F9JizAiNwNCliq+y
vtaGimR1lhFIUWG5pUdeBw9VosX9GzRlxOGnvntwH1kEVfgXlwkbC3qDQQzwH9LV
mTQ64fcUWM9i5cZyLhyh4B4WsngfLcx+XghziO/6fqbeS31ufK7HI1mpm04nLwiq
rvYF7K1I4WXKP9xtaFCkXzBqtH6So3kmatj2xxs+193d6BqDWq/t9gW6gXfH6AXS
agpBOY+OTNAqK04E/nnfpd9il2WTxERJHoikTw2lTA6H6dFOpMdLp1DFzqlaXk3E
t2EOn/EQTrXkNMDQUi0a0JfFN+fdNYpVSEtc3bbYnuKRImxMnoEciqI+GdeOmqsj
4+gh6gvl6K+kH2v2y+ICx72b1jRklSvZgZ2wTj1pIFraYrIoLdcAN7QeLdrxZ7uE
29O/i7Byv1RwJF4Ie6NfXDKQxt7C/uTjVzh7Pr3I6uLbFBqcg+dkE88z0qtTuotO
EY1wAOYHddpJP42oz6emVBXDxfbcJNTzExbmVlGU+ETC1M0SSICIN1TovKSCYnXX
j8iVIkY1BaQW9yr7dw6FjGUh7WW9MXoIsUl35G4WV9jwUcsA+x8=
=xAE2
-----END PGP SIGNATURE-----

--y4kbkysvpam7ygts--
