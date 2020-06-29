Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41F0C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4FC920723
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593458655;
	bh=t+jY07XNh+thgu5bisabM+HXsq7RXdEQ5alGWqjDOzE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QE3WM0otrteec9DAfaEzp1NWp4ZrQ8zWRyFvcCUy/+cBSTPo32FWqbxcrQfx3Rpf8
	 3xnaIPdWZzbvYubIXeYomF/v+q1G1hM5mxB5XwDAd6uXU5G9yOPe+UJqUfoCu7l7K5
	 ldgMTa64OO+jKrfvPsP8MWSjC626urkhr2E3fHec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732275AbgF2TYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732338AbgF2TXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:23:54 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6BCC03E97A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 12:23:53 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id m26so9798354lfo.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 12:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mkLALwEBsfgrF/H397Lx9Gt+sC05sJ13vZdNeAjTZ5E=;
        b=FPlpwVAPUFD3v6bVUhip7cfhfzuueSDNYo7W0SMPvHcy6jzZIQis6GYHuGsYXXfKf3
         ALP2bWjkMLoY3aUn94tO9sMxLR4uZyaVnIgdqw+dVS0hN08AsAYTmLgAbVhQzlDndEU7
         PR1/ytPMFHpUV9rh2wieVICotA43fZMtUaYFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mkLALwEBsfgrF/H397Lx9Gt+sC05sJ13vZdNeAjTZ5E=;
        b=QdCim9pha63doSfYZ32MuHN6qPPpz2UvNqgv1xV4Rou9t5a6JUV78sS0HJNpbVH+v2
         ANX9wgSi0BOyx2N/yymd1Li6luov3Wxr+8Xr0wa3ahww2Px40ny1IYluYzN0iiB0D5FW
         MwIPXaU1CC05/UGh1NVxj8/aymzHoXp4biMH0oUe5rkBg+9tCkLPXCoVXB721AGm++HS
         WnQcwrOP2zT4SHX5Mc+WPOGNKnd5YomuBZYzuwlpscr8u71WMlTwfsU6jrRE+YYU+qdj
         LKauzXPJfvmtvhzbiTaRV7La0eOct/qd0vYSmYa0N6ye1cP5TUA8q07ts4znFzf1j/m7
         u8sg==
X-Gm-Message-State: AOAM533Lq7lck5oct6N26YN0eA+njKcqBXFqpaukrwx0xIvuNvkAcjMf
        Tc4vqwYf+b0rWxNKOYHvv4KU97dnj28=
X-Google-Smtp-Source: ABdhPJxRdmNXNYpVZbZVyipV2r66AuVsrUbiO2vrAw6WUzsH0YTxo8dw+RDUxmJBmBPIfeVCKG7qtw==
X-Received: by 2002:ac2:521a:: with SMTP id a26mr9888743lfl.192.1593458631976;
        Mon, 29 Jun 2020 12:23:51 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id a12sm147350ljb.92.2020.06.29.12.23.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 12:23:51 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id d17so4826521ljl.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 12:23:50 -0700 (PDT)
X-Received: by 2002:a05:651c:1b6:: with SMTP id c22mr6878545ljn.421.1593458630544;
 Mon, 29 Jun 2020 12:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200629182349.GA2786714@ZenIV.linux.org.uk> <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
 <20200629182628.529995-18-viro@ZenIV.linux.org.uk>
In-Reply-To: <20200629182628.529995-18-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Jun 2020 12:23:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjd5HML-EuPGH7J8CjWJrbnMhst3NJbcUyt-P0RV649nA@mail.gmail.com>
Message-ID: <CAHk-=wjd5HML-EuPGH7J8CjWJrbnMhst3NJbcUyt-P0RV649nA@mail.gmail.com>
Subject: Re: [PATCH 18/41] regset: new method and helpers for it
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 11:28 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> ->get2() takes task+regset+buffer, returns the amount of free space
> left in the buffer on success and -E... on error.

Can we please give it a better name than "get2"?

That's not a great name to begin with, and it's a completely
nonsensical name by the end of this series when you've removed the
original "get" function.

So either:

 (a) add one final patch to rename "get2" all back to "get" after you
got rid of the old "get"

 (b) or just call it something better to begin with. Maybe just
"get_regset" instead?

I'd prefer (b) just because I think it will be a lot clearer if we
ever end up having old patches forward-ported (or, more likely,
newpatches back-ported), so having a "get" function that changed
semantics but got back the old name sounds bad to me.

Other than that, I can't really argue with the numbers:

 41 files changed, 1368 insertions(+), 2347 deletions(-)

looks good to me, and the code seems more understandable.

But I only scanned the individual patches, maybe I missed some other horror.

               Linus
