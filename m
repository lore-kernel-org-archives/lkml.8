Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F8BC38A29
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 23:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8609212CC
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 23:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UgsFbZmC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OrTSjch/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgDSXu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 19:50:58 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:63786 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgDSXu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 19:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587340256; x=1618876256;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=oFWJIqqZu7tRvH3Kgq+oRuOGj00WYGC2gau2WTXBk2c=;
  b=UgsFbZmCm4+1x92xXUKEp7E7yFTwcIXgczRKJWJCgpjf0ChlyrnOVwmv
   Buhtc1gqoLGtQomBYHXpeLNdxKDP8f5V+wtNBECayvgt13d4MQiuCbbhv
   17WH2EBEWQe3A+iywP/XAISE1qP13S+ePTJIJGVQWEYuZfhcJQa1dOzKU
   lkOsjZq6ZS40rjlJ1pW0WuSt/gWBb/2/+63odsIFWFOz4PIwBuhKF6lUY
   ur/8gKG6ou9ZlbeGO7wS5iqGGQwwlli/EHLRnacz718HLCnb95WgWIirT
   sJV57/FNkfScdlN8kKYgOiGZrKc1VFe5oM0QWjZsPpRayrdAX7NXr/D4d
   Q==;
IronPort-SDR: KXvY1rhjTLmFjc4ha9vowdTixgoN79Tt4P5vIld0lpQVPMDYqv3MkzFASO7fgySbCqy2OTt5uU
 HvJ3dke+obUdib0jpHM7YgshgxClYQcfKmbQx/4cg4SWJD1cLAFPPr79U43ch7YjqX9QcE+wC+
 pSLLggM9ntfPzSa86FVMYlc5y3af8F6bJqkfi+ioRdLOcKIvl1+2x8EbsJ4rDrRxVR4DYyP3ep
 BvJsRnvPYRIBXCjpqKmklz5dxNZK/Ph2r9VyQ2ftLEixYVeE8mqLFKv0lBhsi3LorVDJW9FLsm
 KwY=
X-IronPort-AV: E=Sophos;i="5.72,404,1580745600"; 
   d="scan'208";a="135976444"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2020 07:50:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqbeNxPGoss2rgM5I7j5GMXKy8mOLugCqe8fGwEgn+Eln4QJNhWY4Li1p5k9frkdVjQmqM5pUJBTQG6tQ7y2vK4VSshnWDKY5YjhT/swWk95zFpDN+gQ5LNcOuCZMjrL3Jk9rdWqInz/RUnTv098J8nY9svJQj+T6lz2mujzkamBA1Ur5gIDZtmf1JiLNDjyT+peFqU8xchhu8R3KybbDaV4syowbK+yzHiG/eoiJM7LWjqnRk3Z/yy7psEOaNMDe/BrwwLMSTDEZ51IgFQgtuBua8uvMZyROcUt7ouPmbjuj0sT63RJBD/Q3S+0cF2no/P8W/q5hSOG65tIAEGrpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lS4RhPgWf85BA/lhPdCD6tcmH26JzgO8A/cjUGSMhpo=;
 b=EvzeGmA55iCQSWHSWsQzeMGqk/qp29Jv2uOnZJ88wKUN5hnsq5D/MhqzrRZsGz1A1xAQQLSu9oQ9j/ItIMKsczwpKAe6r/4w+rNLRvOjeHaA1C44Gfi8BsspAD0o1/rQzYhnpelfUhBY4ewCSXHrktJmK2hpadK5ulbWmQDMcMJLXIVHBmcTOjQBL5lv2/GCvOz5VNyBb0rcCT0XX5eyRp32h25ew62Bn53qCkqBEBvUwWF6GHdIi5tosBYSJkb9HpKi0zxnqlM4WxBFAuLk1aZwvy+LHBzD5qcIHP2PqZMeBPYxDVsxUuEcDmxOg3iQm5q4h6YCbGP0Ej5cXH8JDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lS4RhPgWf85BA/lhPdCD6tcmH26JzgO8A/cjUGSMhpo=;
 b=OrTSjch/7ZIpmLWscSXeNbPEQ9TleeCHCFIvwFtfqqYd1U8M+14wnijRbDhRhNL4e7PBncYalzAC8hpGhpM6ADlcWAT+0+ocTd5cOb4zIg6ViOv/15hWn6EeTMgDhur/QqL/SLVMD4e+cOLwogO9C331enwcBRGtnCRZo9Xu8cw=
Received: from BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20)
 by BY5PR04MB6932.namprd04.prod.outlook.com (2603:10b6:a03:219::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Sun, 19 Apr
 2020 23:50:53 +0000
Received: from BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606]) by BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606%6]) with mapi id 15.20.2921.027; Sun, 19 Apr 2020
 23:50:53 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        "zong.li@sifive.com" <zong.li@sifive.com>
