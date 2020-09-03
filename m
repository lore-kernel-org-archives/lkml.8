Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECC1C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 11:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ED7D20678
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 11:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q1yCvbZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgICLFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 07:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbgICK6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 06:58:00 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250A4C061246;
        Thu,  3 Sep 2020 03:57:57 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u20so2048061pfn.0;
        Thu, 03 Sep 2020 03:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XvxPmxtC0Bk31a11OwZrMge+dU3uUM43arNhidKdfeY=;
        b=q1yCvbZ8w01P8xuPxnIcZnEF3Hr07ImVQMcXxZgqnSncr+zba54pN3npDYYOjJXhbm
         XIqjp77VnYo3sJUa9nsc/OkcPZ2a5Y90boSJn50VaZ74haoOIwzEqzuApddDmuRsWA4t
         5LlNWMh47eFOI/t/pn9hyEBoN/9bMzFwyvwPxAFUkJ5XUIrhRgszLM/M8If1a/RC8WmZ
         6qZ5sWP8uitmybmf3cwkB0qwBCXj3OoX/HrhU+S1S1dHFyplWZAkXiQoi27iG3iQmbnm
         EQGK1zrcCUMrp+7WqPhSebA3XqqW6nM8d6/yeJZq7qMNXZRfKdpHSJtV5y0ESKKzTh/Z
         pJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XvxPmxtC0Bk31a11OwZrMge+dU3uUM43arNhidKdfeY=;
        b=V3pK3e2Oog1j3HPAQsghba8wYWj1Mtrhpt2ehqrEjsJ/S4lckjMeBl1zy6AwYJ2p07
         MjPkKE7T6pPseQHyQLb/nrp9N3e0hdaj4sSktyHB2neM406UB+Yd413XzbV+Atn0xfmi
         Z415AMeFtnBVcs2QNmQPnp891RycLLVRTCwu7GNg8GQcCm7n2+tdQ223nOUWqHELKhlp
         u7qcXnhY5V0qAnNkJbPbP7rFC2ceG2XU4Au4AOtVXvkUEeqOpVkdX6DTXWd5NrV9057N
         T4aesZBQZhCHkbWOsAsjy9N8T14T8c3k09Hdw8Puo/L9/9FIaZo2JFKYirXYLYVJMTjH
         cHRQ==
X-Gm-Message-State: AOAM533pykzo0Pq5/z+hkZSIkPMwFxvqBvegu3w859zL2aEj/0LXi3qV
        gKQzm5BlGL2x4mqc/QdhI7FMysM+vkWi7I45vieAzSzRLXUY+g==
X-Google-Smtp-Source: ABdhPJzWVo7SnArbq5BTD4S1cYWUGvNIOFTqyxYbAJGJHhEbl/k7IWPLuudMRiwWjgcOrgrKPL+6Qt7HKDzE/CcnN7Y=
X-Received: by 2002:a62:6083:0:b029:13c:1611:66c4 with SMTP id
 u125-20020a6260830000b029013c161166c4mr1648433pfb.15.1599130676695; Thu, 03
 Sep 2020 03:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200901221646.26491-1-nicoleotsuka@gmail.com> <20200901221646.26491-2-nicoleotsuka@gmail.com>
In-Reply-To: <20200901221646.26491-2-nicoleotsuka@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 3 Sep 2020 13:57:39 +0300
Message-ID: <CAHp75VcVJBSnPQ6NfdF8FdEDfM+oQ=Sr+cH5VGX4SrAqrgpf-g@mail.gmail.com>
Subject: Re: [PATCH 1/2] dma-mapping: introduce dma_get_seg_boundary_nr_pages()
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" 
        <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rth@twiddle.net, ink@jurassic.park.msu.ru,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        schnelle@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        hca@linux.ibm.com, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 2, 2020 at 1:20 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> We found that callers of dma_get_seg_boundary mostly do an ALIGN
> with page mask and then do a page shift to get number of pages:
>     ALIGN(boundary + 1, 1 << shift) >> shift
>
> However, the boundary might be as large as ULONG_MAX, which means
> that a device has no specific boundary limit. So either "+ 1" or
> passing it to ALIGN() would potentially overflow.
>
> According to kernel defines:
>     #define ALIGN_MASK(x, mask) (((x) + (mask)) & ~(mask))
>     #define ALIGN(x, a) ALIGN_MASK(x, (typeof(x))(a) - 1)
>
> We can simplify the logic here into a helper function doing:
>   ALIGN(boundary + 1, 1 << shift) >> shift
> = ALIGN_MASK(b + 1, (1 << s) - 1) >> s
> = {[b + 1 + (1 << s) - 1] & ~[(1 << s) - 1]} >> s
> = [b + 1 + (1 << s) - 1] >> s
> = [b + (1 << s)] >> s
> = (b >> s) + 1
>
> This patch introduces and applies dma_get_seg_boundary_nr_pages()
> as an overflow-free helper for the dma_get_seg_boundary() callers
> to get numbers of pages. It also takes care of the NULL dev case
> for non-DMA API callers.

...

> +static inline unsigned long dma_get_seg_boundary_nr_pages(struct device *dev,
> +               unsigned int page_shift)
> +{
> +       if (!dev)
> +               return (U32_MAX >> page_shift) + 1;
> +       return (dma_get_seg_boundary(dev) >> page_shift) + 1;

Can it be better to do something like
  unsigned long boundary = dev ? dma_get_seg_boundary(dev) : U32_MAX;

  return (boundary >> page_shift) + 1;

?

> +}

-- 
With Best Regards,
Andy Shevchenko
