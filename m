Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECF8C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2DC62072E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732434AbgFWLMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 07:12:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45740 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732364AbgFWLMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 07:12:46 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jngr4-0005zx-Gg; Tue, 23 Jun 2020 11:12:42 +0000
Subject: Re: [PATCH][next] mm/zswap: fix a couple of memory leaks and rework
 kzalloc failure check
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200622153546.49880-1-colin.king@canonical.com>
 <20200622182816.GF4151@kadam>
 <B926444035E5E2439431908E3842AFD2514C4B@DGGEMI525-MBS.china.huawei.com>
From:   Colin Ian King <colin.king@canonical.com>
Autocrypt: addr=colin.king@canonical.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <baf5a045-40f3-254b-fe0f-ad00cdf4b775@canonical.com>
Date:   Tue, 23 Jun 2020 12:12:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <B926444035E5E2439431908E3842AFD2514C4B@DGGEMI525-MBS.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2020 20:55, Song Bao Hua (Barry Song) wrote:
> 
> 
>> -----Original Message-----
>> From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
>> Sent: Tuesday, June 23, 2020 6:28 AM
>> To: Colin King <colin.king@canonical.com>
>> Cc: Seth Jennings <sjenning@redhat.com>; Dan Streetman
>> <ddstreet@ieee.org>; Vitaly Wool <vitaly.wool@konsulko.com>; Andrew
>> Morton <akpm@linux-foundation.org>; Song Bao Hua (Barry Song)
>> <song.bao.hua@hisilicon.com>; Stephen Rothwell <sfr@canb.auug.org.au>;
>> linux-mm@kvack.org; kernel-janitors@vger.kernel.org;
>> linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH][next] mm/zswap: fix a couple of memory leaks and
>> rework kzalloc failure check
>>
>> On Mon, Jun 22, 2020 at 04:35:46PM +0100, Colin King wrote:
>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> kzalloc failures return NULL on out of memory errors, so replace the
>>> IS_ERR_OR_NULL check with the usual null pointer check.  Fix two memory
>>> leaks with on acomp and acomp_ctx by ensuring these objects are free'd
>>> on the error return path.
>>>
>>> Addresses-Coverity: ("Resource leak")
>>> Fixes: d4f86abd6e35 ("mm/zswap: move to use crypto_acomp API for
>> hardware acceleration")
>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> 
> Colin, thanks for your patch. I am sorry I did the same thing with you here:
> https://lkml.org/lkml/2020/6/22/347

Thanks for fixing this correctly, I ran out of time yesterday to re-do
the fix.

Colin

> 
> 
>>> ---
>>>  mm/zswap.c | 16 +++++++++++-----
>>>  1 file changed, 11 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/mm/zswap.c b/mm/zswap.c
>>> index 0d914ba6b4a0..14839cbac7ff 100644
>>> --- a/mm/zswap.c
>>> +++ b/mm/zswap.c
>>> @@ -433,23 +433,23 @@ static int zswap_cpu_comp_prepare(unsigned int
>> cpu, struct hlist_node *node)
>>>  		return 0;
>>>
>>>  	acomp_ctx = kzalloc(sizeof(*acomp_ctx), GFP_KERNEL);
>>> -	if (IS_ERR_OR_NULL(acomp_ctx)) {
>>> +	if (!acomp_ctx) {
>>>  		pr_err("Could not initialize acomp_ctx\n");
>>>  		return -ENOMEM;
>>>  	}
>>>  	acomp = crypto_alloc_acomp(pool->tfm_name, 0, 0);
>>> -	if (IS_ERR_OR_NULL(acomp)) {
>>> +	if (!acomp) {
>>
>> This should be IS_ERR(acomp).  Please preserve the error code.
>>
>>>  		pr_err("could not alloc crypto acomp %s : %ld\n",
>>>  				pool->tfm_name, PTR_ERR(acomp));
>>> -		return -ENOMEM;
>>> +		goto free_acomp_ctx;
>>>  	}
>>>  	acomp_ctx->acomp = acomp;
>>>
>>>  	req = acomp_request_alloc(acomp_ctx->acomp);
>>> -	if (IS_ERR_OR_NULL(req)) {
>>> +	if (!req) {
>>>  		pr_err("could not alloc crypto acomp %s : %ld\n",
>>>  		       pool->tfm_name, PTR_ERR(acomp));
>>> -		return -ENOMEM;
>>> +		goto free_acomp;
>>>  	}
>>>  	acomp_ctx->req = req;
>>>
>>> @@ -462,6 +462,12 @@ static int zswap_cpu_comp_prepare(unsigned int
>> cpu, struct hlist_node *node)
>>>  	*per_cpu_ptr(pool->acomp_ctx, cpu) = acomp_ctx;
>>>
>>>  	return 0;
>>> +
>>> +free_acomp:
>>> +	kfree(acomp);
>>
>> The kfree() isn't correct.  It needs to be:
>>
>> 	crypto_free_acomp(acomp);
>>
>>> +free_acomp_ctx:
>>> +	kfree(acomp_ctx);
>>> +	return -ENOMEM;
>>
>> regards,
>> dan carpenter
> 

