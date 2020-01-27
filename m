Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D379DC35240
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 02:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5BEB2071E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 02:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0FwtRDo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbgA0ClS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 21:41:18 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35090 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgA0ClS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 21:41:18 -0500
Received: by mail-pg1-f196.google.com with SMTP id l24so4399571pgk.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jan 2020 18:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MXvX6HTY03cjB8r7dbAPsJ6XX5E83K1/cT556VXQ3mc=;
        b=G0FwtRDommL0iM0ZlnUHLPW6cA2VZQGIKLLg3Lg8e+nWKBML5ZowkmdEhxKZVNlJfe
         7f46l1cYDG+y/VCSw3f5/PK9p0i4BbJKO2mI40i5ArinNno9oBfL6lHKZWQsYd+bH3Qy
         BPY5nAM1S8eSumEUMGZm3ZRWbRIqweZ1uirS84yJuVP5rLWwGyucgD//5QPA5GHThO8L
         QaCiTBDKE+jrzTLwZ54GwiTFe7LDvMXvOiL+0KCCf0Hsm4OGiGK+0rI5MPoGq2I7gOj9
         NxTHUPl7/ov+zw485kBkU0PFSas+nm3Jb6jqXZSZGFOxoVHgLpI9lUEIRmR2DJNuwmrZ
         ya7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MXvX6HTY03cjB8r7dbAPsJ6XX5E83K1/cT556VXQ3mc=;
        b=Q6WsEVh0Fuhh0l2gSR4bQmdnzLuiSL9bmC5OIa2L4C7qDCO0KDlGC+knlwBxoVms7R
         xHV0o8avE4kPMp07vliJUdQSy49YG1m8UMmUZ8bbFPfz8VsAXjqP+t2FtFb7CoyQvmGh
         zFbuD3+16vQmelyo+SeMw4SZelX9ToZxE9uJnp8ME9uu/TThG6x3Pyty110dCBPR3Zly
         LwMx1OzH1qpRu8koPBnru+tVRRyVDa6+2qgdTStdQvBCK0Kuu71Bcq+jtSyPuaJygD8f
         lh/iOUco8cZ+YHjYICozCKAtNwB6c2ydo2W3carTbtISueRyyd4F35zNvw/mYqGQSFi1
         GyAQ==
X-Gm-Message-State: APjAAAXaKDWF0sriZma6+fBOlRSKQDJo3Id2gzqWt5GMJuzBB7y1sb6H
        NYkKwujDFJ+Ao1AlZvvwyCCUDYkE
X-Google-Smtp-Source: APXvYqzsZHJTEH4KAaHWbLLQm1hotsGVAJV8TVpAJocc1oq15UucRBwAjpd9T4aK9fG7gXAnUvcy0w==
X-Received: by 2002:a62:2ccd:: with SMTP id s196mr5990930pfs.227.1580092877625;
        Sun, 26 Jan 2020 18:41:17 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id k26sm5922081pfp.47.2020.01.26.18.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2020 18:41:16 -0800 (PST)
Date:   Mon, 27 Jan 2020 11:41:14 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] console: Don't perform test for CON_BRL flag twice
Message-ID: <20200127024114.GC100275@google.com>
References: <20200124155733.54799-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124155733.54799-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/01/24 17:57), Andy Shevchenko wrote:
[..]
> +++ b/drivers/accessibility/braille/braille_console.c
> @@ -369,10 +369,10 @@ int braille_register_console(struct console *console, int index,
>  
>  int braille_unregister_console(struct console *console)
>  {
> -	if (braille_co != console)
> -		return -EINVAL;
>  	if (!(console->flags & CON_BRL))
>  		return 0;
> +	if (braille_co != console)
> +		return -EINVAL;
>  	unregister_keyboard_notifier(&keyboard_notifier_block);
>  	unregister_vt_notifier(&vt_notifier_block);
>  	braille_co = NULL;
> diff --git a/kernel/printk/braille.c b/kernel/printk/braille.c
> index 17a9591e54ff..2ec42173890f 100644
> --- a/kernel/printk/braille.c
> +++ b/kernel/printk/braille.c
> @@ -51,8 +51,5 @@ _braille_register_console(struct console *console, struct console_cmdline *c)
>  int
>  _braille_unregister_console(struct console *console)
>  {
> -	if (console->flags & CON_BRL)
> -		return braille_unregister_console(console);
> -
> -	return 0;
> +	return braille_unregister_console(console);
>  }

Hmm, I don't know. This moves sort of important code from common upper
layer down to particular driver implementation. Should there be another
driver/super-braille.c it must test CON_BRL flag as well.
Because printk invokes _braille_unregister_console() unconditionally,
and _braille_unregister_console() unconditionally calls into the driver.

I guess we can remove CON_BRL from braille_unregister_console() instead,
because printk tests it.

	-ss
