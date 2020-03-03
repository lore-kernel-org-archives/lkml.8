Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF6BC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FBF3214DB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgCCJW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:22:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:38444 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728025AbgCCJW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 04:22:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 66B2DB195;
        Tue,  3 Mar 2020 09:22:56 +0000 (UTC)
Date:   Tue, 3 Mar 2020 10:22:55 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Tobin C . Harding" <me@tobin.cc>
Subject: Re: [PATCH 0/3] lib/test_printf: Clean up basic pointer testing
Message-ID: <20200303092255.c4j7q2r734t5upvz@pathway.suse.cz>
References: <20200227130123.32442-1-pmladek@suse.com>
 <20200303072456.GA904@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303072456.GA904@jagdpanzerIV.localdomain>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-03-03 16:24:56, Sergey Senozhatsky wrote:
> On (20/02/27 14:01), Petr Mladek wrote:
> > 
> > The discussion about hashing NULL pointer value[1] uncovered that
> > the basic tests of pointer formatting do not follow the original
> > structure and cause confusion.
> 
> FWIW, overall looks good to me.

Could I add Acked-by or Reviewed-by tag, please?

Best Regards,
Petr
