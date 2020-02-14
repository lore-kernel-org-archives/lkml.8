Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1920AC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 23:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB0C20848
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 23:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="JMTUKbWT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgBNXFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:05:23 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38318 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgBNXFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 18:05:22 -0500
Received: by mail-ot1-f68.google.com with SMTP id z9so10736741oth.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 15:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MFbGjBAZ9jJ0epeJ8+efVvoWM9zaa3+GyCDFwE2/leM=;
        b=JMTUKbWTyneQpCu5P7I6UY4sjbtgcldSXd8L6n24Ux/t41POpIteMsP3aa4eebSYZl
         puBtNSopjm55AOT7X1FSnUU4whwN+YFgMC9PCjzgxdcA5tNBbmDW1XPp4uYbNM75J1Gl
         +6wP4N0b//tq9VMwWxGNNCKfxpvP9+eiqoIGuiMRRza2HJaZEeQ4isuHO7iYlwmw6zR8
         5NJfOBLW0bd+vnwxwOKAMtiZ0HDb91pCHTz9sqX+VJBKT0Q9aEnm1QgJy5aGqk71HIuF
         LJwai3h5GTbqhdXGkMACukn4Zknw283nV1VHgNb/33G68/BRUNMw2ertvirUBT8Kng3e
         li5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MFbGjBAZ9jJ0epeJ8+efVvoWM9zaa3+GyCDFwE2/leM=;
        b=VZPkZ97Bv6cA1Dq//ocfV9DG/iXQADqqGNfQmot3js7a/VxhKzCqnbF020tQfQ6Rk/
         lLp4mzVGrwHdfPzMHyVp29lJUYfBl9MnRBaXXjDukhAWrmAYn2jrtp/0vkY6aWeR/LCS
         ChzrnTvPHxhdp8oZU/YdeSuFhkFvhw9Cmp/IJT51E5zblXv0W2OyrF7jks2+I+E0lGuM
         2Dvxb2v7sPJSQNWYUCOroho4y2b/veBlxyGPCKBtin1eIGL3vDyCGh3xK5VpR/X6M5DZ
         KYZLbTLjB4xIwi5i19Q+KiQjJ8sNY2vTRzMCRUZtiwYM0Yv6bCe+3WPox/R7uGYclgxU
         AYQQ==
X-Gm-Message-State: APjAAAU4/+UsXYEvr8KAcCXLlaEnwTYaZRFDsxV317d0yODlaDuZV408
        IflQHXsjAA0IrFkd6hz+3n72we2RnpKKTMsDee9ZuQ==
X-Google-Smtp-Source: APXvYqyiTvPjMMOcsUvKfqz6iMQdR7SXgorFNb7wdpVGvSunO+Nl0vivaI37jSYP7UU4tRj9jLKbuUD42j/eENCmZ7c=
X-Received: by 2002:a9d:7852:: with SMTP id c18mr3938798otm.247.1581721522180;
 Fri, 14 Feb 2020 15:05:22 -0800 (PST)
MIME-Version: 1.0
References: <158155489850.3343782.2687127373754434980.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158155490379.3343782.10305190793306743949.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x498sl677cf.fsf@segfault.boston.devel.redhat.com> <CAPcyv4i8xNEsdX=8c2+ehf24U2AFcc-sKmAPS9UoVvm8z0aRng@mail.gmail.com>
 <x49k14odgwz.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49k14odgwz.fsf@segfault.boston.devel.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 14 Feb 2020 15:05:09 -0800
Message-ID: <CAPcyv4hc2ZOyymas1svXYQFa49tziC2ZkVLfgKVV64bu4gTTEg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm/memremap_pages: Introduce memremap_compat_align()
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 12:59 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > On Thu, Feb 13, 2020 at 8:58 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> >> I have just a couple of questions.
> >>
> >> First, can you please add a comment above the generic implementation of
> >> memremap_compat_align describing its purpose, and why a platform might
> >> want to override it?
> >
> > Sure, how about:
> >
> > /*
> >  * The memremap() and memremap_pages() interfaces are alternately used
> >  * to map persistent memory namespaces. These interfaces place different
> >  * constraints on the alignment and size of the mapping (namespace).
> >  * memremap() can map individual PAGE_SIZE pages. memremap_pages() can
> >  * only map subsections (2MB), and at least one architecture (PowerPC)
> >  * the minimum mapping granularity of memremap_pages() is 16MB.
> >  *
> >  * The role of memremap_compat_align() is to communicate the minimum
> >  * arch supported alignment of a namespace such that it can freely
> >  * switch modes without violating the arch constraint. Namely, do not
> >  * allow a namespace to be PAGE_SIZE aligned since that namespace may be
> >  * reconfigured into a mode that requires SUBSECTION_SIZE alignment.
> >  */
>
> Well, if we modify the x86 variant to be PAGE_SIZE, I think that text
> won't work.  How about:

...but I'm not looking to change it to PAGE_SIZE, I'm going to fix the
alignment check to skip if the namespace has "inner" alignment
padding, i.e. "start_pad" and/or "end_trunc" are non-zero.
