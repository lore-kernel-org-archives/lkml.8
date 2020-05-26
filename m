Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89E8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9ACB20870
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590528751;
	bh=hzpAMm6GNwKwC8RuiexegDiwWWnK2huIXZ53CLBXjxw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SdYD0Cd3rTr8bYSpJ+XM9+/XoBlyRCoMho5XEqu1Yf3sW+/gylHdb2HDYZhksr0kl
	 aEZxiEPrY0bFoFymYLfMX5SRSJK3VVrXfafcoTqvWqnquyUrZyg04aAA0acDSFVhF0
	 asbcCApJwkZpxsXo4zyn6SvvxcfTjRi/R/kexdyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389579AbgEZVcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 17:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388740AbgEZVca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 17:32:30 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362B5C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:32:30 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id r125so13170098lff.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/KSqN/1uGFSWAMqjcchuGZIR3exJ8WM8bq7gNpjfuAI=;
        b=fheyBaLlluDLksZ+2j65q0tTKxfK1g+WnuTKf3lXv190aV4fKXfwhttUxZ0VsqTlii
         ARxk9QHilPvtC+sjmqpulPyab9zAp/voO602TJp0MrEWMqo2HJsGfYVYN0LKJAZq35I7
         kQ5HQMhKqeWDvBXtAvAYAlYca6C9iIw6goapQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/KSqN/1uGFSWAMqjcchuGZIR3exJ8WM8bq7gNpjfuAI=;
        b=OpMAQm4ut+IR/djcrT2dQZSDo0hbyUJM6ES3yDPm5ekXvZeh6jkCqX3gkHSRspNEBJ
         v3QcgpFsIlyv1+zSW7uyKSJHzYOhZwnyKFns0d968Luaebucc+rcZU9FaQHu9XY+V5So
         rd0aerK24NYfB038vgts5JmvCNR/b7ii7RO385wLqWohaWC9WeDXm9jtpRADNGuAtWd9
         TtaQ0C4BzuCv7/fkFk6D/7+I/OgUg5erakEHv19xmS5HSkBZW51SPK5ootnXmF0V5kxx
         JeRKtlHF4Hby11jz732SG1X2GbCqthO4z6Ir9kJ41hyITLrumaH5WjDEhYb8Z2gLqgGL
         aDTw==
X-Gm-Message-State: AOAM5335mcXgfDCpnHgFkNl49GjHgmGgUtkHeFeKPydtzs14/a4AQHil
        vbr++t1nNRDVpZacSoBvu2c/rkIxi/c=
X-Google-Smtp-Source: ABdhPJx4Cji/xzhcTPpf1Vdpa55DUZd8tQw2t7WayCeyCe4Rtn7HNmt46TNMOEsj44F+1aqNPTpc3g==
X-Received: by 2002:a19:740e:: with SMTP id v14mr1436795lfe.62.1590528748246;
        Tue, 26 May 2020 14:32:28 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id c22sm259438lfm.25.2020.05.26.14.32.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 14:32:26 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id h188so13227428lfd.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:32:26 -0700 (PDT)
X-Received: by 2002:a19:4048:: with SMTP id n69mr1410519lfa.31.1590528746289;
 Tue, 26 May 2020 14:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <871rn6a6e5.fsf@x220.int.ebiederm.org> <CAHk-=wh5cddDjyS2Av57Oc=qaowkx0XrtuJN=sErcq08qpnb7w@mail.gmail.com>
 <87pnaq5tf9.fsf@x220.int.ebiederm.org>
In-Reply-To: <87pnaq5tf9.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 26 May 2020 14:32:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=whTcs=GjYGs+KHSAL16vkrK1KRuxuWf8WdrR-W2k9wXaQ@mail.gmail.com>
Message-ID: <CAHk-=whTcs=GjYGs+KHSAL16vkrK1KRuxuWf8WdrR-W2k9wXaQ@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull exec fix for v5.7
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 1:36 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> I don't see us touching cap_ambient anywhere except the line that does:
>
>         /* File caps or setid cancels ambient. */
>         if (has_fcap || is_setid)
>                 cap_clear(new->cap_ambient);

That's the one I was thinking of.

I think it would have made more sense to simply initialize it there
and have all accesses to cap_ambient in one place.

The (even better?) alternative would have been to simply just always
re-initialize it in the caller.

If this is about interpreter vs scripts, I really find it confusing
how we make these kinds of re-initializations at the security layer
that doesn't know about one vs the other.. Yes, in your cleanup
branch, the "primary" thing becomes more clear, but it very much is
_not_ clear within the context of this patch.

Hmm?

              Linus
