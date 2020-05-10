Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E20DC38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 17:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7955420736
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 17:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgEJRp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 13:45:28 -0400
Received: from smtprelay0085.hostedemail.com ([216.40.44.85]:38952 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726744AbgEJRp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 13:45:28 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 298BC40FE;
        Sun, 10 May 2020 17:45:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: talk80_699fde1aeca31
X-Filterd-Recvd-Size: 1977
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Sun, 10 May 2020 17:45:25 +0000 (UTC)
Message-ID: <c78e00a05d19a6823e48c7bd50144f0563908a1a.camel@perches.com>
Subject: Re: [PATCH] Kconfig: default to CC_OPTIMIZE_FOR_PERFORMANCE_O3 for
 gcc >= 10
From:   Joe Perches <joe@perches.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        Arnd Bergmann <arnd@arndb.de>,
        Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Sun, 10 May 2020 10:45:24 -0700
In-Reply-To: <9590a4674863448e8b13fee5086fcf73@AcuMS.aculab.com>
References: <20200507224530.2993316-1-Jason@zx2c4.com>
         <20200508090202.7s3kcqpvpxx32syu@butterfly.localdomain>
         <CAHmME9pTZTa9AEUL0-ojTr7P-F7NYe8OR9=-GBPaQNpnSDrEiw@mail.gmail.com>
         <20200508113336.2vdfdnc6tqyx4pu6@butterfly.localdomain>
         <CAK8P3a0dJ0vNnktcoWFiPKB4NJbeyf7nvwWf0YLyeUyxT5pvQg@mail.gmail.com>
         <c774d7371a9599526090e63e85f61e69bddf4795.camel@perches.com>
         <9590a4674863448e8b13fee5086fcf73@AcuMS.aculab.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-05-10 at 12:47 +0000, David Laight wrote:
> From: Joe Perches
> > Sent: 08 May 2020 16:06
> > On Fri, 2020-05-08 at 13:49 +0200, Arnd Bergmann wrote:
> > > Personally, I'm more interested in improving compile speed of the kernel
> > 
> > Any opinion on precompiled header support?
> 
> When ever I've been anywhere near it it is always a disaster.

A disaster? Why?

For a large commercial c only project, it worked well
by reducing a combined multi-include file, similar to
kernel.h here, to a single file.

That was before SSDs though and the file open times
might have been rather larger then.


