Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765BBC41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5060D2076E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585068194;
	bh=bOmteieTZntfb2qgK6E4POcndj74a9FGn0pv40GjbJM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=scXIU2UmoeMeyLz/wVTvfYmsewhtw6fugIGSYzsi1AGfRt9YOMeniZg43VruHtB2+
	 uhEPwUwzhCXbDJdQBRsykFV43J0+fV3kcKHMXI+s7WyXY6CJqYr6RXr7YrBX5n4WF9
	 nGzSab74emmNgHxC3Hk5h9WSaYTla9gYKNJNyA0g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgCXQnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:43:13 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45396 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgCXQnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:43:12 -0400
Received: by mail-lj1-f195.google.com with SMTP id t17so8660322ljc.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 09:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yNlWnerAXVLzObnsd9PaDqNQnqdC4nXPbLaZYzKZiHQ=;
        b=cp8PDwcdLi3Sx58HhqjwAnXvUGvkwrx3sFIA6iBiDHu3GALAAUoI3vIIUjOizXWj4j
         iX4GZZ/pr7nXuay4pa/+Yx8d4j12ZdP3tLJHe+wBHTtAG+Cao64AGMaYtL5taPTgjbtU
         4/ILHSvXmFYSYfVeVdLpSGUboEgrpHYHi7pes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yNlWnerAXVLzObnsd9PaDqNQnqdC4nXPbLaZYzKZiHQ=;
        b=rLhBuxnkCSTwqkCxaPxmSpXCfVmTROmgSDJc7+62fbjgUt5FnBa6rA9nwhQZsAE/fe
         qWsX5JNjSjT6R011CZSwb2wI0X6DhYQh5AVOMvrP+aoVD5CM2yng1LXQJQIZycLxGIXi
         l46wPPIvL4MCAR4Y1XhX+2/7fBHgQUwmuZ1cqBADV1tulzbzMf6wh01Iv2WJZtTDkpHL
         +ooVdVrHG9dln4QxggpS7WMcuDz/coGkmJ9/kDomcK57ea/qS5ySPI+7OS2z9LYHGrhT
         1V+9KhcC1c/0uXP3xtlGFNDkuJy5vioOvPs5oSuvLYOp5KLnC2ihcNgmzeLuD17MVT0G
         9MdQ==
X-Gm-Message-State: ANhLgQ3ABLPsHvn2onK6S2Gr+Ro9aQQpubRmyEFfOtMAkKez365ZO9LQ
        vtnGcZVeO3z+hrUY5ELuHDuU4uk8eBg=
X-Google-Smtp-Source: ADFU+vuIICIYsSaYKtEobh95fle15FLg+tRBELBXaTXaO9ZySQgIDTj1WS4GcqPUgjHI6kXPDY0pqQ==
X-Received: by 2002:a2e:b4a1:: with SMTP id q1mr8602491ljm.262.1585068190323;
        Tue, 24 Mar 2020 09:43:10 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id d12sm10089704lfi.86.2020.03.24.09.43.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 09:43:10 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id j188so9951844lfj.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 09:43:09 -0700 (PDT)
X-Received: by 2002:a19:c3cf:: with SMTP id t198mr11909345lff.30.1585067849259;
 Tue, 24 Mar 2020 09:37:29 -0700 (PDT)
MIME-Version: 1.0
References: <202001131750.C1B8468@keescook> <20200114165135.GK31032@zn.tnic>
 <20200115002131.GA3258770@rani.riverdale.lan> <20200115122458.GB20975@zn.tnic>
 <20200316160259.GN26126@zn.tnic> <20200323204454.GA2611336@zx2c4.com>
 <202003231350.7D35351@keescook> <CAK7LNARMBkc666kZ9jOG9sSThzA69JvKi++WZXMtCP9ddyqcBw@mail.gmail.com>
 <20200324091437.GB22931@zn.tnic> <CAHmME9q2VuhN+Dhi-nzuJKPjXo8dZq013cZ-0x0t9StZFXCAJQ@mail.gmail.com>
 <20200324162843.GE22931@zn.tnic>
In-Reply-To: <20200324162843.GE22931@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Mar 2020 09:37:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=whXBO-Z=Ra_UX=w_LefG1r6iLXcPT=sLuZ+EaKFtWtCBQ@mail.gmail.com>
Message-ID: <CAHk-=whXBO-Z=Ra_UX=w_LefG1r6iLXcPT=sLuZ+EaKFtWtCBQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation/changes: Raise minimum supported binutils
 version to 2.23
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Mauro Rossi <issor.oruam@gmail.com>,
        Michael Matz <matz@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 9:28 AM Borislav Petkov <bp@alien8.de> wrote:
>
> Are you or Kees going to deal with any fallout from upping the binutils
> version, rushed in in the last week before the merge window?

I think it's ok. It's not going to cause any _subtle_ failures, it's
going to cause very clear "oh, now it doesn't build" errors.

No?

And binutils 2.23 is what, 7+ years old by now and apparently had
known failure cases too.

But if there are silent and subtle failures, that might be a reason to
be careful. Are there?

              Linus
