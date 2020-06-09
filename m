Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95200C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 12:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77F4B2078D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 12:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbgFIMLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 08:11:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:37534 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729094AbgFIMLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 08:11:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D6747AD5E;
        Tue,  9 Jun 2020 12:11:02 +0000 (UTC)
Date:   Tue, 9 Jun 2020 14:10:56 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/vmalloc: track which page-table levels were modified
Message-ID: <20200609121056.GB3871@suse.de>
References: <20200603232311.GA205619@roeck-us.net>
 <20200604083512.GN6857@suse.de>
 <CAHk-=wj2_YdxPaRFqBUUDZvtZKKG5To2KJhciJmDbchW2NFLnw@mail.gmail.com>
 <20200604140617.e340dd507ee68b0a05bd21cb@linux-foundation.org>
 <CAHk-=wjm+RrcTjB7KYCCsOouE2EyzRcwWUE9TVq6OCYYAt9Zyw@mail.gmail.com>
 <20200605081644.GS6857@suse.de>
 <20200605100059.GB7524@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605100059.GB7524@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Fri, Jun 05, 2020 at 01:00:59PM +0300, Mike Rapoport wrote:
> We already have include/asm-generic/pgalloc.h, so maybe something like
> that patch below would fork. This is not even compile tested.
> 
> diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h

I experimented a bit with your diff, but it turned out that moving the
page-table allocation functions/macros to asm-generic/pgalloc.h does not
work on all architectures.

The reason is that some archs don't use that header at all (e.g. ARC)
and have their own version of the functions defined there. That could
all be made working, but I decided to no open this can of worms for now.

So I sent out a patch which moves the p?d_alloc_track() functions/macros
to a separate header and include it only in mm/vmalloc.c and
lib/ioremap.c. That compiles on all architectures where current Linus'
master also builds (it does not for Alpha, CSky, Mips and Mips64), and
as usual Hexagon and Unicore32 are not tested because I have no working
compiler for those.

Regards,

	Joerg
