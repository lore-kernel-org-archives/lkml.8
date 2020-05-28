Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E808C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2989C2072D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hFQtq2Z/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407181AbgE1UZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 16:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407173AbgE1UZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:25:22 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC1EC08C5C8
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 13:25:22 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id p21so107014pgm.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 13:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3jEHb7o98C7LTydu7uW3451vfLZG6eEw40N/JKdaSjg=;
        b=hFQtq2Z/UkexUJS87ZXMK5dd/I/61tAxxU1YqXREhFrJ6CQLI+Oiq2KvJWPM4AcVga
         pq/Xzk2fGahlqcUQTUmZPtMsZtxMZtbXNBqs4I/bmIcdGW/kplEMxsqqV8jZpUkL3LPQ
         vxe8xlt4/lDvYm9ucASaaP1IfnlIToCEXzKtbDae0BuzgI1b6NHVNOUCNBaP4Jiwqwnq
         J0i1CzReH3lwCpwSDq8xygbEzj4VlzMTTLL8/EbnZPBaz3bI6cjYs2mzwiZP/1ZwaD3d
         tgIAJ1JGTX0PfSLd/pF9uqp3cRFa4EYFHPfqLB/ZViDskZBrjzNEzh7A9SVYcQmoMPjN
         7Nuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3jEHb7o98C7LTydu7uW3451vfLZG6eEw40N/JKdaSjg=;
        b=n5JFlud0LcNOztLeNFOrjKmsdXxYtIPKlOEh5CjKlg4ln7mNEQu+8R99yYpghjnsik
         4nzMO0pdm38bMt5PA2caXYXMqcEOcXUf+ILZM9aeP7l5pkRl++XJYgzxgGWa20XEOdGg
         JIDRe8AEWRfkyMxunh5kGir2EVUvea8W4tJ1vhqhCIbE32ZpObGlo3e9TA4FBLwxAyYH
         noILNnaEm6u+KEWveMUpW9d1I9GTs3TpMrEEuhXpIp9DKaiueq4z3fMjKNihf7AVTcjW
         cFY9N6kKMdf+NNlBAqlF0HVVDkBiXeccaLnVIdQc0m3dQlCxmB7ZcuBU3JjwY5jHDo5o
         dqNw==
X-Gm-Message-State: AOAM532fOq1G7tCCqvK1LHy35wUcJVZCXMylizLTm0/Idki/WSfO5+v7
        0/lHxD6T6HYJkraDeZmdbHs/XdSZwvOXDXhaCQKOegLRDlE=
X-Google-Smtp-Source: ABdhPJw764Ssi01594KZzzLA4OtCp+IzpMdl6N6pdx/zUmHna7Zf+b7Og+jP/IpOd66J086hTbZTWNc6A47FHKkJIUs=
X-Received: by 2002:a63:d04b:: with SMTP id s11mr4561837pgi.384.1590697521912;
 Thu, 28 May 2020 13:25:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200524153041.2361-1-gregkh@linuxfoundation.org>
In-Reply-To: <20200524153041.2361-1-gregkh@linuxfoundation.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 28 May 2020 13:25:10 -0700
Message-ID: <CAFd5g45xJMgQ6AWgVxw0qQZw7g=jbfqNfUKpzbQre1rNYVZ5YQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] software node: implement software_node_unregister()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        kernel test robot <rong.a.chen@intel.com>,
        stable <stable@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 8:31 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Sometimes it is better to unregister individual nodes instead of trying
> to do them all at once with software_node_unregister_nodes(), so create
> software_node_unregister() so that you can unregister them one at a
> time.
>
> This is especially important when creating nodes in a hierarchy, with
> parent -> children representations.  Children always need to be removed
> before a parent is, as the swnode logic assumes this is going to be the
> case.
>
> Fix up the lib/test_printf.c fwnode_pointer() test which to use this new
> function as it had the problem of tearing things down in the backwards
> order.
>
> Fixes: f1ce39df508d ("lib/test_printf: Add tests for %pfw printk modifier")
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Cc: stable <stable@vger.kernel.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Sorry, I was on vacation.

Seems like this has already been sufficiently reviewed and applied.
Nevertheless,

Tested-by: Brendan Higgins <brendanhiggins@google.com>
