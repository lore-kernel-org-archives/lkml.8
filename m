Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82307C3524A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 04:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588F920842
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 04:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BZ9+x4AU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgBBESY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 23:18:24 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40664 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgBBESY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 23:18:24 -0500
Received: by mail-ed1-f65.google.com with SMTP id p3so12400705edx.7
        for <linux-kernel@vger.kernel.org>; Sat, 01 Feb 2020 20:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UuEb10QAUcFcGwJKCFeGhLUYYwMKG3vOlYqSejkAJjc=;
        b=BZ9+x4AUIFJLiX/N1VBjRD80E1JAY6p+Ow1VTwbX6FGZWiklyuGDkrP0qeMciPsMUe
         8nTSaKr4Ho6/S7dW2SpMb/OZSIj7QcOWDEwMYH9REu0dT4ejNyJIPZbDM/NhReSGj4pW
         0F1tPaYk4DNXr3WnbLQ58PPhFJERk1lmkG/IK6NW0wEAsqpyEd1UQ7Ty1JL1Akh47bmN
         tF+Efol3wF29/cOHJt8lRHPpntXfHAZbLjNTGpINUaeSuWaHL5PYTdxO5Kg4v+zE+uWo
         aQd7vruF8DxQ/LOBHcs/1WTiM3K89c7fQpOzkqbwjA03mvKLkr+BDjefK9rnfrRqG2H5
         UqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UuEb10QAUcFcGwJKCFeGhLUYYwMKG3vOlYqSejkAJjc=;
        b=DvxqXrKeIs/bUFetRM8w5kbdxTppFrawXLpBmcKu28JJwhU09GQ1yN99CMNDINgCf3
         Q/MqpCaaK22HbSSMaALxv134REpvFnn9szN6RzLNYWM/tF+jAnfXumJtAAa1UFfu5HcE
         gIDuLE+F46P/T1sGtQiSJXzah1hOj7E5t51bB1co9ZTrLheGgGflLdL5tPd82gFaWZaA
         Kby7mp/4XaAI+Qe6P+678Veu0SVwgKPG7dWod75NmrZ3BoakPsSRu1B+ydAJcdIDH4Gk
         SWa3EEzuDS0Tnqw8XZtrmFkd0+S/KDzfHTsqY/f1Ejw3CKZOoGnT7RT3im+cFmjVfsEP
         9y/Q==
X-Gm-Message-State: APjAAAWgZLQyaeQMSXgvUMxBTEMu5TKlKj3OAogeofdwIUgAaFgEIK7E
        RKVangp1PCl5Kfal7De53LDq23/jVl0GPiwUx6IkAQ==
X-Google-Smtp-Source: APXvYqybtw5f2jTQcpV4gY36OnxNY8241JvcKkzJUpgAl0cx/UBNZIzQjpkYuf3EJT/Lyi67pPW/bR73IKtF1FLPUjE=
X-Received: by 2002:a17:906:82d6:: with SMTP id a22mr15774735ejy.242.1580617100799;
 Sat, 01 Feb 2020 20:18:20 -0800 (PST)
MIME-Version: 1.0
References: <20200123014627.71720-1-bgeffon@google.com> <20200124190625.257659-1-bgeffon@google.com>
 <20200126220650.i4lwljpvohpgvsi2@box> <CADyq12xCK_3MhGi88Am5P6DVZvrW8vqtyJMHO0zjNhvhYegm1w@mail.gmail.com>
 <20200129104655.egvpavc2tzozlbqe@box>
In-Reply-To: <20200129104655.egvpavc2tzozlbqe@box>
From:   Brian Geffon <bgeffon@google.com>
Date:   Sun, 2 Feb 2020 05:17:53 +0100
Message-ID: <CADyq12xgnVByYOkL=GcszYYKzDpg254QEOFoW8=e1y=bmOCcFQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Add MREMAP_DONTUNMAP to mremap().
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>, Jesse Barnes <jsbarnes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 11:46 AM Kirill A. Shutemov
<kirill@shutemov.name> wrote:
> Any better options for the flag name? (I have none)

The other option is that it's broken up into two new flags the first
MREMAP_MUSTMOVE which can be used regardless of whether or not you're
leaving the original mapping mapped. This would do exactly what it
describes: move the mapping to a new address with or without
MREMAP_FIXED, this keeps consistency with MAYMOVE.

The second flag would be the new MREMAP_DONTUNMAP flag which requires
MREMAP_MUSTMOVE, again with or without MREMAP_FIXED.

What are your thoughts on this?
