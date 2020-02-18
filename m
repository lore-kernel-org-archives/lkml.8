Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3A0C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 14:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195A220801
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 14:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgBROj6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 09:39:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40196 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726605AbgBROj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 09:39:58 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01IEZATg093139
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 09:39:57 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y7uagwcpc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 09:39:56 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.ibm.com>;
        Tue, 18 Feb 2020 14:39:54 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 18 Feb 2020 14:39:52 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01IEcuUR40042880
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 14:38:56 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDD54A4051;
        Tue, 18 Feb 2020 14:39:51 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60FFEA4040;
        Tue, 18 Feb 2020 14:39:51 +0000 (GMT)
Received: from localhost (unknown [9.199.60.10])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 18 Feb 2020 14:39:51 +0000 (GMT)
Date:   Tue, 18 Feb 2020 20:09:49 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/kprobes: Remove redundant code
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <642c8b4ca59e658be38d8dde00f994e183790a6a.1581687838.git.christophe.leroy@c-s.fr>
In-Reply-To: <642c8b4ca59e658be38d8dde00f994e183790a6a.1581687838.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
User-Agent: astroid/v0.15-13-gb675b421
 (https://github.com/astroidmail/astroid)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 20021814-0020-0000-0000-000003AB4FEB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021814-0021-0000-0000-000022034BEA
Message-Id: <1582036611.9hm2t8ijhz.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-18_02:2020-02-17,2020-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 bulkscore=0 suspectscore=0
 adultscore=0 impostorscore=0 mlxscore=0 mlxlogscore=788 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002180114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy wrote:
> At the time being we have something like
> 
> 	if (something) {
> 		p = get();
> 		if (p) {
> 			if (something_wrong)
> 				goto out;
> 			...
> 			return;
> 		} else if (a != b) {
> 			if (some_error)
> 				goto out;
> 			...
> 		}
> 		goto out;
> 	}
> 	p = get();
> 	if (!p) {
> 		if (a != b) {
> 			if (some_error)
> 				goto out;
> 			...
> 		}
> 		goto out;
> 	}
> 
> This is similar to
> 
> 	p = get();
> 	if (something) {
> 		if (p) {
> 			if (something_wrong)
> 				goto out;
> 			...
> 			return;
> 		}
> 	}
> 	if (!p) {
> 		if (a != b) {
> 			if (some_error)
> 				goto out;
> 			...
> 		}
> 		goto out;
> 	}
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/kernel/kprobes.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)

Good cleanup, thanks.

> 
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> index f8b848aa65bd..7a925eb76ec0 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -276,8 +276,8 @@ int kprobe_handler(struct pt_regs *regs)
>  	kcb = get_kprobe_ctlblk();
>  
>  	/* Check we're not actually recursing */
> +	p = get_kprobe(addr);
>  	if (kprobe_running()) {
> -		p = get_kprobe(addr);
>  		if (p) {
>  			kprobe_opcode_t insn = *p->ainsn.insn;
>  			if (kcb->kprobe_status == KPROBE_HIT_SS &&
> @@ -308,22 +308,9 @@ int kprobe_handler(struct pt_regs *regs)
>  			}
>  			prepare_singlestep(p, regs);
>  			return 1;
> -		} else if (*addr != BREAKPOINT_INSTRUCTION) {
> -			/* If trap variant, then it belongs not to us */
> -			kprobe_opcode_t cur_insn = *addr;
> -
> -			if (is_trap(cur_insn))
> -				goto no_kprobe;
> -			/* The breakpoint instruction was removed by
> -			 * another cpu right after we hit, no further
> -			 * handling of this interrupt is appropriate
> -			 */
> -			ret = 1;
>  		}
> -		goto no_kprobe;

A minot nit -- removing the above goto makes a slight change to the 
logic. But, see my comments for the next patch.

- Naveen

>  	}
>  
> -	p = get_kprobe(addr);
>  	if (!p) {
>  		if (*addr != BREAKPOINT_INSTRUCTION) {
>  			/*
> -- 
> 2.25.0
> 
> 

