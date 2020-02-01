Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A934C33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 21:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1047B2064C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 21:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bcQ8FHSY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgBAVEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 16:04:05 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42952 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgBAVEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 16:04:05 -0500
Received: by mail-ed1-f67.google.com with SMTP id e10so11761471edv.9
        for <linux-kernel@vger.kernel.org>; Sat, 01 Feb 2020 13:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+5xWGlvNfGW6R2a9oEMXO5Vtc+knDhZupxtbrwKUTXo=;
        b=bcQ8FHSYBBwSb81QiCF/CKbYbzpf1tXxm8vOpxbJAF12nriUjGMwkVIFbp0mq+2rZG
         7ruF44t2Z0ZSJLH2D/5kxkD17Zv66LgSg4AT4ERgBhAcALe4zS9ENkDobSB5jFoGejpC
         pQaI3ZXFRujxGKy665W4vaewcvoTNCGXu5WiO5DNXBDrHJj3QCyHYMVbfAkDLwa+/ENY
         kiFMORLakKwn7OrqDVWnjKtbwqeKx9W4jVQJiwmND89XzgFMJnztVcVqAx+mOUvXUgvp
         shvkhry3P/mJdC6lcxeQVqFmzSGh6vfViT5i8wIg1CbwMM5Na8ih7Ei5050pBuPCb3fw
         BsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+5xWGlvNfGW6R2a9oEMXO5Vtc+knDhZupxtbrwKUTXo=;
        b=H7AkzEMADw3Fxrgq5ofdTwraxwTLRYwF2ZgjHK6frMy/hGXM9NgzYkygibS3Dw9fa1
         /ovhx8ip9AM0giQgtScy5L9nHOSorNteS1JQyiQ6pDS/iSmHmmwDCMSYPHZIflOBAnAs
         yLO3r6piWJiysHjEX9yS8kpECaMrdH7hPkUoBC8/uYj9hWbMw8iBz+hiUaMUsGXp0xtO
         Wfg3lcvEZVHrmHjQh4c3nRhEdApHkoPTECXb7IQBgKqTk9vBcMXV2W7mRiDCtIuMneDR
         MyBjzfhdPX3iCg6Zbr/LZ4fjLxBfAYba9fWFqFsSILPHMNY7Sb3oibw079wA8EuT7enP
         2J/g==
X-Gm-Message-State: APjAAAVyp5O7VH0oJ9/sW9UAvP6rDsotb5SGXWR+U97mJLiqSlyxcL5J
        Ja9+N4i5JrF3vchx4f+X94R6JzjldrE1cwxLjAVNqQ==
X-Google-Smtp-Source: APXvYqyeuHjcmV/Xzo4whsXR8bzA6nBXfklcpdG29SfmnlxREzB00zSM/PJfdcDHg+A5M772ODl1DKNwwX3tVsLcNjg=
X-Received: by 2002:a05:6402:2037:: with SMTP id ay23mr5935349edb.146.1580591043082;
 Sat, 01 Feb 2020 13:04:03 -0800 (PST)
MIME-Version: 1.0
References: <20200123014627.71720-1-bgeffon@google.com> <20200124190625.257659-1-bgeffon@google.com>
 <20200126220650.i4lwljpvohpgvsi2@box> <CADyq12xCK_3MhGi88Am5P6DVZvrW8vqtyJMHO0zjNhvhYegm1w@mail.gmail.com>
 <20200129104655.egvpavc2tzozlbqe@box>
In-Reply-To: <20200129104655.egvpavc2tzozlbqe@box>
From:   Brian Geffon <bgeffon@google.com>
Date:   Sat, 1 Feb 2020 22:03:37 +0100
Message-ID: <CADyq12ysX9Ce+CUr=Cs-LcYrJDeYubDfZy2-GYFHAz111J8QBA@mail.gmail.com>
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

Hi Kirill,

On Wed, Jan 29, 2020 at 11:46 AM Kirill A. Shutemov
<kirill@shutemov.name> wrote:
> And based on the use case you probably don't really need 'fixed'
> semantics all the time. The user should be fine with moving the mapping
> *somewhere*, not neccessary to the given address

This is true and and it simplifies things a bit as for the outlined
use cases the user would not be required to mmap the destination
before hand. Part of the reason I chose to require MREMAP_FIXED was
because mremap need not move the mapping if it can shrink/grow in
place and it seemed a bit awkward to have "MUSTMOVE" behavior without
MAP_FIXED. I'll make this change to drop the requirement on
MREMAP_FIXED in my next patch.

> BTW, name of the flag is confusing. My initial reaction was that it is
> variant of MREMAP_FIXED that does't anything at the target address.
> Like MAP_FIXED vs. MAP_FIXED_NOREPLACE.
>
> Any better options for the flag name? (I have none)

I see your point. Perhaps MREMAP_MOVEPAGES or MREMAP_KEEP_SOURCE? I
struggle to come up with a single name that encapsulates this behavior
but I'll try to think of other ideas before I mail the next patch.
Given that we will drop the requirement on MREMAP_FIXED, perhaps
MOVEPAGES is the better option as it captures that the mapping WILL be
moved?

Thanks again for taking the time to look at this.

Best,
Brian
