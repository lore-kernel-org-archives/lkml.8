Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1ECC35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 12:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76F024653
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 12:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="flaLEU0j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgBUMXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 07:23:21 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37419 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbgBUMXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 07:23:21 -0500
Received: by mail-lf1-f66.google.com with SMTP id b15so1353749lfc.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 04:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TIZSxEqICxQETWAsSg7biuuXGcfw3yu6sTbolexyQEI=;
        b=flaLEU0j4Im4w/xAgm6LxaDp0XjnIlfbUObgsaisiu207aH8J5jPez1rm8Qudy6Xzm
         68ObGcPxMMcPsa/EMVmYgm5kSB4MlfoTaMqZEE8v79Evn+ptOfwjwf7IDGNvwHZeLk0K
         6YyP8GU4S+sgf/n/+/pNhHaGLbesRA9ZVTMxBGwRV3fHiW477pngUajYwK+XTNXCg4Ht
         cIq9/WZoxRR1jmTJEMT6RRzmsp3c6YFG7muwPsO+8LhdVQzzFC+DahrXC7wToarg01pj
         ZhJ00ojm54JcfVtAObfpIRjP3b+RvK5KylZsAFKhX8mKDkMoLYp05Gs7L/3ZyyxNLWzz
         paug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TIZSxEqICxQETWAsSg7biuuXGcfw3yu6sTbolexyQEI=;
        b=i7LxwQjy3uWqyzAZ2n9KMU3jR9h2TDX4xKjv+h/5I04JVj9dVyijBHd3AgrbgpFDDR
         wcJEuc9lTnlNjDdLGG8rd6qCiv1oM/Fl25OZ7NdpBAZm2lQcu1P9V1a+hFyNgzwLaZ8o
         AOGJdWYPJ5XmGDEzp9nLGZCa6v7BDgMvLiubEi7XjjGgfqlEl5UgD63pjfXTwfC68JAm
         /rvBLIHKwRAHomc0EM9nvFHozq6wpumd2IWUHO+YFXvQ5zs1v1Zh3kScCHIWn7UBNILR
         VUgUiEGBjXahOnOlTarxnxX6qMV1ip02m1MQzaqK7PoyVUNUZgvRfBft0KHAWXXmdCmv
         kiew==
X-Gm-Message-State: APjAAAUud54AlB85UTBJrH2U9pT0E0zF459/Ki0VbbdoIQESKU7j7h2C
        o15uCrV1xyVlqKqbYA7kXA063w==
X-Google-Smtp-Source: APXvYqwCGtBM1ilj7fS/22gI6FqN4kqqSRuZkmu/XAUS5IezK+0lNwoLD3chyi3De6oxVlnghDDoOQ==
X-Received: by 2002:a19:6742:: with SMTP id e2mr19903630lfj.1.1582287798086;
        Fri, 21 Feb 2020 04:23:18 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id k24sm1862501ljj.27.2020.02.21.04.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 04:23:17 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 3AE7B100FC3; Fri, 21 Feb 2020 15:23:47 +0300 (+03)
Date:   Fri, 21 Feb 2020 15:23:47 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH v6 1/2] mm: Add MREMAP_DONTUNMAP to mremap().
Message-ID: <20200221122347.vlw6r7felchtcxgq@box>
References: <20200218173221.237674-1-bgeffon@google.com>
 <20200220115744.ummq6j5ejp5qojic@box>
 <CADyq12y2uJh2ROBajA1D5H6OLEyFrKKEXH=yQC-8ELF0+UiNzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyq12y2uJh2ROBajA1D5H6OLEyFrKKEXH=yQC-8ELF0+UiNzw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 03:55:53PM -0800, Brian Geffon wrote:
> Hi Kirill,
> 
> > I have hard time understanding the case when new_len != old_len.
> >
> > Correct me if I'm wrong, but looks like that you change the size of old
> > mapping to be the new_len and then create a new of the same new_len.
> >
> > This doesn't look right to me.
> >
> > In my opinion, MREMAP_DONTUNMAP has to leave the old mapping intact. And
> > create the new mapping adjusted to the new_len.
> >
> > Other option is to force new_len == old_len if MREMAP_DONTUNMAP is
> > specified. It would simplify the implementation. And I don't see why
> > anybody would really want anything else.
> 
> I had been approaching this as, "do what mremap would have done in
> this situation except skip the last step." Meaning, whatever the final
> state of the old mapping was MREMAP_DONTUNMAP meant that you should
> just not do the unmap operation on the old mapping at the end. But I
> understand why it's confusing, especially when in the case of the VMA
> growing you're left with the old vma of size old_len and the new_vma
> of size new_len but only containing old_len worth of pages.
> Personally, I don't think this is a problem having that behavior
> because it can be documented and it just adds a small amount of
> flexibility.
> 
> Nonetheless, I agree with you and I also cannot come up with a
> situation where you'd actually want to do this so I'm willing to
> restrict it to old_len == new_len and return -EINVAL if not, it
> simplifies it a bit and accounting becomes a easier because the
> outcome is always the same two mappings of size old_len and the size
> of the locked_vm never changes. We can always allow the resize
> operation later if there becomes a need. If everyone is okay with this
> restriction I can send a new patch.

If anyone would want to chagne size it can be archived by followup
mremap() operations. There's no need in one-shot operation.

-- 
 Kirill A. Shutemov
