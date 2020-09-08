Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D78C2D0E0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CAF2207DE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731993AbgIHRBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:01:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11271 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731896AbgIHRBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 13:01:15 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D35657BBF3198A617E25;
        Tue,  8 Sep 2020 20:53:13 +0800 (CST)
Received: from [10.67.102.197] (10.67.102.197) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Tue, 8 Sep 2020 20:53:07 +0800
Subject: Re: Question: Why is there no notification when a file is opened
 using filp_open()?
To:     Amir Goldstein <amir73il@gmail.com>
CC:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <wangle6@huawei.com>
References: <25817189-49a7-c64f-26ee-78d4a27496b6@huawei.com>
 <CAOQ4uxhejJzjKLZCt=b87KAX0sC3RAZ2FHEZbu4188Ar-bkmOg@mail.gmail.com>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <e399cd17-e95e-def4-e03b-5cc2ae1f9708@huawei.com>
Date:   Tue, 8 Sep 2020 20:53:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxhejJzjKLZCt=b87KAX0sC3RAZ2FHEZbu4188Ar-bkmOg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/9/8 18:06, Amir Goldstein wrote:
> On Tue, Sep 8, 2020 at 11:02 AM Xiaoming Ni <nixiaoming@huawei.com> wrote:
>>
>> The file opening action on the system may be from user-mode sys_open()
>> or kernel-mode filp_open().
>> Currently, fsnotify_open() is invoked in do_sys_openat2().
>> But filp_open() is not notified. Why? Is this an omission?
>>
>> Do we need to call fsnotify_open() in filp_open() or  do_filp_open() to
>> ensure that both user-mode and kernel-mode file opening operations can
>> be notified?
>>
> 
> Do you have a specific use case of kernel filp_open() in mind?
> 

For example, in fs/coredump.c, do_coredump() calls filp_open() to 
generate core files.
In this scenario, the fsnotify_open() notification is missing.

Thanks
Xiaoming Ni

