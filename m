Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F37C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3AB20848
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731189AbgCaRFd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 13:05:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11726 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726194AbgCaRFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 13:05:33 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02VGYMaP009789
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 13:05:32 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 303vfhfucm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 13:05:31 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Tue, 31 Mar 2020 18:05:23 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 31 Mar 2020 18:05:19 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02VH5P0960096676
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Mar 2020 17:05:25 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23F0AA405B;
        Tue, 31 Mar 2020 17:05:25 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2D99A4054;
        Tue, 31 Mar 2020 17:05:24 +0000 (GMT)
Received: from localhost (unknown [9.85.74.140])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 31 Mar 2020 17:05:24 +0000 (GMT)
Date:   Tue, 31 Mar 2020 22:35:22 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 10/12] powerpc/entry32: Blacklist exception entry
 points for kprobe.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <1ae02b6637b87fc5aaa1d5012c3e2cb30e62b4a3.1585670437.git.christophe.leroy@c-s.fr>
        <f61ac599855e674ebb592464d0ea32a3ba9c6644.1585670437.git.christophe.leroy@c-s.fr>
In-Reply-To: <f61ac599855e674ebb592464d0ea32a3ba9c6644.1585670437.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
User-Agent: astroid/v0.15-13-gb675b421
 (https://github.com/astroidmail/astroid)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 20033117-0012-0000-0000-0000039BBCE3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20033117-0013-0000-0000-000021D8C9C2
Message-Id: <1585673757.0rkxmweypy.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_05:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003310144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy wrote:
> kprobe does not handle events happening in real mode.
> 
> As exception entry points are running with MMU disabled,
> blacklist them.
> 
> The handling of TLF_NAPPING and TLF_SLEEPING is moved before the
> CONFIG_TRACE_IRQFLAGS which contains 'reenable_mmu' because from there
> kprobe will be possible as the kernel will run with MMU enabled.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
> v2: Moved TLF_NAPPING and TLF_SLEEPING handling
> ---
>  arch/powerpc/kernel/entry_32.S | 37 ++++++++++++++++++++--------------
>  1 file changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
> index 94f78c03cb79..215aa3a6d4f7 100644
> --- a/arch/powerpc/kernel/entry_32.S
> +++ b/arch/powerpc/kernel/entry_32.S
> @@ -51,6 +51,7 @@ mcheck_transfer_to_handler:
>  	mfspr	r0,SPRN_DSRR1
>  	stw	r0,_DSRR1(r11)
>  	/* fall through */
> +_ASM_NOKPROBE_SYMBOL(mcheck_transfer_to_handler)
> 
>  	.globl	debug_transfer_to_handler
>  debug_transfer_to_handler:
> @@ -59,6 +60,7 @@ debug_transfer_to_handler:
>  	mfspr	r0,SPRN_CSRR1
>  	stw	r0,_CSRR1(r11)
>  	/* fall through */
> +_ASM_NOKPROBE_SYMBOL(debug_transfer_to_handler)
> 
>  	.globl	crit_transfer_to_handler
>  crit_transfer_to_handler:
> @@ -94,6 +96,7 @@ crit_transfer_to_handler:
>  	rlwinm	r0,r1,0,0,(31 - THREAD_SHIFT)
>  	stw	r0,KSP_LIMIT(r8)
>  	/* fall through */
> +_ASM_NOKPROBE_SYMBOL(crit_transfer_to_handler)
>  #endif
> 
>  #ifdef CONFIG_40x
> @@ -115,6 +118,7 @@ crit_transfer_to_handler:
>  	rlwinm	r0,r1,0,0,(31 - THREAD_SHIFT)
>  	stw	r0,KSP_LIMIT(r8)
>  	/* fall through */
> +_ASM_NOKPROBE_SYMBOL(crit_transfer_to_handler)
>  #endif
> 
>  /*
> @@ -127,6 +131,7 @@ crit_transfer_to_handler:
>  	.globl	transfer_to_handler_full
>  transfer_to_handler_full:
>  	SAVE_NVGPRS(r11)
> +_ASM_NOKPROBE_SYMBOL(transfer_to_handler_full)
>  	/* fall through */
> 
>  	.globl	transfer_to_handler
> @@ -227,6 +232,23 @@ transfer_to_handler_cont:
>  	SYNC
>  	RFI				/* jump to handler, enable MMU */
> 
> +#if defined (CONFIG_PPC_BOOK3S_32) || defined(CONFIG_E500)
> +4:	rlwinm	r12,r12,0,~_TLF_NAPPING
> +	stw	r12,TI_LOCAL_FLAGS(r2)
> +	b	power_save_ppc32_restore
> +
> +7:	rlwinm	r12,r12,0,~_TLF_SLEEPING
> +	stw	r12,TI_LOCAL_FLAGS(r2)
> +	lwz	r9,_MSR(r11)		/* if sleeping, clear MSR.EE */
> +	rlwinm	r9,r9,0,~MSR_EE
> +	lwz	r12,_LINK(r11)		/* and return to address in LR */
> +	kuap_restore r11, r2, r3, r4, r5
> +	lwz	r2, GPR2(r11)
> +	b	fast_exception_return
> +#endif
> +_ASM_NOKPROBE_SYMBOL(transfer_to_handler)
> +_ASM_NOKPROBE_SYMBOL(transfer_to_handler_cont)
> +

A very minor nit is that the above NOKPROBE annotation actually covers 
the block of code below between the label '1:' till 'reenable_mmu', but 
isn't obvious from the code. Splitting off 'reenable_mmu' would have 
made that clear.

You don't have to fix that though -- a kprobe still won't be allowed 
there and anyone interested should be able to look up this mail chain.


- Naveen

