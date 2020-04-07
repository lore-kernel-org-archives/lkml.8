Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7902C2BB55
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD0F2063A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="rq6AiC7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgDGMWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 08:22:42 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:34458 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbgDGMWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 08:22:42 -0400
Received: by mail-vs1-f68.google.com with SMTP id b5so2048752vsb.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 05:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z511MDYhv4o+xquNAW2DROMbGPhQBRu4/JH0RaTSkLw=;
        b=rq6AiC7dwdXCobVOO+f+WNp1k+3JC8UWM9UFQqKhPm1K0hzAOn92rvaQ0LXCwMHysB
         0SxkT3AujfliCTQxZyyNA/na195T1BDWVlt6CfMVBpe3NryLSdp8m0sujbYkOTD4gcvc
         2ZF2+QsUuU+iVep3ZE9aJca+iEiaIf9yXU49eYBazU0cohQt7SHKPLigGiIDR5obOKUm
         0Dlaq3eiSq7Vl5CGwOaCXpMq7jm78RfvLt2+7l+JBRwp/qAsOWxZFrMlYVR28MGKM4iC
         C5FScwHdCdIpS/eGIDFUR8j5JRZwvn0ETfPjZYZOLimGajlHKPFiwRqdHCLf2PUIC8KZ
         e3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z511MDYhv4o+xquNAW2DROMbGPhQBRu4/JH0RaTSkLw=;
        b=XtdPeBkot9cMd3Eci2GkBxRIqY5xzKSkKZk0a4olqCH49pA70ejp+1kOr+zMVhONVL
         iK0RXvb3STQ/hDL/OWjPNHV1L5chB9aOdbv5t1onwylrjjxwK+2u0KaHc31oFMwCr26Y
         aG5Uvh2CFCk2RIZJlgnKERTdBdTlPbbcPCSFQpS2XIAEQEF5JQ44pOboSUhVMpwfbfvn
         hCew7o+Zh7V0AyMV9DW7J4imd4kjxnOtan0wn5O22rokglulpBp4s8BmTI4dWErkPYtp
         iqfeOPowkF+dzF33RrXHjMvTwnuuTFSzFKsgCsEHXsCTh6NJ7kF9s++W5svQ+/BCGHMb
         HkGw==
X-Gm-Message-State: AGi0PuaXOm3bFNC9ZMH9QPVU4nL38aCq+251XeWxiaeeGU2pchYFoSl9
        UcyqJPZJgiIRSUWsPQvKYemtFqGK4PYLyhtT2MKplC3i
X-Google-Smtp-Source: APiQypJOloediqTcP7bVJrSj3o2Nu6Q5oLyGH8q9e/MG+HlSs5+WgZ/5WabTTYh0HGGAyMoVlmBWh0gWQ1bGQpAECuQ=
X-Received: by 2002:a67:80d6:: with SMTP id b205mr1428650vsd.137.1586262160955;
 Tue, 07 Apr 2020 05:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200407075207.0bfc0e71@canb.auug.org.au>
In-Reply-To: <20200407075207.0bfc0e71@canb.auug.org.au>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Tue, 7 Apr 2020 08:22:29 -0400
Message-ID: <CAOg9mSQEeQQbt2v-fsO6xg-TJS7oucZZp4C2kbozfNvFjtFL8Q@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the orangefs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixed, thanks...

-Mike

On Mon, Apr 6, 2020 at 5:52 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Commits
>
>   aa8891f95484 ("orangefs: don't mess with I_DIRTY_TIMES in orangefs_flush")
>   4501ab590e3c ("Revert "orangefs: remember count when reading."")
>
> are missing a Signed-off-by from their committer.
>
> --
> Cheers,
> Stephen Rothwell
