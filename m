Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BACAC33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 21:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D4BF214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 21:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4QEqgFdh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgAMVqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 16:46:10 -0500
Received: from mail-mw2nam10on2060.outbound.protection.outlook.com ([40.107.94.60]:6138
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726488AbgAMVqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 16:46:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Onj2kNzEfui668JmyN6CSVrKdGCDtgrximKR/otieyb11R44pSu+lrMXgg5hDGrTKj4ma6aYLI0kv/Pa9ME907Zeo3vVZf5Tl7bgva71IoM/H9OdfXfav+4NtkifN4EOhGLLRRJDxClmLty9UqqkOQ7b3TvoocXSVzjvmz/bk5DHU9yyoJjDiX14nUqqBU0XavGPWhPDelXaC0lVBQgBEc84aF1XHqZ2uCfaq28G3EFLchcu9HnOIK9bcEJAGwUSRCumf63cw43dssCchmaPI5UAVp3iC9Qqn2P5doMuq1vKKGxuxPk5P719BWrFM7REdHc41qZglnFKHKG/FMY8dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+g0adhbvh8F82DaCODtpR+QvysFB0Inwg/cZpYVgHw=;
 b=Hr7a5FEcqk+9O448gQx/5huM6kCg1BdxFI1vrHtL3oNlQsM+0Ru972xbgbsHhd4/vjmavNCP8jYdM38qn0obUlRCmBOJeWvlxi9kReu6E7AURgMBPwwOpq0edbbHW9Pk9otc5U2sW/Rox/DtFz0qpeYUCtGyofKFC3npUKS+RzZ9LxrEMNVreE6QndsP4RWYSV/7LuHFFoLMC1lR+GAk9q8v2okUHggFgSG8IMQ8vYj+BUCftiRPsXT+0jSLKaPWkFjHWxX7rdahCq15Txltg/BKAc36ktQxm6gj60hXwRszTtPbGpk5sgispc1WUR4Qpj6Ff5tgBRaZ8SSjK3T9DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+g0adhbvh8F82DaCODtpR+QvysFB0Inwg/cZpYVgHw=;
 b=4QEqgFdh/HHUoX+stRmJ7GUePQVwb7qPLom0gd02mlv2oRT8sDQPNn5tYtCAVl+wypLsOz3Pj7jvwnIl5ZcmiYsKCSroNEqqYV/YNu2DrJwy9OJwi1/2+FbVSQ1Qg2jD5+VsYfvaOGhRhujGdVuUVqmJ+tV1YoJe5f5kr0Bos74=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.71.154) by
 DM6PR12MB3035.namprd12.prod.outlook.com (20.178.198.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Mon, 13 Jan 2020 21:46:06 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::a0cd:463:f444:c270]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::a0cd:463:f444:c270%7]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 21:46:06 +0000
Subject: Re: [PATCH v3] x86/vmlinux: Fix vmlinux.lds.S with pre-2.23 binutils
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Mauro Rossi <issor.oruam@gmail.com>,
        Michael Matz <matz@suse.de>
References: <20200113161310.GA191743@rani.riverdale.lan>
 <20200113195337.604646-1-nivedita@alum.mit.edu>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <3e46154d-6e5e-1c16-90fe-f2c5daa44b60@amd.com>
Date:   Mon, 13 Jan 2020 15:46:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20200113195337.604646-1-nivedita@alum.mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0801CA0002.namprd08.prod.outlook.com
 (2603:10b6:803:29::12) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:15e::26)
