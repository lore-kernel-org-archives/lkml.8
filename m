Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC84C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 05:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6165207F9
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 05:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iszL6iYl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgFIFPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 01:15:06 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35488 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgFIFPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 01:15:05 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0595CVQm136842;
        Tue, 9 Jun 2020 05:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=HvLmUO9WfIu9EpDHvCN9J3AGrpe38k/zLFBsg+AFDwY=;
 b=iszL6iYlKhWol9vdCUWhrzgkJJb+oMfZ/a0pOWH8y1Or5OZZhaOrkoI+k9ELCuIqVvID
 10B9oBJ0YOdpHMemK5Wv/7H5FnPD+TmBn6fxV6EXqKPAY3OGOXiP91AjNhTumNsyxMPP
 0SYH10AxC7qwII63f8AJ+1VokEux0NKpn7wxtJHRdqrj8CYIf9U+19FZEf/48O0czYoL
 vc5nJMD1PheyGaRJ0nW/MvXJKAYP8nSrHzakv2ic1lnh2GR1y0C2lYh7HQTUUFwf7eFq
 mWWY4CecbtgZOuuoQ8qI8IKX5l7qQ6LnuErWEM67L08Gbkik+Fvt2rd9JtxgA2ptYyc8 Sw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 31g3smtd5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 09 Jun 2020 05:14:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05958KcB033010;
        Tue, 9 Jun 2020 05:14:30 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 31gn24tm1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Jun 2020 05:14:30 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0595ETpL004959;
        Tue, 9 Jun 2020 05:14:29 GMT
Received: from dhcp-10-159-136-131.vpn.oracle.com (/10.159.136.131)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Jun 2020 22:14:29 -0700
Subject: Re: [PATCH] sample-trace-array: Fix sleeping function called from
 invalid context
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
References: <20200608075437.1760242-1-wangkefeng.wang@huawei.com>
From:   Divya Indi <divya.indi@oracle.com>
Message-ID: <0047f80f-4fff-16ff-7ac0-20181f03f06a@oracle.com>
Date:   Mon, 8 Jun 2020 22:14:28 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200608075437.1760242-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9646 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=3 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006090039
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9646 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 cotscore=-2147483648 suspectscore=3
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006090039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kefeng,

Thanks for catching this issue.

Please find my comments line -

On 6/8/20 12:54 AM, Kefeng Wang wrote:
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
> mutex_lock() will be called in interrupt context, using workqueueu to fix it.

/s/workqueueu/workqueue

Fixes: 89ed42495ef4 ("tracing: Sample module to demonstrate kernel access to Ftrace instances.")

> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  samples/ftrace/sample-trace-array.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/samples/ftrace/sample-trace-array.c b/samples/ftrace/sample-trace-array.c
> index d523450d73eb..41684c7dbd7b 100644
> --- a/samples/ftrace/sample-trace-array.c
> +++ b/samples/ftrace/sample-trace-array.c
> @@ -20,6 +20,16 @@ struct trace_array *tr;
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
> @@ -29,11 +39,7 @@ static DEFINE_TIMER(mytimer, mytimer_handler);
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

I think we also need to use cancel_work_sync() to handle the case -
1. Module unloaded
2. Timer already ran and scheduled work to disable trace event
3. When the work runs we no longer have the relevant trace array.

static int simple_thread(void *arg)
{
.....

 del_timer(&mytimer);

 <cancel_work_sync> 
.....
 return 0;
}

Thanks,
Divya

