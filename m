Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DFDC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 18:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A3E2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 18:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579025954;
	bh=AeOVIkNpbm2tsZ8/ftSJ1K4kP9i8N1kh8a1Ay1NUwwU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SXtGzhZWFJ6bxi5BqBhnfnm7qHpgZc4wK23IrJqubKcCsBKTPB864iwhaa/HCOFcz
	 Bsb8V3UYTptctINtdoFgbIwclEMyxi9lYeMfUG1kwHSJBsrSrvkYi1+AxlrYRJ7DPk
	 uQEoXkysnD1Rn1x6APXOd7YeCy940J+tU2SwfXvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgANSTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 13:19:12 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32945 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANSTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 13:19:12 -0500
Received: by mail-lj1-f194.google.com with SMTP id y6so15508762lji.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 10:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UYh55Sg8qhe64vzw10Xs0Y/Zd3wTg54bWk/UWSeYbnY=;
        b=d/GHg+X0gq3ZImNmkm3hZh2dmcsvz39ztreS/na9FahzZpNzXIDMf7CFb+uW7GY48+
         +uw53PyGcGxkY0BmbiEV10ds3EQW0kyFPSJy2PJ10ejU4UPZND4yg/447uAgFkinp80c
         oHdzFtH+ekaZwyFPMQhrJx45AvqoNTK5wBJjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UYh55Sg8qhe64vzw10Xs0Y/Zd3wTg54bWk/UWSeYbnY=;
        b=MAM3+I93DDv8v2iL61XdBXy12N3LsCWJADkPisbi7f8bZuaLfTTkNqrO6DrA9tK4sR
         dcULUSX/uaRY/Uf7rwNee7itzSGuuomV9AwAXxnNBxSCpseOZO7o+Qkeh7E5N36+OTdk
         qt3OW85f4vn6615VfqyPcGZLKoqZCuPxVlH4o/pABVkxLqm+F59bpTXqDA+Bp/3KM6Dd
         ChncYJ1zSNjUZjTAXObvpPnvmMVTbROtLzKJXbVZi7BgUjlF0wlJfGhfNIf/wLXgGFqC
         5wjZqauu41A9VuZNO0HgtjmI62HQZdaP+TelZ+BrzY6/IcIAj4NFCnG7C9JWspXtPRMK
         qXaQ==
X-Gm-Message-State: APjAAAXwRokLI+DY6p9x0F+vpwWQIPqkcApK16DRKDgSkWaIY7DlPzrg
        I+gxBN2W2ZxBAey/tPHwSQSPamu3R9M=
X-Google-Smtp-Source: APXvYqwfV5tKFN1ZGbEzgH3kVUj/kMHqxa9crMKkw3ZepZzRkaSUZIpd0oKa8/grrjxWJ3UHddfEfg==
X-Received: by 2002:a2e:96c4:: with SMTP id d4mr15392370ljj.225.1579025949809;
        Tue, 14 Jan 2020 10:19:09 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id k23sm8064490ljj.85.2020.01.14.10.19.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 10:19:09 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id j26so15451298ljc.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 10:19:08 -0800 (PST)
X-Received: by 2002:a2e:800b:: with SMTP id j11mr15222463ljg.126.1579025948652;
 Tue, 14 Jan 2020 10:19:08 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a3wHmr3hgb5H69V68ZA3KCDSFeOekAKmR80MWxgQ7JK=w@mail.gmail.com>
In-Reply-To: <CAK8P3a3wHmr3hgb5H69V68ZA3KCDSFeOekAKmR80MWxgQ7JK=w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Jan 2020 10:18:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjwSC9H1bkEg-0t0cCU0mO+e0gBH8VQn5LG0XL2rpKnfg@mail.gmail.com>
Message-ID: <CAHk-=wjwSC9H1bkEg-0t0cCU0mO+e0gBH8VQn5LG0XL2rpKnfg@mail.gmail.com>
Subject: Re: asm-generic: fixes for v5.5
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 8:23 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
> tags/asm-generic-5.5

Pulled.

However, I noticed that your email doesn't match my usual git pull
search terms (which are "git" and "pull" - shocking, I know), so had
this been during the merge window or some other very busy time for me,
I might not have noticed the email in a timely manner..

Mind adding "git pull" somewhere? Preferably perhaps to the subject
line itself, ie a "[GIT PULL]" prefix, because that's also what the
pr-tracking-bot looks for (well, it's _one_ of the things the bot
looks for, it might have noticed your email even without it because of
the pull-request patterns in the body).

                    Linus
