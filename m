Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30743C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DEA020663
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592418021;
	bh=UdImNF9CVVg1UNhJ4ElxHAZW1qQSELag9MN8jhP3aa4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DuyUkWAnFUJnnTC48yT+Jf0+s6RX/V0tDkD7y8fBr7qCdZgd1kuKIJQL220058pQU
	 XmI7tr6roFrkP11B8LAk9CnHcw5+tEi83fCxa9kwSep/Dx24onGt0+jvXuvuR48mrY
	 d7HIk0r5LNva1uF6myUQ034CmYdZldjPMqUKW2wY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgFQSUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 14:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgFQSUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 14:20:19 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE96AC06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 11:20:17 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id c17so4047075lji.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 11:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YJjGsZLVAH6zFj7eMPw4bY6tMOpJV4lrQZJ2vUrlsXs=;
        b=GaUZbrR8Ronlt8TNog9BlcCkj9ylVyk2hLPc/h5hmrh5aSzkQkyB26cdV0dDWZ2t+b
         b8ERcvj7ux3TrW1sixh+hfMHRHtPYPt9P3Bp7RrXeXTaLsTKq5kzJgf/OJfvs0fYOzcq
         o1bShH7aZgygaykEWzbIZ7zK8/7DXSNu2etoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YJjGsZLVAH6zFj7eMPw4bY6tMOpJV4lrQZJ2vUrlsXs=;
        b=rHjvCr3Fp8E0sIsHHO5vMMa6VVqACYkQs2nEHFOASDRBWhdkhsJfIUbzH+WURlmvL1
         U2WFK5+Vk9H4lgiwmIlqABc74ZZ/w1np5AV+EZLX84d+z2/xdvQGmepacpIdYlpt1q7N
         rF/O4v8yO0a5TMGjTzoN78njEM/05fYJK3pc6h/w1FYd8VNszummgpkxYKhCYHBkDBzp
         /IvfidgVYLtnkeCcgfsIBNYuS8PXhZ9r1zyKrb8+ESwlzur/ieKiWR0QYB4ZeLoWMRso
         EjWIfZPptps5QX14qh7KnQsR8/cx/9FKcGnX+uxs0MjkZCPx6nUHeE1bF0eifEH2g1wp
         zNWg==
X-Gm-Message-State: AOAM5305OuFp1GAB2XC4wPlvlJGL4UKbq7BSCXVoZ6Ga/Mf3OQbUZp03
        L2vkJzpv8SYzeZE23ycIIlXWC2QC3MY=
X-Google-Smtp-Source: ABdhPJw624ZMv0TqBR/t5vavmP7yR6JaB0GlqqgYkkru+wV1SA6SoEbAwlSwOPA5ct6Uva5Gr3koMA==
X-Received: by 2002:a2e:9755:: with SMTP id f21mr238829ljj.377.1592418015958;
        Wed, 17 Jun 2020 11:20:15 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id o201sm118899lff.8.2020.06.17.11.20.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 11:20:15 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id i3so4096752ljg.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 11:20:15 -0700 (PDT)
X-Received: by 2002:a2e:b5d9:: with SMTP id g25mr271473ljn.285.1592418014814;
 Wed, 17 Jun 2020 11:20:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200617073755.8068-1-hch@lst.de> <CAHk-=wjrogXehrGA8zymnyhD8OLWu9i7r46BgfuqJ28b9Ke-VQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjrogXehrGA8zymnyhD8OLWu9i7r46BgfuqJ28b9Ke-VQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 Jun 2020 11:19:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi+bj=CYNSOKRK7AFg32BBxHCeEWxWWxSggDE+wTGqtrg@mail.gmail.com>
Message-ID: <CAHk-=wi+bj=CYNSOKRK7AFg32BBxHCeEWxWWxSggDE+wTGqtrg@mail.gmail.com>
Subject: Re: rename probe_kernel_* and probe_user_*
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 11:11 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'm actually a bit surprised that we don't even get a warning for that
> horrible pattern that smells a bit like the gcc 'cast as lvalue'
> thing.

Oh, it's because I once again got confused by the naming.

"get_kernel_nofault()" doesn't have the "get_user()" semantics despite
being written like it. The arguments are in the reverse order, and the
pointer cast is on the address, not the target.

It's more obvious in the code, but not when grepping for things and
being used to the (much MUCH more common) get_user() semantics.

I really think get_kernel_nofault() should reverse the order of
arguments, because right now that "[PATCH 3/3] maccess: rename
probe_kernel_address to get_kernel_nofault" is really really
confusing.

You rename the function to look and act like get_user() (except for
kernel accesses, of course), but you leave it with an argument order
that is very much the reverse of what get_user() has.

So no. I won't be merging this series after all.

           Linus
