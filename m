Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49256C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 02:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26DCA2053B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 02:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgFOCDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 22:03:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5886 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728031AbgFOCDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 22:03:08 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2B3A86328DFCA906ECDE;
        Mon, 15 Jun 2020 10:03:06 +0800 (CST)
Received: from [127.0.0.1] (10.67.102.197) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Mon, 15 Jun 2020
 10:02:56 +0800
Subject: Re: [PATCH 3/3] creds: convert cred.usage to refcount_t
To:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Elena Reshetova <elena.reshetova@intel.com>,
        David Windsor <dwindsor@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Paul Moore <paul@paul-moore.com>, <edumazet@google.com>,
        <paulmck@kernel.org>, "David Howells" <dhowells@redhat.com>,
        <shakeelb@google.com>, James Morris <jamorris@linux.microsoft.com>,
        <alex.huangjianhui@huawei.com>, <dylix.dailei@huawei.com>,
        <chenzefeng2@huawei.com>, <linux-kernel@vger.kernel.org>
References: <20200612183450.4189588-1-keescook@chromium.org>
 <20200612183450.4189588-4-keescook@chromium.org>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <b3b09954-9973-8cda-747f-0c43b2de5700@huawei.com>
Date:   Mon, 15 Jun 2020 10:02:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200612183450.4189588-4-keescook@chromium.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/6/13 2:34, Kees Cook wrote:
> From: Elena Reshetova <elena.reshetova@intel.com>
> 
> atomic_t variables are currently used to implement reference
> counters with the following properties:
>   - counter is initialized to 1 using atomic_set()
>   - a resource is freed upon counter reaching zero
>   - once counter reaches zero, its further
>     increments aren't allowed
>   - counter schema uses basic atomic operations
>     (set, inc, inc_not_zero, dec_and_test, etc.)
> 
> Such atomic variables should be converted to a newly provided
> refcount_t type and API that prevents accidental counter overflows
> and underflows. This is important since overflows and underflows
> can lead to use-after-free situation and be exploitable.
> 
> The variable cred.usage is used as pure reference counter.
> Convert it to refcount_t and fix up the operations.
> 
> **Important note for maintainers:
> 
> Some functions from refcount_t API defined in lib/refcount.c
> have different memory ordering guarantees than their atomic
> counterparts.Please check Documentation/core-api/refcount-vs-atomic.rst
> for more information.
> 
> Normally the differences should not matter since refcount_t provides
> enough guarantees to satisfy the refcounting use cases, but in
> some rare cases it might matter.
> Please double check that you don't have some undocumented
> memory guarantees for this variable usage.
> 
> For the cred.usage it might make a difference
> in following places:
>   - get_task_cred(): increment in refcount_inc_not_zero() only
>     guarantees control dependency on success vs. fully ordered
>     atomic counterpart
>   - put_cred(): decrement in refcount_dec_and_test() only
>     provides RELEASE ordering and ACQUIRE ordering on success
>     vs. fully ordered atomic counterpart
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> Reviewed-by: David Windsor <dwindsor@gmail.com>
> Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
> Link: https://lore.kernel.org/r/20190306110549.7628-4-elena.reshetova@intel.com
> Signed-off-by: Kees Cook <keescook@chromium.org>

Currently this patch is better than my RFC patch
Looks good to me.

Thanks
Xiaoming Ni


