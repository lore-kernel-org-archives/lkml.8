Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1E6C2BA1B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 17:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012F520675
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 17:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbgDERXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 13:23:07 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:47900 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbgDERXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 13:23:06 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23991372AbgDERXDyMN9m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org> + 1 other);
        Sun, 5 Apr 2020 19:23:03 +0200
Date:   Sun, 5 Apr 2020 18:23:03 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
cc:     linux-mips@vger.kernel.org, Fangrui Song <maskray@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: malta: Set load address for 32bit kernel
 correctly
In-Reply-To: <96C9B1A0-2F89-4650-B0A4-6A6242A2AA0A@flygoat.com>
Message-ID: <alpine.LFD.2.21.2004051817310.4156324@eddie.linux-mips.org>
References: <20200405082451.694910-1-jiaxun.yang@flygoat.com> <alpine.LFD.2.21.2004051738000.4156324@eddie.linux-mips.org> <96C9B1A0-2F89-4650-B0A4-6A6242A2AA0A@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Apr 2020, Jiaxun Yang wrote:

> > Given the description above I think it should be done uniformly and 
> >automatically across all platforms by trimming the address supplied
> >with 
> >$(load-y) to low 8 digits in a single place, that is at the place where
> >
> >the variable is consumed.  This will reduce clutter across Makefile 
> >fragments, avoid inconsistencies and extra work to handle individual 
> >platforms as the problem is triggered over and over again, and limit
> >the 
> >risk of mistakes.
> 
> I was intended to do like this but failed to find a proper way.
> 
> Makefile isn't designed for any kind of calculation.
> And shell variables are 64-bit signed so it can't hold such a huge variable.
> 
> Just wish somebody can give me a way to do like:
> 
> ifndef CONFIG_64BIT
> load-y = $(load-y) & 0xffffffff
> endif

 Use the usual shell tools like `sed', `cut', `awk', or whatever we use in 
the kernel build already for other purposes.  There's no need to do any 
actual calculation here to extract the last 8 characters (and the leading 
`0x' prefix).  At worst you can write a small C program, compile it with 
the build system compiler and run, as we already do for some stuff.

  Maciej
