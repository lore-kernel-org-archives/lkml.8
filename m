Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8246AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 17:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60F1620737
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 17:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598548453;
	bh=ShZS58tdF66Xh9vTndGLo4aEfl1xq/VIGApEobqKDXU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=y+Yl9+F1dQeH6PJ8+8fDgve5GJrWSDMkFlcJQkbzLDNm1CZh5N95vBouqAEHTFGFj
	 MAmbthsFCd/F36c4MuHxqd2kklaNmZmWKtmzKkKiBurXeFuLa514NvwQkYIrgXwfMT
	 zOc1Dq6C2jkDUgkLSv6uc76OFugRO/OqKWI3AG44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgH0ROL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 13:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgH0ROJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 13:14:09 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595ECC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 10:14:09 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id g6so7262741ljn.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 10:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M4prkjP1Ku3b1Mujmm7MQBoZsalaGZICkCWqtSa9I0Q=;
        b=PSw0ZaM0WvUn6MpwD6It0gaG27/wObSq1kVFCBecFjxl05M3hm/lJJJSvazPfJVOQT
         cjVnniEJR+1KQCr4oYfPbro+6zzdFrXrfxKFeKe1p1C/CgSLgLHArfWn+EP8lW7qYQ49
         w0N1GHWVrfxOkaIDPpbVBPi4jLmvTyf7sMt34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M4prkjP1Ku3b1Mujmm7MQBoZsalaGZICkCWqtSa9I0Q=;
        b=fp8XE6ZIAWl6oMpsgpm2PyLuHaG8bhgFZJTItdQc4IGVKqnTAEp+6R+tBN/3DXF+W2
         bQ9Fs29M4Yz2Ip910tsMng4oaeQvlCbgJAClGfVpp7U6O9WXOQUbm9VKO7mezWW62hJK
         i1zx6OWiZCSK4Em9f76hU1iVa5GTTeRfVjYiQzPZvPg9PUB52rBEluTw14hGO1kZ50LS
         Ur6FtDyZy47qQVcWjDfXADD6aM9ZX8A7RuW07UQ51qd/RKjNfua/RbXblVNrlqCQqLa7
         /eaU6dsFe8MqEyO9YbSBjMN3JV7zm8gJI2yN9yLprjOLnnATl56ULoyVz5FBKmmn1CX6
         EmBg==
X-Gm-Message-State: AOAM531yaBsLtAo3Fi7MV2sDjVAaElCLgm7LP0BwldA4Vg3Bl8TSIFlO
        Hi60CvH3s6hTCwpxEkwl+jJnpgmiAImZog==
X-Google-Smtp-Source: ABdhPJyoAoJLbtRhhFBHIRtoMEuH1r2E/aCCwQzLeEMRnp8rrenfMsMzNId3VvXkpdvTOP3r5iVNFg==
X-Received: by 2002:a2e:9e4e:: with SMTP id g14mr2704601ljk.450.1598548447514;
        Thu, 27 Aug 2020 10:14:07 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id 29sm596944ljv.72.2020.08.27.10.14.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 10:14:07 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id i10so7318348ljn.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 10:14:06 -0700 (PDT)
X-Received: by 2002:a05:651c:503:: with SMTP id o3mr10986895ljp.312.1598548445374;
 Thu, 27 Aug 2020 10:14:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200827114932.3572699-1-jannh@google.com> <20200827114932.3572699-7-jannh@google.com>
In-Reply-To: <20200827114932.3572699-7-jannh@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Aug 2020 10:13:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj=QXUkKXLzyWxJ49L80Heu2Z_RoHSahRt+zPq8W4du=g@mail.gmail.com>
Message-ID: <CAHk-=wj=QXUkKXLzyWxJ49L80Heu2Z_RoHSahRt+zPq8W4du=g@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] mm/gup: Take mmap_lock in get_dump_page()
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 4:50 AM Jann Horn <jannh@google.com> wrote:
>
> Properly take the mmap_lock before calling into the GUP code from
> get_dump_page(); and play nice, allowing the GUP code to drop the mmap_lock
> if it has to sleep.

Hmm. Of all the patches in the series, this simple one is now the only
one I feel makes for ugly code. Certainly not uglier than it used to
be,  but also not as pretty as it could be..

I think you're pretty much just re-implementing
get_user_pages_unlocked(), aren't you?

There are differences - you use mmap_read_lock_killable(), for
example. But I think get_user_pages_unlocked() should too.

The other difference is that you don't set FOLL_TOUCH. So it's not
*exactly* the same thing, but it's close enough that I get the feeling
that this should be cleaned up to use a common helper between the two.

That said, I suspect that falls under the heading of "future cleanup".
I don't think there's any need to re-spin this series for this, it's
just the only slightly negative reaction I had for the whole series
now.

                 Linus
