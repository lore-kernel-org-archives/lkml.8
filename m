Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB038C4BA1E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B483F24650
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582740887;
	bh=Q7iIbIn42QjoMFCxDfi66+riXge3492QrU7WQoT/EhE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VL5DAt4K3fEqvkKrhbyXiHlyimwWzdZ7QknFvok9mliB2zT8D8bCJzs6NaZXAg+Fm
	 UhxEiVgEcWEHVjyk3n1gOSjeXqE4dQVFPOHWDpyX5RcDlSfBD7TGAekorHhk8+8Srk
	 0mubrNEXlcfqaXIbqeHvaK9dAC/0/R4lHX7rbrq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgBZSOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 13:14:46 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39775 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgBZSOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 13:14:46 -0500
Received: by mail-lj1-f195.google.com with SMTP id o15so124662ljg.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 10:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bjVgEuW47C2Xrvk9SsDOlUklU0qxH2P/gutncBnIpZo=;
        b=OAWY1TMlyTY31yFaVWeJv1zsgKX7UFGsEx4qNdEfDU9zGJW12QpOe9TXsqYw3G1mVO
         vGpS9h09icLXW7ngtscDtxwnWCVgJALfoKKOGNm9BvBsmIspjLg0snQe4dHiUvDBOP14
         vbI0lrFc0btaa9cby9RqUnLyGsniu1i5ZsBB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bjVgEuW47C2Xrvk9SsDOlUklU0qxH2P/gutncBnIpZo=;
        b=PCmAGOviym75sgp917HlsYy+4pCRMSkZqFMCl85xqJSbknoRcRj3RROcwYyReYKaXu
         WToHl66S6pojpcdx9n3iVzZo7Kca3dpYks/wjYj9suVeArHZgRIBPGLseUzlZJPQd0Ek
         2nhHWIQ4gosTGbJxmgYS9p9QbFtHH+BVl98yARh+b4wBKNCJ+oDQ/q/lA1x/fDBdEs3S
         vLjjm3Bxa+DRcl8ocVxkXvrcZJ4v3qEEXWef/lunD2fwoPMDeKYZiszN/0m9aL3ymBMM
         Z9CJ8DTPTInOgUF+Bp1rhD+GDysVr2xTUmkLDb26Rt+O6ZmSDSfmnqb6cIBsuApnZYw4
         5slg==
X-Gm-Message-State: ANhLgQ3HNUDzDVtMXXeBhIrfrhTfA6Cx1Dp0lkj9ezvXaqqTjcnEpS3G
        SYB8QtT/+ItyWlSajSqyeXpq7NNGvVA=
X-Google-Smtp-Source: ADFU+vvWK2QXd8Z+XP6/FBxzpjaEzi5+G9LN7qvmYKkDhSbik7ik0u6+oeJXGiAvY3ovvLgJ4LlXdQ==
X-Received: by 2002:a05:651c:321:: with SMTP id b1mr149644ljp.62.1582740883427;
        Wed, 26 Feb 2020 10:14:43 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id j11sm1291634lfb.58.2020.02.26.10.14.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2020 10:14:42 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id 83so26983lfh.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 10:14:42 -0800 (PST)
X-Received: by 2002:ac2:490e:: with SMTP id n14mr3230490lfi.142.1582740881995;
 Wed, 26 Feb 2020 10:14:41 -0800 (PST)
MIME-Version: 1.0
References: <94b64a48-a337-63c4-c504-7e9b0c29a7c6@linuxfoundation.org>
In-Reply-To: <94b64a48-a337-63c4-c504-7e9b0c29a7c6@linuxfoundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 26 Feb 2020 10:14:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=whGqq1XyJgYr+Mrx7Po2d2JVRvroSigxzQ+C6jCcU7uqw@mail.gmail.com>
Message-ID: <CAHk-=whGqq1XyJgYr+Mrx7Po2d2JVRvroSigxzQ+C6jCcU7uqw@mail.gmail.com>
Subject: Re: [GIT PULL] Kselftest update for Linux 5.6-rc4
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 3:26 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> - Declutter git status fix from Christophe Leroy

I've pulled this, but just for future reference (and hoping for a
future cleanup patch): instead of putting things in the global
.gitignore file, do it in the relevant local one.

So you could just have added

  *.sh
  !run.sh

in 'tools/testing/selftests/lkdtm/.gitignore' instead of doing

  # Generated lkdtm tests
  /tools/testing/selftests/lkdtm/*.sh
  !/tools/testing/selftests/lkdtm/run.sh

in the top-level one.

That keeps things much better separated. It also incidentally means
that if a directory gets renamed, the gitignore file just "magically"
continues to work (if you rename the actual files themselves that are
named in gitignore, then that's obviously a different thing).

If you put it in the leaf directory, it also means that you don't need
the '/' at the beginning, because the local gitignore entries will
only affect that subdirectory (and any subdirectories under it).

So please put only "global" gitignore patterns in the top-level gitignore file.

              Linus