MIME-Version: 1.0
Received: from [10.236.30.74] (165.204.77.1) by SN4PR0801CA0002.namprd08.prod.outlook.com (2603:10b6:803:29::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.10 via Frontend Transport; Mon, 13 Jan 2020 21:46:05 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 77bdf917-dfdd-4c6b-7f12-08d79871fe99
X-MS-TrafficTypeDiagnostic: DM6PR12MB3035:
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR12MB30358E9A6C3002C0C7A5837DEC350@DM6PR12MB3035.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 028166BF91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(199004)(189003)(2616005)(86362001)(956004)(53546011)(36756003)(2906002)(7416002)(16526019)(54906003)(52116002)(31686004)(81166006)(81156014)(16576012)(316002)(186003)(110136005)(8676002)(26005)(31696002)(5660300002)(8936002)(66476007)(66946007)(66556008)(4326008)(478600001)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3035;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g+OULuF1KIzKHaCiYYdmhIN6XtI9hirkckUbczufH4P+uaFzFZFM5paGr+6aHjlyUNY9+DA5UQdUBQOpX1rr2t7zLOdwOToMW6vKi8nD1JQqOvmYJl/BUPgbvbE4E/ZXCWcR8kyBOYQGDBoMDa4VrWm8NbD5B7yqGI30px2Sw7Nud3Nn8txBNur4XgVPL3C2AzVqkSuHnltRziRLyxbDmDIN2rjN29f2o0Xih+VgPOFYCwbuIf8YkyTP10dY69MHz7EK93CWFKV8M7ck8kgLlWjGTbKqEDIK9pMruB95GHEJyxb0g1KupPm+aD0ReDNVgwfjXfbKA65x/kv6ndLJ9pfXR9RMNKA98PLp7ghZqsUqsRSgmHnnUAhaPy6RpQViuNXaUfomke51m/pyJa/6U9X3vX/IAj/fntOPW7HISbn93Kj6nd/NrDvJyqwlr5Sg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77bdf917-dfdd-4c6b-7f12-08d79871fe99
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2020 21:46:06.8112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 75QXVLr4QB0ZCRYUmt1gflX2LXXbr22v5wkiP4GwJuof8eWS439OFWyq8OA7siNDRrVvR1ucb5fy6es0s2L1tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3035
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/20 1:53 PM, Arvind Sankar wrote:
> Prior to binutils-2.23, ld treats the location counter as absolute if
> used outside an output section definition. From version 2.23 onwards,
> the location counter is treated as relative to an adjacent output
> section (usually the previous one, unless there isn't one or the
> location counter has been assigned to previously, in which case the next
> one).
> 
> The result is that a symbol definition in the linker script, such as
> 	_etext = .;
> that appears outside an output section definition makes _etext an
> absolute symbol prior to binutils-2.23 and a relative symbol from
> version 2.23 onwards. So when using a 2.21 or 2.22 vintage linker, the
> build fails with
> 	Invalid absolute R_X86_64_32S relocation: _etext
> for x86-64, and a similar message with R_386_32 for x86-32.
> 
> This can be reproduced with the official 2.21.1 and 2.22 binutils
> releases.
> 
> Commit b907693883fd ("x86/vmlinux: Actually use _etext for the end of
> the text segment") moved _etext out of the .text section to place it
> after the exception table, however since commit f0d7ee17d57c
> ("x86/vmlinux: Move EXCEPTION_TABLE to RO_DATA segment") this is no
> longer needed. Move _etext back inside .text to make it relative even
> with older linkers.
> 
> Commit c603a309cc75 ("x86/mm: Identify the end of the kernel area to be
> reserved") defines __end_of_kernel_reserve using the location counter
> outside an output section definition. Use __bss_stop instead of the
> location counter for the definition to make it relative with older
> linkers.
> 
> Fixes: b907693883fd ("x86/vmlinux: Actually use _etext for the end of the text segment")
> Fixes: c603a309cc75 ("x86/mm: Identify the end of the kernel area to be reserved")
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
> v3: Modify vmlinux.lds.S instead of adding more workarounds to tools/relocs.c
> 
>  arch/x86/kernel/vmlinux.lds.S | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index 3a1a819da137..bad4e22384dc 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -144,10 +144,12 @@ SECTIONS
>  		*(.text.__x86.indirect_thunk)
>  		__indirect_thunk_end = .;
>  #endif
> +
> +		/* End of text section */
> +		_etext = .;
>  	} :text =0xcccc
>  
> -	/* End of text section, which should occupy whole number of pages */
> -	_etext = .;
> +	/* .text should occupy whole number of pages */
>  	. = ALIGN(PAGE_SIZE);
>  
>  	X86_ALIGN_RODATA_BEGIN
> @@ -372,7 +374,7 @@ SECTIONS
>  	 * explicitly reserved using memblock_reserve() or it will be discarded
>  	 * and treated as available memory.
>  	 */
> -	__end_of_kernel_reserve = .;
> +	__end_of_kernel_reserve = __bss_stop;

The only thing I worry about is if someone inserts a section between
the bss section and here and doesn't update this value.

Thanks,
Tom

>  
>  	. = ALIGN(PAGE_SIZE);
>  	.brk : AT(ADDR(.brk) - LOAD_OFFSET) {
> 
