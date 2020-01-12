Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151B3C33CA2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 16:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0F3206ED
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 16:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733096AbgALQHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 11:07:02 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37158 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733064AbgALQHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 11:07:02 -0500
Received: by mail-ot1-f68.google.com with SMTP id k14so6749213otn.4;
        Sun, 12 Jan 2020 08:07:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lQ5vtysxDL6sgYaa5aaCu9p8HghnbmaEzIcF8ye2OLw=;
        b=k8LHPfUiARJiLAuk6kdGiHQSULve3jPl3oIaWlm8Dar9qn5hSf9DI/dWfiV7+mXI+x
         YZZI3dnZ3Lt95WEyYAoFilFny0BjE42KGEwRZYA33caX95TQWMXEHc6bOZYzEDF/Ehbg
         IqyuEkvZt8Ed3xqPotZWh4xdqu02OBQNuGW+xko6auRtQK2VjZ+JlCgrl8c7xheNaX9U
         Jpl+8m8ZvNs+xQqXLB2ohTs6lT46pssm3faY8W2H9Q7axqBcF1snzRE5QpMQdenuBfUT
         +349tXywnmmjIB0rPw6KtS8YoQu7t5YfOFfxERhMQXK5RSKIJvADdMGNXmCw14jZO1Xc
         PBkg==
X-Gm-Message-State: APjAAAUR5TsqP/EPfDnH0LVc5yRmyKGNbfOX6LC1RLWSW1K/HDli1gJv
        N87sTFLDwwOGILcCTMd5kCm/oRH8RJ3HU6JFmGzEPA==
X-Google-Smtp-Source: APXvYqzvloJjp3XHq1vsiQmJvm8y2syjgxKLF39BbFe7uXQTQwag0Qn/G3r3tMPu/POQkH3j8ksBEt18SOkHidC4RGk=
X-Received: by 2002:a9d:8f1:: with SMTP id 104mr9556402otf.107.1578845221843;
 Sun, 12 Jan 2020 08:07:01 -0800 (PST)
MIME-Version: 1.0
References: <20191124195225.31230-1-jongk@linux-m68k.org>
In-Reply-To: <20191124195225.31230-1-jongk@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 12 Jan 2020 17:06:49 +0100
Message-ID: <CAMuHMdXQAbw_Skj99q_PWXKn77bzVbJf60n38Etmq-zhOoHsHQ@mail.gmail.com>
Subject: Re: [PATCH] m68k: Wire up clone3() syscall
To:     Kars de Jong <jongk@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 24, 2019 at 8:52 PM Kars de Jong <jongk@linux-m68k.org> wrote:
> Wire up the clone3() syscall for m68k. The special entry point is done in
> assembler as was done for clone() as well. This is needed because all
> registers need to be saved. The C wrapper then calls the generic
> sys_clone3() with the correct arguments.
>
> Tested on A1200 using the simple test program from:
>
>   https://lore.kernel.org/lkml/20190716130631.tohj4ub54md25dys@brauner.io/
>
> Cc: linux-m68k@vger.kernel.org
> Signed-off-by: Kars de Jong <jongk@linux-m68k.org>

Thanks, applied and queued for v5.6.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
