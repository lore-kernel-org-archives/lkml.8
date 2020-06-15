Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE30C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 02:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9866D20747
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 02:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgFOCK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 22:10:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53110 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727995AbgFOCK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 22:10:27 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5C61414AF2B502BFE427;
        Mon, 15 Jun 2020 10:10:19 +0800 (CST)
Received: from [127.0.0.1] (10.67.102.197) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Mon, 15 Jun 2020
 10:10:09 +0800
Subject: Re: [PATCH 0/3] Convert nsproxy, groups, and creds to refcount_t
To:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     David Windsor <dwindsor@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "Paul Moore" <paul@paul-moore.com>, <edumazet@google.com>,
        <paulmck@kernel.org>, David Howells <dhowells@redhat.com>,
        <shakeelb@google.com>, James Morris <jamorris@linux.microsoft.com>,
        <alex.huangjianhui@huawei.com>, <dylix.dailei@huawei.com>,
        <chenzefeng2@huawei.com>, <linux-kernel@vger.kernel.org>
References: <20200612183450.4189588-1-keescook@chromium.org>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <7be4d56b-0406-099b-e505-02e074c5173e@huawei.com>
Date:   Mon, 15 Jun 2020 10:10:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200612183450.4189588-1-keescook@chromium.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/6/13 2:34, Kees Cook wrote:
> This series was never applied[1], and was recently pointed out as
> missing[2]. If someone has a tree for this, please take it. Otherwise,
> please Ack and I'll send it to Linus.
> 
> Thanks!
> 
> -Kees
> 
> [1] https://lore.kernel.org/lkml/20190306110549.7628-1-elena.reshetova@intel.com/
> [2] https://lore.kernel.org/lkml/1591957695-118312-1-git-send-email-nixiaoming@huawei.com/
> 
> Elena Reshetova (3):
>    nsproxy: convert nsproxy.count to refcount_t
>    groups: convert group_info.usage to refcount_t
>    creds: convert cred.usage to refcount_t
> 
>   include/linux/cred.h    | 15 +++++++-------
>   include/linux/nsproxy.h |  7 +++----
>   kernel/cred.c           | 44 ++++++++++++++++++++---------------------
>   kernel/groups.c         |  2 +-
>   kernel/nsproxy.c        |  6 +++---
>   net/sunrpc/auth.c       |  2 +-
>   6 files changed, 38 insertions(+), 38 deletions(-)
> 

Should mm->mm_users also be replaced by refcount_t?

In addition, is it better to change all variables that use 
atomic_dec_and_test to control the release process to refconut_t?

Thanks
Xiaoming Ni

