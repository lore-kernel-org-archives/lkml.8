Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C4FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 14:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC7B720663
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 14:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tCr1heuS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbgG1OYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 10:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730089AbgG1OYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 10:24:46 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D194EC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 07:24:45 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l23so18819686qkk.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 07:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MWRFI7Cr0Uwgm5dsy6ruH9K3Q6HQlGNoCK45U52FYiQ=;
        b=tCr1heuSvPmt5jXKf8Iu6VNc9z3I5OpkMkWQoiH+XTQmhONE4L+OWhLqwf1tKEPzob
         Ii1kdw2FWvh4ZgrlKcqogL/4ZVn8E7lARtAFddkrarYxhbaVy+WDrHj8WYDpOCZqpC8W
         S9M7NcreX/JvIs7sgi8QZ8ArTREwbAkqvPV5Yb9yoPD0UMFOqIBGULopBmcHzjnp3cGC
         CQSwGKpthOebWo2/+O+x/xPdaOe2iwKoS+xJ6f7B0Fbn1oUPU/+s5dXnZKynr5X7XrkA
         WiWr6W8FIC4MIwN6bJUxNlbxqAXMD5MtZBXapGzgdF+gRreFfVgXEc929EYlg1kzDpHW
         8U4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=MWRFI7Cr0Uwgm5dsy6ruH9K3Q6HQlGNoCK45U52FYiQ=;
        b=ojJCSmJxKY3Wj5bPYOzSO1PFHc9cFRgqjkOc2CToGaOqiFA19GjYsQ+p4TOPxgpPJ5
         EaA2SPkvdbUFls2JYhALgtaol6fVGdWXzwkovvfdSSPOg1zjQu9Sl4VlvG6GEJBJauHV
         qV8un5xF+NRuC502D2KXDhMJmnc95CMeeog+yWi8ZCH0oumUwUKOSOTEa7EC/EEr4bfH
         wjNLo4GiB8Hu494cx0XBt6EN8ds2R9enCi4+JMwQ1iAhMc0Fcf20v+xYbeI/+he4De5l
         nSWCC30gD4T0vzEfbvd9SER3NPf6ZlZOrL/BtRfGeYJW9+o2ORSOON1KCIBHQs7mg67B
         huBA==
X-Gm-Message-State: AOAM532qa3CN+2A4W9rK+Do8BlQ50Hpc++F5806GFygIGMcJEpHqOJBH
        1WTyjzeln5GD2Vy1Hq1d+NE=
X-Google-Smtp-Source: ABdhPJwWqhRKg+bpR3CFbMj7+HWQ7169YXRxZ7/bHc+gQQYwrJdRXt1vxGYZ6995WJJCastPluwDkw==
X-Received: by 2002:a37:34c:: with SMTP id 73mr9668910qkd.262.1595946285034;
        Tue, 28 Jul 2020 07:24:45 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id e4sm12213878qts.57.2020.07.28.07.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 07:24:44 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 28 Jul 2020 10:24:42 -0400
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] x86/kaslr: Cleanup and small bugfixes
Message-ID: <20200728142442.GA3869481@rani.riverdale.lan>
References: <20200727215047.3341098-1-nivedita@alum.mit.edu>
 <20200727230801.3468620-1-nivedita@alum.mit.edu>
 <20200728110617.GF222284@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200728110617.GF222284@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 01:06:17PM +0200, Ingo Molnar wrote:
> 
> * Arvind Sankar <nivedita@alum.mit.edu> wrote:
> 
> > The first 7 patches are cleanup and minor bugfixes on the x86 KASLR
> > code.
> > 
> > The last one is a bit of an RFC. The memory regions used for KASLR are
> > stored as 64-bit even on a 32-bit kernel. However there are still a few
> > local variables that are 32-bit, but should be ok as far as I can see
> > because they are assigned values that have been already limited to
> > 32-bit. It does make it a little harder to verify that the code is
> > correct. Since KASLR cannot actually use 64-bit regions for the 32-bit
> > kernel, the patch reduces regions to their below-4G segment when
> > creating them, making the actual variables 32-bit. Alternatively, the
> > few local variables could be upgraded to 64-bit.
> > 
> > v1->v2:
> > - Fix a bug in the bugfix 5/8: overlap.start can be smaller than
> >   region.start, so shouldn't subtract before comparing.
> > 
> > Arvind Sankar (8):
> >   x86/kaslr: Make command line handling safer
> >   x86/kaslr: Remove bogus warning and unnecessary goto
> >   x86/kaslr: Fix process_efi_entries comment
> >   x86/kaslr: Initialize mem_limit to the real maximum address
> >   x86/kaslr: Simplify __process_mem_region
> >   x86/kaslr: Simplify process_gb_huge_pages
> >   x86/kaslr: Clean up slot handling
> >   x86/kaslr: Don't use 64-bit mem_vector for 32-bit kernel
> > 
> >  arch/x86/boot/compressed/acpi.c  |   7 +-
> >  arch/x86/boot/compressed/kaslr.c | 228 ++++++++++++-------------------
> >  arch/x86/boot/compressed/misc.h  |  19 ++-
> >  3 files changed, 111 insertions(+), 143 deletions(-)
> 
> I've applied patches 1-4 to x86/kaslr and will push them out if they 
> pass testing - see the review feedback for the others.
> 
> Thanks,
> 
> 	Ingo

Ok, thanks, I will send them split out and replace the last patch.
