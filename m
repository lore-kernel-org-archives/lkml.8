Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38520C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 20:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB6762073E
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 20:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="NDpkuuu4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgGEUXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 16:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbgGEUXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 16:23:22 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D173C061794
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 13:23:22 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id w17so57567ply.11
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 13:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=i5cWO1mH1ckzyP7DGvWAippld7pbJouNE1HHlTWb8PA=;
        b=NDpkuuu4NeDc9MJ/SojRnDM3krKrf3NruI6Bq4nhKLnJTBK2Tk54L4cv/IKGuGkyos
         6o7YoLFGP+CVQ4Tr88/7GQUXM9VTAmnu6BaG9fKiXCd8kCVDVTmvCNcONhU7bAFIeI8k
         DsfEOdT7u3qoPhC37MAQrDRRdsxkVHpIG5bx02nTyl/jFcppnd86VPwtmrYdUNWEGcpg
         aGYhCK93SO5YYGE2WsOPI+fHGE+PjiB2Wh+YCa5CLBxK9QGvymPBbBB2qQwphPK8CwsQ
         B+BaxcarzQ6j/ysADQ818f8r/VnUTLzit7c2CKrC6WmAcB3lp1EVpF5MiEyAYHBTl2z+
         Nw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=i5cWO1mH1ckzyP7DGvWAippld7pbJouNE1HHlTWb8PA=;
        b=mi3YxgFRA5NgjYHXZAcrplk0fEy/a0ih9mVD/MsJz8KSFfLx5gRjDS8VWdDp0N7Eoj
         9DROODUTolKiHGXLZyo1tBc0iP20KbWvNSkeaixDMA2ZoyAkbvtiuzamiN+tPxVTY4wQ
         k5RyGEEbwWzLw6oO1IU9Bp/kgPQspuw9p6PVFEKI8poE+3q/b8IJCQCD7S5C1x4oDvKK
         s0UPrF4hDI/ZRzjNqqJu1BwIAV7sv9fn6eN/gVPPOSjLZESX+MfSRFEuEcLaYq2nAb8C
         FLldaTDhOBKk77QzFT2hFT61ucEN9uxb6y8z3+KSWqndog7YBN76JdT9weRljiV2/8cc
         4y8g==
X-Gm-Message-State: AOAM531ghaBoyUW8y1oNmca3VqATs74hBhgpR8cCIpW+Hy/8PwN1q68f
        3OzuHTCZZUO53ZN+aZfUOvD+xXS4xBs=
X-Google-Smtp-Source: ABdhPJwXhO28osiAK9CgD1pLHxQhoWwk1vxGz4HznTD7ySrF2k3uDWpCxfAcoLYHVc/0pDCEA49cdg==
X-Received: by 2002:a17:902:c391:: with SMTP id g17mr39302327plg.330.1593980601582;
        Sun, 05 Jul 2020 13:23:21 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:b424:f00a:4c70:7a71? ([2601:646:c200:1ef2:b424:f00a:4c70:7a71])
        by smtp.gmail.com with ESMTPSA id k12sm16586897pfk.219.2020.07.05.13.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2020 13:23:20 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [GIT pull] x86/urgent for v5.8-rc4
Date:   Sun, 5 Jul 2020 13:23:17 -0700
Message-Id: <B8CAA214-A115-4852-9AAC-0A68CD0FA76E@amacapital.net>
References: <CAHk-=wgV9toS7GU3KmNpj8hCS9SeF+A0voHS8F275_mgLhL4Lw@mail.gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
In-Reply-To: <CAHk-=wgV9toS7GU3KmNpj8hCS9SeF+A0voHS8F275_mgLhL4Lw@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org






--Andy
> On Jul 5, 2020, at 12:46 PM, Linus Torvalds <torvalds@linux-foundation.org=
> wrote:
>=20
> =EF=BB=BFOn Sun, Jul 5, 2020 at 8:47 AM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>>=20
>> - Disable 16 bit segments on XEN PV. It's not supported because XEN PV
>>   does not implement ESPFIX64
>=20
> I don't disagree with this conceptually, and I've pulled it, but
> christ, that warning is over-engineered.
>=20
> Seriously, it uses a mutex to protect a "set once" variable. That's just c=
razy.
>=20
> We have "pr_info_once()", which does all of this for you. And no, it's
> not thread-safe, becasue ABSOLUTELY NOBODY CARES.
>=20
> If you happen to get two or more warnings because they happen on
> separate CPU's at exactly the same time, nobody possibly cares.
>=20
> And if you really are so anal that you care about that case, using a
> mutex is still the wrong thing to do for something as simple as this.
>=20
> You could literally have made it just a single atomic variable, and
> that would have been simpler, faster, and be context-safe at the same
> time.
>=20
> So using a mutex is not only overkill, it is literally technically
> _inferior_ to just about all the possible ways you can do this.
>=20
> I've pulled this, but I found that code so bad as to be actually
> offensive, and added a commit to remove the garbage and just use
> "pr_info_once()".
>=20
> And if somebody wants to guarantee the "it really can only happen once
> even in theory", that person can add the code to "pr_info_once()" to
> improve it to first optimistically load the value, and then use a
> "cmpxchg" or whatever.
>=20
> But that sounds pointless, and I'm not going to waste my time on it.
>=20
> But I _did_ waste my time on removing this horrendous case of
> re-implementing "pr_info_once()" horribly badly.
>=20
> Because it physically hurt my eyes to look at that code.


I=E2=80=99m not sure whether I should apologize or feel proud of my ability t=
o injure your eyeballs at a distance.  In my defense, I looked for helpers l=
ike this by grepping for _ONCE and didn=E2=80=99t find _once.  I suppose I s=
hould have remembered that this helper existed.

Thanks for the fixup!=
