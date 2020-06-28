Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2ADEC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 18:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C937C206C0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 18:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593370662;
	bh=ss9+dziLtPq1t7XQHp8VXJd317B1CYxXBS8JGRJKTUE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0FOElOv1Wu+pQGAU/u4XmXLe3ySdi01iIu1R1buhGj0pax0urHHUoeTBOY3q2+qOv
	 heKQFP1ISOgo7fqcPy6bByGo6XsGP3/6/B+dKf3uhfiG78m9cFZwFPm6FTk+XQoYe3
	 nURemWpJRq/JV/pldqGM4spKmei4OqXL1p2DozF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgF1S5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 14:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgF1S5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 14:57:38 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C961FC03E97A
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 11:57:37 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id s9so15655952ljm.11
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 11:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=me4EsdBDUgzOWyCfaWTKrh1/8VSX/WOOzYty4vYJbaA=;
        b=Lh1BHMQPK4pHb+0pZdaLnW04plhoseGZ9Aju792/YX26s0fWjKZj3RLGKor51B7+z7
         KqHB/Yz9hh44U6vxmt6KDnGPhf1ONIZLqAsUPSB28Iyn/+aAizAG8K9eVVQKAQY0f3lp
         dnSo693KFmnoSo48/Wq3cLLiXAKaEoTCsV5n4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=me4EsdBDUgzOWyCfaWTKrh1/8VSX/WOOzYty4vYJbaA=;
        b=Tg9a1K4TYEWw/2Z/QfjY+VbNiBFrjpNDEaxd7NO7tG1YSuFlS5Ip/mgPnVQa6R+y4P
         oI9gYKneY95d/1zEy8pyazLPwGRWlcfmEQIrL/aFV+Y1bpE8kOnAs3gGlyfFLRhWd7+O
         7ybld2LPiIEL0APSKZlWIBtdLndtVTdORvEmhfxoOJsbKc0knyf8LPuGwqPQSGlqZFYi
         8i8ccvcuyXnIPn3fE1s943lExXb6fca7KyWtq/A49Rs47kgL58f0c2wC7ZlsOKHwr2kk
         Vqaa7cLY+BZcnMv14Pz4xIAynHiR3AQjTALLzP1lAKgVZ5ncb92YUixu5VZLd7orO9Vs
         bWAQ==
X-Gm-Message-State: AOAM530F4sPFBbAzfTpnvu6b0CO/kjBCLWaSH47y/qTiWvS9KqgtIzB4
        EqHNCwSNoRF7Jt76ocoeZWqSxRi3uNM=
X-Google-Smtp-Source: ABdhPJze5jxnH2re0qUE2A0ltrorujlMtr5qIuhZ66ON+E9TZ1WdmbmdbpHEnz9hTIW9csBYL6jOPQ==
X-Received: by 2002:a2e:98d4:: with SMTP id s20mr6695036ljj.83.1593370655835;
        Sun, 28 Jun 2020 11:57:35 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id o4sm8568975lfb.52.2020.06.28.11.57.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2020 11:57:34 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 9so15682632ljc.8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 11:57:34 -0700 (PDT)
X-Received: by 2002:a05:651c:1b6:: with SMTP id c22mr4749702ljn.421.1593370654268;
 Sun, 28 Jun 2020 11:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200628182601.GA84577@gmail.com>
In-Reply-To: <20200628182601.GA84577@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Jun 2020 11:57:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgD+q+oDdtukYC74_cDX5i0Ynf0GLhuNe2Faaokejj6fQ@mail.gmail.com>
Message-ID: <CAHk-=wgD+q+oDdtukYC74_cDX5i0Ynf0GLhuNe2Faaokejj6fQ@mail.gmail.com>
Subject: Re: [GIT PULL] EFI fixes
To:     Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 28, 2020 at 11:26 AM Ingo Molnar <mingo@kernel.org> wrote:
>
> - Fix build regression on v4.8 and older

Interesting.

It's perhaps yet another reason to just skip gcc-4.8 too, since
apparently 4.9 works.

gcc-4.9 really has a lot of advantages. It's where (I think) gcc
basically supports all C11 things, including _Generic() but also
__auto_type.

So if we just say that we only care about gcc-4.9 upwards, it frees us
to clean up some (really) old constructions where we've been using
macros with sizeof and/or typeof, and make the code potentially rather
more readable and often more compact.

Yeah, I know we _just_ made the minimum compiler version be 4.8, but I
do get the feeling that we should just have bitten the bullet and gone
all the way to 4.9.

Arnd, what was the reason for 4.8 support? I'm assuming there's some
sad unfortunate distro that still uses that ancient compiler..

Ok, ok, 4.9 isn't exactly new either (4.9.0 released May 2014, and
final 4.9 release was 2016), but 4.9 really from a feature angle is a
much saner thing than 4.8.

Afaik, the main "interesting" part of gcc-4.8 was that it was when gcc
switched over to be built as C++. That's perhaps a huge milestone for
gcc itself, but not necessarily for the users..

Arnd? You're the one who tends to keep track of these things..

             Linus
