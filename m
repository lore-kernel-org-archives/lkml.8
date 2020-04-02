Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFF1C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56CEE2072E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390173AbgDBX2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 19:28:11 -0400
Received: from smtprelay0216.hostedemail.com ([216.40.44.216]:36478 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387919AbgDBX2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 19:28:11 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id E4123182CED2A;
        Thu,  2 Apr 2020 23:28:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: horse36_cc82b9208349
X-Filterd-Recvd-Size: 2399
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Thu,  2 Apr 2020 23:28:07 +0000 (UTC)
Message-ID: <04bb934e551f43540d1daacd2759beacc0b3116a.camel@perches.com>
Subject: Re: [PATCH 1/1] lib/vsprintf: Add support for printing V4L2 and DRM
 fourccs
From:   Joe Perches <joe@perches.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     mchehab@kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hverkuil@xs4all.nl,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        laurent.pinchart@ideasonboard.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-media@vger.kernel.org,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>
Date:   Thu, 02 Apr 2020 16:26:11 -0700
In-Reply-To: <87eet6mgk7.fsf@intel.com>
References: <20200401140522.966-1-sakari.ailus@linux.intel.com>
         <87eet6mgk7.fsf@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-04-02 at 11:34 +0300, Jani Nikula wrote:
> On Wed, 01 Apr 2020, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
> > Add a printk modifier %ppf (for pixel format) for printing V4L2 and DRM
> > pixel formats denoted by 4ccs. The 4cc encoding is the same for both so
> > the same implementation can be used.
> 
> I'm not going to take a strong stand in one way or the other regarding
> the patch at hand, but I do think at some point we have to draw a line
> what should be included in printk formats. Arguably they should be
> reserved to things that are generally useful across large parts of the
> kernel, right?

Definitely yes.

> I think the more specialized you get, the more you should think about
> just using the plain old %s, and your own helpers. Because frankly, the
> kernel printk specifiers also start getting more than a little obscure.
> 
> Or could we conceive of a way to make this locally extensible yet safe,
> letting callers use something like %{foo}, as well as providing a
> locally relevant function to do the conversion?

No.  printf validation would be broken.


