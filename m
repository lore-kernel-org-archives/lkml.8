Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9520DC11D00
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 09:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6090220801
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 09:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fgz01I+q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgBTJ2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 04:28:44 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38203 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgBTJ2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 04:28:43 -0500
Received: by mail-lf1-f66.google.com with SMTP id r14so2506781lfm.5;
        Thu, 20 Feb 2020 01:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aXBYI7iN04ln6Ion90FgCxJnmbc7ifsuLMedAnCxmZg=;
        b=Fgz01I+qAuo3DyELQn4YOkmmqdbZG0GyFC0OM551PnYPk0qWHczUrMpYYKUKJiPI4g
         iEc3V4+CzggO/N5X4p3T1ke0BzSBUvUsrfXSt8xvRgx9AhbQ8kSTtWcp+0UtcNTJLtzp
         jo3xbT0JiMidrEoSaZMPPP1+pJhaotHe5GlbjapHTvN13jyXawb1yuQA4H4aqb3bgjX5
         tj+0nCcCQASUvGIr5ueSo9yxS/zn+iGnsX8pA1DlPO1DOGgEPaIopjlfryIflIKGjX6K
         wwPFOb0DQByw0cGYJ9eG0hnfrSREMghHAxvzV+VU2SuJsjziF60f+vDrQ5RB+tB0pe8O
         CHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aXBYI7iN04ln6Ion90FgCxJnmbc7ifsuLMedAnCxmZg=;
        b=F8xP31rlgWn6GJuCu13IdGBmioOlc1l41YjipAgJ5WUjuGgGr+MGXbtLwvDaq1qpg+
         o6kMcl6YaDGnhPtK7r0xOsX+bpXk58hnAZz01xtgsNqDwtbS2dIvxsmCHLCHRWqXaQIP
         H5JdCNCXenbkwfVhtJzEts1f2zL55WT8WMDz7r0AcM1TeRtlQ1AvSp5PzvAAp0bSDGel
         VUT+ebvnnwguB/bjAyqh6X2w/67YrOqH3jDJx283+gEcBo/PJY4SS3a2XElA+yvKZ11i
         2YsPcGjm+0VYaoyQZfGGM+OR2lk0FYyiqxYX3XkZTqY4U/62BB+LDWTmPPcB6USWLhqm
         1/4g==
X-Gm-Message-State: APjAAAUwSHiu0Xkm2k6X4CLJElb3TzzWh5nKE/FeSeMpDAsUx8bS4ij0
        as60Z1grVMH2Rl+6EuDl0fGJcZLZT3dob0ByDDE=
X-Google-Smtp-Source: APXvYqzqPQ9BCBt2x2OiYVmwTljlYndEM577r2iYLn7YqzpJ1YQgQCYJ1SjotvYnvWD0v8GZKl4r3TDCXgAkgUM7iSc=
X-Received: by 2002:a05:6512:78:: with SMTP id i24mr16504662lfo.10.1582190921659;
 Thu, 20 Feb 2020 01:28:41 -0800 (PST)
MIME-Version: 1.0
References: <20200220071140.14080-1-masahiroy@kernel.org>
In-Reply-To: <20200220071140.14080-1-masahiroy@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 20 Feb 2020 10:28:30 +0100
Message-ID: <CANiq72kqxdGrZO7NokY6Zkh=e8owBVJCpK5DxWLnwiuxyzCybg@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdso: remove meaningless undefining CONFIG_OPTIMIZE_INLINING
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        sparclinux@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 8:12 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> It it about two years since 28128c61e08e. Nobody has reported a

Nit: "It it" -> "it is"

> It is ugly and unreliable to attempt to undefine a CONFIG option from
> C files, and anyway the inlining heuristic is up to the compiler.

+1

Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Cheers,
Miguel
