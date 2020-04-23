Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6D2C55191
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E08482076C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZQYrqHE7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbgDWPkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 11:40:45 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43642 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729319AbgDWPkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 11:40:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03NFcpdU194747;
        Thu, 23 Apr 2020 15:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=6ZLAsgCDhOGVwWwqxbkz0p8KejxQtWQlAgAXa53ukss=;
 b=ZQYrqHE7YkaDeteWeromgNTKKK8QcTr5xu/UKPORNbKFUgqgiu4Zy4lKZ4KRjDROU/dF
 NlaHYSZ0GLOyd/2nydO75iRwILoI9lhCHYIrbWUUOt80BkslgPhuPjvHklzoMONP/r6P
 9EhTsfDyUtEzWLybD1EbwytxjgGCkyhUXuWHNTwQCmdx3nu+gzQhR6HrpDX3/heSaeEu
 HakxiyOvklboJq0iowH1vFUZ55nRBkKTGP050ZC0KQjPUI4plTNUKwPtjPE7vnn6l39B
 9mtc8y/Yr7WBP8Ua416hrlZStBWRZZWxLJ501s0Bn1l2a7McMTxOTOGrgaerZEr2L3x/ 0A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 30k7qe2367-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Apr 2020 15:40:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03NFckJu043951;
        Thu, 23 Apr 2020 15:40:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 30gbbmcujy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Apr 2020 15:40:27 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03NFePUj003206;
        Thu, 23 Apr 2020 15:40:26 GMT
Received: from linux-1.home (/92.157.36.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 Apr 2020 08:40:25 -0700
Subject: Re: [PATCH 5/8] x86/speculation: Change FILL_RETURN_BUFFER to work
 with objtool
To:     Peter Zijlstra <peterz@infradead.org>, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de, x86@kernel.org, mbenes@suse.cz
References: <20200423125013.452964352@infradead.org>
 <20200423125042.876058319@infradead.org>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <1e0e7e76-622d-0162-2234-767176d5adbc@oracle.com>
Date:   Thu, 23 Apr 2020 17:45:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200423125042.876058319@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9600 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004230121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9600 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004230121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/23/20 2:47 PM, Peter Zijlstra wrote:
> Change FILL_RETURN_BUFFER and vmexit_fill_RSB() so that objtool groks
> them and can generate correct ORC unwind information for them.
> 
>   - Since ORC is alternative invariant; that is, all alternatives
>     should have the same ORC entries, the __FILL_RETURN_BUFFER body
>     can not be part of an alternative.
> 
>     Therefore, move it out of the alternative and keep the alternative
>     as a sort of jump_label around it.
> 
>   - Use the ANNOTATE_INTRA_FUNCTION_CALL annotation to white-list
>     these 'funny' call instructions to nowhere.
> 
>   - Use UNWIND_HINT_EMPTY to 'fill' the speculation traps, otherwise
>     objtool will consider them unreachable.
> 
>   - Move the RSP adjustment into the loop, such that the loop has a
>     deterministic stack layout.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   arch/x86/include/asm/nospec-branch.h |   16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)


Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.

> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -4,11 +4,13 @@
>   #define _ASM_X86_NOSPEC_BRANCH_H_
>   
>   #include <linux/static_key.h>
> +#include <linux/frame.h>
>   
>   #include <asm/alternative.h>
>   #include <asm/alternative-asm.h>
>   #include <asm/cpufeatures.h>
>   #include <asm/msr-index.h>
> +#include <asm/unwind_hints.h>
>   
>   /*
>    * This should be used immediately before a retpoline alternative. It tells
> @@ -46,21 +48,25 @@
>   #define __FILL_RETURN_BUFFER(reg, nr, sp)	\
>   	mov	$(nr/2), reg;			\
>   771:						\
> +	ANNOTATE_INTRA_FUNCTION_CALL		\
>   	call	772f;				\
>   773:	/* speculation trap */			\
> +	UNWIND_HINT_EMPTY;			\
>   	pause;					\
>   	lfence;					\
>   	jmp	773b;				\
>   772:						\
> +	ANNOTATE_INTRA_FUNCTION_CALL		\
>   	call	774f;				\
>   775:	/* speculation trap */			\
> +	UNWIND_HINT_EMPTY;			\
>   	pause;					\
>   	lfence;					\
>   	jmp	775b;				\
>   774:						\
> +	add	$(BITS_PER_LONG/8) * 2, sp;	\
>   	dec	reg;				\
> -	jnz	771b;				\
> -	add	$(BITS_PER_LONG/8) * nr, sp;
> +	jnz	771b;
>   
>   #ifdef __ASSEMBLY__
>   
> @@ -137,10 +143,8 @@
>     */
>   .macro FILL_RETURN_BUFFER reg:req nr:req ftr:req
>   #ifdef CONFIG_RETPOLINE
> -	ANNOTATE_NOSPEC_ALTERNATIVE
> -	ALTERNATIVE "jmp .Lskip_rsb_\@",				\
> -		__stringify(__FILL_RETURN_BUFFER(\reg,\nr,%_ASM_SP))	\
> -		\ftr
> +	ALTERNATIVE "jmp .Lskip_rsb_\@", "", \ftr
> +	__FILL_RETURN_BUFFER(\reg,\nr,%_ASM_SP)
>   .Lskip_rsb_\@:
>   #endif
>   .endm
> 
> 
