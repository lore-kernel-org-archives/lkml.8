Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4ABBC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5FCF2072A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="s+wEPBVq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgB1O6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:58:52 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38382 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgB1O6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:58:52 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01SEngFI002495;
        Fri, 28 Feb 2020 14:58:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=GulWo/ERO+XRKVn0r/oj91l/RAWAVXTQimK8f180GfI=;
 b=s+wEPBVqQIvJ309JHP8amqSvbDUFqFcIfGdhnLv0wjfHTPnwY4xHStLDNWV0GzDnu2wz
 tTymbEGtTimdptwBXP8mv46wEuSrxT3qQByHUifMICA+Q4DYhuaqgUjaz95oyffRaSl8
 Lnru5R2sxgZVGW45H2mVLiiCcw4O+awOAHaE+DEKoihumsx6OxWZW01R4BymfToMJ7zJ
 /AD3YrLT4RGUY9uoTL81dJMm7bxYZloRC4Xe0PSU0vsmDXioCt50i8noNb5TlRn9Q2OY
 VVWGurHPEG5DajNk1OjBL1n9a2ES7gumCoLB1oWPpKUliHijj03iE6ZKniAYuGj4y1oC og== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2ydcsnudyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 14:58:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01SEsLgP186603;
        Fri, 28 Feb 2020 14:58:09 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2ydcs8pg42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 14:58:09 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01SEw1AT026881;
        Fri, 28 Feb 2020 14:58:01 GMT
Received: from [10.39.209.75] (/10.39.209.75)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Feb 2020 06:58:01 -0800
Subject: Re: [patch 08/24] x86/entry: Convert Divide Error to IDTENTRY
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20200225221606.511535280@linutronix.de>
 <20200225222648.970676604@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Organization: Oracle Corporation
Message-ID: <4afd832a-2a78-798a-97e0-d1e3636cc290@oracle.com>
Date:   Fri, 28 Feb 2020 15:58:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20200225222648.970676604@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9545 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9544 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/25/20 11:16 PM, Thomas Gleixner wrote:
> Convert #DE to IDTENTRY:
>    - Implement the C entry point with DEFINE_IDTENTRY
>    - Emit the ASM stub with DECLARE_IDTENTRY
>    - Remove the ASM idtentry in 64bit
>    - Remove the open coded ASM entry code in 32bit
>    - Fixup the XEN/PV code
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/x86/entry/entry_32.S       |    7 -------
>   arch/x86/entry/entry_64.S       |    1 -
>   arch/x86/include/asm/idtentry.h |    3 +++
>   arch/x86/include/asm/traps.h    |    3 ---
>   arch/x86/kernel/idt.c           |    2 +-
>   arch/x86/kernel/traps.c         |    7 ++++++-
>   arch/x86/xen/enlighten_pv.c     |    7 ++++++-
>   arch/x86/xen/xen-asm_64.S       |    2 +-
>   8 files changed, 17 insertions(+), 15 deletions(-)
> 
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -1386,13 +1386,6 @@ SYM_CODE_START(alignment_check)
>   	jmp	common_exception
>   SYM_CODE_END(alignment_check)
>   
> -SYM_CODE_START(divide_error)
> -	ASM_CLAC
> -	pushl	$0				# no error code
> -	pushl	$do_divide_error
> -	jmp	common_exception
> -SYM_CODE_END(divide_error)
> -
>   #ifdef CONFIG_X86_MCE
>   SYM_CODE_START(machine_check)
>   	ASM_CLAC
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1061,7 +1061,6 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
>    * Exception entry points.
>    */
>   
> -idtentry	X86_TRAP_DE		divide_error		do_divide_error			has_error_code=0
>   idtentry	X86_TRAP_OF		overflow		do_overflow			has_error_code=0
>   idtentry	X86_TRAP_BP		int3			do_int3				has_error_code=0
>   idtentry	X86_TRAP_BR		bounds			do_bounds			has_error_code=0
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -76,4 +76,7 @@ static __always_inline void __##func(str
>   
>   #endif /* __ASSEMBLY__ */
>   
> +/* Simple exception entries: */
> +DECLARE_IDTENTRY(X86_TRAP_DE,		exc_divide_error);
> +

I think this macro has a tricky behavior because it will declare C functions
when included in a C file, and define assembly idtentry when included in an
assembly file.

I see your point which is to have a single statement which provides both C
and assembly functions, but this dual behavior is not obvious when reading
the code. Maybe add a comment to explain this behavior?

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.


