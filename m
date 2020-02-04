Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1544EC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CB9217BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeAfttWg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbgBDLWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 06:22:17 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35969 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbgBDLWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 06:22:16 -0500
Received: by mail-pj1-f67.google.com with SMTP id gv17so1245449pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 03:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1W+3zsnEU6ZNkubtrp4GhFh9NK/nPnnv+lTC1XegvP8=;
        b=OeAfttWgeChdF9jpkkVhU+wvcxHefjsWiwdrj2bhSZJT0Dr1h7Haz2ILIGKxW1pati
         jWehdM8enEg1fnOfj9k14OETsvT058yy816xDBSWLLtwX+6W1U5uxSs+Ky/n54JVHLza
         myy+gxjwYaoR9mx27dDhk7ftGOgtfkSEeGOqu/l/8TTSEDXHy2danjBrVVObAhyab/l4
         fONNsjAJMbhlGJu5zMdNxQRoky60xsHUA6R9Z4Hth10regafKyM62/8owbTUUwJ2IePx
         K8LLcFp79iMIdloo7KQX5AWzEXfzXU1IJms7gbAYpmL9bFSNOuCfi6eWUWztTNeNQsr2
         9wLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1W+3zsnEU6ZNkubtrp4GhFh9NK/nPnnv+lTC1XegvP8=;
        b=ja80OpgmTxeRjUld+5JcvSeXijhXSEbiPl2kyqnAqsd6oVX/FKYEgkQo1hTGj1DkRW
         6m5uqMqvPz1XVnra9wPNlYiNV81hOL9J9fP7qCrKDhhClk+GjT/SEy9sr1bkOwurLtTQ
         vIbvbTPiLWVQ7zRkVtYRV7fEVtwK6S/PINp8FgNTY5Ac+5mOmgNEybWlydRVJP177yUp
         uzfNnu0hmLDcsasmLwDTW3EfdyQ1I9SaX4a/GaIi3NMltRJ2HQYCTlgZgXEDdhc9Zpod
         T5M+cfMpX8Ff+ZwVSOX+HVDGYvJ0I2wAaCNzoko2JOHxtJg6n7XPBznkJcjc9IL7zRxe
         Ud0Q==
X-Gm-Message-State: APjAAAVOTV9JETa5pspPX1e75+Gk45JRH3KyrLTMurUHCYtVv6xuco+O
        9DVmtbvE1MgU2DEkaYgzaq8=
X-Google-Smtp-Source: APXvYqxiY99hRz0Z6ZPw4flyNky2QRyCA5rtWeXn3U1HJyW3z3hjSBngmChiLfN+jOENx+SaSwVs+A==
X-Received: by 2002:a17:90a:8a08:: with SMTP id w8mr5823926pjn.125.1580815336037;
        Tue, 04 Feb 2020 03:22:16 -0800 (PST)
Received: from localhost (167.117.30.125.dy.iij4u.or.jp. [125.30.117.167])
        by smtp.gmail.com with ESMTPSA id z14sm22336409pgj.43.2020.02.04.03.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 03:22:14 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Tue, 4 Feb 2020 20:22:11 +0900
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v1] printk: Declare log_wait as external variable
Message-ID: <20200204112211.GA2009@jagdpanzerIV.localdomain>
References: <20200203131528.52825-1-andriy.shevchenko@linux.intel.com>
 <20200204021620.GD41358@google.com>
 <20200204090533.GM32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204090533.GM32742@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/04 11:05), Andy Shevchenko wrote:
> > > --- a/kernel/printk/printk.c
> > > +extern wait_queue_head_t log_wait;	/* Used in fs/proc/kmsg.c */
> > >  DECLARE_WAIT_QUEUE_HEAD(log_wait);
> > > +#else
> > > +static DECLARE_WAIT_QUEUE_HEAD(log_wait);
> > > +#endif /* CONFIG_PROC_FS */
> > 
> > [..]
> > 
> > Since we are now introducing CONFIG_PROC_FS dependency to printk (and
> > proc/kmsg already has CONFIG_PRINTK dependency),
> 
> I'm not sure I understood. The above does not introduce any dependencies.

kernel/printk/printk.c
 +#ifdef CONFIG_PROC_FS
 ..

Not exactly "dependency"... what is the correct word here.

	-ss
