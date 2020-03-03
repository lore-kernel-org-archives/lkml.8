Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0A3C3F2D8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 20:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A2320848
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 20:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZFBuyQ+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731880AbgCCUgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 15:36:23 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:36940 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731560AbgCCUgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 15:36:23 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 023KNq1T038916;
        Tue, 3 Mar 2020 20:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=gSPnYkp/gsBfpEV6Yjj6/q+Wa2a1CF7Q8zfIoEjeOPw=;
 b=ZFBuyQ+eCwWA5xgrbllDuccKRz6ZPMamZaeDKyOm4D316dF6puF5+p5FdMs+G8luuhCb
 flHya7lPzFFURhF0gtyGjxrAyrUZWfbKgU+fybEPDntRO8cX9ETVeYsDmlfUdAkfEDZL
 FR0wWm65LpNj+FFEFc5KI/eqA3M8ui2OeNCsNCYVXLHhD93Z9kgWjZxE1phlvpOfjip7
 DQR8fC/9yqvjhViVnN+OTjN+1tjNwV+sOv0XjlmsfZnzkh8rWjb6ezKoVszVzxgsT0mH
 RdJHpA6cc1/a7fuSVvnMBEQGpGOkaF8YlgLhummFCy1UL5OfKKUaTI8vMvmycJlaR2mJ 9g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2yffcuhwtk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Mar 2020 20:36:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 023KH1I4123203;
        Tue, 3 Mar 2020 20:36:16 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2yg1gy7cyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Mar 2020 20:36:15 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 023KaDvb009743;
        Tue, 3 Mar 2020 20:36:13 GMT
Received: from dhcp-10-211-47-111.usdhcp.oraclecorp.com (/10.211.47.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Mar 2020 12:36:12 -0800
Subject: Re: [Xen-devel] [PATCH v2 1/2] xenbus: req->body should be updated
 before req->state
To:     Julien Grall <julien@xen.org>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Cc:     jgross@suse.com, boris.ostrovsky@oracle.com,
        sstabellini@kernel.org, joe.jin@oracle.com
References: <20200303184752.20821-1-dongli.zhang@oracle.com>
 <4ed129f9-ff23-f228-6833-77e37c2bb7b2@xen.org>
From:   dongli.zhang@oracle.com
Organization: Oracle Corporation
Message-ID: <89e891be-2572-fdbf-d627-d1b71284e50d@oracle.com>
Date:   Tue, 3 Mar 2020 12:36:11 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <4ed129f9-ff23-f228-6833-77e37c2bb7b2@xen.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=3 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003030130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 suspectscore=3 spamscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003030130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/3/20 11:37 AM, Julien Grall wrote:
> Hi,
> 
> On 03/03/2020 18:47, Dongli Zhang wrote:
>> The req->body should be updated before req->state is updated and the
>> order should be guaranteed by a barrier.
>>
>> Otherwise, read_reply() might return req->body = NULL.
>>
>> Below is sample callstack when the issue is reproduced on purpose by
>> reordering the updates of req->body and req->state and adding delay in
>> code between updates of req->state and req->body.
>>
>> [   22.356105] general protection fault: 0000 [#1] SMP PTI
>> [   22.361185] CPU: 2 PID: 52 Comm: xenwatch Not tainted 5.5.0xen+ #6
>> [   22.366727] Hardware name: Xen HVM domU, BIOS ...
>> [   22.372245] RIP: 0010:_parse_integer_fixup_radix+0x6/0x60
>> ... ...
>> [   22.392163] RSP: 0018:ffffb2d64023fdf0 EFLAGS: 00010246
>> [   22.395933] RAX: 0000000000000000 RBX: 75746e7562755f6d RCX: 0000000000000000
>> [   22.400871] RDX: 0000000000000000 RSI: ffffb2d64023fdfc RDI: 75746e7562755f6d
>> [   22.405874] RBP: 0000000000000000 R08: 00000000000001e8 R09: 0000000000cdcdcd
>> [   22.410945] R10: ffffb2d6402ffe00 R11: ffff9d95395eaeb0 R12: ffff9d9535935000
>> [   22.417613] R13: ffff9d9526d4a000 R14: ffff9d9526f4f340 R15: ffff9d9537654000
>> [   22.423726] FS:  0000000000000000(0000) GS:ffff9d953bc80000(0000)
>> knlGS:0000000000000000
>> [   22.429898] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   22.434342] CR2: 000000c4206a9000 CR3: 00000001ea3fc002 CR4: 00000000001606e0
>> [   22.439645] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [   22.444941] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [   22.450342] Call Trace:
>> [   22.452509]  simple_strtoull+0x27/0x70
>> [   22.455572]  xenbus_transaction_start+0x31/0x50
>> [   22.459104]  netback_changed+0x76c/0xcc1 [xen_netfront]
>> [   22.463279]  ? find_watch+0x40/0x40
>> [   22.466156]  xenwatch_thread+0xb4/0x150
>> [   22.469309]  ? wait_woken+0x80/0x80
>> [   22.472198]  kthread+0x10e/0x130
>> [   22.474925]  ? kthread_park+0x80/0x80
>> [   22.477946]  ret_from_fork+0x35/0x40
>> [   22.480968] Modules linked in: xen_kbdfront xen_fbfront(+) xen_netfront
>> xen_blkfront
>> [   22.486783] ---[ end trace a9222030a747c3f7 ]---
>> [   22.490424] RIP: 0010:_parse_integer_fixup_radix+0x6/0x60
>>
>> The barrier() in test_reply() is changed to virt_rmb(). The "while" is
>> changed to "do while" so that test_reply() is used as a read memory
>> barrier.
>>
>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>> ---
>> Changed since v1:
>>    - change "barrier()" to "virt_rmb()" in test_reply()
>>
>>   drivers/xen/xenbus/xenbus_comms.c |  2 ++
>>   drivers/xen/xenbus/xenbus_xs.c    | 11 +++++++----
>>   2 files changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/xen/xenbus/xenbus_comms.c
>> b/drivers/xen/xenbus/xenbus_comms.c
>> index d239fc3c5e3d..852ed161fc2a 100644
>> --- a/drivers/xen/xenbus/xenbus_comms.c
>> +++ b/drivers/xen/xenbus/xenbus_comms.c
>> @@ -313,6 +313,8 @@ static int process_msg(void)
>>               req->msg.type = state.msg.type;
>>               req->msg.len = state.msg.len;
>>               req->body = state.body;
>> +            /* write body, then update state */
>> +            virt_wmb();
>>               req->state = xb_req_state_got_reply;
>>               req->cb(req);
>>           } else
>> diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
>> index ddc18da61834..1e14c2118861 100644
>> --- a/drivers/xen/xenbus/xenbus_xs.c
>> +++ b/drivers/xen/xenbus/xenbus_xs.c
>> @@ -194,15 +194,18 @@ static bool test_reply(struct xb_req_data *req)
>>       if (req->state == xb_req_state_got_reply || !xenbus_ok())
>>           return true;
>>   -    /* Make sure to reread req->state each time. */
>> -    barrier();
>> +    /*
>> +     * read req->state before other fields of struct xb_req_data
>> +     * in the caller of test_reply(), e.g., read_reply()
>> +     */
>> +    virt_rmb();
> 
> Looking at the code again, I am afraid the barrier only happen in the false
> case. Should not the new barrier added in the 'true' case?

I would leave the original "barrier()" in the 'false' case and add the new
barrier only in the 'true' case.

Thank you very much!

Dongli Zhang
