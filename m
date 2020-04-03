Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1119BC2BA16
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4AE92073B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403872AbgDCNNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:13:23 -0400
Received: from smtprelay0139.hostedemail.com ([216.40.44.139]:51020 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726087AbgDCNNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 09:13:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 955A4182CED34;
        Fri,  3 Apr 2020 13:13:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: lake39_5738fffbee928
X-Filterd-Recvd-Size: 2320
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Fri,  3 Apr 2020 13:13:19 +0000 (UTC)
Message-ID: <a5d0029edb7328691f1a08009d564c576924a3eb.camel@perches.com>
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
Date:   Fri, 03 Apr 2020 06:11:22 -0700
In-Reply-To: <87zhbtkrc5.fsf@intel.com>
References: <20200401140522.966-1-sakari.ailus@linux.intel.com>
         <87eet6mgk7.fsf@intel.com>
         <04bb934e551f43540d1daacd2759beacc0b3116a.camel@perches.com>
         <87zhbtkrc5.fsf@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-04-03 at 09:37 +0300, Jani Nikula wrote:
> On Thu, 02 Apr 2020, Joe Perches <joe@perches.com> wrote:
> > On Thu, 2020-04-02 at 11:34 +0300, Jani Nikula wrote:
> > > Or could we conceive of a way to make this locally extensible yet safe,
> > > letting callers use something like %{foo}, as well as providing a
> > > locally relevant function to do the conversion?
> > 
> > No.  printf validation would be broken.
> 
> I tossed the idea on a whim, and thinking further I could probably come
> up with a number of challenges, but care to elaborate on what you see as
> the problem in validation?

I understand you to want to add something like

	%<m> where m is a non-standard format specifier

so using using gcc's extension of

__attribute__((__format__(printf, string_index, first_to_check))

could not validate the argument type against use of the %<m>
in the format string.

	printk("%a\n", a);

Compiler bleats.

