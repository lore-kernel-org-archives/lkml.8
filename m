Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0360C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF79F2077D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585923745;
	bh=IG3HW5nXis1myAfaOtsltKO4crrvHruEx/TVC+6Pvqg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=NhB2jm1fGXH5KBwVaa0eOpe3YFXQPi95D5P8/F74wySfdibfYkkBbyJtlXbwepd1q
	 MtyQZ0RG0gA1rRlmVs3FG6aeHJUiQd+OZcmVLH3VWAAsuhNE0dJ7FuCq07GZCAuqVE
	 o3eXntqkieztYlElmr0eXs1W3GK28BVb9EeBmo2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391064AbgDCOWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 10:22:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54742 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390812AbgDCOWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description;
        bh=YN+nDi5ri8WqCT+wyS5XzUuEbEnx6eD8KXJvPFKkcJ0=; b=JsEUU9LS/TRsw3vAcYvjbME7w1
        46230s179k6N8hcYbzdod0iClZb5pfF1hnPswFh0w511l3De0mzqGLNLF9CSrEAUGNiJdbxIjd0Dc
        GVkUchwJ3Jb6w2V2udovgVkaRiKitbWGjSoJ/Sh5iVHWfe5UwMKTGFoC016EVbAebiyeBR0GhGFAa
        JIsSlT1WXIfB8WjA3HpGyLPTYjL9aL4c/2u7PIr/aH6buIywtwfpOFJp+3g1mbZi12WJ8m9CcRf4K
        yK6E5zkRJfoZkfu/xKrHK9XxdAClb2YT91sHCSHTlRtwaifkkWC7gfpBbi+BGG2trtwPdzmvyVgdt
        GHXCjRIQ==;
Received: from ip5f5ad4d8.dynamic.kabel-deutschland.de ([95.90.212.216] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKND8-0001JS-8I; Fri, 03 Apr 2020 14:22:18 +0000
Date:   Fri, 3 Apr 2020 16:22:10 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-media@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joe Perches <joe@perches.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v2 1/1] lib/vsprintf: Add support for printing V4L2 and
 DRM fourccs
Message-ID: <20200403162210.23f1e2a5@coco.lan>
In-Reply-To: <1105bfe5-88f1-040e-db40-54d7761747d5@rasmusvillemoes.dk>
References: <20200403091156.7814-1-sakari.ailus@linux.intel.com>
        <1105bfe5-88f1-040e-db40-54d7761747d5@rasmusvillemoes.dk>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 3 Apr 2020 14:10:53 +0200
Rasmus Villemoes <linux@rasmusvillemoes.dk> escreveu:

> On 03/04/2020 11.11, Sakari Ailus wrote:
> > Add a printk modifier %ppf (for pixel format) for printing V4L2 and DRM
> > pixel formats denoted by 4ccs. The 4cc encoding is the same for both so
> > the same implementation can be used.  
> 
> This seems quite niche to me, I'm not sure that belongs in vsprintf.c.

It is used on different subsystems. At least media, drm and input (yes, 
there are some input multi-touch devices with return images using
"GREY" fourcc - see drivers/input/touchscreen/sur40.c).

> What's wrong with having a
> 
> char *fourcc_string(char *buf, u32 x)
> 
> that formats x into buf and returns buf, so it can be used in a
> 
> char buf[8];
> pr_debug("bla: %s\n", fourcc_string(buf, x))
> 
> Or, for that matter, since it's for debugging, why not just print x with
> 0x%08x?

That's about what it has been done so far, using different solutions
on different places. Some display hex values, others display fourcc
(usually ignoring the BE case). We'd like to have a common solution
that won't be subsystem-specific and will handle it on a proper unified
way.

With regards to ex values, see for example the GREY format:

	V4L2_PIX_FMT_GREY ('GREY')

when someone reads 'GREY', this is easily understandable as a grey image
format, even by someone that it is not familiar with 4cc codes. Same is
true for several other widely used formats, like BGR and RGB.

If you see its hexa representation, 0x47524559 is a lot more obscure.

Thanks,
Mauro
