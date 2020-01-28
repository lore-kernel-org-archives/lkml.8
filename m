Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D500C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 05:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F7D22522
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 05:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t58f8cjQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgA1FRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 00:17:15 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40168 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgA1FRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 00:17:15 -0500
Received: by mail-pg1-f194.google.com with SMTP id k25so6342559pgt.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 21:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=otf+Kn6E7gyvAshKC+Kdl4WFFbgC+FHpC4JGC79vfSY=;
        b=t58f8cjQR2wG6rt1bbL+cDPFF77PanYskydWvDuxs14ZXbByeZDMu1K4RJBqP3xPuZ
         KdOi7J+3RBR7vomXkUojcWiMd7gENUIs5Lpl3QeE8iCXY/mQw0OICNKSGOOgZwTpSgFT
         3JW+CVSqwW+lIl4yPl5tpY2vDcuRRZKHTQ7hNtykESa4AsfeJ7C1spEcgdFT2574quEA
         1ZV6iv6Iu3xJtdnoU+DljeYDar37k5p+woCwSbNxvCpbwKJLJalJuPFgtk5/BA5g602k
         H1saRoF3FAOrfphCWuww0gnhXxUMdUuKlAEOy/9NoCvw7QwDHSSYeFGULz7cLiGgpZML
         m8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=otf+Kn6E7gyvAshKC+Kdl4WFFbgC+FHpC4JGC79vfSY=;
        b=pf3msgCFZx+JGOj2LMwCYUL5HZH+ujugEqasxGXHGNSvtd6f2D6pNM6z0/3DXD/rM5
         B3C9LOdUXd2hQG3c5y9mAuyyAEyYY4SxBFJHpIfngycykgt7DwXcVRvKsepPUkpRMgyu
         EuuV1CZrPdmzy99PTIvYskNKTAKYdszFXJQ1YY70PRQjOApj5R0ae5pp5E5H1lSiuk01
         NA6qtFcuDviZ+277OXSIhUtxwIx7sJSmx4khqeDNoVeBvH0Iyy1lLe3yssX9tZwHETzB
         eQgoQhVWASmtzGECvGKjfEnOQ+gytsa0tHkMlrAXyxx22vXFbiRM7IPIrwCM9qgdAe7W
         H+cQ==
X-Gm-Message-State: APjAAAVNecQBJ2BBD+Phqj6qJ3sMfI4ltl1+2OurWKHdHo10KFii2kZT
        cmj5B/I2vY6Ay9CFra2+VsE=
X-Google-Smtp-Source: APXvYqzupBTl6g57Wv4m/R2Pr1Ujb2YvZNpUjlhSLZAkFP7Cy12BOM3pmuFTv1vvvsD0ITXcSk17Lw==
X-Received: by 2002:a63:4641:: with SMTP id v1mr22592498pgk.389.1580188633925;
        Mon, 27 Jan 2020 21:17:13 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id d22sm17365348pfo.187.2020.01.27.21.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 21:17:13 -0800 (PST)
Date:   Tue, 28 Jan 2020 14:17:11 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] console: Introduce ->exit() callback
Message-ID: <20200128051711.GB115889@google.com>
References: <20200127114719.69114-1-andriy.shevchenko@linux.intel.com>
 <20200127114719.69114-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127114719.69114-5-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/01/27 13:47), Andy Shevchenko wrote:
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
> index da6a9bdf76b6..6ca03d199132 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2853,6 +2853,10 @@ int unregister_console(struct console *console)
>  	console->flags &= ~CON_ENABLED;
>  	console_unlock();
>  	console_sysfs_notify();
> +
> +	if (console->exit)
> +		console->exit(console);
> +

If the console was not registered (hence not enabled) is it still required
to call ->exit()? Is there a requirement that ->exit() should handle such
cases?

	-ss
