Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFB7C3403F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 14:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1650020801
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 14:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgBROlD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 09:41:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726116AbgBROlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 09:41:03 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01IEYECq129874
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 09:41:02 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6e2fjcpx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 09:41:00 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Tue, 18 Feb 2020 14:40:58 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 18 Feb 2020 14:40:55 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01IEesQW56164594
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 14:40:54 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 863DC11C05B;
        Tue, 18 Feb 2020 14:40:54 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB0BB11C050;
        Tue, 18 Feb 2020 14:40:53 +0000 (GMT)
Received: from localhost (unknown [9.199.60.10])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 18 Feb 2020 14:40:53 +0000 (GMT)
Date:   Tue, 18 Feb 2020 20:10:52 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] powerpc/kprobes: Reduce depth of a test
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <642c8b4ca59e658be38d8dde00f994e183790a6a.1581687838.git.christophe.leroy@c-s.fr>
        <b67d6705956a1a294af600700115930ff87e643c.1581687838.git.christophe.leroy@c-s.fr>
In-Reply-To: <b67d6705956a1a294af600700115930ff87e643c.1581687838.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
User-Agent: astroid/v0.15-13-gb675b421
 (https://github.com/astroidmail/astroid)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 20021814-0012-0000-0000-00000387FE91
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021814-0013-0000-0000-000021C48F21
Message-Id: <1582036273.gp0i4o7fv2.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-18_02:2020-02-17,2020-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=816 mlxscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002180114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy wrote:
> 	if (a) {
> 		if (b)
> 			do_something();
> 	}
> 
> Is equivalent to
> 
> 	if (a & b)
> 		do_something();
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/kernel/kprobes.c | 58 +++++++++++++++++------------------
>  1 file changed, 28 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> index 7a925eb76ec0..d7c80a078c1e 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -277,38 +277,36 @@ int kprobe_handler(struct pt_regs *regs)
>  
>  	/* Check we're not actually recursing */
>  	p = get_kprobe(addr);
> -	if (kprobe_running()) {
> -		if (p) {
> -			kprobe_opcode_t insn = *p->ainsn.insn;
> -			if (kcb->kprobe_status == KPROBE_HIT_SS &&
> -					is_trap(insn)) {
> -				/* Turn off 'trace' bits */
> -				regs->msr &= ~MSR_SINGLESTEP;
> -				regs->msr |= kcb->kprobe_saved_msr;
> -				goto no_kprobe;
> -			}
> -			/* We have reentered the kprobe_handler(), since
> -			 * another probe was hit while within the handler.
> -			 * We here save the original kprobes variables and
> -			 * just single step on the instruction of the new probe
> -			 * without calling any user handlers.
> -			 */
> -			save_previous_kprobe(kcb);
> -			set_current_kprobe(p, regs, kcb);
> -			kprobes_inc_nmissed_count(p);
> -			kcb->kprobe_status = KPROBE_REENTER;
> -			if (p->ainsn.boostable >= 0) {
> -				ret = try_to_emulate(p, regs);
> -
> -				if (ret > 0) {
> -					restore_previous_kprobe(kcb);
> -					preempt_enable_no_resched();
> -					return 1;
> -				}
> +	if (kprobe_running() && p) {
> +		kprobe_opcode_t insn = *p->ainsn.insn;
> +
> +		if (kcb->kprobe_status == KPROBE_HIT_SS && is_trap(insn)) {
> +			/* Turn off 'trace' bits */
> +			regs->msr &= ~MSR_SINGLESTEP;
> +			regs->msr |= kcb->kprobe_saved_msr;
> +			goto no_kprobe;
> +		}
> +		/* We have reentered the kprobe_handler(), since
> +		 * another probe was hit while within the handler.
> +		 * We here save the original kprobes variables and
> +		 * just single step on the instruction of the new probe
> +		 * without calling any user handlers.
> +		 */
> +		save_previous_kprobe(kcb);
> +		set_current_kprobe(p, regs, kcb);
> +		kprobes_inc_nmissed_count(p);
> +		kcb->kprobe_status = KPROBE_REENTER;
> +		if (p->ainsn.boostable >= 0) {
> +			ret = try_to_emulate(p, regs);
> +
> +			if (ret > 0) {
> +				restore_previous_kprobe(kcb);
> +				preempt_enable_no_resched();
> +				return 1;
>  			}
> -			prepare_singlestep(p, regs);
> -			return 1;
>  		}
> +		prepare_singlestep(p, regs);
> +		return 1;
>  	}
>  

If we move the below !p case before the check for kprobe_running() right 
after get_kprobe(), we won't need to check for (p) above and we won't 
have any change in logic from Patch 1.

>  	if (!p) {


- Naveen

