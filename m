Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DE1C2D0FB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 00:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 389AA20769
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 00:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589329666;
	bh=npw0YWZB21eQ2N/KBNiYMgEpOQ9Rya4NEY9nds5Ynt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oP9/xbt5pr+AjkFluo7yhzcYrvH26nEkEK0eaodYZt3TreqmgQ/aQrC5lNgUIqRfW
	 45gI6Z55X7m9MF3vkhAfn8hnCPztO6VVg/CyjaTqCdJ441G8Al+VtbEePvS1K6YKs7
	 5dHaCZNMR3Ws3h8FuEuDC00GeJzd/V5X5OFyVzlc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731754AbgEMA1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 20:27:45 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38292 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbgEMA1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 20:27:45 -0400
Received: by mail-pf1-f195.google.com with SMTP id y25so7206421pfn.5;
        Tue, 12 May 2020 17:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mi1r7sjPCBWlRuip23J6jYxdcglvz/pF2DIUwfVvmR4=;
        b=iPvySpOww7wjeutYxZCRlLIuw9Je+qAM6woOpgE3FZQ/ym6xmAKEiBU4TqABUPq4bA
         8FJqWKxS0OqVa3UM8pzMj+AZNLHtvDSBdpfnyPeuBlBC4Uvi+LMBumstRTlhOwS5zpiB
         Clw+qs4U7yTvp8idoo2yrzU6Zk7udva9lsm7GrXnD0wCDQx2Syi8+QFfrKMOIh0JrF63
         UEhQvN05+vTsyM5p433DQkEFyRdE93Sz33DDr04zU8rC1wEHoXChXGfUDVMvAijxPwc7
         pJal9PFS4yHs9zRJ5DdX+SJjweXz80n2bQWo4/HV5BKcv5b17WIP2lJ8Ee+OGv93evL8
         PGIg==
X-Gm-Message-State: AGi0PubMBZBPdwXD5+GElN+557hrMJzyDReKsdnEASgaCXMfycZ+EBD1
        BQzmH+yLD/2+D4Xzajwhg/E=
X-Google-Smtp-Source: APiQypKzsoKeSk/gwFDAi5tNqLyOjqLzxZIGT8Ug4NHjYG4sk1+ftz/e4UuD2Im8fUZ7Q5qE1S+e/Q==
X-Received: by 2002:a63:5c04:: with SMTP id q4mr21256779pgb.53.1589329663163;
        Tue, 12 May 2020 17:27:43 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id fv12sm2908612pjb.42.2020.05.12.17.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 17:27:41 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 3B83E4063E; Wed, 13 May 2020 00:27:41 +0000 (UTC)
Date:   Wed, 13 May 2020 00:27:41 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Scott Branden <scott.branden@broadcom.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH v5 1/7] fs: introduce kernel_pread_file* support
Message-ID: <20200513002741.GG11244@42.do-not-panic.com>
References: <20200508002739.19360-1-scott.branden@broadcom.com>
 <20200508002739.19360-2-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508002739.19360-2-scott.branden@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 05:27:33PM -0700, Scott Branden wrote:
> diff --git a/fs/exec.c b/fs/exec.c
> index 06b4c550af5d..cfab212fab9d 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -896,10 +896,14 @@ struct file *open_exec(const char *name)
>  }
>  EXPORT_SYMBOL(open_exec);
>  
> -int kernel_read_file(struct file *file, void **buf, loff_t *size,
> -		     loff_t max_size, enum kernel_read_file_id id)
> -{
> -	loff_t i_size, pos;
> +int kernel_pread_file(struct file *file, void **buf, loff_t *size,
> +		      loff_t pos, loff_t max_size, unsigned int flags,

You use int flags, but.. these are mutually exclusive operations, and
so flags is a misnomer. Just use an enum instead of a define, that way
we can use kdoc for documentation.

> +EXPORT_SYMBOL_GPL(kernel_pread_file);
> +EXPORT_SYMBOL_GPL(kernel_pread_file_from_path);
> +EXPORT_SYMBOL_GPL(kernel_pread_file_from_path_initns);
> +EXPORT_SYMBOL_GPL(kernel_pread_file_from_fd);

If no one is using these don't export them. I think you only use one of
these. In fact just remove the code from the ones which are not used.

  Luis
