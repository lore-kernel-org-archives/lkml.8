Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AD4C33CAA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 22:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F286421734
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 22:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="owiLuPsQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgAWWQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 17:16:28 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:35065 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbgAWWQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 17:16:27 -0500
Received: by mail-pj1-f65.google.com with SMTP id s7so118707pjc.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 14:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=POE26sNda0qtVdGqaXyUt84eyMAEBk9xA850hvv0kH4=;
        b=owiLuPsQcxHYXKCoP2YMvnzUUPRJslexRJOb18oXdkPOh4AC/fUyal/8hlDeRp0mdv
         95kuNy3Kj511gamXHKpivwFl1DWCF0A0Y4Gg8kcYVQlTq+a1hI+Oq2F7npRIwS/sRbLy
         bQYuRm0gv+0PeBKEW6cZ337kB2rH+rFCuIyCs5tDxu5vilTm2/tjN4N8+GWxnzQjyXBF
         a8OwHYZWuHAxe0etWYupTfs/aNXsWV/aIkLDu1qVfQFPWPIOni32bHbPFDm0fPpaDhqL
         Vl7ulGV5qPCRx2w5O/MhRC8mo1C9nAOIV9q9rvvlvmxFRh8+uxQr97uBodTZuSf5YqYq
         4gYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=POE26sNda0qtVdGqaXyUt84eyMAEBk9xA850hvv0kH4=;
        b=XDiPhEqlTyGszhJpc76v+1eTEGDlyjs9Mu5ETVQOcUyxD0E1TMqi/hpR36Thng3CNj
         hGuMw4zl3zXNPgCxt3qalZ7DeeZCQA/jEUT8Wts2+6+LGM9W4GYoF5bYxLECKBZqszp9
         l4pB7plPzvw6KhNxDOqcHie4dkuT3ccJLHiGBSuP3+KtuhG5Nv/aw1/spbuAI+e6j9a5
         HQ6aqxHK1H1tpPARXVqGPVpvj+wkhkqQzrZecFiRSwTWZnleQQcnpKPKBixOKVNwU/97
         qBStbIgD8X2i+3wcTGdFZNTeRQ2ScqjP7lkN6xwQ1LbTxZycGcRDeXOk+aZDqrs3lzmO
         eEHA==
X-Gm-Message-State: APjAAAVixiAvFSASXRPG4wNqNFhkzOZvfJCUBsJsLO1eKAbb3DZXN8PV
        RIw1W88gm9vq9TocNdtGjNHXMpxUxtJ7mqc5k74Vbg==
X-Google-Smtp-Source: APXvYqxxENHLtb92CkinCc6e7hMd/rmU5Q1evHN28+Wrp9/KsMdz3zfVLEZj0nvViglYxV3hcct7P8IRe35WoCSUI4U=
X-Received: by 2002:a17:902:fe8d:: with SMTP id x13mr320727plm.232.1579817786931;
 Thu, 23 Jan 2020 14:16:26 -0800 (PST)
MIME-Version: 1.0
References: <20191211192742.95699-1-brendanhiggins@google.com>
 <20191211192742.95699-7-brendanhiggins@google.com> <20191214112815.GA3335535@kroah.com>
In-Reply-To: <20191214112815.GA3335535@kroah.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 23 Jan 2020 14:16:15 -0800
Message-ID: <CAFd5g44Eg7DjBYWfKZ-s860X+GW65k-RtwjfEbeGXkKQ99h8WA@mail.gmail.com>
Subject: Re: [PATCH v1 6/7] staging: axis-fifo: add unspecified HAS_IOMEM dependency
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Moses Christopher <moseschristopherb@gmail.com>,
        linux-um <linux-um@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>, devel@driverdev.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 14, 2019 at 3:28 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Dec 11, 2019 at 11:27:41AM -0800, Brendan Higgins wrote:
> > Currently CONFIG_XIL_AXIS_FIFO=y implicitly depends on
> > CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
> > the following build error:
> >
> > ld: drivers/staging/axis-fifo/axis-fifo.o: in function `axis_fifo_probe':
> > drivers/staging/axis-fifo/axis-fifo.c:809: undefined reference to `devm_ioremap_resource'
> >
> > Fix the build error by adding the unspecified dependency.
> >
> > Reported-by: Brendan Higgins <brendanhiggins@google.com>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>
> Saying you reported a problem and then fixed it kind of does a bit of
> disservice to the "reported-by:" tag which we normally use only to
> credit the people that do not actually fix the problem.
>
> So in the future, no need for this to be there for patches that you
> write yourself.

Alright, thanks for spelling that out. I will remember that in the future.

Cheers!
