Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3BCC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 22:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F53720748
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 22:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585519971;
	bh=j1QS8umrZrjMUQJAYFyVQmb46JyiZIsFexFPY07e1y0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=q+YQ7Wb9cP0Xaf7oYfCbjQNNmUSY2EKfi8lMLwzwx5/4o2NaKI4M7xJuKcpHmBALO
	 ezr0+cOYLNR5gHjN4uVXVfb67ZZ/ozTh0V/fl1nX8dAf7IAuxHjjzzSk0Q3th1inow
	 LRqB2tz367N1/yXXrSgBVoGW7jEywd9BnNtPjDxU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgC2WMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 18:12:50 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44170 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbgC2WMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 18:12:49 -0400
Received: by mail-lj1-f194.google.com with SMTP id p14so15981801lji.11
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 15:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lf4B+cUpy3zLX5w5D1ihgybvJqfLV1dlANhZhAEv/0Q=;
        b=gOuqbZqb513wbd8Kp8EPzxWuXeiO9OH9KxNOC4/uBi+QGly/O+zPq7Ansd0vrhdHsk
         kNVBYNcxdt0ISCrxLv53bhl3jHgaPDfodxJzKPz31KQnt9QYAYh0Uv/l5TVQ/IBTZ/0+
         59f3jmm1GHgT31k/aOfmRHeAymETtM6OdIFqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lf4B+cUpy3zLX5w5D1ihgybvJqfLV1dlANhZhAEv/0Q=;
        b=hiyCNxITw4XUz9JhvXyFhQUBM2ywh3Rgnc+Bn9N3jxbQ4996BxEBz0wj5OCzonjkux
         UGGqeiNdpJYRdQKvmeQ75VIyOrBxTavFV7syyDOgGzNjjMsyT6jX5FHrQXhB3sn6tDOJ
         jOyfN2dnz1S2zI2fJ/6FkFC8r70bTLmjmPbOvBFUG7TRVpXcVczSlkSZfdhOfzZSqlmw
         0jt1vU6wfJD85bUCaP+nnQgfH1gFomt4FkA6Jr15YxZihYecnof4Ky+LGE+7mNdc20uB
         6Y26/ZGCwLMxEv8mb5JaAEg3Ia2wB5ReNY2B+xlyPrDaxSa/n4d/mGwTnwGs0azr1zMp
         euyQ==
X-Gm-Message-State: AGi0PuZLNBNHd07EFKeXAy7mEYbHPKYNb7epv2lgyH1j19faCobCnnax
        bH/lNmcTlJ4okYJuMx3NKH2nQRB9XNc=
X-Google-Smtp-Source: APiQypLwZj9oo5SLlCTP5n0JkOE6QL/cw1InjC1qSGCxjEgFb61lxTc2fcap+APPct8nLhgj7OvDBA==
X-Received: by 2002:a2e:94c8:: with SMTP id r8mr5464060ljh.28.1585519966601;
        Sun, 29 Mar 2020 15:12:46 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id i18sm6992270lfe.15.2020.03.29.15.12.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2020 15:12:45 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id r7so8341477ljg.13
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 15:12:45 -0700 (PDT)
X-Received: by 2002:a2e:b4cb:: with SMTP id r11mr5651376ljm.201.1585519964848;
 Sun, 29 Mar 2020 15:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200323183620.GD23230@ZenIV.linux.org.uk> <20200323183819.250124-1-viro@ZenIV.linux.org.uk>
 <20200328104857.GA93574@gmail.com> <20200328115936.GA23230@ZenIV.linux.org.uk>
 <20200329092602.GB93574@gmail.com> <CALCETrX=nXN14fqu-yEMGwwN-vdSz=-0C3gcOMucmxrCUpevdA@mail.gmail.com>
 <489c9af889954649b3453e350bab6464@AcuMS.aculab.com> <CAHk-=whDAxb+83gYCv4=-armoqXQXgzshaVCCe9dNXZb9G_CxQ@mail.gmail.com>
 <9352bc55302d4589aaf2461c7b85fb6b@AcuMS.aculab.com> <CAHk-=wjEf+0sBkPFKWpYZK_ygS9=ig3KTZkDe5jkDj+v8i7B+w@mail.gmail.com>
 <CALCETrXWKE8RMX-mZ=p5T19sfS8Rn+1b_EtJz4TXbmf57_aY5g@mail.gmail.com> <CAHk-=wi74U0VLhHLBUqRPrPgercnAdt_8cJ_vjwcTeMzEwocnw@mail.gmail.com>
In-Reply-To: <CAHk-=wi74U0VLhHLBUqRPrPgercnAdt_8cJ_vjwcTeMzEwocnw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 29 Mar 2020 15:12:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgmkAvRqOe9B6Nt3X8yFtiFHshoTU2B9tn2hvPug2Wc-Q@mail.gmail.com>
Message-ID: <CAHk-=wgmkAvRqOe9B6Nt3X8yFtiFHshoTU2B9tn2hvPug2Wc-Q@mail.gmail.com>
Subject: Re: [RFC][PATCH 01/22] x86 user stack frame reads: switch to explicit __get_user()
To:     Andy Lutomirski <luto@kernel.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Ingo Molnar <mingo@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 29, 2020 at 3:06 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Anyway, just in case people want to see it, I'm attaching my current
> unconditional patch.

Side note: I've actually been running variations of this patch for a
couple of months now, so it's even tested, but I debugged one of the
problems with the clang asm goto support it exposed only this last
week. I thought it was a problem with my patch for the longest time,
and couldn't figure it out.

So to work it needs tip-of-tree clang *and* an additional llvm bugfix
from Nick Desaulniers for that problem I reported that hasn't landed
yet.

So I included that patch just for people to look at. If you actually
want to test it, I can send you Nick's llvm fix too, and you need to
have the ability to build your own clang.

                 Linus
