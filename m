Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D704EC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 18:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B408220684
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 18:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgCFSi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 13:38:26 -0500
Received: from baldur.buserror.net ([165.227.176.147]:38498 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgCFSi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 13:38:26 -0500
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1jAHn7-0002zj-NU; Fri, 06 Mar 2020 12:33:46 -0600
Message-ID: <78e666fb78604d98252c436e9e3f6a27cff25a9a.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Jason Yan <yanaijie@huawei.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        lkml <linux-kernel@vger.kernel.org>,
        "Tobin C . Harding" <tobin@kernel.org>,
        Daniel Axtens <dja@axtens.net>
Date:   Fri, 06 Mar 2020 12:33:44 -0600
In-Reply-To: <CAADWXX8guqt=Yz-Lo+qU6Ed0t-mG-B=UkqSDaSr3bH+Q2aOn-Q@mail.gmail.com>
References: <20200304124707.22650-1-yanaijie@huawei.com>
         <202003041022.26AF0178@keescook>
         <b5854fd867982527c107138d52a61010079d2321.camel@buserror.net>
         <CAADWXX8guqt=Yz-Lo+qU6Ed0t-mG-B=UkqSDaSr3bH+Q2aOn-Q@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: torvalds@linux-foundation.org, keescook@chromium.org, yanaijie@huawei.com, pmladek@suse.com, rostedt@goodmis.org, sergey.senozhatsky@gmail.com, andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org, tobin@kernel.org, dja@axtens.net
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH v3 0/6] implement KASLR for powerpc/fsl_booke/64
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-03-05 at 12:51 -0600, Linus Torvalds wrote:
> On Wed, Mar 4, 2020 at 3:16 PM Scott Wood <oss@buserror.net> wrote:
> > 
> > The frustration is with the inability to set a flag to say, "I'm debugging
> > and
> > don't care about leaks... in fact I'd like as much information as possible
> > to
> > leak to me."
> 
> Well, I definitely don't want to tie it to "I turned off kaslr in
> order to help debugging". That just means that now you're debugging a
> kernel that is fundamentally different from what people are running.

One shouldn't *test* with something different from what people are running but
once a problem has been identified I don't see the problem with changing the
kernel to make diagnosis easier (assuming the problem is reproduceable). 
Though I suppose one could just locally apply a "no pointer hashing" patch
when debugging...

> So I'd much rather have people just set a really magic flag, perhaps
> when kgdb is in use or something.
> 
> > In any case, this came up now due to a question about what to use when
> > printing crash dumps.  PowerPC currently prints stack and return addresses
> > with %lx (in addition to %pS in the latter case) and someone proposed
> > converting them to %p and/or removing them altogether.
> 
> Please just use '%pS'.
> 
> The symbol and offset is what is useful when users send crash-dumps.
> The hex value is entirely pointless with kaslr - which should
> basically be the default.
> 
> Note that this isn't about security at that point - crash dumps are
> something that shouldn't happen, but if they do happen, we want the
> pointers. But the random hex value just isn't _useful_, so it's just
> making things less legible.

Losing %lx on the return address would be a minor annoyance (harder to verify
that you're looking at the right stack frame in a dump, more steps to look up
the line number when modules and kaslr aren't involved, etc), but %pS doesn't
help with stack addresses themselves -- and yes, digging into the actual stack
data (via kdump, external debugger, etc.) is sometimes useful.  Maybe
condition it on it being an actual crash dump and not some other caller of
show_stack()?

-Scott


