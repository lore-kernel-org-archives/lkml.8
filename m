Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D188C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 23:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 451DD20657
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 23:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597707205;
	bh=pgCuzCOEIdIigji2cBS30qMeoyzff/puO38/cO54FaU=;
	h=References:In-Reply-To:From:Date:Subject:To:List-ID:From;
	b=IW8EDqs/NkVnyWJZtEhlyU6qVfgbspS9UrvLGRLu8WlURtjtr1t9TZKLv7z/28NoV
	 6lR56Jmees1VvGw8K/x6bfRqY/DnvwWaDeMXeSWI8wm3xdcgKzzoiInbIG6FFY/uXg
	 mioZht4KCiG7lKsIcrxoYLQEUTM8LbgYkt3wGOb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgHQXdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 19:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgHQXdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 19:33:23 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0A8C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 16:33:19 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w14so19373852ljj.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 16:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=FifRv5fzYglFQPh5FYSGShnZrmnfM3kKbm4D0PEuEs4=;
        b=DSSJYBfqUqSVYbJaGm8rfTY5KjQsyhXCsKHacZ/kCQSTfAoxGgSXtMvR1V71xsVBrN
         a1zMisQovyRSC4K8DhQJOwovatfZudQkWhY+R+orArtSZXTJkF/IXwitF/nVolDqtiax
         0I0uN4N70UZjoQL+52XUho8gWT09yu4VNWmiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=FifRv5fzYglFQPh5FYSGShnZrmnfM3kKbm4D0PEuEs4=;
        b=Wa8A9e2r7kXjbFbZ8Zd3r62zFTbDqSBs7MWT2OLMtkN8pdpWo1SHsIt4En7vXyoB/K
         gxBF8UntITsC5Fqk2468hBKoFoGtz7L69iKxDmfe67PBbJodPhTegj6OvCZKwrG1dm4n
         rXXNInNivTa5WOKtaztgbdNodzY+1WRaH1QqcQsU+1FZfU0wPrGQxyY5R5MCcRRCHKEK
         F+1cSCvvFMIB85qer1cqKztAjFjIMeNv9B41c5K+q3Wy6xLw9KClvRfM+pjya7QMoHgV
         TSeKQ3G+/p0cGPKbgPJCUDjfD8btaMbHTyJsvqUXj7KTjsCQtYqrsz7F5vMFZFETILuv
         4Xjw==
X-Gm-Message-State: AOAM531Bl0Etz4pnkjikKU2jPmUjDHJ/TQn8yXH5H5KEjdM5zZLetSWt
        OPy4E34hlPjjgKAOS2Rn8nOgZ1hxc9bR7g==
X-Google-Smtp-Source: ABdhPJwmdWv7DJvrGAXQqEjQoJOxsbCDMpJDnkU2McCMr8sGvmfl8uGyxydQZCdEBrXVf/reqm82fg==
X-Received: by 2002:a2e:164f:: with SMTP id 15mr8692461ljw.68.1597707197119;
        Mon, 17 Aug 2020 16:33:17 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id x6sm5890504lff.64.2020.08.17.16.33.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 16:33:16 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id i19so9235658lfj.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 16:33:16 -0700 (PDT)
X-Received: by 2002:ac2:58d5:: with SMTP id u21mr8422105lfo.31.1597707195695;
 Mon, 17 Aug 2020 16:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiwfkKp93C+yLqKWAU0ChBdeBDUhgOk09_=UQ8gOKbV3w@mail.gmail.com>
 <20200816225822.GA3222@debian> <CAHk-=wgOaEmFGYhnx7XLe8AbQKYpgMAzyuHuS8dYZoB2hS3C=A@mail.gmail.com>
 <20200817212519.GA11141@debian>
In-Reply-To: <20200817212519.GA11141@debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Aug 2020 16:32:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=whm2fcvovhvtXceNzQGet=hZspqSBRrpoYzwe2ZhX=UNg@mail.gmail.com>
Message-ID: <CAHk-=whm2fcvovhvtXceNzQGet=hZspqSBRrpoYzwe2ZhX=UNg@mail.gmail.com>
Subject: Re: .config file attached for your perusal..build stopped... Linux 5.9-rc1
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 2:25 PM Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
>
> Thanks, Linus ...I have attached the .config file with this mail for your
> perusal.

There's something wrong with your setup - like Randy, I cannot
recreate the problem.

I wonder if you perhaps have some buggy version of ccache installed,
or something like that, which could mess up the build subtly?
Corrupted ccache files can result in some really hard-to-debug stuff,
because what the compiler sees isn't actually what you see when you
look at the source files...

                 Linus
