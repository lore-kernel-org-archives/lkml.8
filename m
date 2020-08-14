Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C216C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 10:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67F2C2074D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 10:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgHNKLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 06:11:46 -0400
Received: from mail.loongson.cn ([114.242.206.163]:41204 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726012AbgHNKLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 06:11:46 -0400
Received: from [10.130.0.187] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxGMZWYzZfFuMIAA--.17S3;
        Fri, 14 Aug 2020 18:11:35 +0800 (CST)
Subject: Re: [PATCH] kexec: Delete an unnecessary comparison
To:     Joe Perches <joe@perches.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Vivek Goyal <vgoyal@redhat.com>
References: <1597322730-3881-1-git-send-email-tangyouling@loongson.cn>
 <d1414df440b872ab7792946725991cb948537654.camel@perches.com>
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <b11bb204-749d-9755-85db-aed2606870a5@loongson.cn>
Date:   Fri, 14 Aug 2020 18:11:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <d1414df440b872ab7792946725991cb948537654.camel@perches.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9DxGMZWYzZfFuMIAA--.17S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZr15XryrAF1xtry5WF48WFg_yoW5Wr13p3
        9xWFyDt3WUXr9rKF4xAF4DZ3W5X3yktFW7u39rGryrJr1Yyr1qqay09a1UZFWjyr9akFyS
        gF4F9r1qg34FyFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Cr0_Gr
        1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487
        MxkIecxEwVAFwVW8twCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
        026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
        JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
        vEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280
        aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyT
        uYvjxUzJPEUUUUU
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/14/2020 02:07 PM, Joe Perches wrote:
> On Thu, 2020-08-13 at 20:45 +0800, Youling Tang wrote:
>> Regardless of whether the ret value is zero or non-zero, the trajectory
>> of the program execution is the same, so there is no need to compare.
>>
>> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
>> ---
>>   kernel/kexec_file.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index 78c0837..3ad0ae2 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -800,8 +800,6 @@ static int kexec_calculate_store_digests(struct kimage *image)
>>   
>>   		ret = kexec_purgatory_get_set_symbol(image, "purgatory_sha256_digest",
>>   						     digest, SHA256_DIGEST_SIZE, 0);
>> -		if (ret)
>> -			goto out_free_digest;
>>   	}
>>   
>>   out_free_digest:
> If you really want to change the function, then
> you could change a couple of breaks to gotos,
> remove multiple unnecessary tests, and unindent
> a block of code too.
>
> ---
>   kernel/kexec_file.c | 30 ++++++++++++------------------
>   1 file changed, 12 insertions(+), 18 deletions(-)
>
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index ca40bef75a61..34a025e85887 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -763,7 +763,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
>   		ret = crypto_shash_update(desc, ksegment->kbuf,
>   					  ksegment->bufsz);
>   		if (ret)
> -			break;
> +			goto out_free_digest;
>   
>   		/*
>   		 * Assume rest of the buffer is filled with zero and
> @@ -777,32 +777,26 @@ static int kexec_calculate_store_digests(struct kimage *image)
>   				bytes = zero_buf_sz;
>   			ret = crypto_shash_update(desc, zero_buf, bytes);
>   			if (ret)
> -				break;
> +				goto out_free_digest;
>   			nullsz -= bytes;
>   		}
>   
> -		if (ret)
> -			break;
> -
>   		sha_regions[j].start = ksegment->mem;
>   		sha_regions[j].len = ksegment->memsz;
>   		j++;
>   	}
>   
> -	if (!ret) {
> -		ret = crypto_shash_final(desc, digest);
> -		if (ret)
> -			goto out_free_digest;
> -		ret = kexec_purgatory_get_set_symbol(image, "purgatory_sha_regions",
> -						     sha_regions, sha_region_sz, 0);
> -		if (ret)
> -			goto out_free_digest;
> +	ret = crypto_shash_final(desc, digest);
> +	if (ret)
> +		goto out_free_digest;
>   
> -		ret = kexec_purgatory_get_set_symbol(image, "purgatory_sha256_digest",
> -						     digest, SHA256_DIGEST_SIZE, 0);
> -		if (ret)
> -			goto out_free_digest;
> -	}
> +	ret = kexec_purgatory_get_set_symbol(image, "purgatory_sha_regions",
> +					     sha_regions, sha_region_sz, 0);
> +	if (ret)
> +		goto out_free_digest;
> +
> +	ret = kexec_purgatory_get_set_symbol(image, "purgatory_sha256_digest",
> +					     digest, SHA256_DIGEST_SIZE, 0);
>   
>   out_free_digest:
>   	kfree(digest);
>
OK, looks good to me, I will send v2.

Thanks,
Youling

