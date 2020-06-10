Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F472C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 425B0206F7
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgFJOTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 10:19:36 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5803 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726157AbgFJOTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 10:19:36 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0F8C5F29553EBFAD2C53;
        Wed, 10 Jun 2020 22:19:35 +0800 (CST)
Received: from [127.0.0.1] (10.67.102.197) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Wed, 10 Jun 2020
 22:19:26 +0800
Subject: Re: [PATCH] sysctl: Delete the code of sys_sysctl
To:     "Eric W. Biederman" <ebiederm@xmission.com>
CC:     <keescook@chromium.org>, <ak@linux.intel.com>,
        <alex.huangjianhui@huawei.com>, <linzichang@huawei.com>,
        <linux-kernel@vger.kernel.org>
References: <1591683605-8585-1-git-send-email-nixiaoming@huawei.com>
 <87a71c59my.fsf@x220.int.ebiederm.org>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <84286450-295b-b61b-f400-f08e7eafbe7c@huawei.com>
Date:   Wed, 10 Jun 2020 22:19:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <87a71c59my.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/6/10 3:20, Eric W. Biederman wrote:
> Xiaoming Ni <nixiaoming@huawei.com> writes:
> 
>> Since the commit 61a47c1ad3a4dc ("sysctl: Remove the sysctl system call"),
>> sys_sysctl has lost its actual role: any input can only return an error.
> 
> The remaining code does have a role.  It reports programs that attempt
> to use the removed sysctl.
> 
> It would help if your change description had a reason why we don't want
> to warn people that a program has used a removed system call.
> 
> Probably something like:
> 
>    We have been warning about people using the sysctl system call for years
>    and believe there are no more users.  Even if there are users of this
>    interface if they have not complained or fixed their code by now they
>    probably are not going to, so there is no point in warning them any
>    longer.
> 
> With a change like that made to the patch description.
> 
> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
Thanks for your guidance
I will add it in the v2 version

Thanks
Xiaoming Ni


