Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6221C2BB55
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 08:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABFEE20753
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 08:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J5zd79c2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgDJIHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 04:07:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41884 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgDJIHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 04:07:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9so1411868wrc.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 01:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Cyd0/zn6vVsVdCI+cOjuAuX6u7ft9nArtNzLtQs2SlE=;
        b=J5zd79c2q+x9msDB0nyJ6/Dc8VmRYiV0qSG9gdFyYfkUauqH6RLRsFCfeOdTgUaBIr
         3hDjfvx3BTx7he9s8HzmGH851vbzztklDzobR4qYWHzwkWC3QCtzRBhBWGWcaRprMT9n
         yMGZKm5wgVhhFvWVXDj/wIxYN5WzMdG3Jud5yKTJoJWL/TjJr58aih1GWoLhj1+shi3H
         iCY7B61HixYHwG96yK+Yj2noPmPJglGWifI6CE5rtYuTGB+uxGxnYDpu+Mf+DI3W6Yxr
         qMtOcMLPPLf0WR8bAjivksPmDZ8W2ODFR0yRgFW4V3gUoawAWUIG1MkHMkyt8FqXwwSr
         EaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cyd0/zn6vVsVdCI+cOjuAuX6u7ft9nArtNzLtQs2SlE=;
        b=BzN7TuQ/LwBCMtgwETKeXvMDcyO+lX/BK2ElyDd0quiG7UQsLJng3CQbV1pjAHwmvz
         7zYBt23HRfmqtXecdMyc7eVdrN9rJNv7ZtToXwQHl/xfi+oz7oz6A83m1xU1A5bzYR/b
         E/hYinUJOLl+gRTNFCCk4MQS2otVr3np7whTWEgUbH9Tqm2w3LlBnUTsXqVrwz5ybsz9
         7LB/l1tmo1y7f76dGvoEJDNXeJS62VsRDWRbmEG6pfRpyT+sYYLQHhgsNlq2Lq+cLKTE
         OyoD4lv9i4r5PJCLjbADi+bJyB6YF5KPHGOtCe735UN9I9Amtmi82ICYgIMbovlPacWZ
         Nihw==
X-Gm-Message-State: AGi0PuaIJ/mythFO4G/aTCGH8S7gblxvW5NvVnw0QiVcN+RTpr7zKbVL
        L4DOhJ9Kpq4J+/DHpijx71jFgwrUy1g=
X-Google-Smtp-Source: APiQypLJ/AhfVfdGw21h2zMaH3hRKUa9ZBO/Tg2vojgaHJfFdPRYdFtBZNy6pY6DxfK/e3EWyMBt4A==
X-Received: by 2002:a5d:468b:: with SMTP id u11mr3224240wrq.89.1586506039960;
        Fri, 10 Apr 2020 01:07:19 -0700 (PDT)
Received: from [192.168.1.5] (212-5-158-142.ip.btc-net.bg. [212.5.158.142])
        by smtp.googlemail.com with ESMTPSA id v131sm1843409wmb.19.2020.04.10.01.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 01:07:19 -0700 (PDT)
Subject: Re: [PATCH 1/7] venus: core: Add missing mutex destroy
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>
References: <20200408213330.27665-1-stanimir.varbanov@linaro.org>
 <20200408213330.27665-2-stanimir.varbanov@linaro.org>
 <20200409214734.GV199755@google.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <0dbcaf04-20a4-c5e4-4be2-64d2f9466d06@linaro.org>
Date:   Fri, 10 Apr 2020 11:07:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200409214734.GV199755@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 4/10/20 12:47 AM, Matthias Kaehlcke wrote:
> Hi Stanimir,
> 
> On Thu, Apr 09, 2020 at 12:33:24AM +0300, Stanimir Varbanov wrote:
>> This adds missing mutex_destroy in remove method of venus core driver.
>>
>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>> ---
>>  drivers/media/platform/qcom/venus/core.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
>> index 4395cb96fb04..f8b9a732bc65 100644
>> --- a/drivers/media/platform/qcom/venus/core.c
>> +++ b/drivers/media/platform/qcom/venus/core.c
>> @@ -335,6 +335,7 @@ static int venus_remove(struct platform_device *pdev)
>>  
>>  	v4l2_device_unregister(&core->v4l2_dev);
>>  	mutex_destroy(&core->pm_lock);
>> +	mutex_destroy(&core->lock);
>>  
>>  	return ret;
>>  }
> 
> On which tree is this series based? From the context it seems that the
> tree includes the patch "venus: vdec: Use pmruntime autosuspend"
> (https://lore.kernel.org/patchwork/patch/1187829/), however I can not
> find this patch in any of the branches of your git tree
> (https://git.linuxtv.org/svarbanov/media_tree.git/)

Yes, sorry about that. It is based on runtime suspend patch and few
others. I prepared a pull request but did not send it nor publish the
branch yet cause I wait for rc1 tag.

> 
> Am I looking in the wrong place?
> 

No, you are on right place. I will update my linuxtv tree with material
for v5.8.

-- 
regards,
Stan