>   #endif
> --- a/arch/x86/include/asm/traps.h
> +++ b/arch/x86/include/asm/traps.h
> @@ -11,7 +11,6 @@
>   
>   #define dotraplinkage __visible
>   
> -asmlinkage void divide_error(void);
>   asmlinkage void debug(void);
>   asmlinkage void nmi(void);
>   asmlinkage void int3(void);
> @@ -38,7 +37,6 @@ asmlinkage void machine_check(void);
>   asmlinkage void simd_coprocessor_error(void);
>   
>   #if defined(CONFIG_X86_64) && defined(CONFIG_XEN_PV)
> -asmlinkage void xen_divide_error(void);
>   asmlinkage void xen_xennmi(void);
>   asmlinkage void xen_xendebug(void);
>   asmlinkage void xen_int3(void);
> @@ -62,7 +60,6 @@ asmlinkage void xen_machine_check(void);
>   asmlinkage void xen_simd_coprocessor_error(void);
>   #endif
>   
> -dotraplinkage void do_divide_error(struct pt_regs *regs, long error_code);
>   dotraplinkage void do_debug(struct pt_regs *regs, long error_code);
>   dotraplinkage void do_nmi(struct pt_regs *regs, long error_code);
>   dotraplinkage void do_int3(struct pt_regs *regs, long error_code);
> --- a/arch/x86/kernel/idt.c
> +++ b/arch/x86/kernel/idt.c
> @@ -70,7 +70,7 @@ static const __initconst struct idt_data
>    * set up TSS.
>    */
>   static const __initconst struct idt_data def_idts[] = {
> -	INTG(X86_TRAP_DE,		divide_error),
> +	INTG(X86_TRAP_DE,		asm_exc_divide_error),
>   	INTG(X86_TRAP_NMI,		nmi),
>   	INTG(X86_TRAP_BR,		bounds),
>   	INTG(X86_TRAP_UD,		invalid_op),
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -279,6 +279,12 @@ static inline void __user *error_get_tra
>   	return (void __user *)uprobe_get_trap_addr(regs);
>   }
>   
> +DEFINE_IDTENTRY(exc_divide_error)
> +{
> +	do_error_trap(regs, 0, "divide_error", X86_TRAP_DE, SIGFPE,
> +		      FPE_INTDIV, error_get_trap_addr(regs));
> +}
> +
>   #define IP ((void __user *)uprobe_get_trap_addr(regs))
>   #define DO_ERROR(trapnr, signr, sicode, addr, str, name)		   \
>   dotraplinkage void do_##name(struct pt_regs *regs, long error_code)	   \
> @@ -286,7 +292,6 @@ dotraplinkage void do_##name(struct pt_r
>   	do_error_trap(regs, error_code, str, trapnr, signr, sicode, addr); \
>   }
>   
> -DO_ERROR(X86_TRAP_DE,     SIGFPE,  FPE_INTDIV,   IP, "divide error",        divide_error)
>   DO_ERROR(X86_TRAP_OF,     SIGSEGV,          0, NULL, "overflow",            overflow)
>   DO_ERROR(X86_TRAP_UD,     SIGILL,  ILL_ILLOPN,   IP, "invalid opcode",      invalid_op)
>   DO_ERROR(X86_TRAP_OLD_MF, SIGFPE,           0, NULL, "coprocessor segment overrun", coprocessor_segment_overrun)
> --- a/arch/x86/xen/enlighten_pv.c
> +++ b/arch/x86/xen/enlighten_pv.c
> @@ -602,6 +602,11 @@ struct trap_array_entry {
>   	bool ist_okay;
>   };
>   
> +#define TRAP_ENTRY(func, ist_ok) {			\
> +	.orig		= asm_##func,			\
> +	.xen		= xen_asm_##func,		\
> +	.ist_okay	= ist_ok }
> +
>   static struct trap_array_entry trap_array[] = {
>   	{ debug,                       xen_xendebug,                    true },
>   	{ double_fault,                xen_double_fault,                true },
> @@ -615,7 +620,7 @@ static struct trap_array_entry trap_arra
>   	{ entry_INT80_compat,          xen_entry_INT80_compat,          false },
>   #endif
>   	{ page_fault,                  xen_page_fault,                  false },
> -	{ divide_error,                xen_divide_error,                false },
> +	TRAP_ENTRY(exc_divide_error,			false ),
>   	{ bounds,                      xen_bounds,                      false },
>   	{ invalid_op,                  xen_invalid_op,                  false },
>   	{ device_not_available,        xen_device_not_available,        false },
> --- a/arch/x86/xen/xen-asm_64.S
> +++ b/arch/x86/xen/xen-asm_64.S
> @@ -28,7 +28,7 @@ SYM_CODE_END(xen_\name)
>   _ASM_NOKPROBE(xen_\name)
>   .endm
>   
> -xen_pv_trap divide_error
> +xen_pv_trap asm_exc_divide_error
>   xen_pv_trap debug
>   xen_pv_trap xendebug
>   xen_pv_trap int3
> 
> 
