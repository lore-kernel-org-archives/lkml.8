Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF90C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76B1F20738
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hP5Co7OB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgHZPOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgHZPO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:14:28 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF9EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 08:14:27 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id o12so2126129qki.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 08:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CBaRv42XjbovsMHbgZPMzIWdl59pk9+rR0JFaPmgCaw=;
        b=hP5Co7OB44xOCPdlOVmWc++vpyjcyspFrY5iez03x+SeT+/ahiaGixxVlOG5tiz8gs
         rS92JKUSg2BJht01sSFLZhXuGu3FXC3dwJBg0E58tEZAqNxxBGR951PTsfIRsLGNQvJT
         +6qXnXmO7/C8DjsZqL8FcfkVaG+weJWQEvTYhUvHP28N5y3pNe+XVpRcBJZXGb3bxvci
         Qudnjm75Sy4JL3VwDe0paLq0jo8nhcpI1AymuYgyeo2fuqFR2dqj2BHbvbpf9hLxrNYY
         r80L6cOPR1F2p5N6vUTvtGG3s+1wVpIT8wWuiWiOpG3HYnlKOivEfzAwYJurdZBrsj+O
         UDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CBaRv42XjbovsMHbgZPMzIWdl59pk9+rR0JFaPmgCaw=;
        b=QeYmMA1dB0RCUouRfcXGnTSkua/DO2Oa4YJpxrCrreXjWIBJEwkZQdr24CKzahDtts
         73n2INKb4k+AcNkoOFb4EbfJ8Agi8iCVaX+IEdNtJ9w9WDcKO9+RBQtax4nyG1F1rpx4
         UlUs0997RsPg4GEt/6Z7kqpXsam8IuB+KOeSPGge7XSihs0YqO4C5FYxG7mCUeNLhmDH
         EtpuSXXmrrz9CqefU1UsW6XlEcUfBQEgdDRd6JrlQqZK4oWUyR4Q26vOxfyPKW9tWou5
         +TIantgfwgzcfHd7J2Oxl23c5Cvrw9Zd2EeoKyLca2mgOwX8ThgP142X1QuJPP/AcKyn
         6p7A==
X-Gm-Message-State: AOAM531xguQamO/kDnOVI7Q4vYaiPNmmUJdrr7QFCmltMT66+qs8Ykvk
        zoZJ5EARN6qHDx+uk3iDL5fP3w==
X-Google-Smtp-Source: ABdhPJyoOggiUgxQk2/nZj0Xq/VBAsxFYjmba+73kL2mhzFlfKlao06SU2mgnWNQx81J9mJXYtwBqw==
X-Received: by 2002:ae9:e80c:: with SMTP id a12mr7492262qkg.306.1598454866808;
        Wed, 26 Aug 2020 08:14:26 -0700 (PDT)
Received: from [192.168.0.105] (d-65-175-178-104.nh.cpe.atlanticbb.net. [65.175.178.104])
        by smtp.gmail.com with ESMTPSA id t1sm1876216qkt.119.2020.08.26.08.14.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 08:14:26 -0700 (PDT)
Subject: Re: [RFC v2] perf/core: Fixes hung issue on perf stat command during
 cpu hotplug
To:     Kajol Jain <kjain@linux.ibm.com>, acme@kernel.org,
        peterz@infradead.org
Cc:     jolsa@redhat.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        daniel@iogearbox.net, srikar@linux.vnet.ibm.com
References: <20200826145411.489169-1-kjain@linux.ibm.com>
From:   Barret Rhoden <brho@google.com>
Message-ID: <19fac9f1-4662-b695-3bf3-60ddd7133594@google.com>
Date:   Wed, 26 Aug 2020 11:14:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200826145411.489169-1-kjain@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

On 8/26/20 10:54 AM, Kajol Jain wrote:
> Commit 2ed6edd33a21 ("perf: Add cond_resched() to task_function_call()")
> added assignment of ret value as -EAGAIN in case function
> call to 'smp_call_function_single' fails.
> For non-zero ret value, it did
> 'ret = !ret ? data.ret : -EAGAIN;', which always
> assign -EAGAIN to ret and make second if condition useless.
> 
> In scenarios like when executing a perf stat with --per-thread option, and
> if any of the monitoring cpu goes offline, the 'smp_call_function_single'
> function could return -ENXIO, and with the above check,
> task_function_call hung and increases CPU
> usage (because of repeated 'smp_call_function_single()')
> 
> Recration scenario:
> 	# perf stat -a --per-thread && (offline a CPU )
> 
> Patch here removes the tertiary condition added as part of that
> commit and added a check for NULL and -EAGAIN.
> 
> Fixes: 2ed6edd33a21("perf: Add cond_resched() to task_function_call()")
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> Reported-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> ---
>   kernel/events/core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Changelog:
> - Remove addition of else in the first patch for
>    if(ret != -EAGAIN) condition.
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 856d98c36f56..fe104fee097a 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -115,8 +115,8 @@ task_function_call(struct task_struct *p, remote_function_f func, void *info)
>   	for (;;) {
>   		ret = smp_call_function_single(task_cpu(p), remote_function,
>   					       &data, 1);
> -		ret = !ret ? data.ret : -EAGAIN;
> -
> +		if(!ret)
                   ^
Minor nit, you need a space after the if.

Also, the comment for the function says it returns @func's return val or 
-ESRCH.  You could also add -ENXIO to that.

Thanks for the fix.

Reviewed-by: Barret Rhoden <brho@google.com>

> +			ret = data.ret;
>   		if (ret != -EAGAIN)
>   			break;
>   
> 

