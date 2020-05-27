Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33FEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FA6820835
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="dvDvQkJQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403893AbgE0RpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 13:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391542AbgE0RpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 13:45:17 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACF0C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 10:45:17 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id e2so29036340eje.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 10:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8mFtPr70+M6apdHwECQwtE0zBIswHryRWPxkV/RNuy4=;
        b=dvDvQkJQFI8yWa2awybOsZrnFGgmcqFM7ZW4rJz0zjtlx9s5xgduk+OM2lc7nFfjCo
         c6Vz/iUvE0DfRgVV8SbSVoTXQXQ0YkZok9A0AcjzfZBwT7RKbjwXU4ELIKGZQStewJmz
         kknihChozQhZ/pQ1tJ0hEKMYQq7b7X7ggStktoC+sFL9O5rM300uiKvwtj8+HhR2zmvF
         Jt8Sa02KiuYawH9lV3OB5Lv0XI4o4N8/YWfD1IIinggWKQj3PAk/vq+0MWxl8fLsc4Hy
         KkfBO7OGsIxqdFboM3JUWjhvWxCNRHxD/Pm6nPrxZ79lem0gPlqNHUEYAtaF7FUfRBhN
         54Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8mFtPr70+M6apdHwECQwtE0zBIswHryRWPxkV/RNuy4=;
        b=hmvVrasrfG0/yAPWmzFksyKGtRwgLz2r98B91RNgtl9bb/YvHy5BoupEVrZVfL9tBF
         BDVBAQhw9BBwFrgESqGuUx48BlwLnh8cnL2Ljb+YJfpZLmN0dNoN0zg30xSpiCLkh1tJ
         l+3nMLNKvV4TKGi4jQoGQl6d2eU7LNvWMhEDk9NDE/R77NX42GmUNDs4+6Z+EcO6pCPH
         1Oc7LYG3dZhWhArDMPR3KUZ/8ZnirINbBQyv+hd6ru789sHp7KlitK/zTPtcfoNaBaqs
         goroqNfH5gLJzQ13SCMWGSQr9Y34tzYGAEFU9BUdHFFE0c1yZiVfXSFbtmVenU7wwdVW
         XvLw==
X-Gm-Message-State: AOAM531d5blwASBUOyi9Z6BUyPjYNDl/qTxTlbQc4yYGGegqMwyxO/jV
        jI8A0H7K8GXhjHKA5qIkLomSuiyAPQpc0CUi0Qe4cg==
X-Google-Smtp-Source: ABdhPJyTjA/zTkYCTIHeH9PsmBKXEZoxnZzzLtoLEydIvlAGMECI+VKgrxr/M1xDJHkM9rV+v4IRpxyHFaY0PLCjndg=
X-Received: by 2002:a17:906:3597:: with SMTP id o23mr7022104ejb.174.1590601516095;
 Wed, 27 May 2020 10:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <159010126119.975921.6614194205409771984.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159010126739.975921.6393757191247357952.stgit@dwillia2-desk3.amr.corp.intel.com>
 <87mu5yg8n6.fsf@mpe.ellerman.id.au>
In-Reply-To: <87mu5yg8n6.fsf@mpe.ellerman.id.au>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 27 May 2020 10:45:05 -0700
Message-ID: <CAPcyv4h6moXY0fB=cyGuXOpT=+rFWupCy0kh87OT0X_1ZB2ROg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] x86, powerpc: Rename memcpy_mcsafe() to
 copy_mc_to_{user, kernel}()
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        stable <stable@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 5:04 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Hi Dan,
>
> Sorry one minor nit below.
>
> Dan Williams <dan.j.williams@intel.com> writes:
> > diff --git a/tools/testing/selftests/powerpc/copyloops/.gitignore b/tools/testing/selftests/powerpc/copyloops/.gitignore
> > index ddaf140b8255..1152bcc819fe 100644
> > --- a/tools/testing/selftests/powerpc/copyloops/.gitignore
> > +++ b/tools/testing/selftests/powerpc/copyloops/.gitignore
> > @@ -12,4 +12,4 @@ memcpy_p7_t1
> >  copyuser_64_exc_t0
> >  copyuser_64_exc_t1
> >  copyuser_64_exc_t2
> > -memcpy_mcsafe_64
> > +copy_mc_to_user
>
> Should be:
>
> +copy_mc_64
>
> Otherwise the powerpc bits look good to me.
>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

Will update, thanks!
