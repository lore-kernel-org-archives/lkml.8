Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BD0C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 21:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC5620842
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 21:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388358AbgCDVQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 16:16:09 -0500
Received: from baldur.buserror.net ([165.227.176.147]:34298 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387762AbgCDVQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 16:16:08 -0500
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1j9bIq-0000R4-KO; Wed, 04 Mar 2020 15:11:40 -0600
Message-ID: <b5854fd867982527c107138d52a61010079d2321.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Kees Cook <keescook@chromium.org>, Jason Yan <yanaijie@huawei.com>
Cc:     pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        "Tobin C . Harding" <tobin@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>
Date:   Wed, 04 Mar 2020 15:11:39 -0600
In-Reply-To: <202003041022.26AF0178@keescook>
References: <20200304124707.22650-1-yanaijie@huawei.com>
         <202003041022.26AF0178@keescook>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: keescook@chromium.org, yanaijie@huawei.com, pmladek@suse.com, rostedt@goodmis.org, sergey.senozhatsky@gmail.com, andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org, tobin@kernel.org, torvalds@linux-foundation.org, dja@axtens.net
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH v3 0/6] implement KASLR for powerpc/fsl_booke/64
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-04 at 10:34 -0800, Kees Cook wrote:
> On Wed, Mar 04, 2020 at 08:47:07PM +0800, Jason Yan wrote:
> > When I am implementing KASLR for powerpc, Scott Wood argued that format
> > specifier "%p" always hashes the addresses that people do not have a
> > choice to shut it down: https://patchwork.kernel.org/cover/11367547/
> > 
> > It's true that if in a debug environment or security is not concerned,
> > such as KASLR is absent or kptr_restrict = 0,  there is no way to shut
> > the hashing down except changing the code and build the kernel again
> > to use a different format specifier like "%px". And when we want to
> > turn to security environment, the format specifier has to be changed
> > back and rebuild the kernel.
> > 
> > As KASLR is available on most popular platforms and enabled by default,
> > print the raw value of address while KASLR is absent and kptr_restrict
> > is zero. Those who concerns about security must have KASLR enabled or
> > kptr_restrict set properly.
> 
> Sorry, but no: %p censoring is there to stem the flood of endless pointer
> leaks into logs, sysfs, proc, etc. These are used for attacks to build
> reliable kernel memory targets, regardless of KASLR. (KASLR can be
> bypassed with all kinds of sampling methods, side-channels, etc.)
> 
> Linus has rejected past suggestions to provide a flag for it[1],
> wanting %p to stay unconditionally censored.

The frustration is with the inability to set a flag to say, "I'm debugging and
don't care about leaks... in fact I'd like as much information as possible to
leak to me."  Hashed addresses only allow comparison to other hashes which
doesn't help when looking at (or trying to find) data structures in kernel
memory, etc.  I get what Linus is saying about "you can't have nice things
because people won't test the normal config" but it's still annoying. :-P

In any case, this came up now due to a question about what to use when
printing crash dumps.  PowerPC currently prints stack and return addresses
with %lx (in addition to %pS in the latter case) and someone proposed
converting them to %p and/or removing them altogether.  Is there a consensus
on whether crash dumps need to be sanitized of this stuff as well?  It seems
like you'd have the addresses in the register dump as well (please don't take
that away too...).  Maybe crash dumps would be a less problematic place to
make the hashing conditional (i.e. less likely to break something in userspace
that wasn't expecting a hash)?

-Scott


