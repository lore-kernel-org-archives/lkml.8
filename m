Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755ADC47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 520D42073A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mqWrSJf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgEFNNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 09:13:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58754 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbgEFNNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 09:13:30 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046D39SN158162;
        Wed, 6 May 2020 13:12:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=YPanAL/gkvF9NhQLHyGdrj4xqiZSj4lYpKFmBT99yDM=;
 b=mqWrSJf1Y+lhd30yUeWljcWwrMrkr5EK9XQdiEYUOx0LxBu2DvvrWevOUmkIEQMA95sx
 VKbTha7y5mq52GszCHULXEMq6LBVf69uC2RS7Le2xQMlX5szxexqh2AfRZG5Gyf2tMpK
 jNEdEEdu89Jx9S0fTqEv/98qjwG5exsz54micPKPkfYbDOCMrEv/i0UqAjmJzq6NYdks
 VA9N/SBDna9pqXa6G4e/lzML6XLGx+LJoZPppFNlfNZ2HmPWCcEoKnoK6hAYMLFAIh8H
 8suqulcPT+J5DoLHZWkuFeUnoZyf+VHAKawY45b4uwrIizT6+98WSDd8RjFdhS23BmuP jg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 30usgq1ayk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 13:12:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046DBl05074875;
        Wed, 6 May 2020 13:12:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 30t1r7t0b6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 13:12:35 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 046DCWwv024873;
        Wed, 6 May 2020 13:12:32 GMT
Received: from linux-1.home (/10.175.10.30)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 06:12:32 -0700
Subject: Re: [patch V4 part 1 06/36] compiler: Simple READ/WRITE_ONCE()
 implementations
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
 <20200505134058.651504242@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <e5a33a9b-91f4-e56b-f455-c560af53e0b6@oracle.com>
Date:   Wed, 6 May 2020 15:11:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200505134058.651504242@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005060103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/5/20 3:16 PM, Thomas Gleixner wrote:
> READ/WRITE_ONCE_NOCHECK() is required for atomics in code which cannot be
> instrumented like the x86 int3 text poke code. As READ/WRITE_ONCE() is
> undergoing a rewrite, provide __{READ,WRITE}_ONCE_SCALAR().
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   include/linux/compiler.h |    8 ++++++++
>   1 file changed, 8 insertions(+)

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.

> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -313,6 +313,14 @@ unsigned long read_word_at_a_time(const
>   	__u.__val;					\
>   })
>   
> +#define __READ_ONCE_SCALAR(x)				\
> +	(*(const volatile typeof(x) *)&(x))
> +
> +#define __WRITE_ONCE_SCALAR(x, val)			\
> +do {							\
> +	*(volatile typeof(x) *)&(x) = val;		\
> +} while (0)
> +
>   /**
>    * data_race - mark an expression as containing intentional data races
>    *
> 