CC:     "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v5 9/9] riscv: add STRICT_KERNEL_RWX support
Thread-Topic: [PATCH v5 9/9] riscv: add STRICT_KERNEL_RWX support
Thread-Index: AQHWDXtlba0LR/X2T0mj7jnY6FovDQ==
Date:   Sun, 19 Apr 2020 23:50:53 +0000
Message-ID: <BY5PR04MB69001DE1B20907D2BA8F0BEDE7D70@BY5PR04MB6900.namprd04.prod.outlook.com>
References: <mhng-09f91ec8-5821-41ad-a743-3842ca10f9e2@palmerdabbelt-glaptop1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ddc42d53-3916-4e2c-9425-08d7e4bc7f47
x-ms-traffictypediagnostic: BY5PR04MB6932:
x-microsoft-antispam-prvs: <BY5PR04MB69329B3B572743CDD8C2E31AE7D70@BY5PR04MB6932.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:457;
x-forefront-prvs: 0378F1E47A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6900.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(66556008)(66446008)(478600001)(8936002)(8676002)(64756008)(71200400001)(66476007)(76116006)(66946007)(9686003)(81156014)(55016002)(4326008)(54906003)(52536014)(26005)(316002)(86362001)(6506007)(110136005)(2906002)(7696005)(33656002)(186003)(5660300002)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RFIqlOEQk1beq7cTO/IwnoqDMdoboxq2YTZcHa/kh6Xu7VJ0BwKUtnyBXIpsyCIpWK4rjQ+84jynxYYivi9iUKWjMaDFLxviVLNcrDwdGEKyB7VNq1KkRuZAgY9RGZOd297Jk66JRcuYbo01GmQLKkzuVFDhith2XZqfWIiLevYNnc+A3e0qS7LyHgRqXubIRbN0N7zFn+Z5IgoqZ+qHqHYR0upLjBZhzUYP87QVdQ++t+E0QHhsqhZLi4MFl3SEkfT1DEK7RkiAet4ay+EFHHDufIT/R+PL3OmChPWG3qzPP5XfaTLrg/9kdavfJp2d/5p/YOwIso4t93f/jYsuyeHrc34ol0cWazxCYZ2WylnTzh99bQ0Gd/xj6FwrlS2IWQpTLfg0i/O8+Q7Na4FSPJCkM4PY+AGRXhAMxbXRH3Kpjyq9mCMoLtBftKAO2P7t
x-ms-exchange-antispam-messagedata: FKKw8vW0s58RJPKgiQl21N1N9SQEWYHt3rtslAsBdpLyFUUOkyDELeQ2vWf4Vz94oQ8v31pCJEy3xj7lcu8paH1XX1qlAhCRfav2C6zV8fTfG/ECRdYFeP1p0XDWsel95f3bZ+hwhGvJaqGWy1eMDA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc42d53-3916-4e2c-9425-08d7e4bc7f47
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2020 23:50:53.4396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pfOJBgEnVnoFgvDrdXQbNGxCxzJBoG152NvcWtgEuye8QaxKXqeN9vClxbL+5froR+04aV7+Rp5tx1Jr7yppTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6932
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/04/18 9:30, Palmer Dabbelt wrote:=0A=
> On Wed, 08 Apr 2020 00:57:04 PDT (-0700), zong.li@sifive.com wrote:=0A=
>> The commit contains that make text section as non-writable, rodata=0A=
>> section as read-only, and data section as non-executable.=0A=
>>=0A=
>> The init section should be changed to non-executable.=0A=
>>=0A=
>> Signed-off-by: Zong Li <zong.li@sifive.com>=0A=
>> ---=0A=
>>  arch/riscv/Kconfig                  |  1 +=0A=
>>  arch/riscv/include/asm/set_memory.h |  8 ++++++=0A=
>>  arch/riscv/mm/init.c                | 44 +++++++++++++++++++++++++++++=
=0A=
>>  3 files changed, 53 insertions(+)=0A=
>>=0A=
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig=0A=
>> index 1e1efc998baf..58b556167d59 100644=0A=
>> --- a/arch/riscv/Kconfig=0A=
>> +++ b/arch/riscv/Kconfig=0A=
>> @@ -61,6 +61,7 @@ config RISCV=0A=
>>  	select ARCH_HAS_GIGANTIC_PAGE=0A=
>>  	select ARCH_HAS_SET_DIRECT_MAP=0A=
>>  	select ARCH_HAS_SET_MEMORY=0A=
>> +	select ARCH_HAS_STRICT_KERNEL_RWX=0A=
=0A=
This should be:=0A=
=0A=
	select ARCH_HAS_STRICT_KERNEL_RWX if !MMU=0A=
=0A=
This option does not make sense for the no MMU case and more importantly, i=
t=0A=
ends up generating gigantic binary images which breaks things like the K210=
 support.=0A=
