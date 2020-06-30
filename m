Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48461C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11148206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593546223;
	bh=X275nFXMXUDOi+iKPw7HAKHSBcy5WgxO35MzZthZOXA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kcTus/IQzk026lhT1DhMNzn0zLKrVx9BoStR1ICz7Ujmxwmmu00fckxFbS+hTViJt
	 XtHownoBthVxz5TI0Prcpy8KhYi+0N9kZnzbuc4BUleqvXtJMl9zwAp3FDk17yvX8c
	 qwikmFdb9wO15gc1S7eXIJS9s1ATjsBhAhLE1wZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgF3Tnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 15:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbgF3Tnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 15:43:41 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1763C03E979
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 12:43:40 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e4so24030973ljn.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 12:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YsqwdRQFFt3HHRK3xFxPD0d+PNk+87DZe2KkR3X05O4=;
        b=HT7tCbAjQS+Z4+G4SyrMS3j9InGiewKytjMCpTGPeocEMilLSzDoOCC3XIhxcrkAg+
         95aSOjncCnTsTDEsFE4ITphAp+kV64NzgNuu7AJHEnDGSpko+cWd1wtiBEiZjGsxn1A2
         1DjW+cPmNaM7JVxpleTXfH6VRMPkgVOO6wr8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YsqwdRQFFt3HHRK3xFxPD0d+PNk+87DZe2KkR3X05O4=;
        b=QJABp9JQkD+sJ2zXTxXxv8JEZhjOJ5eF0yM3sEfWdvd+wQMxfklQHIYhTP7BJrv8gB
         Kt0k+GVrKE7r7Uc7VLY9Gb9GNaSh/GjA9CCFnXqsASI9XBSVRYEYdBGtgF1+HBWK5yU8
         i3xhqITMKaKuPl2JdgqPw1Z+ZYWXmTbDlIluBQNsKhssiki+4VktNfQg0uymeeYSAhNI
         9MxowXwZGmtKVjf/nnu4lrzmCnxyJOnQ4o5f6A6zl7GplPLuMkQLNCaIQt0nlO2rSn6m
         M/Z++mfdoh5QCDdxOKQJtan8QH7UR43iMKbo0f4GsdQdzLricavFFdwkgMlyGEIs0A6R
         CjLA==
X-Gm-Message-State: AOAM532LnLNQXERCTouCGciyUB6r9Ob+/Qtr7DE0w5y9WPhd3Ssf/P0s
        aN6tRyHVVyVVPHfuEg9vBOk6EMTrWXY=
X-Google-Smtp-Source: ABdhPJySw+tqMbAiJQB5u1vfOOiQmXxhVeDYhx9IJ3knpbLdfAJimqmW3yWQok61l/ZIbMpdhijRpQ==
X-Received: by 2002:a2e:9186:: with SMTP id f6mr7917589ljg.386.1593546218660;
        Tue, 30 Jun 2020 12:43:38 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id a9sm1033071ljm.84.2020.06.30.12.43.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 12:43:37 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id e4so24030835ljn.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 12:43:37 -0700 (PDT)
X-Received: by 2002:a2e:991:: with SMTP id 139mr10946115ljj.314.1593546217407;
 Tue, 30 Jun 2020 12:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <341326348.19635.1589398715534.JavaMail.zimbra@efficios.com>
 <CANn89i+GH2ukLZUcWYGquvKg66L9Vbto0FxyEt3pOJyebNxqBg@mail.gmail.com>
 <CANn89iL26OMWWAi18PqoQK4VBfFvRvxBJUioqXDk=8ZbKq_Efg@mail.gmail.com>
 <1132973300.15954.1593459836756.JavaMail.zimbra@efficios.com> <CANn89iJ4nh6VRsMt_rh_YwC-pn=hBqsP-LD9ykeRTnDC-P5iog@mail.gmail.com>
In-Reply-To: <CANn89iJ4nh6VRsMt_rh_YwC-pn=hBqsP-LD9ykeRTnDC-P5iog@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 Jun 2020 12:43:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=CEzD+xevqpJnOJ9w72=bEMjDNmKdovoR5GnESJBdqA@mail.gmail.com>
Message-ID: <CAHk-=wh=CEzD+xevqpJnOJ9w72=bEMjDNmKdovoR5GnESJBdqA@mail.gmail.com>
Subject: Re: [regression] TCP_MD5SIG on established sockets
To:     Eric Dumazet <edumazet@google.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Yuchung Cheng <ycheng@google.com>,
        Jonathan Rajotte-Julien <joraj@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 1:47 PM Eric Dumazet <edumazet@google.com> wrote:
>
> If you want to be able to _change_ md5 key, this is fine by me, please
> send a patch.

Eric, if this change breaks existing users, then it gets reverted.
That's just fundamental.

No RFC's are in the lreast relevant when compared to "this broke
existing users".

If you're not willing to do the work to fix it, I will revert that
commit. Because that's how it works - you can't ask other people to
fix the breakage you introduced.

It really is that simple. We do not allow developers to break things
and then step away and say "not my problem".

         Linus
