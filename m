Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAD0C35240
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 02:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1AED2083E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 02:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMeygzc+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgA0CWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 21:22:23 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40012 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgA0CWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 21:22:23 -0500
Received: by mail-pg1-f195.google.com with SMTP id k25so4370345pgt.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jan 2020 18:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M+XuWgHANdv6/hr5N9ZHxgdulAzENt8/f+HzpO/uuL4=;
        b=kMeygzc+542peYhQiMvjcL22O263y7pXctubsLqHIpRD18BOTX9FnbX3En1e7cqmGa
         /gZgw/uV1bba1snc8m6s77lCO8BBjmorPAN5oYxxLkKCBqZsbdWuBXry5DNjiJbV5lR+
         6TSL8L5BU2ByEmkdoCFvGjlwPBWvs8+n+GgDLjblaMVwuKxoOfZz0Z55OWite2te05V7
         sJFfbvxrzReYyvR7vGLyb/LvkU88dMAOqAfWapb5gXTMxeGuwyw73MaLP9lChUkkO7uC
         aq0BDokFyZ6KMkmdUXYDf+UTryynsgbLYgUlcKUrgZM4U6Wgy0FKgaExfK1Wxn0iAvo6
         TogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M+XuWgHANdv6/hr5N9ZHxgdulAzENt8/f+HzpO/uuL4=;
        b=TR2kJUnkcgbsSrWPx/fII7HXGnDkhsV50LuvPYNvPb7kepvqcGkAsk5sWPxqLz9o3s
         s460ZhExtF8StiAtI7e5GpTUwF1Nz4vrXICiMaWu/EnWybZu/ZXKObs/Bd74+r2/6Lz7
         v8jhQMsbCFojDsYfcKgV293tmXinAmPGR9pIXFk1ZDbLsQQ6R70lct25D2+jMoUYEMo6
         Ea0lsKf0T/vNvpD7fHAkGFpR5zJmY9aWdbXQ9Lc7Ut9ZqVv2yorLKI4FKwuM5fS3DlhS
         qVpF0vnwMnLSPnE1v1uOTBTXZYiUr5ChWpFA2bQuwFJKGgXQPGgvajRCq+UNUABSWWtl
         M1iw==
X-Gm-Message-State: APjAAAWd2JGkz7S3Re++py/XFXyhPqL1HhC1OSF+XH2d/FhTK5V+w+wl
        n3uYRx3KUqtxoqQEdKs3uZA=
X-Google-Smtp-Source: APXvYqzC6oGtkRLLtnPND3DQvlStWVFiIiHBmcOH+5LgndPC0pNt2SXTUdO5CXYDfwjctsIeEJEFmw==
X-Received: by 2002:a63:1a1c:: with SMTP id a28mr17918168pga.374.1580091742609;
        Sun, 26 Jan 2020 18:22:22 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id i11sm13789393pjg.0.2020.01.26.18.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2020 18:22:21 -0800 (PST)
Date:   Mon, 27 Jan 2020 11:22:20 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] console: Introduce ->exit() callback
Message-ID: <20200127022220.GB100275@google.com>
References: <20200124155733.54799-1-andriy.shevchenko@linux.intel.com>
 <20200124155733.54799-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124155733.54799-5-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/01/24 17:57), Andy Shevchenko wrote:
[..]
> +++ b/include/linux/console.h
> @@ -148,6 +148,7 @@ struct console {
>  	struct tty_driver *(*device)(struct console *, int *);
>  	void	(*unblank)(void);
>  	int	(*setup)(struct console *, char *);
> +	void	(*exit)(struct console *);
>  	int	(*match)(struct console *, char *name, int idx, char *options);
>  	short	flags;
>  	short	index;
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index da6a9bdf76b6..0319bb698d05 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2850,6 +2850,9 @@ int unregister_console(struct console *console)
>  	if (console_drivers != NULL && console->flags & CON_CONSDEV)
>  		console_drivers->flags |= CON_CONSDEV;
>
> +	if (console->exit)
> +		console->exit(console);
> +
>  	console->flags &= ~CON_ENABLED;
>  	console_unlock();
>  	console_sysfs_notify();

Do you need to call ->exit() under console_lock?

	-ss