=0A=
Palmer,=0A=
=0A=
I sent a patch to fix that. You did not reply/comment on it.=0A=
=0A=
=0A=
>>  	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT=0A=
>>  	select SPARSEMEM_STATIC if 32BIT=0A=
>>  	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU=0A=
>> diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/as=
m/set_memory.h=0A=
>> index 4c5bae7ca01c..c38df4771c09 100644=0A=
>> --- a/arch/riscv/include/asm/set_memory.h=0A=
>> +++ b/arch/riscv/include/asm/set_memory.h=0A=
>> @@ -22,6 +22,14 @@ static inline int set_memory_x(unsigned long addr, in=
t numpages) { return 0; }=0A=
>>  static inline int set_memory_nx(unsigned long addr, int numpages) { ret=
urn 0; }=0A=
>>  #endif=0A=
>>=0A=
>> +#ifdef CONFIG_STRICT_KERNEL_RWX=0A=
>> +void set_kernel_text_ro(void);=0A=
>> +void set_kernel_text_rw(void);=0A=
>> +#else=0A=
>> +static inline void set_kernel_text_ro(void) { }=0A=
>> +static inline void set_kernel_text_rw(void) { }=0A=
>> +#endif=0A=
>> +=0A=
>>  int set_direct_map_invalid_noflush(struct page *page);=0A=
>>  int set_direct_map_default_noflush(struct page *page);=0A=
>>=0A=
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c=0A=
>> index fab855963c73..b55be44ff9bd 100644=0A=
>> --- a/arch/riscv/mm/init.c=0A=
>> +++ b/arch/riscv/mm/init.c=0A=
>> @@ -12,6 +12,7 @@=0A=
>>  #include <linux/sizes.h>=0A=
>>  #include <linux/of_fdt.h>=0A=
>>  #include <linux/libfdt.h>=0A=
>> +#include <linux/set_memory.h>=0A=
>>=0A=
>>  #include <asm/fixmap.h>=0A=
>>  #include <asm/tlbflush.h>=0A=
>> @@ -477,6 +478,17 @@ static void __init setup_vm_final(void)=0A=
>>  	csr_write(CSR_SATP, PFN_DOWN(__pa_symbol(swapper_pg_dir)) | SATP_MODE)=
;=0A=
>>  	local_flush_tlb_all();=0A=
>>  }=0A=
>> +=0A=
>> +void free_initmem(void)=0A=
>> +{=0A=
>> +	unsigned long init_begin =3D (unsigned long)__init_begin;=0A=
>> +	unsigned long init_end =3D (unsigned long)__init_end;=0A=
>> +=0A=
>> +	/* Make the region as non-execuatble. */=0A=
>> +	set_memory_nx(init_begin, (init_end - init_begin) >> PAGE_SHIFT);=0A=
>> +	free_initmem_default(POISON_FREE_INITMEM);=0A=
>> +}=0A=
>> +=0A=
>>  #else=0A=
>>  asmlinkage void __init setup_vm(uintptr_t dtb_pa)=0A=
>>  {=0A=
>> @@ -488,6 +500,38 @@ static inline void setup_vm_final(void)=0A=
>>  }=0A=
>>  #endif /* CONFIG_MMU */=0A=
>>=0A=
>> +#ifdef CONFIG_STRICT_KERNEL_RWX=0A=
>> +void set_kernel_text_rw(void)=0A=
>> +{=0A=
>> +	unsigned long text_start =3D (unsigned long)_text;=0A=
>> +	unsigned long text_end =3D (unsigned long)_etext;=0A=
>> +=0A=
>> +	set_memory_rw(text_start, (text_end - text_start) >> PAGE_SHIFT);=0A=
>> +}=0A=
>> +=0A=
>> +void set_kernel_text_ro(void)=0A=
>> +{=0A=
>> +	unsigned long text_start =3D (unsigned long)_text;=0A=
>> +	unsigned long text_end =3D (unsigned long)_etext;=0A=
>> +=0A=
>> +	set_memory_ro(text_start, (text_end - text_start) >> PAGE_SHIFT);=0A=
>> +}=0A=
>> +=0A=
>> +void mark_rodata_ro(void)=0A=
>> +{=0A=
>> +	unsigned long text_start =3D (unsigned long)_text;=0A=
>> +	unsigned long text_end =3D (unsigned long)_etext;=0A=
>> +	unsigned long rodata_start =3D (unsigned long)__start_rodata;=0A=
>> +	unsigned long data_start =3D (unsigned long)_data;=0A=
>> +	unsigned long max_low =3D (unsigned long)(__va(PFN_PHYS(max_low_pfn)))=
;=0A=
>> +=0A=
>> +	set_memory_ro(text_start, (text_end - text_start) >> PAGE_SHIFT);=0A=
>> +	set_memory_ro(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT)=
;=0A=
>> +	set_memory_nx(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT)=
;=0A=
>> +	set_memory_nx(data_start, (max_low - data_start) >> PAGE_SHIFT);=0A=
>> +}=0A=
>> +#endif=0A=
>> +=0A=
>>  void __init paging_init(void)=0A=
>>  {=0A=
>>  	setup_vm_final();=0A=
> =0A=
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
