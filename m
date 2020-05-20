Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C674C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 658B4207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgETKxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 06:53:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:52142 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgETKxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 06:53:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A5633AD41;
        Wed, 20 May 2020 10:53:04 +0000 (UTC)
Date:   Wed, 20 May 2020 12:53:00 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] vsprintf: don't obfuscate NULL and error pointers
Message-ID: <20200520105300.GE3464@linux-b0ei>
References: <20200519112657.17098-1-idryomov@gmail.com>
 <CAHk-=wi9+qm_msiKsk32vaUMon6UQEE0-TydPF_-D6xNPjbOfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi9+qm_msiKsk32vaUMon6UQEE0-TydPF_-D6xNPjbOfg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-05-19 11:36:52, Linus Torvalds wrote:
> On Tue, May 19, 2020 at 4:27 AM Ilya Dryomov <idryomov@gmail.com> wrote:
> >
> > This just came up again, please consider sending this to Linus
> > for 5.7.
> 
> I just took it directly, since I like it and it looks trivial.

Great, I am happy that it has got resolved.

I am sorry for the inconvenience. I have started working again last
week. But I am still fighting with many pending mails.

BTW: printk maintainers are switching to a git repo with shared write
access to avoid these delays in the future.

Best Regards,
Petr
