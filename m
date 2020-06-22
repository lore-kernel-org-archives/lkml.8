Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989F8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7494F20767
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592843543;
	bh=xRxDJuYU0wC2AVWHXzeBuevs3Gxc+NCyaqITdEVBO38=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2ofdNB8byVcYES5FHJnAU3TImqN/o2whwYPQppHxjj2+2QCOxUGbnEZ2Ro6UVR2NH
	 X8OP3toX61MVUoI+E+gx6xMqdzluMQFnwmG5JB0fFdg71PAhk9hvZ9YU8S2aFwQkd4
	 7rZ/vWI7t1vREYkPQ4wAL3yVHs5BsuX9T27OJH5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbgFVQcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 12:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729438AbgFVQcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 12:32:21 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D0AC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 09:32:20 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 9so20040771ljv.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 09:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TV9vbk2srZd0i6ieR89D2XCZp2Oy3hSU0itcsj4ofg8=;
        b=JPzybZthSg1toEDZXkxqiJgE55OU7mI6WORVXw3g2Mm8e2WJXoZLGP8rDgvvkpas8y
         jaiRzJb5zTdTyXw75RB0rvpiAteBIkkg2rm8Xc4VriNk+N95AD443ACer69TnOeQp5tn
         ohZMfZLjiLHaef4fjK1xhfQyNq+NhroN+hwrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TV9vbk2srZd0i6ieR89D2XCZp2Oy3hSU0itcsj4ofg8=;
        b=GTQ23i5w6EAf13dXrm+xczH67ki0alLDjXOu8I6LuDUetX0i0hE+f3mJxjuHDsob1s
         R082APIxYZe+0L/MkJ1lA37gxgZGNfq8Y7Qc1joUXTwGLBfzsZtK5dZBgXwPaX12sAQ4
         2hbRs7gs+6gW7HY0acGNFIYBqSmM9lwkf87Ja+tzM+j8qTkqZr3s7IY317w8zOYGM1nu
         d/rvvJDzKG88AbbsezyQTSWQSTHMnNgCPAyg2yota3fH9FW61/diJ9GSoAoMuhVxm7l2
         iz6GahX40SibqzqCxYEr6GmmLuwo0oucvApEUTnXrah61Za1G7lQoo2F6vrtz2zq607r
         ljFA==
X-Gm-Message-State: AOAM532DciZbmD/z+X9dLRbg4LDXLdEXhXz7tbz0nGRP09MpndKxMNhh
        68E2P29MWXBBc54gRfuqVXdrbr9FZbM=
X-Google-Smtp-Source: ABdhPJw1m6joQwBuGifZ1mEzmcB6olqZrUqKH3IONC+STPlwtvGLJkgluK9UQQO0xh0XsU1uRhYUeQ==
X-Received: by 2002:a2e:b0db:: with SMTP id g27mr9066160ljl.425.1592843538434;
        Mon, 22 Jun 2020 09:32:18 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id a27sm2788264ljn.58.2020.06.22.09.32.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 09:32:17 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id i3so20080245ljg.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 09:32:17 -0700 (PDT)
X-Received: by 2002:a2e:b5d7:: with SMTP id g23mr8480791ljn.70.1592843536797;
 Mon, 22 Jun 2020 09:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <87pn9u6h8c.fsf@x220.int.ebiederm.org> <87k1026h4x.fsf@x220.int.ebiederm.org>
 <CAHk-=wgczNRMP-DK3Ga-e_HXvZMBbQNxthdGt=MqMZ0CFDHHcg@mail.gmail.com> <87eeq7xebo.fsf@x220.int.ebiederm.org>
In-Reply-To: <87eeq7xebo.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 Jun 2020 09:32:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiiwWj9CKYvdKqLtOivozqwowcGXxQL6yhPC+euHa5j2Q@mail.gmail.com>
Message-ID: <CAHk-=wiiwWj9CKYvdKqLtOivozqwowcGXxQL6yhPC+euHa5j2Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] exec: Don't set group_exit_task during a coredump
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 9:24 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Why do you think the test sig->group_exit_task != NULL should be removed
> for the commit to make sense?

Because that's what your commit message _said_.

It still implies that with your changed language.

And honestly, wouldn't it be a lot more understandable if the state
was tracked with a single variable? The whole point of this series has
been "clarify exec".

So let's clarify it. There aren't that many places that set
sig->group_exit_task (whether renamed or not). How about we just
change _all_ of those to set 'sig->flags', and really clarify things?

                 Linus
