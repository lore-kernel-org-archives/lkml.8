Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3021AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 04:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF218206D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 04:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ySiq0WKu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgEUEiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 00:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbgEUEiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 00:38:09 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ABFC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 21:38:09 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id z5so7280060ejb.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 21:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5KCOIIzeGC6Wr485lQFHvKtNsuBP0Oc0+69jKUw3by0=;
        b=ySiq0WKuoG1C+5Z4Vg6tTZipO3Me/HdFVu3eL1WLrsp9IuYT5SUXZ8gV3gm9kR2mu+
         x2gdrYsEYD44ygiBAP717RAXIj/S1kUDoPWQexjPUXer+qInFOUqPIsNllw1zEG4Ybl8
         K9QwsJ3lYpL0jUPVKiPf+l9+EjGbIgSDnF5zjKaMML2Di5HIbtT56HdSPiC3wbLfsERa
         jVOT0IQsVeeRIvZddIVE7IssnaCp98tK1TIGPVtnq+rz5d0Pee2ZSwxM7XzBLlEQ2Z1t
         THVfPkkYP+kWuG7EBseJ/ZFKi6G8B1OQYspLqlUycTR2pLShmLeA72kSRf1hQsCDsMhn
         lKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5KCOIIzeGC6Wr485lQFHvKtNsuBP0Oc0+69jKUw3by0=;
        b=bFtapPl+j9HrhAcPDvXZRNaP7EKfoQPmMhQZcBhWJosja7sp6KwAv0aHOkfsDUi0mG
         2bUe2Y3Zdmn6YLT3Qz7blF6AacjI8hJt/c5ACinQY+zHt8eIJLaDtAcVvoAqLxbhWvEE
         x+gbjQgnai36gkO1SBM2mo8ZhfxW82aI6tRDVVOsA3+jmseaS0brMyZPXUNkBybzhwDF
         NUL3FuarTQpE9HH7GeU90WpJVGP3mMfVGS79zNFE6Cn3OV/uBGjo6WkatutbeQVE9EcM
         lsHYO5pQ0FgZls5LgZ4CNhlQOvjZZTUT/yNnqB977AO79xhR0PZd6xV17lme0UkAdk+N
         HTCQ==
X-Gm-Message-State: AOAM533rKnMzsPgf8M6CoZ9A24FWYlS4cU4zvVbASDXZc1f78HjqfKUx
        IOMATAqLvveCBOyYgUNcVwI2CLRrBCsnAopl+KGltg==
X-Google-Smtp-Source: ABdhPJw3DDYskRhdkTyiCNA2LABXPQAcEKzN/xK3GpvX8gosenDGbFcGGo2iovgmqIIkIOGIZ98Xa6vCprEsXzr4xao=
X-Received: by 2002:a17:906:a8d:: with SMTP id y13mr1867800ejf.455.1590035888160;
 Wed, 20 May 2020 21:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <159002475918.686697.11844615159862491335.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200521022628.GE16070@bombadil.infradead.org>
In-Reply-To: <20200521022628.GE16070@bombadil.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 20 May 2020 21:37:57 -0700
Message-ID: <CAPcyv4jpKo7s-bqM2TN2BS73ssOVfhdNaooziZMs2zULH6xs-g@mail.gmail.com>
Subject: Re: [PATCH v3] /dev/mem: Revoke mappings when a driver claims the region
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
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

On Wed, May 20, 2020 at 7:26 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, May 20, 2020 at 06:35:25PM -0700, Dan Williams wrote:
> > +static struct inode *devmem_inode;
> > +
> > +#ifdef CONFIG_IO_STRICT_DEVMEM
> > +void revoke_devmem(struct resource *res)
> > +{
> > +     struct inode *inode = READ_ONCE(devmem_inode);
> > +
> > +     /*
> > +      * Check that the initialization has completed. Losing the race
> > +      * is ok because it means drivers are claiming resources before
> > +      * the fs_initcall level of init and prevent /dev/mem from
> > +      * establishing mappings.
> > +      */
> > +     smp_rmb();
> > +     if (!inode)
> > +             return;
>
> But we don't need the smp_rmb() here, right?  READ_ONCE and WRITE_ONCE
> are a DATA DEPENDENCY barrier (in Documentation/memory-barriers.txt parlance)
> so the smp_rmb() is superfluous ...

Is it? I did not grok that from Documentation/memory-barriers.txt.
READ_ONCE and WRITE_ONCE are certainly ordered with respect to each
other in the same function, but I thought they still depend on
barriers for smp ordering?

>
> > +     /*
> > +      * Use a unified address space to have a single point to manage
> > +      * revocations when drivers want to take over a /dev/mem mapped
> > +      * range.
> > +      */
> > +     inode->i_mapping = devmem_inode->i_mapping;
> > +     inode->i_mapping->host = devmem_inode;
>
> umm ... devmem_inode->i_mapping->host doesn't already point to devmem_inode?

Not if inode is coming from:

     mknod ./newmem c 1 1

...that's the problem that a unified inode solves. You can mknod all
you want, but mapping and mapping->host will point to a common
instance.

>
> > +
> > +     /* publish /dev/mem initialized */
> > +     smp_wmb();
> > +     WRITE_ONCE(devmem_inode, inode);
>
> As above, unnecessary barrier, I think.

Well, if you're not sure, how sure should I be?
