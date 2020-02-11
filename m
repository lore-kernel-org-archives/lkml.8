Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4CFC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8319520873
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbgBKNFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:05:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:33656 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728666AbgBKNFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:05:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3BCF5AD2D;
        Tue, 11 Feb 2020 13:05:06 +0000 (UTC)
Date:   Tue, 11 Feb 2020 14:05:05 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] printk: Convert a use of sprintf to snprintf in
 console_unlock
Message-ID: <20200211130505.2lj2fm6nslbwgmg6@pathway.suse.cz>
References: <20200130221644.2273-1-natechancellor@gmail.com>
 <20200131070237.GB240941@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200131070237.GB240941@google.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-01-31 16:02:37, Sergey Senozhatsky wrote:
> On (20/01/30 15:16), Nathan Chancellor wrote:
> > When CONFIG_PRINTK is disabled (e.g. when building allnoconfig), clang
> > warns:
> > 
> > ../kernel/printk/printk.c:2416:10: warning: 'sprintf' will always
> > overflow; destination buffer has size 0, but format string expands to at
> > least 33 [-Wfortify-source]
> >                         len = sprintf(text,
> >                               ^
> > 1 warning generated.
> > 
> > It is not wrong; text has a zero size when CONFIG_PRINTK is disabled
> > because LOG_LINE_MAX and PREFIX_MAX are both zero. Change to snprintf so
> > that this case is explicitly handled without any risk of overflow.
> 
> We probably can add a note here that for !CONFIG_PRINTK builds
> logbuf overflow is very unlikely.

Good point. Well, the sprintf() was used for a well defined string:
"** %llu printk messages dropped **\n" ""

It could overflow only when anyone modified LOG_LINE_MAX to
something really small. It was not the case upstream, definitely.

> Otherwise,
> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

The patch has been committed into printk.git, branch for-5.7.

I did not add any extra comment to keep it simple. I hope
that it is ok.

Best Regards,
Petr
