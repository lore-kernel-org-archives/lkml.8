Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23031C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 23:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BA90206D8
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 23:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgHIXPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 19:15:32 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:55664 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgHIXPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 19:15:32 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 9F8A729B87;
        Sun,  9 Aug 2020 19:15:28 -0400 (EDT)
Date:   Mon, 10 Aug 2020 09:15:18 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Guenter Roeck <linux@roeck-us.net>
cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joshua Thompson <funaho@jurai.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Laurent Vivier <lvivier@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] macintosh/via-macii: Access autopoll_devs when inside
 lock
In-Reply-To: <20200809190138.GA133890@roeck-us.net>
Message-ID: <alpine.LNX.2.23.453.2008100859330.8@nippy.intranet>
References: <cover.1593318192.git.fthain@telegraphics.com.au> <5952dd8a9bc9de90f1acc4790c51dd42b4c98065.1593318192.git.fthain@telegraphics.com.au> <20200809190138.GA133890@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Aug 2020, Guenter Roeck wrote:

> Hi,
> 
> On Sun, Jun 28, 2020 at 02:23:12PM +1000, Finn Thain wrote:
> > The interrupt handler should be excluded when accessing the 
> > autopoll_devs variable.
> > 
> 
> I am quite baffled by this patch. Other than adding an unnecessary lock 
> / unlock sequence,

The new lock/unlock sequence means that the expression (autopoll_devs && 
!current_req) can be understood to be atomic. That makes it easier for me 
to follow (being that both variables are shared state).

> accessing a variable (which is derived from another variable) from 
> inside or outside a lock does not make a difference. If autopoll_devs = 
> devs & 0xfffe is 0 inside the lock, it will just as much be 0 outside 
> the lock, and vice versa.
> 
> Can you explain this in some more detail ? Not that is matters much 
> since the change already made it into mainline, but I would like to 
> understand what if anything I am missing here.
> 

I think the new code is more readable and is obviously free of race 
conditions. It's not obvious to me why the old code was free of race 
conditions but if you can easily establish that by inspection then you are 
a better auditor than I am. Regardless, I'll stick with "Keep It Simple, 
Stupid".
