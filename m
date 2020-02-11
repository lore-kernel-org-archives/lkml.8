Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1687BC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D3F20870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbgBKP0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:26:52 -0500
Received: from kernel.crashing.org ([76.164.61.194]:55452 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbgBKP0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:26:51 -0500
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 01BFQhb0017681
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Feb 2020 09:26:46 -0600
Message-ID: <66c67637ba097edb39efea7280989aaa20d710b1.camel@kernel.crashing.org>
Subject: Re: [PATCH v3 1/3] printk: Move console matching logic into a
 separate function
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 11 Feb 2020 16:26:42 +0100
In-Reply-To: <20200211142947.favkq56gkyexqkpg@pathway.suse.cz>
References: <e6b63bc26108c6e3645f9ea9e03aba38fd8b8464.camel@kernel.crashing.org>
         <20200211142947.favkq56gkyexqkpg@pathway.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-02-11 at 15:29 +0100, Petr Mladek wrote:
> > @@ -2626,6 +2627,60 @@ static int __init keep_bootcon_setup(char *str)
> > +     /*
> > +         * Some consoles, such as pstore and netconsole, can be enabled even
> > +         * without matching.
> > +         */
> 
> There are few lines in the patchset where the indentation is done
> by spaces instead of tabs. The above 3 lines are just one example.

Odd. Something must have gone wrong with my emacs config when I
switched laptops, I'll have a look thanks.

> I'll fix this when pushing. But please, be more careful next time ;-)
> I suggest to use some more clever editor that helps with code
> formatting.

I normally do :)

> Also I suggest to run ./scripts/checkpatch.pl on the patches
> before sending.

Yeah I never quite got that knack, I still keep forgetting ... the doom
of old habits, I didn't even when I was maintainer of arch/powerpc ...
oops :)

But yeah, I'll try to remember next time.

> Also the three patches were not send in a single thread so that
> it was harder to find all the pieces. I personally use:
> 
>     git format-patch --cover-letter origin/master -o some-dir
>     ./scripts/checkpatch.pl some-dir/*
>     $> edit some-dir/0000-*.patch
>     git send-email --smtp-server=... --to= --cc= ... some-dir/*

I usually do when it's more than a couple of patches but yeah, again,
bad old habits. Sorry about that.

Cheers,
Ben.


