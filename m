Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB80C3815B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 02:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC0B121927
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 02:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibvnyBGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgDRCAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 22:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725796AbgDRCAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 22:00:11 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DE0C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 19:00:11 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id x10so3829809oie.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 19:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UDhmKyRwtrrcwWzyNDyqVl+mjHgBzC9RP/xHPQTSQ2w=;
        b=ibvnyBGLmtPAKNZBoF40Vs+m7TVz/L9OzrncZp05mIyVI9HfcORmsAILK4w1Pey6r2
         JdrZIY6bgOt38tFTWlhUw0sHeAyt7p/kCtdgmuAylFmwxgQgvg+G4lpZECNsIGJS1Hxy
         4T9rH5rSA/xCpgttaj68N2YpANPfhjETclI3W6dWTJQQ8YRm+Irq6xq6z0o4F7FhhUYb
         IkpA+ZAXz1rk5YvfpfLtBx9uAin6HDGDam3eAQZPADvZkgs/IaiVOoc2kiTah/vWfHzY
         YE7grFPG4C1gsFH0saqS6SNFKolM1KrRZTugKk/e0BVGi4V+0SH6ti7GvJ6bGaCOsiZO
         o/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=UDhmKyRwtrrcwWzyNDyqVl+mjHgBzC9RP/xHPQTSQ2w=;
        b=ffqtZfeUmMyjrhEfoVvcitGncl0Z0UVUMyz6aP/4lqE6ZDO7CI2yt8sMJxNq2d5Qje
         2Pk1RCJ6movdiybhT7WdjWgUkvKV+fiaX2a1CYK5nYpsw2shQ5i89NJ4VxtX5HcwUmuV
         vcPg76HyLAOIymsYtVLiUUQ7IZi2vAZil851VTA5oWNP/r7rIXki3ktqKuFWnV+Ce71w
         SCuZkT0cZM06JTVsXVkdPFVRmct60o1DhiMVCgI8smncy0Qn4yp6pbg1jgRirpzJI58E
         q9dafhzqfnLJQkd1jbu8rgxaxr6kBt8ghNkvNv/jx4Lc4MrLVb3rVB7qliOVVZUjhB1a
         C3dA==
X-Gm-Message-State: AGi0PuZv8FH88NrorQXA319ctmmBDq/UDzeKkp/Acj1/5zitYVKxjJ0M
        gE2CDBdbj0qXxRTllfwSGw==
X-Google-Smtp-Source: APiQypKUwY3nQ4qkxtA3EZQ4REOJnC1bu+V4YjYtLKwDCnV33bSQ8ZKAHcgVd2lY/cEHQWHKYGsZ0A==
X-Received: by 2002:aca:b984:: with SMTP id j126mr3992277oif.87.1587175209802;
        Fri, 17 Apr 2020 19:00:09 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id 33sm8451506otn.50.2020.04.17.19.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 19:00:08 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:8b39:c3f3:f502:5c4e])
        by serve.minyard.net (Postfix) with ESMTPSA id E9680180053;
        Sat, 18 Apr 2020 02:00:07 +0000 (UTC)
Date:   Fri, 17 Apr 2020 21:00:06 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] ipmi: use vzalloc instead of kmalloc for user
 creation
Message-ID: <20200418020006.GB6246@minyard.net>
Reply-To: minyard@acm.org
References: <1587099689-13678-1-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587099689-13678-1-git-send-email-feng.tang@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 01:01:29PM +0800, Feng Tang wrote:
> We met mulitple times of failure of staring bmc-watchdog,
> due to the runtime memory allocation failure of order 4.

I'm beginning to think that using srcu was a bad idea.  It made things
cleaner and easier, but it eats tons of memory.  Sigh.

Applied, at least for a fix for now.

Thanks,

-corey

> 
>      bmc-watchdog: page allocation failure: order:4, mode:0x40cc0(GFP_KERNEL|__GFP_COMP), nodemask=(null),cpuset=/,mems_allowed=0-1
>      CPU: 1 PID: 2571 Comm: bmc-watchdog Not tainted 5.5.0-00045-g7d6bb61d6188c #1
>      Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.00.01.0015.110720180833 11/07/2018
>      Call Trace:
>       dump_stack+0x66/0x8b
>       warn_alloc+0xfe/0x160
>       __alloc_pages_slowpath+0xd3e/0xd80
>       __alloc_pages_nodemask+0x2f0/0x340
>       kmalloc_order+0x18/0x70
>       kmalloc_order_trace+0x1d/0xb0
>       ipmi_create_user+0x55/0x2c0 [ipmi_msghandler]
>       ipmi_open+0x72/0x110 [ipmi_devintf]
>       chrdev_open+0xcb/0x1e0
>       do_dentry_open+0x1ce/0x380
>       path_openat+0x305/0x14f0
>       do_filp_open+0x9b/0x110
>       do_sys_open+0x1bd/0x250
>       do_syscall_64+0x5b/0x1f0
>       entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Using vzalloc/vfree for creating ipmi_user heals the
> problem.
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index c48d8f0..96f1573 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -1153,7 +1153,7 @@ static void free_user_work(struct work_struct *work)
>  					      remove_work);
>  
>  	cleanup_srcu_struct(&user->release_barrier);
> -	kfree(user);
> +	vfree(user);
>  }
>  
>  int ipmi_create_user(unsigned int          if_num,
> @@ -1185,7 +1185,7 @@ int ipmi_create_user(unsigned int          if_num,
>  	if (rv)
>  		return rv;
>  
> -	new_user = kmalloc(sizeof(*new_user), GFP_KERNEL);
> +	new_user = vzalloc(sizeof(*new_user));
>  	if (!new_user)
>  		return -ENOMEM;
>  
> @@ -1232,7 +1232,7 @@ int ipmi_create_user(unsigned int          if_num,
>  
>  out_kfree:
>  	srcu_read_unlock(&ipmi_interfaces_srcu, index);
> -	kfree(new_user);
> +	vfree(new_user);
>  	return rv;
>  }
>  EXPORT_SYMBOL(ipmi_create_user);
> -- 
> 2.7.4
> 
