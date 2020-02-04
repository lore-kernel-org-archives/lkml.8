Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D49C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 02:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380812084E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 02:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eozpiRxf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgBDCQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 21:16:24 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44015 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgBDCQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 21:16:24 -0500
Received: by mail-pf1-f194.google.com with SMTP id s1so8608618pfh.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 18:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QH6t5+P9IvjHew1g3+ZZFvveJFDwCjcHV2ml4p3nTPg=;
        b=eozpiRxf1ifzipl/Fgd3fvIqP2hdE/FX1LeJgVDf44CUROE3vz1QaKnniZ1qT7Aj16
         6AChhuW2rNu52u+DvKIV8aKwXeHTlgB1ekN2Tf0ZOgGrbEnI71mFV1QUsThfvmcRh3ho
         000MtGIG3o4WdZfGtS93vreC3xN1/FbLyR0v40NzvNHNxtXAblWqYXdUxQPDrQeOEZ4Z
         1PkZjEKuuXbkioEyuiJnEO2HXDTu3XnQbSB7oCClZRrj2L1fTAVG4m1WGq4qoVcrkd8P
         5qr5BV86idf/vtK4/KYNdjSRi8neOXG+pn9Y+Uf12rkE2u4V3KIYRO08CbRxcCathKr1
         unhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QH6t5+P9IvjHew1g3+ZZFvveJFDwCjcHV2ml4p3nTPg=;
        b=sKky7TVl5q51oRhF11QZPVeVOINXkXqqh4XLytUJtgx4uSvhWx5c1dbs7SggK/zejM
         XVYy7GHIOBrXqw/2mutPLS+gIFY5Ue1Wd4+6wUEwHLZ1PCotl56lEOj5Q3xVHk5RuQtJ
         /1b8xQw+tGAyTEHp44A77F+E8Xhl7buUpQEgbWde4e/PGYO7GWNOGb0E9mOStaE5ELs7
         adkTlimUDiJ4BBEP0Im7ystFan9viFCs+t55mbqlmA4j+PpKhFIcRLtQEJI5Yp9GHCHj
         2e1AMDxB9z40Q3GKO5OeZdBY/JhknhyzOlHoVI78cvFOGCZy6ryrSLpyqa4zAzQQfvb+
         5cvA==
X-Gm-Message-State: APjAAAUu8DBFgyv+1Rh3LsyrupTcmP8uWszGfYUfCrQXLizD5O4W3uW7
        nOActJ3oudwpwCy253Hb5gHhMslX
X-Google-Smtp-Source: APXvYqzfLYfco8Pv23blx1p7G6YEjbP2W9xGDfDycLtP/wusgLrgFwSBE7IiVllJtq5ISH7lx5OAkg==
X-Received: by 2002:aa7:9a0b:: with SMTP id w11mr8842662pfj.4.1580782583373;
        Mon, 03 Feb 2020 18:16:23 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id w131sm22534230pfc.16.2020.02.03.18.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 18:16:22 -0800 (PST)
Date:   Tue, 4 Feb 2020 11:16:20 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v1] printk: Declare log_wait as external variable
Message-ID: <20200204021620.GD41358@google.com>
References: <20200203131528.52825-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203131528.52825-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/03 15:15), Andy Shevchenko wrote:
> Static analyzer is not happy:
> 
> kernel/printk/printk.c:421:1: warning: symbol 'log_wait' was not declared. Should it be static?
> 
> This is due to usage of log_wait in the other module without announcing
> its declaration to the world. I wasn't able to dug into deep history of
> reasons why it is so, and thus decide to make less invasive change, i.e.
> declaring log_wait as external variable to make static analyzer happy.

[..]

> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 633f41a11d75..43b5cb88c607 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -418,7 +418,14 @@ DEFINE_RAW_SPINLOCK(logbuf_lock);
>  	} while (0)
>
>  #ifdef CONFIG_PRINTK
> +
> +#ifdef CONFIG_PROC_FS
> +extern wait_queue_head_t log_wait;	/* Used in fs/proc/kmsg.c */
>  DECLARE_WAIT_QUEUE_HEAD(log_wait);
> +#else
> +static DECLARE_WAIT_QUEUE_HEAD(log_wait);
> +#endif /* CONFIG_PROC_FS */

[..]

Since we are now introducing CONFIG_PROC_FS dependency to printk (and
proc/kmsg already has CONFIG_PRINTK dependency), then I guess I wouldn't
mind it if fs/proc/kmsg would just relocate to printk, next to devksmg
implementation. Just saying.

	-ss
