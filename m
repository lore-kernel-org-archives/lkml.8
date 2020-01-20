Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6FEC33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA74207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgATJUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 04:20:13 -0500
Received: from smtprelay0106.hostedemail.com ([216.40.44.106]:53119 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725872AbgATJUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 04:20:12 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 479371802D512;
        Mon, 20 Jan 2020 09:20:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: lamp39_15b12ba1e401
X-Filterd-Recvd-Size: 1607
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Mon, 20 Jan 2020 09:20:09 +0000 (UTC)
Message-ID: <1d375eb78623261eb334caaa3980905115aa1bf8.camel@perches.com>
Subject: Re: [PATCH 0/2] printf: add support for %de
From:   Joe Perches <joe@perches.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Date:   Mon, 20 Jan 2020 01:19:09 -0800
In-Reply-To: <20200120085508.25522-1-u.kleine-koenig@pengutronix.de>
References: <20200120085508.25522-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-01-20 at 09:55 +0100, Uwe Kleine-König wrote:
> Hello,
> 
> this is an reiteration of my patch from some time ago that introduced
> %dE with the same semantic. Back then this resulted in the support for
> %pe which was less contentious.
> 
> I still consider %de (now with a small 'e' to match %pe) useful.

I still think this is not a good idea at all.

There really should be no need to introduce more
odd vsprintf extensions.

%p<foo> should be enough.


