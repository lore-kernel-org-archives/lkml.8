Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F3FC2BA15
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20F52080C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585935171;
	bh=14knU8ACVNnK6xW1RmVIrSOB5671IbOcqMn1tJl9NDw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=NesaLWf3lq1OLcei1WGc6pqw788WvuXqEiR6p3EZfADpTgP5lJhS6q5O/ywpeBYlJ
	 di0ggAZ7gGQ6Fd3Jo4vvmaFmyO0w4PZWc2scJ++l/zugoYC3XiaF+bL8SG7aYx+GOX
	 cSuI7MhCcv8Zkfb3RSyFaLugl4q9vNImrA9IfuhQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404455AbgDCRct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 13:32:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404218AbgDCRct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 13:32:49 -0400
Received: from coco.lan (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 721DB20737;
        Fri,  3 Apr 2020 17:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585935168;
        bh=14knU8ACVNnK6xW1RmVIrSOB5671IbOcqMn1tJl9NDw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wm68y4B9nhyQFatl2Bgxi3vs96I1A1u7J82pUriMabS91oVeNYd9BUXgQLAfo9Etm
         +gfYJ18RfNCgKP3wZlitJoErVSDqJ024fmvOXyKz6xppqqyOMF0MWlkDDXhi5LgZ96
         wuqjofHdtLjLRmAj8pPHSj7MiNc6SVvJwkfGieeQ=
Date:   Fri, 3 Apr 2020 19:32:42 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-media@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v2 1/1] lib/vsprintf: Add support for printing V4L2 and
 DRM fourccs
Message-ID: <20200403193242.38611906@coco.lan>
In-Reply-To: <b1e6213ba9f67da8278dd5c5f5e4def8ab927c83.camel@perches.com>
References: <20200403091156.7814-1-sakari.ailus@linux.intel.com>
        <1105bfe5-88f1-040e-db40-54d7761747d5@rasmusvillemoes.dk>
        <b1e6213ba9f67da8278dd5c5f5e4def8ab927c83.camel@perches.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 03 Apr 2020 09:56:42 -0700
Joe Perches <joe@perches.com> escreveu:

> On Fri, 2020-04-03 at 14:10 +0200, Rasmus Villemoes wrote:
> > On 03/04/2020 11.11, Sakari Ailus wrote:  
> > > Add a printk modifier %ppf (for pixel format) for printing V4L2 and DRM
> > > pixel formats denoted by 4ccs. The 4cc encoding is the same for both so
> > > the same implementation can be used.  
> > 
> > This seems quite niche to me, I'm not sure that belongs in vsprintf.c.
> > What's wrong with having a
> > 
> > char *fourcc_string(char *buf, u32 x)
> > 
> > that formats x into buf and returns buf, so it can be used in a
> > 
> > char buf[8];
> > pr_debug("bla: %s\n", fourcc_string(buf, x))  
> 
> Nothing really, it's a number of uses question.
> 
> For networking code,  print_mac was used before %pM.
> 
> After Linus floated the idea of %p<foo>, %pM was
> introduced and all the DECLARE_MAC_BUF/print_mac
> calls were converted.
> 
> %pM did reduce overall object size a fair amount.
> 
> How many instances of %p4cc could there be?

That's hard to know... there are several places printing it
with different ways:

	$ git grep -i -E "(dev|pr)_(warn|dbg|info)" drivers/media|grep pixf|wc -l
	6
	$ git grep -i -E "print" drivers/media|grep pixf|wc -l
	1
	$ git grep print_fourcc|wc -l
	7
	$ git grep -i -E "(dev|pr)_(warn|dbg|info)" drivers/media|grep pixelf|wc -l
	10
	$ git grep -i -E "(dev|pr|v4l)_(warn|dbg|info)" drivers/media|grep format|wc -l
	60

I bet there are other places besides the above ones, but the thing is, as 
we currently lack a standard way, drivers still have their own ideas
about how to handle it. Each one does it differently.


Thanks,
Mauro
