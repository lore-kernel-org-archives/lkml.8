Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13865C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 20:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5957221E9
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 20:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgGDUcy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 16:32:54 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:44577 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbgGDUcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 16:32:54 -0400
Received: from sogo6.sd4.0x35.net (sogo6.sd4.0x35.net [10.200.201.56])
        (Authenticated sender: kerneldev@karsmulder.nl)
        by relay12.mail.gandi.net (Postfix) with ESMTPA id 1EAAE200003;
        Sat,  4 Jul 2020 20:32:50 +0000 (UTC)
From:   "Kars Mulder" <kerneldev@karsmulder.nl>
In-Reply-To: <CAHp75Ve4O+OmVttjhtKepFWwZLU6tFMx5vNpPVJdB58mcLFm3w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
Date:   Sat, 04 Jul 2020 22:32:50 +0200
Cc:     "David Laight" <David.Laight@aculab.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Pavel Machek" <pavel@ucw.cz>,
        =?utf-8?q?linux-kernel=40vger=2Ekernel=2Eorg?= 
        <linux-kernel@vger.kernel.org>,
        "Kai-Heng Feng" <kai.heng.feng@canonical.com>
To:     "Andy Shevchenko" <andy.shevchenko@gmail.com>
MIME-Version: 1.0
Message-ID: <613b-5f00e780-a9-10028e00@255553491>
Subject: =?utf-8?q?Re=3A?= Writing to a const =?utf-8?q?pointer=3A?= is this 
 supposed to =?utf-8?q?happen=3F?=
User-Agent: SOGoMail 4.3.2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, July 04, 2020 16:39 CEST, Andy Shevchenko wrote: 
> > I've searched for a function that parses an int from a string and
> > stores a pointer to the end; I can find some function simple_strtoul
> > that matches this criterion, but it's documented as
> >
> >     "This function has caveats. Please use kstrtoul instead."
> >
> > ... and kstrtoul does not store a pointer to the end. The documentation
> > of kstrtoul describes simple_strtoul as obsolete as well.
> 
> 
>  Where? We need to fix that, because using simple_strto*() is fairly legal
> in cases like this, but "has caveats".

In lib/vsprintf.c, the comments before the function's implementation say:

    /**
     * simple_strtoul - convert a string to an unsigned long
     * @cp: The start of the string
     * @endp: A pointer to the end of the parsed string will be placed here
     * @base: The number base to use
     *
     * This function has caveats. Please use kstrtoul instead.
     */

Many variants upon kstrtoul, such as kstrtoull, defined in lib/kstrtox.c,
describe the simple_strtoull function as obsolete:

    /**
     * kstrtoull - convert a string to an unsigned long long
     * [...]
     *
     * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
     * Used as a replacement for the obsolete simple_strtoull. Return code must
     * be checked.
     */

I seem to have been slightly inaccurate about my claim that "kstrtoul"
describes simple_strtoul as "obsolete" though, because in the specific
case of kstrtoul, include/linux/kernel.h only says:

    /**
     * kstrtoul - convert a string to an unsigned long
     * [...]
     *
     * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
     * Used as a replacement for the simple_strtoull. Return code must be checked.
    */

(Also, there may be a documentation error here: all kstrto* functions in
kstrtox.c and kernel.h describe themselves as replacements of simple_strtoull.
E.g. kstrtol and kstrtoul also describe themselves as replacements of
simple_strtoull rather than as a replacements of simple_strtol and
simple_strtoul respectively.)

By the way, I found the documentation of the caveat somewhere in
include/linux/kernel.h:

    /*
     * Use kstrto<foo> instead.
     *
     * NOTE: simple_strto<foo> does not check for the range overflow and,
     *	 depending on the input, may give interesting results.
     *
     * Use these functions if and only if you cannot use kstrto<foo>, because
     * the conversion ends on the first non-digit character, which may be far
     * beyond the supported range. It might be useful to parse the strings like
     * 10x50 or 12:21 without altering original string or temporary buffer in use.
     * Keep in mind above caveat.
     */

