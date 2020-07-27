Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D25FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2F96206E7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VV0QxcDh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbgG0Pkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 11:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729049AbgG0Pkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 11:40:37 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1731CC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 08:40:37 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id u64so15593860qka.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 08:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3MHzayRxL6bOiigyiJOXy0PhmCnVIol0KG4wc5+RCf8=;
        b=VV0QxcDhBbkfas2oiGVS1tvt5ESJqhpl67y4uGCMb2n8mBj4P/nU8cHUjPv/l76bU4
         gjETm59e+fdYBwoodcOoh5UBxu7PGmou3asy7AL7Er8fbs2atIxO53YJaHKqiHTjuDds
         uaaNWCmDvrjyoUO8wlSmU05OiMrdHR9gTE1KZHICoXD4hWPwF9ZOf0SEFlP8KbD3vDAO
         Kwvs3ocpCiWZTfN0OihoxC4jjfSlefzs0ztS9PBUMkSl/xIR2wpSHO70miNuSAGrRdPo
         J0lI1V2F7Z3w0wUZ+go35o8LtiBgZRBNNuTmpDojB8TO83eJEFKBkk7Xdc0hm62xdgoz
         /CVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3MHzayRxL6bOiigyiJOXy0PhmCnVIol0KG4wc5+RCf8=;
        b=gFAccrvMktWmIUiRkRDJERKDzl48hfz8JkssRh2P47orDcF7lV1FKiVgkFWpycYMRm
         6DHfA82Li7KnJCXWobrJrRp/sRmfXZgIP9tqKuPaIalMtQxAvLaByVsAnvzi6XQ2Skvt
         ptpN2p5MH4tD6+/9nzMK9zatmsJ2YDKRm328NRZoD7B824sS3+d1aJxG8wK4VR5imfF/
         l7ssf+c9VUUxKMiQlDkV3NPGwpHe1lC0OOPprzF4v8Pl3gzLFnfDXHG2IkpcJ/uoE+R8
         iYz+O81vIUdVSitbtS5MT6P6D75K4ehUQ6LPShiggOeI1BsTk5x2NgrfsUNqCG1o4RjJ
         QQ6g==
X-Gm-Message-State: AOAM532RQcQVsBs+BuAN9NMJZ8V51IiX0VZfZBlxKJ4AhVWl78vLnM6b
        8Qq2fQLGV9106GDgw92uRw==
X-Google-Smtp-Source: ABdhPJz4p/ncsvcYlE0kBz7qziAGuqugFJvTZuwprUxKjrQU5gfYhHAMcIXMO2IekfmUlJxyg0HaEA==
X-Received: by 2002:a37:a655:: with SMTP id p82mr23048681qke.92.1595864436373;
        Mon, 27 Jul 2020 08:40:36 -0700 (PDT)
Received: from PWN ([209.94.141.207])
        by smtp.gmail.com with ESMTPSA id 128sm17457791qkk.101.2020.07.27.08.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 08:40:35 -0700 (PDT)
Date:   Mon, 27 Jul 2020 11:40:33 -0400
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux1394-devel@lists.sourceforge.net,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-kernel-mentees] [PATCH] firewire: Prevent kernel-infoleak
 in ioctl_get_info()
Message-ID: <20200727154033.GA315469@PWN>
References: <20200727151537.315023-1-yepeilin.cs@gmail.com>
 <CAK8P3a3zz-xfz2jwUpEU5R7GyCK735PFQK7OjFmmTESgnSzq=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3zz-xfz2jwUpEU5R7GyCK735PFQK7OjFmmTESgnSzq=Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 05:35:12PM +0200, Arnd Bergmann wrote:
> On Mon, Jul 27, 2020 at 5:18 PM Peilin Ye <yepeilin.cs@gmail.com> wrote:
> >
> > ioctl_get_info() is copying uninitialized stack memory to userspace due to
> > the compiler not initializing holes in statically allocated structures.
> > Fix it by initializing `event` using memset() in fill_bus_reset_event().
> >
> > Cc: stable@vger.kernel.org
> > Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> I would recommend always looking through the git history of the
> file to come up with an appropriate 'Fixes' tag. In this case
> 
> $ git log -p --follow drivers/firewire/core-cdev.c
> 
> searching for any mention of fill_bus_reset_event leads you to
> commit 344bbc4de14e.
> 
> In my ~/.gitconfig I have this alias:
> 
> [core]
>         abbrev = 12
> [alias]
>         fixes = show --format='Fixes: %h (\"%s\")' -s
> 
> With something like that, calling 'git fixes 344bbc4de14e' produces
> the line to copy:
> 
> Fixes: 344bbc4de14e ("firewire: Generalize get_config_rom to get_info.")

Thank you for the advice! Actually I did all of that (manually...) but
wasn't sure whether I should add it on. I will send a v2 soon, and do so
for future patches.

Thank you,
Peilin Ye
