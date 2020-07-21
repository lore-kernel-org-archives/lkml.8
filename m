Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD74C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CDF7206F2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBmDm2wx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbgGULby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgGULbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:31:53 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879E5C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 04:31:53 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 95so14791132otw.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 04:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J8+ZzLQU1DKkGpd+nrEd6PrRxlNkrxHw8dBLLALGP/4=;
        b=mBmDm2wxTdvMcm1uLvLz/S2MTRQoiNFHp26/ALu0Z15rkWakMIMMYBYSQ1m5BV8Vj7
         zarNUBw1TKK0gu83LpYu8Rux5oPZ43QgrTmnPHlCs5iHAT3j5xyayvCa3FqLKLcaoLHg
         T8pBl7caJAByaP7IoZCvlpanEY3WucjtCrhDfgntzaBmcC7vdU5koHWDy5aUroxF8S+J
         4rOYfE9AjrH4/zOL9L1/8tbNLhM8jRLeutmg664m9Fc1lMVmcHkc32gzDUx1K729SmY+
         EZH/mnYbet+kTjwjCZGHyD+W0cYwQoRkWi/F6qXnKXiNfIMC0ifJG0XpR+h/2f7Dlie5
         SAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=J8+ZzLQU1DKkGpd+nrEd6PrRxlNkrxHw8dBLLALGP/4=;
        b=GGMejwFj17EctgepVfkpv3dF2rnU+JCCaC4b8RqMli9BXuLSaEAhuie+Apnb9wtXoj
         3U09p3EKqkEdNrWlAwRcMLwlsIGZjl2GY+YNUKIr/dj4bvWbZ2ocY7VP9YGdzjYSq21d
         P//IHwsIZEs9CW5j/9ttggah6MAz1HVjSyYn0ABmMa6LTB+rPEu6QGLdnPuHhJHuY2bl
         T7AdHDDutyQp4gwpol9NJTzH/M8PsAO9uwDDs95sJuNzKh/tXT9Vkl/xLCfd9w/BJedY
         b/j1GFuEW1LGmDM8mUVcm+OZfjChf2+w2q1jDyM4C4LwF75qoHn91PhQswxyJmvMaHYs
         XWXg==
X-Gm-Message-State: AOAM532C27e3fGapzZ7qvmBkmS6eL16SGUQqFYXHiS7WUhfaLhR3UNpT
        Zyze0PnFAJFi8ptukNjz8Q==
X-Google-Smtp-Source: ABdhPJy4fDNvNSAWBrkH6siHqvLvS4hIhyc98yEGNeHrZmkH8eBvKk3W0h8YSMqDMrD27KE6ulXf5w==
X-Received: by 2002:a9d:4ef:: with SMTP id 102mr23456732otm.289.1595331112867;
        Tue, 21 Jul 2020 04:31:52 -0700 (PDT)
Received: from serve.minyard.net ([47.184.146.204])
        by smtp.gmail.com with ESMTPSA id x10sm5035671ooq.13.2020.07.21.04.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 04:31:51 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:70d6:b947:41f4:6e7e])
        by serve.minyard.net (Postfix) with ESMTPSA id BDAFA18003B;
        Tue, 21 Jul 2020 11:31:50 +0000 (UTC)
Date:   Tue, 21 Jul 2020 06:31:49 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, guohanjun@huawei.com, joe@perches.com
Subject: Re: [PATCH v2] ipmi/watchdog: add missing newlines when printing
 parameters by sysfs
Message-ID: <20200721113149.GH2952@minyard.net>
Reply-To: minyard@acm.org
References: <1595313309-43881-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595313309-43881-1-git-send-email-wangxiongfeng2@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 02:35:09PM +0800, Xiongfeng Wang wrote:
> When I cat some ipmi_watchdog parameters by sysfs, it displays as
> follows. It's better to add a newline for easy reading.
> 
> root@(none):/# cat /sys/module/ipmi_watchdog/parameters/action
> resetroot@(none):/# cat /sys/module/ipmi_watchdog/parameters/preaction
> pre_noneroot@(none):/# cat /sys/module/ipmi_watchdog/parameters/preop
> preop_noneroot@(none):/#
> 
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>

Thanks, included in my queue for next release.

-corey

> ---
>  drivers/char/ipmi/ipmi_watchdog.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_watchdog.c b/drivers/char/ipmi/ipmi_watchdog.c
> index 55986e1..f78156d 100644
> --- a/drivers/char/ipmi/ipmi_watchdog.c
> +++ b/drivers/char/ipmi/ipmi_watchdog.c
> @@ -232,12 +232,17 @@ static int set_param_str(const char *val, const struct kernel_param *kp)
>  static int get_param_str(char *buffer, const struct kernel_param *kp)
>  {
>  	action_fn fn = (action_fn) kp->arg;
> -	int       rv;
> +	int rv, len;
>  
>  	rv = fn(NULL, buffer);
>  	if (rv)
>  		return rv;
> -	return strlen(buffer);
> +
> +	len = strlen(buffer);
> +	buffer[len++] = '\n';
> +	buffer[len] = 0;
> +
> +	return len;
>  }
>  
>  
> -- 
> 1.7.12.4
> 
