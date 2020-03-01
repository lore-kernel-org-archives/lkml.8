Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F47C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 21:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7BC24695
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 21:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583098451;
	bh=dcpCGeKVoQHpJJq5lLWxv7pllnCjP+Wl/MFzTSif3LE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ckI+bnp6v6yBtei98DLChlSEKAhZGhFDoixQ0D25djuijstod3QBbpzFdevcr6IqJ
	 G+cNBGHszgRuAtKE8TVRlKXUg/SxblONHBjBlakbHiiw8GDgsA7yCZv5yLPDsT6jF/
	 krNWn/X30Z8pzwHuesu84GhO3vxpzAabdx8tVPCo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgCAVeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 16:34:08 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36530 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgCAVeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 16:34:08 -0500
Received: by mail-lj1-f193.google.com with SMTP id 195so1347608ljf.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 13:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MG3T/bBKuDUDeti/Rm+y4RgArjtBEYGQp1e9CzWemF0=;
        b=apcGvjA2u0cCo4C+VwBU1Sw2XH7N23BHVkkkrwPxPkkLpwgWEXMy8mpoRYhJoe/OwW
         RBhZVTwyblCqHaOrJTdKlZx65NbvjknGHtyp34sPZrAw2qZMOvsnJkebTADHFDIkes4L
         iqhdCg9qQtF1WKTcpzzg+2KH8XViHFCpx2BGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MG3T/bBKuDUDeti/Rm+y4RgArjtBEYGQp1e9CzWemF0=;
        b=l4pXLLJKUuMggr89enRwGorvUtpfQtu8Q20YR/rYMfzRF1Nyy7Nnq9fFgXsCsy1rwC
         7lGYs0cbdch34tSRyAQMCOyRZ3ZBYqZ2vGOs99HWZQAU0cZlFYBUeenUXYflqck219B4
         aj0h0yEknhPOhUAFBq5jnRUKXC7JzGbtPnLT57qrSsDZlLilmAmYzOgHGkmxYvOIwHeE
         zBbR0qv3lJwm+tcnaz9K0PifU1AhyDkgfDFQUPlPAGX+Lf8S0bCWI0himrSiFJexxImh
         DxJkSHt/9XdqXHC2DNrFahhdRfurdRokl0eQoNIvGFyaDGFsDCE63m+wHYeq68woeP0K
         pvnQ==
X-Gm-Message-State: ANhLgQ2b4Aio/WMW36x7xrevIcGk8JAWy06lBwyAyZq+Sujl2pDMMsAg
        YzxqK3JHtLAAMFa2brMOBGjZ99lvUOF0Yg==
X-Google-Smtp-Source: ADFU+vszH+gkjphMMhSbLJ9U6/Fz27Re9aNzIvLKDkpdgu1TXqcJMwzXSTCb2R4LPToO1NZZi/tnJw==
X-Received: by 2002:a2e:9b90:: with SMTP id z16mr9569244lji.254.1583098446030;
        Sun, 01 Mar 2020 13:34:06 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id v10sm9432170lfb.61.2020.03.01.13.34.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2020 13:34:05 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id s23so6315131lfs.10
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 13:34:04 -0800 (PST)
X-Received: by 2002:a05:6512:10cf:: with SMTP id k15mr1918456lfg.142.1583098444431;
 Sun, 01 Mar 2020 13:34:04 -0800 (PST)
MIME-Version: 1.0
References: <1583089390-36084-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1583089390-36084-1-git-send-email-pbonzini@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 1 Mar 2020 15:33:48 -0600
X-Gmail-Original-Message-ID: <CAHk-=wiin_LkqP2Cm5iPc5snUXYqZVoMFawZ-rjhZnawven8SA@mail.gmail.com>
Message-ID: <CAHk-=wiin_LkqP2Cm5iPc5snUXYqZVoMFawZ-rjhZnawven8SA@mail.gmail.com>
Subject: Re: [GIT PULL] Second batch of KVM changes for Linux 5.6-rc4 (or rc5)
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 1, 2020 at 1:03 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Paolo Bonzini (4):
>       KVM: allow disabling -Werror

Honestly, this is just badly done.

You've basically made it enable -Werror only for very random
configurations - and apparently the one you test.

Doing things like COMPILE_TEST disables it, but so does not having
EXPERT enabled.

So it looks entirely ad-hoc and makes very little sense. At least the
"with KASAN, disable this" part makes sense, since that's a known
source or warnings. But everything else looks very random.

I've merged this, but I wonder why you couldn't just do what I
suggested originally?

Seriously, if you script your build tests, and don't even look at the
results, then you might as well use

   make KCFLAGS=-Werror

instead of having this kind of completely random option that has
almost no logic to it at all.

And if you depend entirely on random build infrastructure like the
0day bot etc, this likely _is_ going to break when it starts using a
new gcc version, or when it starts testing using clang, or whatever.
So then we end up with another odd random situation where now kvm (and
only kvm) will fail those builds just because they are automated.

Yes, as I said in that original thread, I'd love to do -Werror in
general, at which point it wouldn't be some random ad-hoc kvm special
case for some random option. But the "now it causes problems for
random compiler versions" is a real issue again - but at least it
wouldn't be a random kernel subsystem that happens to trigger it, it
would be a _generic_ issue, and we'd have everybody involved when a
compiler change introduces a new warning.

I've pulled this for now, but I really think it's a horrible hack, and
it's just done entirely wrong.

Adding the powerpc people, since they have more history with their
somewhat less hacky one. Except that one automatically gets disabled
by "make allmodconfig" and friends, which is also kind of pointless.

Michael, what tends to be the triggers for people using
PPC_DISABLE_WERROR? Do you have reports for it? Could we have a
_generic_ option that just gets enabled by default, except it gets
disabled by _known_ issues (like KASAN).

Being disabled for "make allmodconfig" is kind of against one of the
_points_ of "the build should be warning-free".

               Linus
