Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B908FC3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C8120866
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgCBKYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 05:24:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:38010 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbgCBKYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 05:24:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9A1BEAF4E;
        Mon,  2 Mar 2020 10:24:29 +0000 (UTC)
Date:   Mon, 2 Mar 2020 11:24:27 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Tobin C . Harding" <me@tobin.cc>
Subject: Re: [PATCH 1/3] lib/test_printf: Clean up test of hashed pointers
Message-ID: <20200302102427.brzxardpanwqlyfy@pathway.suse.cz>
References: <20200227130123.32442-1-pmladek@suse.com>
 <20200227130123.32442-2-pmladek@suse.com>
 <bdb7d995-f16f-335c-c06a-b6732dcbbfa2@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bdb7d995-f16f-335c-c06a-b6732dcbbfa2@kleine-koenig.org>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-02-27 15:30:51, Uwe Kleine-König wrote:
> Hello Petr,
> 
> On 2/27/20 2:01 PM, Petr Mladek wrote:
> > The commit ad67b74d2469d9b82a ("printk: hash addresses printed with %p")
> > helps to prevent leaking kernel addresses.
> > 
> > The testing of this functionality is a bit problematic because the output
> > depends on a random key that is generated during boot. Though, it is
> > still possible to check some aspects:
> > 
> >   + output string length
> >   + hash differs from the original pointer value
> >   + top half bits are zeroed on 64-bit systems
> 
> Is "hash differs from the original pointer value" a valid check?
> Depending on the random value and the actual pointer I can imagine a
> valid match. Such a match is unlikely but not necessarily bogus, is it?

Yes, there is a small risk or false negative.

It might be possible to try if the problem persist with PTR+1 value or
so. But I am not sure if it is worth it.

The problem is only on 32-bit systems. The chance is really small.
I have added a comment above the check. It can be found via the added
error message.

Note that this check has been there even before in plain_hash().
But it was worse because it was without any comment or error message.

Best Regards,
Petr
