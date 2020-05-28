Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3BEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D31B820B80
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgE1Iuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 04:50:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5361 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727088AbgE1Iux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 04:50:53 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7E43DB575D419CF2EC2B;
        Thu, 28 May 2020 16:50:51 +0800 (CST)
Received: from [127.0.0.1] (10.67.102.197) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Thu, 28 May 2020
 16:50:49 +0800
Subject: Re: [PATCH v2 1/1] userfaultfd/sysctl: add
 vm.unprivileged_userfaultfd
To:     Peter Xu <peterx@redhat.com>
CC:     <aarcange@redhat.com>, <akpm@linux-foundation.org>,
        <cracauer@cons.org>, <dplotnikov@virtuozzo.com>,
        <gokhale2@llnl.gov>, <hannes@cmpxchg.org>, <hughd@google.com>,
        <jglisse@redhat.com>, <kirill@shutemov.name>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <maxime.coquelin@redhat.com>, <mcfadden8@llnl.gov>,
        <mcgrof@kernel.org>, <mgorman@suse.de>, <mike.kravetz@oracle.com>,
        <pbonzini@redhat.com>, <rppt@linux.vnet.ibm.com>,
        <xemul@virtuozzo.com>, <keescook@chromium.org>
References: <3b64de85-beb4-5a07-0093-cad6e8f2a8d8@huawei.com>
 <20200527142143.GC1194141@xz-x1>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <a5aa7dfd-b4a9-0ab2-9392-d7889897382f@huawei.com>
Date:   Thu, 28 May 2020 16:50:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200527142143.GC1194141@xz-x1>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/5/27 22:21, Peter Xu wrote:
> On Wed, May 27, 2020 at 02:54:13PM +0800, Xiaoming Ni wrote:
>>
>> On Tue, Mar 19, 2019 at 11:07:22AM +0800, Peter Xu wrote:
>>> Add a global sysctl knob "vm.unprivileged_userfaultfd" to control
>>> whether userfaultfd is allowed by unprivileged users.  When this is
>>> set to zero, only privileged users (root user, or users with the
>>> CAP_SYS_PTRACE capability) will be able to use the userfaultfd
>>> syscalls.
>>
>> Hello
> 
> Hi, Xiaoming,
> 
>> I am a bit confused about this patch, can you help to answer it.
>>
>> Why the sysctl interface of fs/userfaultfd.c belongs to vm_table instead of
>> fs_table ?
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cefdca0a86be517bc390fc4541e3674b8e7803b0
> 
> Because I think it makes more sense to put the new key into where it suites
> better, irrelevant to which directory the variable is declared.  To me,
> unprivileged_userfaultfd is definitely more suitable for vm rather than fs,
> because userfaultfd is really about memory management rather than file system.
> 
> Thanks,
> 

Thank you for your answer
Since userfaultfd and vm are more closely related, will there be 
consideration to move fs/userfaultfd.c to the mm directory in the future?

Thanks
Xiaoming Ni

