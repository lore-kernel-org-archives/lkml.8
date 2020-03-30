Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC5EC2D0F0
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00EAB20771
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585607285;
	bh=F/zp406/fsE4ruRPq2jZWsW1yzqweN5tKhcb/NQFXXk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IoQH/TFYWz1/AleG93V4nz3M8XA1fmy+G6Rt73wt65ERKnH3d9pE3Pf7qompMpFxV
	 IMQwhTF96f4oJorlskEQ4UYyE9n/MMo20bZ4+80bpqd/w5jzzShgHJMbC76MzWsxD7
	 JHkKVnruRaOGyyIRl4NG65bNQ9VXOSnmuIUpRYZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgC3W2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 18:28:03 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38330 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728980AbgC3W2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 18:28:03 -0400
Received: by mail-lj1-f193.google.com with SMTP id w1so19886137ljh.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 15:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9xJXkRShIw9WgOqBCHeFKsSXZRGj0KeqvyNceVAQ38U=;
        b=egjH8Qp8DEHoukQZETeJK0y19v9Qnw8BqRqy6nkQJlj3TGJ8FWYvzd85grCYYAhjv6
         yjiN/YkYH1qVU/GALP+dPTWZCpFIbyJy3lIFCA3WoPc2/oknZLWt8Sur/O4bocLgcjo5
         45Mwdd5jIy0JZEFgAM+p8VJZx+evSCo52vbYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9xJXkRShIw9WgOqBCHeFKsSXZRGj0KeqvyNceVAQ38U=;
        b=T3KX1H5bM5o8qCAcEErZpME+Y9I8Fyy+B5ELLemgBE4h31UOnulTrmFaS/3Bc7OKsz
         5NkFk3s2yOJSiKkmzyLH3NIRMpmyf3RshbgSQ/yMBzaBV26nXpsOZJTWrOB3g9w93haE
         2I95QRm6+bL7aRCZX+5bfmuFwOUmcMCEf3fXuuBCRxAt4ULYjA0u8+wbJogXFEIpBf5X
         lc0eUdD8wapAFZqA1CMZkJPB+We8iUhgZSk+PvNt0z0wv+u4EUOSXB6b5YTKs5SE2vRz
         Qo6OAvhT/Gpo/SrejaaomyNW0BwIJ9fRT+gmnCg5Glqjd114bmCvJ/nyf6W83utc3+XC
         NPxA==
X-Gm-Message-State: AGi0Pub377fQxDw9Avm2q2juAO9VLYGdvRexX3UP1iEt/9OFJGierWxj
        +KdvCEmTiulucm1cbdWRd/5xIywMP08=
X-Google-Smtp-Source: APiQypI1UY8Z1UjM0AiUgpKhN4oYj9yhCBAGs2i3ETSLb3w2LN4uxtSA4Ch1lDseLWfhCP2Cqg6uUw==
X-Received: by 2002:a2e:7606:: with SMTP id r6mr8103829ljc.118.1585607279900;
        Mon, 30 Mar 2020 15:27:59 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id y3sm6385646ljh.15.2020.03.30.15.27.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2020 15:27:58 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id f20so19945939ljm.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 15:27:58 -0700 (PDT)
X-Received: by 2002:a2e:b4cb:: with SMTP id r11mr8652748ljm.201.1585607278073;
 Mon, 30 Mar 2020 15:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wj1K5rsyoPps3H5QW_KOxtDQ8zPJ-bc-BmYjT4jXU_7Og@mail.gmail.com>
 <F45052AF-D619-4993-AFF4-1E417C3BF424@redhat.com> <20200330151441.e3a704f7c98dc70cdce95d0e@linux-foundation.org>
In-Reply-To: <20200330151441.e3a704f7c98dc70cdce95d0e@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Mar 2020 15:27:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjQCPE1nh8ZoQZzXV8taV9nttsBp=4FQG8OL=L5fuWZXw@mail.gmail.com>
Message-ID: <CAHk-=wjQCPE1nh8ZoQZzXV8taV9nttsBp=4FQG8OL=L5fuWZXw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm/memory_hotplug: simplify calculation of number
 of pages in __remove_pages()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>, Baoquan He <bhe@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richardw.yang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 3:14 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> My nightly check-all-the-patches-for-various-cruft script emails me
> about =3D but I didn't' have a test for "o=$m".  I just added one.

=3D may be the common one, but =20 and =09 are others that end up
showing up when whitespace gets quoted for various reasons.

Another one is =46 for 'F'. Why? Because some mailers think that
"From" at the beginning of a line is the mbox beginning marker, and
they'll escape any line that begins with "From" to use "=46rom"
instead.

Those mailers are wrong (at a _minimum_ it's "From " with a space, and
you generally should be even stricter than that), but it happens.

And obviously, if there is real 8-bit stuff, you'll get all the real
odd hex noise.

               Linus
