Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC09FC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8572077D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391127AbgDCSka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 14:40:30 -0400
Received: from smtprelay0024.hostedemail.com ([216.40.44.24]:43886 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728337AbgDCSka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 14:40:30 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 232EE837F27B;
        Fri,  3 Apr 2020 18:40:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: head59_210c0a7bd8631
X-Filterd-Recvd-Size: 2165
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Fri,  3 Apr 2020 18:40:26 +0000 (UTC)
Message-ID: <e44e41317719727ea12aee4ff1e210dea796dd2f.camel@perches.com>
Subject: Re: [PATCH v2 1/1] lib/vsprintf: Add support for printing V4L2 and
 DRM fourccs
From:   Joe Perches <joe@perches.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-media@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        hverkuil@xs4all.nl, mchehab@kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
Date:   Fri, 03 Apr 2020 11:38:29 -0700
In-Reply-To: <20200403104701.GC3172@kekkonen.localdomain>
References: <20200403091156.7814-1-sakari.ailus@linux.intel.com>
         <20200403102449.GB4882@pendragon.ideasonboard.com>
         <20200403104701.GC3172@kekkonen.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-04-03 at 13:47 +0300, Sakari Ailus wrote:
> On Fri, Apr 03, 2020 at 01:24:49PM +0300, Laurent Pinchart wrote:
> > On Fri, Apr 03, 2020 at 12:11:56PM +0300, Sakari Ailus wrote:
> > > Add a printk modifier %ppf (for pixel format) for printing V4L2 and DRM
> > > pixel formats denoted by 4ccs. The 4cc encoding is the same for both so
> > > the same implementation can be used.
[]
> > > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
[]
> > > +static noinline_for_stack
> > > +char *fourcc_string(char *buf, char *end, const u32 *fourcc,
> > > +		    struct printf_spec spec, const char *fmt)
[]
> > > +	if (fmt[1] != 'c' || fmt[2] != 'c')

This could check outside a format string if
the %p4 is at the end of the format string.

	printk("%p4", fourcc)

So this should verify

	if (!(fmt[1] == 'c' && fmt[2] == 'c'))


