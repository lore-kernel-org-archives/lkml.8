Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECBDC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F1820CC7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GsFMh/Fa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbgCCRhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:37:21 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59010 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730451AbgCCRhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:37:20 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 023HN1O1005389;
        Tue, 3 Mar 2020 17:37:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=TigWHKuU0u8e8cBMH2aBQQB/e3/5kFEeKkleJ+pVwic=;
 b=GsFMh/Fay0vq5JL5EP78UFlmxGMxM1zg7/0m0mFqRWnZR8Yv8zXDEHO6MPmIGXqbFWIo
 t2V5WlHaXien2BS9ibonyge254FTEwkYOz/KPnVdmMvOoXBvxjtKMNE6MAgjsXwyBMSK
 J0nM8KtkXMwDuJl0MDr2NAnvcH6Cq3jUZZNHxGvcL+gBl3ojorGTrAqcwCrw38++1m9q
 P9/SDzHwIdwD7+9lHZCkHkELQSFfE3TJjqnYkjbSswEaUX8oB44h2Svsb/j+E9/NSH7m
 bED0X+F0K5maWzs3VvkdmPMlbk2spvFplDH68ZepPi9TWTgSlqFLKS2ehAac0wOvvxJw CA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2yghn34pa3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Mar 2020 17:37:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 023Hb9oe018102;
        Tue, 3 Mar 2020 17:37:13 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2yg1em8ujh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Mar 2020 17:37:11 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 023HaX6a026231;
        Tue, 3 Mar 2020 17:36:33 GMT
Received: from dhcp-10-211-47-111.usdhcp.oraclecorp.com (/10.211.47.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Mar 2020 09:36:33 -0800
Subject: Re: [Xen-devel] [PATCH 1/2] xenbus: req->body should be updated
 before req->state
To:     Julien Grall <julien@xen.org>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Cc:     jgross@suse.com, boris.ostrovsky@oracle.com,
        sstabellini@kernel.org, joe.jin@oracle.com
References: <20200303015859.18813-1-dongli.zhang@oracle.com>
 <2f175c30-b6b9-5f21-6cf3-2ee89e0c475e@xen.org>
From:   dongli.zhang@oracle.com
Organization: Oracle Corporation
Message-ID: <4d2428a4-01f7-cf23-82e1-6a9bec2c6d19@oracle.com>
Date:   Tue, 3 Mar 2020 09:36:32 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <2f175c30-b6b9-5f21-6cf3-2ee89e0c475e@xen.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=3 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003030118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003030117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/3/20 1:40 AM, Julien Grall wrote:
> Hi,
> 
> On 03/03/2020 01:58, Dongli Zhang wrote:
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
>> The "while" is changed to "do while" so that wait_event() is used as a
>> barrier.
> 
> The correct barrier for read_reply() should be virt_rmb(). While on x86, this is
> equivalent to barrier(), on Arm this will be a dmb(ish) to prevent the processor
> re-ordering memory access.
> 
> Therefore the barrier in test_reply() (called by wait_event()) is not going to
> be sufficient for Arm.

Sorry that I just erroneously thought wait_event() would be used as read barrier.

I would change barrier() to virt_rmb() for read_reply() in v2.

Thank you very much!

Dongli Zhang
