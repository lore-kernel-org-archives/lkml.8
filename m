Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC9BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 02:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F0F52078D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 02:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tkpMz1rm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgHTCxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 22:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgHTCxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 22:53:13 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46824C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 19:53:13 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mt12so332627pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 19:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=dTjeEry3Z8Fh3i/QDk2u2z0zWnHEpNGthQeGER8z6Fo=;
        b=tkpMz1rmHr/pt399a5d5omZYUPrk7oM/oKyiK1XH05m3swD5Hw3jfnJNU0fAw7bMtx
         KrXhIVQys9OUUPnW6K2t22hoRs9PVENwAT80Ja8TBD6hZcrp7LuQ7LMeKBQNqI3khVsD
         FLwXoEjfwFWXQz52rGzcbAwBQmfrYxY6ZzlrMFEbk3KpACcrc8s88FAt7h5fmmutooiq
         8g7pnSY8moFCNA+xP642snZ1zS31jjOlKHvWkJ5OcskZn01wIbEjCnD1bnLalOTR9M7r
         fdlIvqzJO5GLmvW7kZ7bX8Dhq3b5kF8M6TDh0lrwF9f47aYXphptiFGCCmWaq6SM4CvW
         R4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dTjeEry3Z8Fh3i/QDk2u2z0zWnHEpNGthQeGER8z6Fo=;
        b=KDFI6Gi9pPD799JmtXMGLLSzRo3RaTmImN9pkvldf3KJmh23DVwhsqP44qRwukU+jc
         LzmV8raP8QB+gkKJllquSfFkey9VSpEzv4REk7cw054ImQgPmkhrYJeM9e46vhb+VtqP
         q1SKPi/37llu9n37nvhUQ2JYXXgROWRjsxlz8Jn+Q5lVdgIel+eRYT3PNBEhYm0jvo2P
         jOH+AeaSIJOCKEA8pcqYDwFZW6bXLUDEEvwnrBOOhL0M7h7zWNXWGxSr+cRa510OYRnM
         zpfk14OHMk7tnWrskIYRE9ubfdT8afY2tXXpyI1wTcCGkzT68U3b4Pc2ONju1vaWrexR
         7AwA==
X-Gm-Message-State: AOAM533/sZ94DuCWKNK634KUMOEfniUzc0B9vW9R+9dYCq4AYyYUYAoo
        /jxuhvPaoLSof58fAaEET0yNwJBmxwHy8g==
X-Google-Smtp-Source: ABdhPJy+sPlfGTo7t8tWEPfoY0Abn7ZY2NKwF2d+yaD4ynjbu+/uOU0jDw2LUOjbpjx7whUt8MBkjg==
X-Received: by 2002:a17:90a:5b:: with SMTP id 27mr687730pjb.188.1597891992048;
        Wed, 19 Aug 2020 19:53:12 -0700 (PDT)
Received: from ?IPv6:240e:362:440:ee00:a151:c520:3d27:43bb? ([240e:362:440:ee00:a151:c520:3d27:43bb])
        by smtp.gmail.com with ESMTPSA id u191sm533990pgu.56.2020.08.19.19.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 19:53:11 -0700 (PDT)
Subject: Re: [PATCH] uacce: Use kobj_to_dev() instead of container_of()
To:     Tian Tao <tiantao6@hisilicon.com>, wangzhou1@hisilicon.com,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com
References: <1597889792-53139-1-git-send-email-tiantao6@hisilicon.com>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <9f2bbd04-79fa-95e6-50ec-e0dd270f6c61@linaro.org>
Date:   Thu, 20 Aug 2020 10:52:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597889792-53139-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/8/20 上午10:16, Tian Tao wrote:
> Use kobj_to_dev() instead of container_of()
>
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
Acked-by: Zhangfei Gao <zhangfei.gao@linaro.org>

Thanks
> ---
>   drivers/misc/uacce/uacce.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
> index a5b8dab..a9da7b1 100644
> --- a/drivers/misc/uacce/uacce.c
> +++ b/drivers/misc/uacce/uacce.c
> @@ -370,7 +370,7 @@ static struct attribute *uacce_dev_attrs[] = {
>   static umode_t uacce_dev_is_visible(struct kobject *kobj,
>   				    struct attribute *attr, int n)
>   {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>   	struct uacce_device *uacce = to_uacce_device(dev);
>   
>   	if (((attr == &dev_attr_region_mmio_size.attr) &&

