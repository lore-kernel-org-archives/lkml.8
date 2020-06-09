Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8449C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9036D2072F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yzHT+wYN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731610AbgFIALi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:11:38 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56434 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730678AbgFIALR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 20:11:17 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05903EeO186754;
        Tue, 9 Jun 2020 00:10:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=dw+QeKm88je8loQ/pnNon1EHawhGvF167U/gt4X3HMA=;
 b=yzHT+wYNTTdWL5nXPLo31S2vFFhYz/0gqN1YyH5BV3sHrzeJMoqGVFLxNJFkjB6Bzr1f
 CNKGAaDgC5G2OseC4oOS3eElo6N9XGNvqFnHkhIaH2RIpJUw3GjKipKHUItCLPcO0o/b
 vtEtdMCw2fJ3R8hYjTrPQMC3APJN3XJXkYi6+vE8Y7fQZT6cooFIgOAVWj5EkdFakemq
 UOCaTTd/K3pfe8yyc6dF3U/kOLK7AYTCr6D1gSuYDD/BGG8S/c0uJrr3yAhSl8Z7lXvu
 eDFZgTRbc/XxopRIz5CqNFfwao+m2G7OY8dSL3SJpn6EyrTdaqwso4FWNRNciCANybKG Qw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 31g33m1qab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 09 Jun 2020 00:10:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05902MDV138588;
        Tue, 9 Jun 2020 00:10:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 31gn2490wf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Jun 2020 00:10:44 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0590AiZm028183;
        Tue, 9 Jun 2020 00:10:44 GMT
Received: from dhcp-10-159-150-182.vpn.oracle.com (/10.159.150.182)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Jun 2020 17:10:43 -0700
Subject: Re: [PATCH] sample-trace-array: Fix sleeping function called from
 invalid context
To:     Steven Rostedt <rostedt@goodmis.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
References: <20200608075437.1760242-1-wangkefeng.wang@huawei.com>
 <20200608103709.39afa15f@gandalf.local.home>
From:   Divya Indi <divya.indi@oracle.com>
Message-ID: <3a672473-8621-ff7e-42d5-b4d9412267e8@oracle.com>
Date:   Mon, 8 Jun 2020 17:10:42 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200608103709.39afa15f@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9646 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=3 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=781
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080166
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9646 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 adultscore=0 spamscore=0
 cotscore=-2147483648 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1011
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=813
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006080166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Sure, I am looking into it and reviewing the patch.

Thanks,
Divya

On 6/8/20 7:37 AM, Steven Rostedt wrote:
> On Mon, 8 Jun 2020 07:54:37 +0000
> Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
>>  BUG: sleeping function called from invalid context at kernel/locking/mutex.c:935
>>  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/5
>>  1 lock held by swapper/5/0:
>>   #0: ffff80001002bd90 (samples/ftrace/sample-trace-array.c:38){+.-.}-{0:0}, at: call_timer_fn+0x8/0x3e0
>>  CPU: 5 PID: 0 Comm: swapper/5 Not tainted 5.7.0+ #8
>>  Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
>>  Call trace:
>>   dump_backtrace+0x0/0x1a0
>>   show_stack+0x20/0x30
>>   dump_stack+0xe4/0x150
>>   ___might_sleep+0x160/0x200
>>   __might_sleep+0x58/0x90
>>   __mutex_lock+0x64/0x948
>>   mutex_lock_nested+0x3c/0x58
>>   __ftrace_set_clr_event+0x44/0x88
>>   trace_array_set_clr_event+0x24/0x38
>>   mytimer_handler+0x34/0x40 [sample_trace_array]
>>
>> mutex_lock() will be called in interrupt context, using workqueueu to fix it.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>
> Divya,
>
> Can you give a Reviewed-by for this?
>
> -- Steve
