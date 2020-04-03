Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDB8C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29618206F6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390687AbgDCQ6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:58:43 -0400
Received: from smtprelay0129.hostedemail.com ([216.40.44.129]:39372 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726087AbgDCQ6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:58:42 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 8995D1801EEB1;
        Fri,  3 Apr 2020 16:58:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: blood31_115de04d83516
X-Filterd-Recvd-Size: 2242
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Fri,  3 Apr 2020 16:58:39 +0000 (UTC)
Message-ID: <b1e6213ba9f67da8278dd5c5f5e4def8ab927c83.camel@perches.com>
Subject: Re: [PATCH v2 1/1] lib/vsprintf: Add support for printing V4L2 and
 DRM fourccs
From:   Joe Perches <joe@perches.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-media@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com,
        mchehab@kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
Date:   Fri, 03 Apr 2020 09:56:42 -0700
In-Reply-To: <1105bfe5-88f1-040e-db40-54d7761747d5@rasmusvillemoes.dk>
References: <20200403091156.7814-1-sakari.ailus@linux.intel.com>
         <1105bfe5-88f1-040e-db40-54d7761747d5@rasmusvillemoes.dk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-04-03 at 14:10 +0200, Rasmus Villemoes wrote:
> On 03/04/2020 11.11, Sakari Ailus wrote:
> > Add a printk modifier %ppf (for pixel format) for printing V4L2 and DRM
> > pixel formats denoted by 4ccs. The 4cc encoding is the same for both so
> > the same implementation can be used.
> 
> This seems quite niche to me, I'm not sure that belongs in vsprintf.c.
> What's wrong with having a
> 
> char *fourcc_string(char *buf, u32 x)
> 
> that formats x into buf and returns buf, so it can be used in a
> 
> char buf[8];
> pr_debug("bla: %s\n", fourcc_string(buf, x))

Nothing really, it's a number of uses question.

For networking code,  print_mac was used before %pM.

After Linus floated the idea of %p<foo>, %pM was
introduced and all the DECLARE_MAC_BUF/print_mac
calls were converted.

%pM did reduce overall object size a fair amount.

How many instances of %p4cc could there be?


