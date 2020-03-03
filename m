Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A9FC3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9785A20838
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="L8h6Pj96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbgCCQlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 11:41:04 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42307 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbgCCQlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 11:41:04 -0500
Received: by mail-wr1-f68.google.com with SMTP id z11so5174975wro.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 08:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gu5Vr9phmfw4xw3s4gMaeq4iGj88kUgqgIzkzEB9pSA=;
        b=L8h6Pj96emL1ZWlQUdEcXi5ptNYm7JI4OVyxrrFXJi2iVfoKsg/DUbgp+xgqv5zYut
         clP/W3TZoMbEldX/UhJqNfoeZIE+2t+OKXzvZfK3FOh3xWj39NRZ2HxSFOcNv286+iDm
         7mMCZNORAv7Wl6JSOWiNxEQ+otRAxHtFpUJp78nouBmnXoPbzjyhPLzHnYXWCYThrlLw
         avU3Njqzc/U6Eo2MuhYh0PQT3Kye0LMN1/DYfwPXW0veAV4ryk3bvjztrjyiBxJWgScn
         Nr6siGFHKUiyxgE7x20a+vKmTWutuSceA+hJWYPBQncxNLyDH4YXYf+UyFoDFJPaLaWx
         L56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gu5Vr9phmfw4xw3s4gMaeq4iGj88kUgqgIzkzEB9pSA=;
        b=nnbjzFbORvopidC0mvwrXlW4fvsB/vCKh1LL7CFrH3OPyBPcR2KlV4HHAsEuNkoOrm
         E0Ixsl8r5bxTqUYYKR4pXnfQV3XvPhLlDcR9+23k1mh4XOpMhtArO2CSZY+1Vn9IBE8K
         j5i/8MbolerUJFqpl7/VMwa6acc+Q0HsAPZYR7pEwpX4jCBs5pXYhHdcdN3Kg+FVh/eL
         LbyzNmBCWkCajY0gb0Je3lSJ9N69zWxg7Iyg7Gq1j95uGXdL1Rv/qmAdIw7HKG/vLLQ5
         WqGXYy4ni1dSblQAYj6w2QehTNmiqHoEOK48ne4jikYo3NpAQRxDuCgkc3/rQz4vSlBK
         600g==
X-Gm-Message-State: ANhLgQ2+Xhldg8jykyV2LeHAu7ozjC8MAdiRMX7doszzs/QIfabnF3AG
        SLOdjk0juTeU6Ow1V8bvEN7QNA==
X-Google-Smtp-Source: ADFU+vvwFCvbhgW1tjtZiQgB80fxp5GDFXVUbe+L+v4+L//7+V4uMTIwvCfx4mD5dEM2KEN/9Ymr1w==
X-Received: by 2002:adf:f607:: with SMTP id t7mr6118275wrp.36.1583253662962;
        Tue, 03 Mar 2020 08:41:02 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id e11sm33280806wrm.80.2020.03.03.08.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 08:41:02 -0800 (PST)
Subject: Re: [PATCH] sys/sysinfo: Respect boottime inside time namespace
To:     Cyril Hrubis <chrubis@suse.cz>, linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@openvz.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Bohac <jbohac@suse.cz>
References: <20200303150638.7329-1-chrubis@suse.cz>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <9ab86b0c-8a32-39ae-5a14-78b872be6d82@arista.com>
Date:   Tue, 3 Mar 2020 16:40:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200303150638.7329-1-chrubis@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/20 3:06 PM, Cyril Hrubis wrote:
> The sysinfo() syscall includes uptime in seconds this makes it
> consistent with the /proc/uptime inside of a time namespace.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

Reviewed-by: Dmitry Safonov <dima@arista.com>

> ---
>  kernel/sys.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/sys.c b/kernel/sys.c
> index f9bc5c303e3f..d325f3ab624a 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -47,6 +47,7 @@
>  #include <linux/syscalls.h>
>  #include <linux/kprobes.h>
>  #include <linux/user_namespace.h>
> +#include <linux/time_namespace.h>
>  #include <linux/binfmts.h>
>  
>  #include <linux/sched.h>
> @@ -2546,6 +2547,7 @@ static int do_sysinfo(struct sysinfo *info)
>  	memset(info, 0, sizeof(struct sysinfo));
>  
>  	ktime_get_boottime_ts64(&tp);
> +	timens_add_boottime(&tp);
>  	info->uptime = tp.tv_sec + (tp.tv_nsec ? 1 : 0);
>  
>  	get_avenrun(info->loads, 0, SI_LOAD_SHIFT - FSHIFT);
> 

Thanks for noticing,
          Dmitry
