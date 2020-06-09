Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DA1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 16:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 933FC2078C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 16:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ej3xLcAg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730921AbgFIQcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 12:32:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44910 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbgFIQcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 12:32:21 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 059GSQQR147264;
        Tue, 9 Jun 2020 16:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=jZgCtbZbgkuq7BZtPfL2jcAm6vIJFlTHQIaDDJRq+ak=;
 b=ej3xLcAg9LMeYIqExEKvVkgMQMrCL6ZMR7pjIe3gxxirZcdwppqvIiKZ9Eoqjb2XH7F2
 kEG6weKcFGQqN0MIHYKwNRxSxZA4WF+Yuc4GhuIH1VqqSO1WjZPWF2XjBMmzeUfk/Nsu
 6Rb8lex5c9XWwRN5fgdzezWw6zHb60I0U5BBzubY7o1ldoUJPIhjDdPRca5N27AbvfhD
 F+hnbZIrN5brZaYyp2QC2zI8dHMIi3i3kYdUt9GsOu2ZppIPMp9k/8rSLz63U8pSXhDf
 HHI3a+k9QQ6N5tFsYcnAD/Q/eG9mZwqM2dnS5HKKxhs/BfY9heCC30I2tRxYz6viEdY/ 4A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 31g2jr5vhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 09 Jun 2020 16:31:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 059GSPTx108999;
        Tue, 9 Jun 2020 16:29:33 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 31gmwrn3p9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Jun 2020 16:29:33 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 059GTWXu004780;
        Tue, 9 Jun 2020 16:29:32 GMT
Received: from dhcp-10-159-155-165.vpn.oracle.com (/10.159.155.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Jun 2020 09:29:32 -0700
Subject: Re: [PATCH v2] sample-trace-array: Fix sleeping function called from
 invalid context
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
References: <0047f80f-4fff-16ff-7ac0-20181f03f06a@oracle.com>
 <20200609135125.2206637-1-wangkefeng.wang@huawei.com>
From:   Divya Indi <divya.indi@oracle.com>
Message-ID: <53201591-082d-7e42-9043-237ae4239da6@oracle.com>
Date:   Tue, 9 Jun 2020 09:29:30 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200609135125.2206637-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9647 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006090125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9647 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 cotscore=-2147483648 priorityscore=1501 spamscore=0 suspectscore=3
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006090125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/20 6:51 AM, Kefeng Wang wrote:
>  BUG: sleeping function called from invalid context at kernel/locking/mutex.c:935
>  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/5
>  1 lock held by swapper/5/0:
>   #0: ffff80001002bd90 (samples/ftrace/sample-trace-array.c:38){+.-.}-{0:0}, at: call_timer_fn+0x8/0x3e0
>  CPU: 5 PID: 0 Comm: swapper/5 Not tainted 5.7.0+ #8
>  Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
>  Call trace:
>   dump_backtrace+0x0/0x1a0
>   show_stack+0x20/0x30
>   dump_stack+0xe4/0x150
>   ___might_sleep+0x160/0x200
>   __might_sleep+0x58/0x90
>   __mutex_lock+0x64/0x948
>   mutex_lock_nested+0x3c/0x58
>   __ftrace_set_clr_event+0x44/0x88
>   trace_array_set_clr_event+0x24/0x38
>   mytimer_handler+0x34/0x40 [sample_trace_array]
>
> mutex_lock() will be called in interrupt context, using workqueue to fix it.
Fixes:
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: Divya Indi <divya.indi@oracle.com>

> ---
> v2:
> - add include of linux/workqueue.h
> - add missing cancel_work_sync() suggested by Divya Indi
>
>  samples/ftrace/sample-trace-array.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/samples/ftrace/sample-trace-array.c b/samples/ftrace/sample-trace-array.c
> index d523450d73eb..9e437f930280 100644
> --- a/samples/ftrace/sample-trace-array.c
> +++ b/samples/ftrace/sample-trace-array.c
> @@ -6,6 +6,7 @@
>  #include <linux/timer.h>
>  #include <linux/err.h>
>  #include <linux/jiffies.h>
> +#include <linux/workqueue.h>
>  
>  /*
>   * Any file that uses trace points, must include the header.
> @@ -20,6 +21,16 @@ struct trace_array *tr;
>  static void mytimer_handler(struct timer_list *unused);
>  static struct task_struct *simple_tsk;
>  
> +static void trace_work_fn(struct work_struct *work)
> +{
> +	/*
> +	 * Disable tracing for event "sample_event".
> +	 */
> +	trace_array_set_clr_event(tr, "sample-subsystem", "sample_event",
> +			false);
> +}
> +static DECLARE_WORK(trace_work, trace_work_fn);
> +
>  /*
>   * mytimer: Timer setup to disable tracing for event "sample_event". This
>   * timer is only for the purposes of the sample module to demonstrate access of
> @@ -29,11 +40,7 @@ static DEFINE_TIMER(mytimer, mytimer_handler);
>  
>  static void mytimer_handler(struct timer_list *unused)
>  {
> -	/*
> -	 * Disable tracing for event "sample_event".
> -	 */
> -	trace_array_set_clr_event(tr, "sample-subsystem", "sample_event",
> -			false);
> +	schedule_work(&trace_work);
>  }
>  
>  static void simple_thread_func(int count)
> @@ -76,6 +83,7 @@ static int simple_thread(void *arg)
>  		simple_thread_func(count++);
>  
>  	del_timer(&mytimer);
> +	cancel_work_sync(&trace_work);
>  
>  	/*
>  	 * trace_array_put() decrements the reference counter associated with
