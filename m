Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D04C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AA0B20772
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="uEOFXLPJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbgGBNL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 09:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729147AbgGBNL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 09:11:56 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BD9C08C5DD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 06:11:56 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id s21so9000663ilk.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 06:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4T2/tOm2utLxkDVCIclRjvAJrzJlAzfQSBQGwPXBCYw=;
        b=uEOFXLPJjXSm2OFaf2ftEyA9WHX4un8w0jz/SrqobbbqcKZnZm/R7Esv+xGohE4MSX
         eYEgfWhHvh0fgQxGHuEEO0WpWgZmd1UrVO8QB9xNXvI0znnn+W7ztqH7Zhj07zQCFq+r
         aLLxLhWFkiKdwmHS953X14WU/Ob6SPxfNjepQpEM7BQasYN4jba3hNaxfYOgeCKN52t7
         oa7EMBUUr2WjO0ZDK2B/8U2UkhKWMWNEdtZZ334qav4caKjlapdqQbSyaWcaeFvValTB
         NMizvIvdBO9+L8ANXX23ViPVhPcNkK6qaSu8pk/YZf3oGjs96BDk8FUEfeI7YNgDv60N
         QezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4T2/tOm2utLxkDVCIclRjvAJrzJlAzfQSBQGwPXBCYw=;
        b=MkPm5WSFDysgzwZlrayxJXZXUAQkF/2wCE2pZgLj2RUuCUApFZVZBJz4oIslFHGnQn
         DRXDalDwR0seDsLl7oqtZzSodMflF+sG2QfHRe8QGTQSA/8RQh6xz0lt+y1IfStvRh89
         uX43cqblEu8yQEvCx7737HVxCtbHTL0G+jaJkniVMF3P+Mzi1VHiwFcYifR140SQl4cV
         KiYqf9+2GC3DOpx4QFI31jj8jnHQKw+Xoc8XGZunMYjMvZDz+9cOYGpNJHygE2FUXhBL
         tRpDUhROnbtJ3Z9MW09UPPhSa0Vf9MRx/nSfRI6MqH6HfzfmNzEcqqqQ6vijajeCHn8w
         YaYg==
X-Gm-Message-State: AOAM531OxeMmozIVLlK5KNZ/j68eBqAePvIw8pTVi6zkEXDvKSLuqTVG
        e20eJUxBXdQR4Td7i7tPy5pRDsGe6dRNvqNB2J8k2g==
X-Google-Smtp-Source: ABdhPJyOSZEb1Tz8D5+CyElWjiUEsBaXIB3CS2khF5aWcydrghdsdkSKPSM7V/wF+6D+m6eN8BOs+6GQiTgfBM3EQRM=
X-Received: by 2002:a92:c213:: with SMTP id j19mr12764064ilo.40.1593695515892;
 Thu, 02 Jul 2020 06:11:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200629065008.27620-1-brgl@bgdev.pl> <20200629065008.27620-6-brgl@bgdev.pl>
 <20200702124258.GA1882489@kroah.com>
In-Reply-To: <20200702124258.GA1882489@kroah.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 2 Jul 2020 15:11:44 +0200
Message-ID: <CAMRc=Mc6dWCtnFT_SMGLUsggf68i3y7Njr61NyDQ7KeQ-rSErg@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] devres: provide devm_krealloc()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 2:42 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jun 29, 2020 at 08:50:07AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Implement the managed variant of krealloc(). This function works with
> > all memory allocated by devm_kmalloc() (or devres functions using it
> > implicitly like devm_kmemdup(), devm_kstrdup() etc.).
> >
> > Managed realloc'ed chunks can be manually released with devm_kfree().
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

[snip!]

>
> That's a lot of logic that does not seem to match up with the krealloc()
> logic in mm/slab_common.c, are you sure we need to do all of that?
>

What are you referring to exactly? The check for rodata? It's because
devm_kfree() handles this case, while regular kfree() (or krealloc())
doesn't - there's kfree_const() but no devm_kfree_const().

> Who wants this?

The hwmon commit I mentioned in my response to patch 6/6 explicitly
mentions the lack of this helper.

Bartosz
