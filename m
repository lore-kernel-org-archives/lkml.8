Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DC9C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB64206E9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgDIPbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 11:31:52 -0400
Received: from smtprelay0184.hostedemail.com ([216.40.44.184]:44932 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727919AbgDIPbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 11:31:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 564AD182CCCD3;
        Thu,  9 Apr 2020 15:31:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: join46_2d27205586809
X-Filterd-Recvd-Size: 2325
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Thu,  9 Apr 2020 15:31:50 +0000 (UTC)
Message-ID: <bcdfa5ae68b8cb7d9324a89aedf452f6209b570c.camel@perches.com>
Subject: Re: [PATCH] checkpatch: check for missing \n at the end of logging
 message
From:   Joe Perches <joe@perches.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        apw@canonical.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Thu, 09 Apr 2020 08:29:49 -0700
In-Reply-To: <60c732a1-aa4e-afab-d223-894a67713003@wanadoo.fr>
References: <20200407204908.10420-1-christophe.jaillet@wanadoo.fr>
         <8617a6b94c0644bce1fd4ca77309d67a612e6300.camel@perches.com>
         <4b7e1cf3-6fa7-60af-a1d3-2457339dbe8a@wanadoo.fr>
         <efb5a518fdc47f0120b94a7e8a95d275c0f4ad43.camel@perches.com>
         <60c732a1-aa4e-afab-d223-894a67713003@wanadoo.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-04-09 at 09:24 +0200, Christophe JAILLET wrote:
> I think that, at least printk(), WARN() and co, and panic() should also 
> be handled the same way.

Maybe.

> A few files (5 according to my grep) also have something like:
>     #define pr_fmt(fmt) "bcache: %s()" fmt "\n", __func__
> and then sometimes a mix of pr_xxx() with either trailing \n or not.

Didn't know about those.

> Maybe those should be handled manually to be consistent and avoid a "\n" 
> in pr_fmt which is not widely used in other files

More likely the pr_fmt should have the \n removed and added
to the uses.

$ git grep -P 'define\s+pr_fmt.*\\n'
drivers/clocksource/timer-davinci.c:#define pr_fmt(fmt) "%s: " fmt "\n", __func__
drivers/md/bcache/bcache.h:#define pr_fmt(fmt) "bcache: %s() " fmt "\n", __func__
drivers/md/bcache/bset.c:#define pr_fmt(fmt) "bcache: %s() " fmt "\n", __func__
lib/math/prime_numbers.c:#define pr_fmt(fmt) "prime numbers: " fmt "\n"
lib/percpu-refcount.c:#define pr_fmt(fmt) "%s: " fmt "\n", __func__
lib/test_hash.c:#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt "\n"
tools/usb/usbip/libsrc/usbip_common.h:#define pr_fmt(fmt)       "%s: %s: " fmt "\n", PROGNAME



