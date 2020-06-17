Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3CFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 658842082F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgFQJTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 05:19:47 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6351 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726816AbgFQJTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 05:19:46 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3B258A92749A78F0C949;
        Wed, 17 Jun 2020 17:19:44 +0800 (CST)
Received: from [10.166.213.22] (10.166.213.22) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 17 Jun
 2020 17:19:35 +0800
Subject: Re: [PATCH linux-next] kernel/fork.c: annotate data races for
 copy_process
To:     Chenweilong <chenweilong@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dvyukov@google.com" <dvyukov@google.com>
References: <AB5DF7CCD2A48B4A97860D5EDCA2B71D94AA8AEC@DGGEMM528-MBS.china.huawei.com>
From:   Zefan Li <lizefan@huawei.com>
Message-ID: <9b8346c8-c3b8-b0bd-b925-9545aa3482f9@huawei.com>
Date:   Wed, 17 Jun 2020 17:19:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <AB5DF7CCD2A48B4A97860D5EDCA2B71D94AA8AEC@DGGEMM528-MBS.china.huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.213.22]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/6/17 17:08, Chenweilong wrote:
>> On Tue, Jun 09, 2020 at 11:08:01AM +0800, Weilong Chen wrote:
>>> The check is only there to stop root fork bombs.
>>>
>>> BUG: KCSAN: data-race in copy_process / copy_process
>>>
>>> write to 0xffffffff86f87d20 of 4 bytes by task 7121 on cpu 5:
>>>  copy_process+0x2e1a/0x3af0 kernel/fork.c:2285
>>>  _do_fork+0xf7/0x790 kernel/fork.c:2430
>>>  __do_sys_clone+0xf9/0x130 kernel/fork.c:2585  __se_sys_clone
>>> kernel/fork.c:2566 [inline]
>>>  __x64_sys_clone+0x6c/0x80 kernel/fork.c:2566
>>>  do_syscall_64+0xc7/0x3b0 arch/x86/entry/common.c:295
>>>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>
>>> read to 0xffffffff86f87d20 of 4 bytes by task 7125 on cpu 3:
>>>  copy_process+0x9eb/0x3af0 kernel/fork.c:1967
>>>  _do_fork+0xf7/0x790 kernel/fork.c:2430
>>>  __do_sys_clone+0xf9/0x130 kernel/fork.c:2585  __se_sys_clone
>>> kernel/fork.c:2566 [inline]
>>>  __x64_sys_clone+0x6c/0x80 kernel/fork.c:2566
>>>  do_syscall_64+0xc7/0x3b0 arch/x86/entry/common.c:295
>>>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>
>>> Signed-off-by: Weilong Chen <chenweilong@huawei.com>
>>
>> Plumbing data_race() in there just to taper over this seems ugly.
>> Before we do that we should probably simply make nr_threads atomic_t.
> Will using atomic_t cause performance degradation ? I don’t know why atomic was not used in the beginning.
> 
>> Also, where's the link to the syzbot/kcsan report? Or did you get this report from somewhere else?
> I got this from local test.

There is a comment just above the if statement to explain this race:

        /*
         * If multiple threads are within copy_process(), then this check
         * triggers too late. This doesn't hurt, the check is only there
         * to stop root fork bombs.
         */

This race won't go away by making nr_threads atomic, because I think it is
tasklist_lock that protects nr_thread.

Adding data_race() here I think makes the code more readable, as a supplementary
to the code comment.
