Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F0EC352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 04:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB412082F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 04:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbgBMEva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 23:51:30 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:45761 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727076AbgBMEv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 23:51:29 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TpsO4JW_1581569484;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TpsO4JW_1581569484)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 13 Feb 2020 12:51:25 +0800
Subject: Re: [PATCH 1/2] mm: vmpressure: don't need call kfree if kstrndup
 fails
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1581398649-125989-1-git-send-email-yang.shi@linux.alibaba.com>
 <b47f8f37-fbde-5487-5025-fcb0df7a7e30@redhat.com>
 <48d53caf-4b89-69c3-cf9b-47b8627db0bd@linux.alibaba.com>
 <20200212204827.df1de9015a3c03c79a8d7155@linux-foundation.org>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <a1876cc1-fe27-2e30-332e-67d4345b0dd1@linux.alibaba.com>
Date:   Wed, 12 Feb 2020 20:51:22 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200212204827.df1de9015a3c03c79a8d7155@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/12/20 8:48 PM, Andrew Morton wrote:
> On Wed, 12 Feb 2020 19:14:27 -0800 Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
>> On 2/12/20 3:21 AM, David Hildenbrand wrote:
>>> On 11.02.20 06:24, Yang Shi wrote:
>>>> When kstrndup fails (returns NULL) there is no memory is allocated by
>>>> kmalloc, so no need to call kfree().
>>> "When kstrndup fails, no memory was allocated and we can exit directly."
>> Thanks for correcting the commit log.
>>
>> Andrew, do you prefer I send an updated version or you would just update
>> the patch in -mm tree?
> I have already done this.

Thanks!

>
> From: Yang Shi <yang.shi@linux.alibaba.com>
> Subject: mm: vmpressure: don't need call kfree if kstrndup fails
>
> When kstrndup fails, no memory was allocated and we can exit directly.
>
> [david@redhat.com: reword changelog]
> Link: http://lkml.kernel.org/r/1581398649-125989-1-git-send-email-yang.shi@linux.alibaba.com
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Acked-by: David Rientjes <rientjes@google.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>   mm/vmpressure.c |    6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> --- a/mm/vmpressure.c~mm-vmpressure-dont-need-call-kfree-if-kstrndup-fails
> +++ a/mm/vmpressure.c
> @@ -371,10 +371,8 @@ int vmpressure_register_event(struct mem
>   	int ret = 0;
>   
>   	spec_orig = spec = kstrndup(args, MAX_VMPRESSURE_ARGS_LEN, GFP_KERNEL);
> -	if (!spec) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> +	if (!spec)
> +		return -ENOMEM;
>   
>   	/* Find required level */
>   	token = strsep(&spec, ",");
> _

