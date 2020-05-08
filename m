Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9F8C35280
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 03:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 159BC20746
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 03:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgEHDG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 23:06:57 -0400
Received: from gentwo.org ([3.19.106.255]:33624 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbgEHDG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 23:06:57 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 3E98C3FEDA; Fri,  8 May 2020 03:06:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 3CA8A3FED9;
        Fri,  8 May 2020 03:06:56 +0000 (UTC)
Date:   Fri, 8 May 2020 03:06:56 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Rafael Aquini <aquini@redhat.com>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, iamjoonsoo.kim@lge.com,
        rientjes@google.com, penberg@kernel.org
Subject: Re: [PATCH] mm: slub: add panic_on_error to the debug facilities
In-Reply-To: <20200504025138.GB18463@t490s>
Message-ID: <alpine.DEB.2.22.394.2005080305110.56560@www.lameter.com>
References: <20200501211540.71216-1-aquini@redhat.com> <alpine.DEB.2.22.394.2005022313490.1519@www.lameter.com> <20200504025138.GB18463@t490s>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 May 2020, Rafael Aquini wrote:

> On Sat, May 02, 2020 at 11:16:30PM +0000, Christopher Lameter wrote:
> > On Fri, 1 May 2020, Rafael Aquini wrote:
> >
> > > Sometimes it is desirable to override SLUB's debug facilities
> > > default behavior upon stumbling on a cache or object error
> > > and just stop the execution in order to grab a coredump, at
> > > the error-spotting time, instead of trying to fix the issue
> > > and report in an attempt to keep the system rolling.
> >
> > The stopping of execution on an error is the default behavior. Usually
> > you get some OOPS somewhere when data is corrupted and that causes a core
> > dump.
> >
> > SLUB can fix the issue and continue if enabled by specifying special
> > options on boot. That is *not* the default.
> >
> It is the default behavior when slub_debug is turned on, which is what
> this patch is trying to override, when needed. We've been seeing the
> need for such feature as, most often than not, by letting the system
> running to crash somewhere else after hitting occurrences reported by
> slub_debug ends up clobbering clues to the original issue.

Ok. The backtrace is not sufficient in that case?


