Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9502CC3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC5C2067C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582895261;
	bh=82O9Q4K3fw+DxlKKNILi3KCVgL4Kq+Mu3Um5a9/JeOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PqUVeKIYGRU3mcUlX7HoerrCXbKK0ZipuASNpkpmTYdcRgkGnb9f9koug6UztI1oO
	 lucmxZKK5ambZExUeuWbZyM3zpulvHV3JEkoU8jBsI+G/zz553s8kghevbj5W1MFFv
	 Sj4NiEGgTqj0gMW87w+bzafpkBZOVFzhgLUjn7hA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgB1NHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:07:40 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39400 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgB1NHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:07:40 -0500
Received: by mail-pg1-f195.google.com with SMTP id s2so646348pgv.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 05:07:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aX8lWjzLnVjmxiN9TcAcGkrQKJfwGRC+NlHJIQaBb3E=;
        b=ak54Gs27w0dWBG+vXT3xX9T2P1FYNis+Pinsw3Aspu/19oO3OAbPg8VTihlo1feqyh
         9cNLWMcPDtRs2B4zpmtGCx5egzK+9U6iXE5o0Yhyo3lzfEI///QGU3BshLSvq/ZanlU7
         VVD0HvxwbN4tzjdmFf0N7Nmtr69/v5jI7068H0ffgrN0X8ylKTdt20JgT58FObicoz/n
         B5DdMOhIJGy3ljDCLebYnU734zlU8HJHkKLVRelnMlB3hRYiWIS8YGLFHYnl18omh+Fq
         v6LcPIwy0s+HOv3/wCwbeq909l+UhEPBxuYOtOIZmKD+OO3/362DoejBq6MUGyLeYkL1
         aHJA==
X-Gm-Message-State: APjAAAWtsXr1Lo5oACBzI6F8kNR3+tj5CMmIFcYBfLOKVvwH0tOl7P1Y
        p94YeaHg0PjGfALoZtBORsk=
X-Google-Smtp-Source: APXvYqwD/9fmH32eVCZEP5+6HvThzzEZEn76c0ySdjqM8akpO/1BRkFVXK4aJiqyQMOXIbXqcmMTLQ==
X-Received: by 2002:a63:114a:: with SMTP id 10mr4448655pgr.185.1582895257294;
        Fri, 28 Feb 2020 05:07:37 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id a18sm2926947pfr.148.2020.02.28.05.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 05:07:35 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 2E59E4042C; Fri, 28 Feb 2020 13:07:35 +0000 (UTC)
Date:   Fri, 28 Feb 2020 13:07:35 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Junyong Sun <sunjy516@gmail.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        sunjunyong@xiaomi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: fix a double abort case with
 fw_load_sysfs_fallback
Message-ID: <20200228130735.GA11244@42.do-not-panic.com>
References: <1582876593-27926-1-git-send-email-sunjunyong@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582876593-27926-1-git-send-email-sunjunyong@xiaomi.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 03:56:33PM +0800, Junyong Sun wrote:
> fw_sysfs_wait_timeout may return err with -ENOENT
> at fw_load_sysfs_fallback and firmware is already
> in abort status, no need to abort again, so skip it.

What exactly is caused by this issue though? Are you seeing
a kernel panic, some extra messages in the kernel log? This
informationw ould be useful for the kernel commit log.

> Signed-off-by: Junyong Sun <sunjunyong@xiaomi.com>
> ---
>  drivers/base/firmware_loader/fallback.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
> index 8704e1b..1e9c96e 100644
> --- a/drivers/base/firmware_loader/fallback.c
> +++ b/drivers/base/firmware_loader/fallback.c
> @@ -525,7 +525,7 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs,
>  	}
>  
>  	retval = fw_sysfs_wait_timeout(fw_priv, timeout);
> -	if (retval < 0) {
> +	if (retval < 0 && retval != -ENOENT) {
>  		mutex_lock(&fw_lock);
>  		fw_load_abort(fw_sysfs);
>  		mutex_unlock(&fw_lock);
> -- 
> 2.7.4
> 
