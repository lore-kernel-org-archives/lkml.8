Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EA3C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 21:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9173924960
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 21:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LTTvgtHC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbgEEVsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 17:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbgEEVsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 17:48:35 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFA2C061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 14:48:35 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id f7so1570191pfa.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 14:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p9AA4xWTEKVxtYf0LEjgHn4IlPJGCm4GiDnieohbszo=;
        b=LTTvgtHC4JiLx7JtcwOPPwfX0mrW2kj4it8w+R4Lvse+xpXov4Nu/KnoEDB88lKNeb
         ofz0/oCODff07j7/iKEf1YmjweawTfDF1AKu+vayz/Z70kg1ej87mRy8ighAHzr2aLtC
         9CQrwgQWh1fVUPndxsDXGd5O875olXB0+CvE9Meeap1g8LkGxfeMrl9/3AeNwqN09Df1
         e5ahNp8jRJJFO4oDfwaVacmI8cEYK9YMs+cSQ9HT6RCY/3adIKroOWylzUk3flv1yg8N
         RHjgctXIMhTHGrQqUkZfXTscNaIviePPZtozc4T9EnoKHqt9+4dcsfNSMxlKIz0JI876
         tb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p9AA4xWTEKVxtYf0LEjgHn4IlPJGCm4GiDnieohbszo=;
        b=SuKok/AEvsIENGfbY6z90d8ai4043HEz4tyLbXN4SK+pvFYlPXAQV38QLuEfYPbXCe
         gwLmVflcUrJ4UasuqjEDuwBXI0iYG2kGPnmCcM/daeoXIXp3aan+xMRi4UQO7RvwgpFo
         r3q5SU76CvoP4BKphxzFaGKxMhE5RAm/DnrUKZRzfl7SIyO+vqZV00BD23R90rkGPPRw
         3/2NIse7S6c8L/mEOl/6uUTYVKRgV+Idx6xNfsO/BJ5arBY86SbDUF/Vbc8n7GT0pWx0
         c/i7dgDVnAmAg6DKw0dBkqImSbGEKZrd4tvUbTEOUGW9+xEEwjbaUOeRuRwrVokFSZfp
         AyNA==
X-Gm-Message-State: AGi0PuaOZQ1madBthpbpO7jov1UeGeCiouAjSpnCh8FB6cfCb5LfBpsx
        WiyQPlQe5ZIgMDSDIZUSf342gan+AYgnWM5D0n72dQ==
X-Google-Smtp-Source: APiQypL6vp3+P4v2jpiQP1jQx9T5145MG0xmE+mzySNqHUdz9VoF1KT0zZt3tC16kPH1BLKmfd5MAIbH0UssbNRhMIc=
X-Received: by 2002:a62:146:: with SMTP id 67mr5115544pfb.169.1588715314449;
 Tue, 05 May 2020 14:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200505135947.216022-1-arnd@arndb.de> <CAHmME9oMcfY4nwkknwN9c4rB-O7xD4GCAOFPoZCbdnq=034=Vw@mail.gmail.com>
In-Reply-To: <CAHmME9oMcfY4nwkknwN9c4rB-O7xD4GCAOFPoZCbdnq=034=Vw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 5 May 2020 14:48:23 -0700
Message-ID: <CAKwvOd=OiMUfbNVzQ-Z-bLrsqvPKgG867NBX379rzop62TB0-g@mail.gmail.com>
Subject: Re: [PATCH] crypto: curve25519-hacl64 - Disable fortify-source for clang-10
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        George Burgess <gbiv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Kees, George, who have started looking into this, too.

On Tue, May 5, 2020 at 2:40 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> As discussed on IRC, this issue here isn't specific to this file, but
> rather fortify source has some serious issues on clang-10, everywhere
> in the kernel, and we should probably disable it globally for this
> clang version. I'll follow up with some more info in a different
> patch.
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/CAHmME9oMcfY4nwkknwN9c4rB-O7xD4GCAOFPoZCbdnq%3D034%3DVw%40mail.gmail.com.



-- 
Thanks,
~Nick Desaulniers
