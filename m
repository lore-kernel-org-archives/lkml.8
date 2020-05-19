Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D54C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7960420578
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="AXuLfz4Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbgESS1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 14:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgESS1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 14:27:15 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A0AC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 11:27:14 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id l3so342843edq.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 11:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EE4DNOBMavO7IZ4rNX59iIePh4zF+lvNEi66QnnKnCE=;
        b=AXuLfz4ZzY37jAmrhDap2PxzbyMy8lDBdhunupa7OTJ4aw9/+o7d4HMJKIP1EIRV0G
         GI0Yai6wZFyMg61X4/Qc+Wwft+wSUaCbhSFuk8mNd0o1eS/a+lwlO4bq+f8oav+Fux2G
         Bwvp82AMeEb3p4PmACGeu8iwsBpNROchx23Z8xFrpbBs+pFVjCxJBVRSj99NSI76VMTP
         fS0Fj5lRs5MVOF7S3ahejgm61hkffvMvqskDc68lfqdfnha6eyFzI8bENQ8fAyYxGWvG
         wQ+9mvKwU/BpJSM7+5nueLTgKeXn3O7sTqwBsKVXOXcZol1iY3W38x0EUTU47S0p560Q
         qSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EE4DNOBMavO7IZ4rNX59iIePh4zF+lvNEi66QnnKnCE=;
        b=p9MgxAvm2t7XE6meTWF4eWvbFDYdCy7H3wH+UAJ+GJvNteg76yQakRrGeXLN5FrizP
         b9h7WC9aKh8gL6/pyzhmQ6mbcmIts4QZIml1meklejrOxAgsu4NjoJD84MuFBe2TUCMr
         75Z5z/Mv3/v/kPWPE7Da2ZiIOMKPvuk+MJcvNSr2JhvMn3OOXGRiwwmqoIJbBZr+V4wm
         gBgkq2NJ0AmhYG9TsGLPnmtELQCxCkqb3lgd5eg5Wvstj2R5nEON14/qqf0Jv43tNTnM
         CN9osqUKtFXR+7G3ra4sWIvZJ6iJvt12JMtm9lqQofiiypMR4amygJfAlQQTRXi1/qGD
         tYnw==
X-Gm-Message-State: AOAM532/4PHhVLrxslr8pnU3zWonBcYdsRK0266lIb1ds1tlzxKmZv87
        EYMumcAtkX7LG+GMwiHxlQ8gfaDIiy5pXJ/tdtYHmA==
X-Google-Smtp-Source: ABdhPJxH4swItD3dIgSTnKIJ51ANtghX84k0sbelvVaXdBdX7PXJvEUUsea7iWlT+xv92Mkd6Iz00oKGUp1l8IdYQSg=
X-Received: by 2002:a50:c2d9:: with SMTP id u25mr215498edf.123.1589912833400;
 Tue, 19 May 2020 11:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <158987153989.4000084.17143582803685077783.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200519121115.GC332015@kroah.com>
In-Reply-To: <20200519121115.GC332015@kroah.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 19 May 2020 11:27:02 -0700
Message-ID: <CAPcyv4gTkWx_q4sDXVyS+ybh0Nj7ybPUXGC4HCHQCO4eGxXwiQ@mail.gmail.com>
Subject: Re: [PATCH v2] /dev/mem: Revoke mappings when a driver claims the region
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Russell King <linux@arm.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 5:11 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, May 19, 2020 at 12:03:06AM -0700, Dan Williams wrote:
> > Close the hole of holding a mapping over kernel driver takeover event of
> > a given address range.
> >
> > Commit 90a545e98126 ("restrict /dev/mem to idle io memory ranges")
> > introduced CONFIG_IO_STRICT_DEVMEM with the goal of protecting the
> > kernel against scenarios where a /dev/mem user tramples memory that a
> > kernel driver owns. However, this protection only prevents *new* read(),
> > write() and mmap() requests. Established mappings prior to the driver
> > calling request_mem_region() are left alone.
> >
> > Especially with persistent memory, and the core kernel metadata that is
> > stored there, there are plentiful scenarios for a /dev/mem user to
> > violate the expectations of the driver and cause amplified damage.
> >
> > Teach request_mem_region() to find and shoot down active /dev/mem
> > mappings that it believes it has successfully claimed for the exclusive
> > use of the driver. Effectively a driver call to request_mem_region()
> > becomes a hole-punch on the /dev/mem device.
> >
> > The typical usage of unmap_mapping_range() is part of
> > truncate_pagecache() to punch a hole in a file, but in this case the
> > implementation is only doing the "first half" of a hole punch. Namely it
> > is just evacuating current established mappings of the "hole", and it
> > relies on the fact that /dev/mem establishes mappings in terms of
> > absolute physical address offsets. Once existing mmap users are
> > invalidated they can attempt to re-establish the mapping, or attempt to
> > continue issuing read(2) / write(2) to the invalidated extent, but they
> > will then be subject to the CONFIG_IO_STRICT_DEVMEM checking that can
> > block those subsequent accesses.
> >
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Fixes: 90a545e98126 ("restrict /dev/mem to idle io memory ranges")
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> > Changes since v1 [1]:
> >
> > - updated the changelog to describe the usage of unmap_mapping_range().
> >   No other logic changes:
> >
> > [1]: http://lore.kernel.org/r/158662721802.1893045.12301414116114602646.stgit@dwillia2-desk3.amr.corp.intel.com
> >
> > Greg, Andrew,
> >
> > I have a regression test for this case now. This was found by an
> > intermittent data corruption scenario on pmem from a test tool using
> > /dev/mem.
>
> Ick, why are test tools messing around in /dev/mem :)

Yeah, I'm all for useful tools, just not at the expense of kernel integrity.

> Anyway, this seems sane to me, want me to take it through my tree?

Yes please, seems to belong with the driver core.

Thanks!
