Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A67C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 15:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3562A20716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 15:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUhwiUrr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgA2PMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 10:12:47 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34807 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgA2PMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 10:12:47 -0500
Received: by mail-pf1-f193.google.com with SMTP id i6so8568170pfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 07:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jAjbdSB4PhitWLBUJjxyeisP8S1SP7CeBBmza1KhN5I=;
        b=nUhwiUrrhq4PW56L55MpFpqvYrEdFtdiCz0sH/7uO8q/jYtCVEpfuL33MOIONxZXgh
         IZnD7f85h9Mig4OgfxU2/hTPuw2o31euM2U/vb1yusQwX7zVRhd2vyY5Rky/cNpq4qRf
         M2WyJyh4AFVhuHS58OLfgwAZRNqqc1pF901rA8bdErnfJHrueT5D1liUg/356t3ELJRz
         aiGLFzVDEXw8REvoyonx8SCyBhpdDOKbEY3pOqr/9f+XYZZQyayj/Y8yav8NDWezw0QR
         EvBbBbE3aQFHqovoJyB5dDqEmB6xA1P/KClmQ2F47ybRPayoUCvRwkFQ7wZhkm6En4al
         H0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jAjbdSB4PhitWLBUJjxyeisP8S1SP7CeBBmza1KhN5I=;
        b=b31zeP41yA+BTI5y0zr7lx/y9DLd5pzDC0uisj4bM2rx+eBKG4dMgn0UxkfBNoPwg6
         O4WW9j7UPAI7Eboc2gOOu6yAHsAqetq94xTOUr/1mmbmoEGfwJDORSL6Jy/9mC6htIte
         8YKYDsgpEhoYcbMkgP+fvAZjmh5JROjxDwMPzcz0GzWNopt0hDa7/BrIL4PFDNd3JmC7
         E57QaM0DLtTCExoae1LspPRcTqlVQ0oFtaABMVbI6wPQxythZQUn9Al/J2chIoQp3HXn
         qDhtfRNXz23FCK/3F2dHaNo5Tgmm1izcG5hBXbhw1fsaJ737Q+nVWocSnFvWTTkaDRPe
         zhvw==
X-Gm-Message-State: APjAAAVIA0A/MGcqCimHwVU5DWK60MCDiJ8gRjvs1E+cGWA7dQQ6919t
        KsLBglJ0O7FMJ+hAwipxqiM=
X-Google-Smtp-Source: APXvYqxHNmXVUROAUa+EIZK9o8thI2wc91+MWT5N/XwlKDdwSltEocb6ynMek21mGIeW3Xp3lYVBLg==
X-Received: by 2002:aa7:8246:: with SMTP id e6mr85570pfn.102.1580310766610;
        Wed, 29 Jan 2020 07:12:46 -0800 (PST)
Received: from localhost (167.117.30.125.dy.iij4u.or.jp. [125.30.117.167])
        by smtp.gmail.com with ESMTPSA id g8sm3073746pfh.43.2020.01.29.07.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 07:12:45 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Thu, 30 Jan 2020 00:12:43 +0900
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] console: Introduce ->exit() callback
Message-ID: <20200129151243.GA488@jagdpanzerIV.localdomain>
References: <20200127114719.69114-1-andriy.shevchenko@linux.intel.com>
 <20200127114719.69114-5-andriy.shevchenko@linux.intel.com>
 <20200128051711.GB115889@google.com>
 <20200128094418.GY32742@smile.fi.intel.com>
 <20200129134141.GA537@jagdpanzerIV.localdomain>
 <20200129142558.GF32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129142558.GF32742@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/01/29 16:25), Andy Shevchenko wrote:
> I understand. Seems the ->setup() has to be idempotent. We can tell the same
> for ->exit() in some comment.
> 
> Can you describe, btw, struct console in kernel doc format?
> It will be very helpful!

We probably need some documentation.

> > > In both cases we will get the console to have CON_ENABLED flag set.
> > 
> > And there are sneaky consoles that have CON_ENABLED before we even
> > register them.
> 
> So, taking into consideration my comment to the previous patch, what would be
> suggested guard here?
> 
> For a starter something like this?
> 
>   if ((console->flags & CON_ENABLED) && console->exit)
> 	console->exit(console);

This will work if we also add something like this

---

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index a30ff46c0081..01ced6f38776 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2739,6 +2739,8 @@ void register_console(struct console *newcon)
 		}
 	}
 
+	newcon->flags &= ~CON_ENABLED;
+
 	if (console_drivers && console_drivers->flags & CON_BOOT)
 		bcon = console_drivers;
 

---

I don't know why some consoles set CON_ENABLED statically.

E.g. drivers/tty/serial/mux.c

static struct console mux_console = {
        .name =         "ttyB",
        .write =        mux_console_write,
        .device =       uart_console_device,
        .setup =        mux_console_setup,
        .flags =        CON_ENABLED | CON_PRINTBUFFER,
        .index =        0,
        .data =         &mux_driver,
};

No idea...

Such consoles still will have CON_ENABLED even if registration failed
and we never ->setup() them.

	-ss
