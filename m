Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD50C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 18:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A853520702
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 18:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rMfvEh8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbgAZSix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 13:38:53 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37416 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgAZSix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 13:38:53 -0500
Received: by mail-yw1-f67.google.com with SMTP id l5so3714118ywd.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jan 2020 10:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i69aVqNtUh0aH4/EUSRDvf/FER9Hz68ISkhaUxUzTl0=;
        b=rMfvEh8T4b186lRHcWlnCCdlJg9db7RjBiyF5TCaQz1NcahGJQ7eCMmDE/JxwOTl7b
         LHizr5TWq5uqwSzp8Xk0MsEgWlBAejc5L0ULiKQk/ZD9n2y0doi/z55xP00bj3yv3Ava
         L1t7HDea0d8F2i15NqsG2tcjSbJpeFciT4k6Js5l0jnPrIJaQ1FOAirbv1uves9uyh2Z
         o3144kE6biOVCtOgZVGZn6xIrQgN6laceEyhtJJnAEV5rVe9ujeKKBx7s3pYa1nxQgzf
         K2Sjc9L5ypLwirkXI9cgkeeANEbDCpTBHHhXM+dSdh4vjzNWV6apbmPXhJ3d+idb2OX+
         959g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i69aVqNtUh0aH4/EUSRDvf/FER9Hz68ISkhaUxUzTl0=;
        b=Eat9MpAO0OhHL5csVs5A6j3x2BjsUFWQB1bJWkGp3nyV4d585dGr1aw4a0hkhe3ytY
         /kBYJaTLKCHelKHc002SRQRkiiZk4/up1E3ZhqN2RUuKz1I5/xI1Q/1Si9O0U5KeL/vE
         fqDFJXcdNnjElClg5RATdbt5x170OJGJoSh0YpV+mIrc3/HATdduQMtzNmPyF8uP827C
         YPuI89b0KIii4gAcZOTFmcBZlMv3drgC8VSef26p6otz/wfEMgY862htIIjznz5MCto+
         FhCo4jolVi+E9C2JpTsHNzcZTtR+myrW6YEvrSZjTGtlirZcZfUzY4EvnJEcPWeMKuV6
         Gqlw==
X-Gm-Message-State: APjAAAUWSUZFPypav6WJeoS92JOTGnm/hCPRQXOdm0VFbZ0TNPTsbew6
        WgrBCNSgdC0X3kYcLScMZ0cfhU2ln+8jb24Chgd7Sejb
X-Google-Smtp-Source: APXvYqyWhEZHHYbOhHnC3t0Y6vH6sqNyRu0S2xuvfX0uCPx5pSn6uW89RhMOwvFd1iBNaWGKbGJxIM0/hZDazU7SBIc=
X-Received: by 2002:a81:53d7:: with SMTP id h206mr8970498ywb.92.1580063932400;
 Sun, 26 Jan 2020 10:38:52 -0800 (PST)
MIME-Version: 1.0
References: <20200124093047.008739095@linuxfoundation.org> <20200124093207.912523612@linuxfoundation.org>
 <20200126182917.GA26911@amd>
In-Reply-To: <20200126182917.GA26911@amd>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sun, 26 Jan 2020 10:38:41 -0800
Message-ID: <CANn89iKTYMT8T5tOPmk0j4emHt2gCbJD9Dpjf=5LR88zC1tu4A@mail.gmail.com>
Subject: Re: [PATCH 4.19 625/639] packet: fix data-race in fanout_flow_is_huge()
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2020 at 10:29 AM Pavel Machek <pavel@denx.de> wrote:
>
>
> > -     po->rollover->history[prandom_u32() % ROLLOVER_HLEN] = rxhash;
> > +     victim = prandom_u32() % ROLLOVER_HLEN;
> > +
> > +     /* Avoid dirtying the cache line if possible */
> > +     if (READ_ONCE(history[victim]) != rxhash)
> > +             WRITE_ONCE(history[victim], rxhash);
> > +
>
> Replacing simple asignment with if() is ... not nice and with all the
> "volatile" magic in _ONCE macros may not be win for
> everyone. [Actually, I don't think this is win here. This is not
> exactly hot path, is it?


This is a critical hot path, eg under DDOS attack.

>
> If this is going to get more common, should we get
> WRITE_ONCE_NONDIRTY() macro hiding the uglyness?
>

Sure, but we do not add macros for stable patches, usually.

Honestly, WRITE_ONCE_NONDIRTY() looks ugly to me.

Note that the KCSAN race might be solved in another way when
data_race() is available.
