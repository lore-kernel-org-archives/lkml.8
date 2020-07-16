Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26D0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADE3F206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQND8iLs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgGPFaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 01:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgGPFaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 01:30:21 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FFEC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 22:30:21 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k5so3365633plk.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 22:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vqYp+m7poFYGaCADKhMFMyKYCoivm3CAg0E2XiQB4uA=;
        b=jQND8iLsyQbPEL6SHrhg+mruO8aswQssHwjWyQSW95RZ2s4ifcXlrhydDwXdGKM+R9
         LhEopGUuCmTe9c2El+1a9AgUAI7Ilh/oo4PzXdWj4taO8HdjEHJHP1J4XmKFuD9xCp95
         dqQ/9a6p0bbVu9knAUX9nOKqUxmwvhl5Sui/21+zzjyY/PMahgEvAWabiXPVMh96qEFF
         xuxtSbzPxBmwPzQPFAK78lPRDJeaolvgt88b8RJxTCXtlBR/kIuqfx+LWsaesV9AA08i
         g2+2M1hkiwTnnzc/MNSOaIB/YUHYlEAD4jlnpBVeKzOFlPYi/LAn3bLruVC3z9hA8exk
         abxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=vqYp+m7poFYGaCADKhMFMyKYCoivm3CAg0E2XiQB4uA=;
        b=ZFLs7sjFk9mvUoiYXZ3aIgvdWLWGgXijGlpGLtsSQ3Y5HiqKrIDxRKeYeP9iZdNmEr
         1sHdCaACpBHB0dDfI47hdh1AdeKiqAFoPekPgNWUV3l6y8WPikw4JZGK58tCsnSypzTY
         mOogJc+EmwYo5atXOmctPexN+4Z9blcBOHP/Ld2AU4DS/ms4+rVeQW2gR8DMnhKO6tLf
         KO2MeG382HmCmoghT+0tUCHB+2ud0DnE2keCI0aUyQmaeS/bBJ6JtF9v3OVounXBfntw
         2FhlA5559Q/bNp+0pLBT1mSDO8Ux/10AQ6XcPMEZJx0MOE12UPDHdiYhZ1qDQbmSJbI5
         L5VQ==
X-Gm-Message-State: AOAM5319zKqCZfU1A27gUgisFB3pnZwO+oUlLYeyK26Ng61T9VaUSGLx
        b/hu3PidOf9EvEWLodcu65e/89ig
X-Google-Smtp-Source: ABdhPJzgolvwUH+q8ytZ+v7JJ3GYHy2m4H/39farjhUARdRU8osnHf2QPy/J2CxmvQCBxIiUpnhNVQ==
X-Received: by 2002:a17:902:b78a:: with SMTP id e10mr2344993pls.34.1594877420379;
        Wed, 15 Jul 2020 22:30:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b24sm3757249pgn.8.2020.07.15.22.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 22:30:19 -0700 (PDT)
Subject: Re: [PATCH v1] driver core: Fix scheduling while atomic warnings
 during device link deletion
To:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
References: <20200716050846.2047110-1-saravanak@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <e3f4469e-8467-1736-8a39-6539b9f542af@roeck-us.net>
Date:   Wed, 15 Jul 2020 22:30:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716050846.2047110-1-saravanak@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/20 10:08 PM, Saravana Kannan wrote:
> Marek and Guenter reported that commit 287905e68dd2 ("driver core:
> Expose device link details in sysfs") caused sleeping/scheduling while
> atomic warnings.
> 
> BUG: sleeping function called from invalid context at kernel/locking/mutex.c:935
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 12, name: kworker/0:1
> 2 locks held by kworker/0:1/12:
>   #0: ee8074a8 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_one_work+0x174/0x7dc
>   #1: ee921f20 ((work_completion)(&sdp->work)){+.+.}-{0:0}, at: process_one_work+0x174/0x7dc
> Preemption disabled at:
> [<c01b10f0>] srcu_invoke_callbacks+0xc0/0x154
> ----- 8< ----- SNIP
> [<c064590c>] (device_del) from [<c0645c9c>] (device_unregister+0x24/0x64)
> [<c0645c9c>] (device_unregister) from [<c01b10fc>] (srcu_invoke_callbacks+0xcc/0x154)
> [<c01b10fc>] (srcu_invoke_callbacks) from [<c01493c4>] (process_one_work+0x234/0x7dc)
> [<c01493c4>] (process_one_work) from [<c01499b0>] (worker_thread+0x44/0x51c)
> [<c01499b0>] (worker_thread) from [<c0150bf4>] (kthread+0x158/0x1a0)
> [<c0150bf4>] (kthread) from [<c0100114>] (ret_from_fork+0x14/0x20)
> Exception stack(0xee921fb0 to 0xee921ff8)
> 
> This was caused by the device link device being released in the context
> of srcu_invoke_callbacks().  There is no need to wait till the RCU
> callback to release the device link device.  So release the device
> earlier and revert the RCU callback code to what it was before
> commit 287905e68dd2 ("driver core: Expose device link details in sysfs")
> 
> Fixes: 287905e68dd2 ("driver core: Expose device link details in sysfs")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
> Marek and Guenter,
> 
> It haven't had a chance to test this yet. Can one of you please test it
> and confirm it fixes the issue?
> 

With this patch applied, the original warning is gone, but I get lots
of other warnings.

WARNING: CPU: 0 PID: 1 at drivers/base/core.c:1790 device_release+0x94/0xa4^M
Device 'regulators:regulator@0:50038000.ethernet' does not have a release() function, it is broken and must be fixed.

WARNING: CPU: 0 PID: 1 at drivers/base/core.c:1790 device_release+0x94/0xa4
Device '53f9c000.gpio:50038000.ethernet' does not have a release() function, it is broken and must be fixed.

WARNING: CPU: 0 PID: 1 at drivers/base/core.c:1790 device_release+0x94/0xa4^M
Device '50030000.tscadc:50030400.tcq' does not have a release() function, it is broken and must be fixed.

and so on. I don't know if this is caused by this patch or by
some other patch in -next.

Guenter

> Thanks,
> Saravana
> 
>  drivers/base/core.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 5373ddd029f6..ccb2ce11f5b5 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -306,16 +306,10 @@ static struct attribute *devlink_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(devlink);
>  
> -static void devlink_dev_release(struct device *dev)
> -{
> -	kfree(to_devlink(dev));
> -}
> -
>  static struct class devlink_class = {
>  	.name = "devlink",
>  	.owner = THIS_MODULE,
>  	.dev_groups = devlink_groups,
> -	.dev_release = devlink_dev_release,
>  };
>  
>  static int devlink_add_symlinks(struct device *dev,
> @@ -737,7 +731,7 @@ static void device_link_free(struct device_link *link)
>  
>  	put_device(link->consumer);
>  	put_device(link->supplier);
> -	device_unregister(&link->link_dev);
> +	kfree(link);
>  }
>  
>  #ifdef CONFIG_SRCU
> @@ -756,6 +750,7 @@ static void __device_link_del(struct kref *kref)
>  	if (link->flags & DL_FLAG_PM_RUNTIME)
>  		pm_runtime_drop_link(link->consumer);
>  
> +	device_unregister(&link->link_dev);
>  	list_del_rcu(&link->s_node);
>  	list_del_rcu(&link->c_node);
>  	call_srcu(&device_links_srcu, &link->rcu_head, __device_link_free_srcu);
> @@ -771,6 +766,7 @@ static void __device_link_del(struct kref *kref)
>  	if (link->flags & DL_FLAG_PM_RUNTIME)
>  		pm_runtime_drop_link(link->consumer);
>  
> +	device_unregister(&link->link_dev);
>  	list_del(&link->s_node);
>  	list_del(&link->c_node);
>  	device_link_free(link);
> 

