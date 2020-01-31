Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D14C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 01:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEEDD206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 01:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCmk4rO9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbgAaBb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 20:31:58 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38471 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbgAaBb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 20:31:58 -0500
Received: by mail-pg1-f193.google.com with SMTP id a33so2595937pgm.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 17:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U2x5dj+83wXzm4VqGaoW0lyT3PBQZww/cM9e5d5k+tk=;
        b=BCmk4rO9h/X2WMI+bVjsIxvvmFsYojMNZVHIRUuhW9VXixd/bE3Qo3d5txWxxPJq71
         oLGqnE4pgsMKmY37JoOpsGHOjkPHqU7DTvtypm0a44k+mw7X8iaj5vhMgsLpJt23F3ad
         hSaOGdjVjr8rKFAQvSbNLyO9uKowaAAGP6QNmuWWTZveLQ9/kEoxk0zHZVekpG5slYPk
         dWrTaxeb+mh8FS9peKZ95/oZ+Fb5HimFDaBVXVtbfGZjF7SITCQOR4WMkZp3Tiby8aZf
         YihxkQ0e+qSY8aT8XetXhkXwAYKMia1ygr2y4PoTj3TkyWsrQiar3Wziczb4uLlmmwQ+
         hi2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U2x5dj+83wXzm4VqGaoW0lyT3PBQZww/cM9e5d5k+tk=;
        b=UNgLAnyN5yUDxT0fbF6+ZmZvlMfPl0y7g0zMmpP+olNgZ1/SUUevH3jCP5QHkuiw8p
         gxZfhCEMtuEuHstykmE6Ew3bKvm1AoD66yWKpcpq0R67+se1PcTMmsRVCjY66YBqj4CR
         kE0avTZjYJbr4oi+FwkBy/VTvBm/ea9dqvzw2rXjzbxKpZqiIPtm2OhYYmVN4Gos38OW
         v3Zf+eaXqrWO00tgihxZ+e9wFLOX5c0iIvvpSzME/idDB1TQ2iEoYXyAFkrAsUlAXpXP
         NaOIsIY/6j0PtKyNzZUFrsuNMa5O9/JQ2+sCncwYA6gn5mp8iQ9B+4BtbdSn7udVEzFd
         CEiQ==
X-Gm-Message-State: APjAAAXiDblGVxaLpNPVdpBhASBOGlZslaKiosYRxPdDg6e/zvxroCjv
        Qm59SjfK+vpGCnJt31YBH5r2F/MP
X-Google-Smtp-Source: APXvYqxstfUd3VCQgGh7nQVX5ClZySt3J6nKgJD5BwYURM7/ioR5FM51xsVrZAViiyrX8khMsyOH2Q==
X-Received: by 2002:a63:6fca:: with SMTP id k193mr8077308pgc.416.1580434317399;
        Thu, 30 Jan 2020 17:31:57 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id b188sm6246599pfb.56.2020.01.30.17.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 17:31:56 -0800 (PST)
Date:   Fri, 31 Jan 2020 10:31:54 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/6] console: Introduce ->exit() callback
Message-ID: <20200131013154.GH115889@google.com>
References: <20200130152558.51839-1-andriy.shevchenko@linux.intel.com>
 <20200130152558.51839-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130152558.51839-5-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/01/30 17:25), Andy Shevchenko wrote:
[..]
> diff --git a/include/linux/console.h b/include/linux/console.h
> index f33016b3a401..54759ad0c36b 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -148,6 +148,7 @@ struct console {
>  	struct tty_driver *(*device)(struct console *, int *);
>  	void	(*unblank)(void);
>  	int	(*setup)(struct console *, char *);
> +	void	(*exit)(struct console *);

Should console ->exit() be able to return an error code?

>  	int	(*match)(struct console *, char *name, int idx, char *options);
>  	short	flags;
>  	short	index;
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 932345e6cd71..0117d4d92a8e 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2850,6 +2850,10 @@ int unregister_console(struct console *console)
>  	console->flags &= ~CON_ENABLED;
>  	console_unlock();
>  	console_sysfs_notify();
> +
> +	if (!res && console->exit)
> +		console->exit(console);
> +
>  	return res;
>  }

I would probably push it a bit further (I posted this snippet in another
thread). If console is not on the list then there is nothing for us to do
and sysfs notify is pointless.

---

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 0117d4d92a8e..7116e421210b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2837,7 +2837,13 @@ int unregister_console(struct console *console)
 		}
 	}
 
-	if (!res && (console->flags & CON_EXTENDED))
+	if (res) {
+		console->flags &= ~CON_ENABLED;
+		console_unlock();
+		return res;
+	}
+
+	if (console->flags & CON_EXTENDED)
 		nr_ext_console_drivers--;
 
 	/*
@@ -2851,7 +2857,7 @@ int unregister_console(struct console *console)
 	console_unlock();
 	console_sysfs_notify();
 
-	if (!res && console->exit)
+	if (console->exit)
 		console->exit(console);
 
 	return res;
