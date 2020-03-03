Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E479DC3F2D8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A7A2073B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730916AbgCCSc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 13:32:57 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39344 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728986AbgCCSc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 13:32:56 -0500
Received: by mail-ed1-f67.google.com with SMTP id m13so5649769edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 10:32:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qfpDezwww7L9uf7TmZz7wLuYrk5SzVsB7AreqfK31e0=;
        b=jKIGKBhZCAYYRQ+X47Nr2Sv7oxaf7lanaFtZ5l4HqzkijtWJJRMP1+24hjzG68Ung2
         8WBHRGAkDSnqYncagpDmbyYoIXzItoh9Yx7/Jp+17t46zlsRcRkaG0mR1VJ/KW8AKfQ9
         ALYWYP09lk3rOubv2VZgg9zg5C/06tx5CPB0u5hKXZL2vAqypjQNpZGWEEc4+FTMkiCE
         9FwVmLUaYm+p+UQVuSnrEQaA4qMb4ck0qgN1ggGqgCXwk7Q0NtSEtrKWMryV23ajGAYi
         9r+U8JROFXOI12Q0oCoRR3obYYC1e/VyWJRsUASxRmZfslYttwR7LwnqGwbNvVs+WJLt
         BJaQ==
X-Gm-Message-State: ANhLgQ2/HG5b00OaUCGpf4LAw9DLah3rMJ7fhyvQKLr2QjIDye7PP+oF
        RSPVI4RjVr6TSGLVbFQOgcs=
X-Google-Smtp-Source: ADFU+vsYE5JInFpii/M+MXghNvc7wL/LQA9d9qMeUUb4B8TPDdzCE1J5GB0XGnj6f8ettrGQXBMEhQ==
X-Received: by 2002:a05:6402:30ba:: with SMTP id df26mr5335252edb.382.1583260374576;
        Tue, 03 Mar 2020 10:32:54 -0800 (PST)
Received: from a483e7b01a66.ant.amazon.com (54-240-197-230.amazon.com. [54.240.197.230])
        by smtp.gmail.com with ESMTPSA id j9sm755033ejb.36.2020.03.03.10.32.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 10:32:53 -0800 (PST)
Subject: Re: [Xen-devel] [PATCH 1/2] xenbus: req->body should be updated
 before req->state
To:     dongli.zhang@oracle.com, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Cc:     jgross@suse.com, boris.ostrovsky@oracle.com,
        sstabellini@kernel.org, joe.jin@oracle.com
References: <20200303015859.18813-1-dongli.zhang@oracle.com>
 <2f175c30-b6b9-5f21-6cf3-2ee89e0c475e@xen.org>
 <4d2428a4-01f7-cf23-82e1-6a9bec2c6d19@oracle.com>
From:   Julien Grall <julien@xen.org>
Message-ID: <d6c8b2aa-bc3a-3901-9b04-fd9d6d26b353@xen.org>
Date:   Tue, 3 Mar 2020 18:32:52 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <4d2428a4-01f7-cf23-82e1-6a9bec2c6d19@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/03/2020 17:36, dongli.zhang@oracle.com wrote:
> 
> 
> On 3/3/20 1:40 AM, Julien Grall wrote:
>> Hi,
>>
>> On 03/03/2020 01:58, Dongli Zhang wrote:
>>> The req->body should be updated before req->state is updated and the
>>> order should be guaranteed by a barrier.
>>>
>>> Otherwise, read_reply() might return req->body = NULL.
>>>
>>> Below is sample callstack when the issue is reproduced on purpose by
>>> reordering the updates of req->body and req->state and adding delay in
>>> code between updates of req->state and req->body.
>>>
>>> [   22.356105] general protection fault: 0000 [#1] SMP PTI
>>> [   22.361185] CPU: 2 PID: 52 Comm: xenwatch Not tainted 5.5.0xen+ #6
>>> [   22.366727] Hardware name: Xen HVM domU, BIOS ...
>>> [   22.372245] RIP: 0010:_parse_integer_fixup_radix+0x6/0x60
>>> ... ...
>>> [   22.392163] RSP: 0018:ffffb2d64023fdf0 EFLAGS: 00010246
>>> [   22.395933] RAX: 0000000000000000 RBX: 75746e7562755f6d RCX: 0000000000000000
>>> [   22.400871] RDX: 0000000000000000 RSI: ffffb2d64023fdfc RDI: 75746e7562755f6d
>>> [   22.405874] RBP: 0000000000000000 R08: 00000000000001e8 R09: 0000000000cdcdcd
>>> [   22.410945] R10: ffffb2d6402ffe00 R11: ffff9d95395eaeb0 R12: ffff9d9535935000
>>> [   22.417613] R13: ffff9d9526d4a000 R14: ffff9d9526f4f340 R15: ffff9d9537654000
>>> [   22.423726] FS:  0000000000000000(0000) GS:ffff9d953bc80000(0000)
>>> knlGS:0000000000000000
>>> [   22.429898] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [   22.434342] CR2: 000000c4206a9000 CR3: 00000001ea3fc002 CR4: 00000000001606e0
>>> [   22.439645] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> [   22.444941] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>> [   22.450342] Call Trace:
>>> [   22.452509]  simple_strtoull+0x27/0x70
>>> [   22.455572]  xenbus_transaction_start+0x31/0x50
>>> [   22.459104]  netback_changed+0x76c/0xcc1 [xen_netfront]
>>> [   22.463279]  ? find_watch+0x40/0x40
>>> [   22.466156]  xenwatch_thread+0xb4/0x150
>>> [   22.469309]  ? wait_woken+0x80/0x80
>>> [   22.472198]  kthread+0x10e/0x130
>>> [   22.474925]  ? kthread_park+0x80/0x80
>>> [   22.477946]  ret_from_fork+0x35/0x40
>>> [   22.480968] Modules linked in: xen_kbdfront xen_fbfront(+) xen_netfront
>>> xen_blkfront
>>> [   22.486783] ---[ end trace a9222030a747c3f7 ]---
>>> [   22.490424] RIP: 0010:_parse_integer_fixup_radix+0x6/0x60
>>>
>>> The "while" is changed to "do while" so that wait_event() is used as a
>>> barrier.
>>
>> The correct barrier for read_reply() should be virt_rmb(). While on x86, this is
>> equivalent to barrier(), on Arm this will be a dmb(ish) to prevent the processor
>> re-ordering memory access.
>>
>> Therefore the barrier in test_reply() (called by wait_event()) is not going to
>> be sufficient for Arm.
> 
> Sorry that I just erroneously thought wait_event() would be used as read barrier.

I was also kind of expecting wait_event() to contain a memory barrier. 
But it does not at least if condition is valid before waiting.

Cheers,


-- 
Julien Grall
