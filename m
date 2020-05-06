Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93079C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 12:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64C84206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 12:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mRTseJNw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgEFMOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 08:14:21 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40916 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgEFMOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 08:14:21 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046C7ijV046993;
        Wed, 6 May 2020 12:13:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=sE1J9KpsdkE2duem5k+nnW/gLGRolEnst8TqxIIihT8=;
 b=mRTseJNwHVILox0U4mcRLBHsYojoEcuuMB/0KHmXmrSmEP8vt5tKY8NOhf5aNyFvyMbv
 T6GXB2xXeMVngRrV2e3SlYaOuHs2rA5ub0ZVp5H3Opka0A4LCy/2ASH7Ed5Zb9SrGVgF
 LlvI3dbUn+1AlXLHo2/r8KNt99JDAMhHhaM3r/6SrDv1gTJiIlbRffFrFk4Oq3wdPMQh
 pDRrqEhMXb1hKnk6ZLo9S3K6IkSqB4nHlct6k8z5gLKH7lmDv74QQCcI8uF7KdRRPHdl
 kefKN7SULLsNNEI0TXul29UnCNzmWHMXCTAC3osWNG3VJhjXt27rNkC+Pl9jmjeJNs7P Aw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 30s1gn9sqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 12:13:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046C7RS8061597;
        Wed, 6 May 2020 12:13:09 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 30sjnj7ecr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 12:13:09 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 046CD2gG021127;
        Wed, 6 May 2020 12:13:05 GMT
Received: from linux-1.home (/10.175.10.30)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 05:13:00 -0700
Subject: Re: [patch V4 part 1 02/36] x86/hw_breakpoint: Prevent data
 breakpoints on cpu_entry_area
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <20200505131602.633487962@linutronix.de>
 <20200505134058.272448010@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <fb9f513c-786c-af15-693d-3d76eb74fc35@oracle.com>
Date:   Wed, 6 May 2020 14:11:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200505134058.272448010@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 clxscore=1011 priorityscore=1501 bulkscore=0 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/5/20 3:16 PM, Thomas Gleixner wrote:
> From: Andy Lutomirski <luto@kernel.org>
> 
> A data breakpoint near the top of an IST stack will cause unresoverable

typo: unresoverable -> unrecoverable

> recursion.  A data breakpoint on the GDT, IDT, or TSS is terrifying.
> Prevent either of these from happening.
> 
> Co-developed-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/x86/kernel/hw_breakpoint.c |   25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.

> --- a/arch/x86/kernel/hw_breakpoint.c
> +++ b/arch/x86/kernel/hw_breakpoint.c
> @@ -227,10 +227,35 @@ int arch_check_bp_in_kernelspace(struct
>   	return (va >= TASK_SIZE_MAX) || ((va + len - 1) >= TASK_SIZE_MAX);
>   }
>   
> +/*
> + * Checks whether the range from addr to end, inclusive, overlaps the CPU
> + * entry area range.
> + */
> +static inline bool within_cpu_entry_area(unsigned long addr, unsigned long end)
> +{
> +	return end >= CPU_ENTRY_AREA_PER_CPU &&
> +	       addr < (CPU_ENTRY_AREA_PER_CPU + CPU_ENTRY_AREA_TOTAL_SIZE);
> +}
> +
>   static int arch_build_bp_info(struct perf_event *bp,
>   			      const struct perf_event_attr *attr,
>   			      struct arch_hw_breakpoint *hw)
>   {
> +	unsigned long bp_end;
> +
> +	bp_end = attr->bp_addr + attr->bp_len - 1;
> +	if (bp_end < attr->bp_addr)
> +		return -EINVAL;
> +
> +	/*
> +	 * Prevent any breakpoint of any type that overlaps the
> +	 * cpu_entry_area.  This protects the IST stacks and also
> +	 * reduces the chance that we ever find out what happens if
> +	 * there's a data breakpoint on the GDT, IDT, or TSS.
> +	 */
> +	if (within_cpu_entry_area(attr->bp_addr, bp_end))
> +		return -EINVAL;
> +
>   	hw->address = attr->bp_addr;
>   	hw->mask = 0;
>   
> 
