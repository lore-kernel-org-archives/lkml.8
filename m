Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E415BC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 18:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99342064A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 18:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c/beJqJf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgCGSUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 13:20:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59364 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgCGSUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 13:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=if1OKwL/QusXkeff4xIltyEZfd1ZJmY0KjaMoce0+8M=; b=c/beJqJfBZ33gHOURhKT9lVHQg
        4xe1UMH7jMl7ILkzVHLJbnpo6YcgxnHwH/EyGEmqDK6HNBw3dSwLXJlBTCJGnUvjPdZlOwo6nvszk
        UKrN6N+h/PdGUjkDtIVOMaY+OSNDPiDhqCFcyfaBaN9tUB3rUVGa4XjT5TGcv+bgQAgWpbyXVRdQ9
        wT46/SgwzjuTk6OUPNsDihwS56m3t9QjHMz8bVSvQzY3LKh84FfJ216Kx2YsT7FPS7oTQMO27yFqw
        T112PsJ9bJI1bbAIZZrMN439vnArQj2Gbd9wvko3xHFckmXmwljo+Oq4MBCm+qNSkqTeQzfN8Ky0I
        D54lRcsg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jAe40-0000JY-Hz; Sat, 07 Mar 2020 18:20:40 +0000
Subject: Re: What kernel version does 'irq_set_irq_type' become available?
To:     Peter Willis <pwillis@aslenv.com>, linux-kernel@vger.kernel.org
References: <002301d5f3dc$dc029890$9407c9b0$@aslenv.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1f6467f1-98f2-c47e-700f-f3af1bb3adb0@infradead.org>
Date:   Sat, 7 Mar 2020 10:20:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <002301d5f3dc$dc029890$9407c9b0$@aslenv.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/20 9:29 AM, Peter Willis wrote:
> Hello,
> 
> Is there a history diagram somewhere that shows where specific features appear in the codebase?

I don't know.

> Various online documentation for kernel driver development have references to functions that, in some cases, are either deprecated or do not yet exist in older versions of kernel source.
> 
> For example, I have written an interrupt service driver for an embedded application running on kernel version 2.6.21.  The original driver is level triggered and requires the driver to: 

2.6.21 was released in April of 2007.
It's a shame that someone (anyone) is still using it.


> a.) Temporarily disable the interrupt
> b.) Service the interrupt
> c.) Re-enable the interrupt
> 
> There was some desire for that driver to move to a more standard rising edge trigger.

Does the hardware work as (optionally; programmable) level triggered or edge triggered?
Usually not in my experience.
Usually one or the other.

> In that line of thought , the documentation suggests    ' irq_set_irq_type'  with flag     'IRQF_TRIGGER_RISING'.
> 
> That function was experimental at one point, and doesn't appear to be available in the 2.6.21 source.

No, in 2.6.21 it is named 'set_irq_type'.

I can't see that it was experimental.

> I did a      'find' -> 'while read' -> 'fgrep'  search to find the function declaration in headers but had no luck under 2.6.21 .
> 
> -- My specific questions --
> 
> Question 1.)   Is  'irq_set_irq_type'  still experimental ?

No.

> Question 2.)   At what version of the kernel source does the function appear?

It is named irq_set_irq_type in 2.6.39.  That's the earliest AFAICT.

> Question 3.)  If the function exists for  2.6.21  What headers are required to allow effective compilation?
> 

<linux/irq.h>

> 
> -- Notes and suggestions regarding kernel function documentation --
> 
> Note 1.) Perhaps functions should be documented with indications of what kernel versions they apply to.
> Note 2.) In function documentation, an indication of what headers to include supporting each specific function would be nice.

'grep' is really easy to use.

> Thank you for your time and comments,

Good luck.

-- 
~Randy

