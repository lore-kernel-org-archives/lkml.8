Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FDBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79DDF2068E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgFOI3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:29:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5890 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728872AbgFOI3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:29:32 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 22705C249E38EBCC0C97;
        Mon, 15 Jun 2020 16:29:08 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 15 Jun
 2020 16:29:00 +0800
Subject: Re: [PATCH] erofs: Eliminate usage of uninitialized_var() macro
To:     Gao Xiang <hsiangkao@redhat.com>, Jason Yan <yanaijie@huawei.com>
CC:     Kees Cook <keescook@chromium.org>,
        <kernel-hardening@lists.openwall.com>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <xiang@kernel.org>, <linux-erofs@lists.ozlabs.org>
References: <20200615040141.3627746-1-yanaijie@huawei.com>
 <20200615072521.GA25317@xiangao.remote.csb>
 <783fe4f9-fb1f-7f5e-c900-7e30d5c85222@huawei.com>
 <20200615080714.GB25317@xiangao.remote.csb>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <4319ff76-c61f-e266-354f-83526207c767@huawei.com>
Date:   Mon, 15 Jun 2020 16:29:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200615080714.GB25317@xiangao.remote.csb>
Content-Type: text/plain; charset="gbk"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/6/15 16:07, Gao Xiang wrote:
> On Mon, Jun 15, 2020 at 03:43:09PM +0800, Jason Yan wrote:
>>
>>
>> �?2020/6/15 15:25, Gao Xiang 写道:
>>> Hi Jason,
>>>
>>> On Mon, Jun 15, 2020 at 12:01:41PM +0800, Jason Yan wrote:
>>>> This is an effort to eliminate the uninitialized_var() macro[1].
>>>>
>>>> The use of this macro is the wrong solution because it forces off ANY
>>>> analysis by the compiler for a given variable. It even masks "unused
>>>> variable" warnings.
>>>>
>>>> Quoted from Linus[2]:
>>>>
>>>> "It's a horrible thing to use, in that it adds extra cruft to the
>>>> source code, and then shuts up a compiler warning (even the _reliable_
>>>> warnings from gcc)."
>>>>
>>>> The gcc option "-Wmaybe-uninitialized" has been disabled and this change
>>>> will not produce any warnnings even with "make W=1".
>>>>
>>>> [1] https://github.com/KSPP/linux/issues/81
>>>> [2] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/
>>>>
>>>> Cc: Kees Cook <keescook@chromium.org>
>>>> Cc: Chao Yu <yuchao0@huawei.com>
>>>> Signed-off-by: Jason Yan <yanaijie@huawei.com>
>>>> ---
>>>
>>> I'm fine with the patch since "-Wmaybe-uninitialized" has been disabled and
>>> I've also asked Kees for it in private previously.
>>>
>>> I still remembered that Kees sent out a treewide patch. Sorry about that
>>> I don't catch up it... But what is wrong with the original patchset?
>>>
>>
>> Yes, Kees has remind me of that and I will let him handle it. So you can
>> ignore this patch.
> 
> Okay, I was just wondering if this part should be send out via EROFS tree
> for this cycle. However if there was an automatic generated patch by Kees,
> I think perhaps Linus could pick them out directly. But anyway, both ways
> are fine with me. ;) Ping me when needed.

Either way is okay to me.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> 
> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
>> Jason
>>
>>> Thanks,
>>> Gao Xiang
>>>
>>>
>>> .
>>>
>>
> 
> .
> 
