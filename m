Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EFAC41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5EA206F6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585068734;
	bh=wv7V6OA+vnQKUw2Y4zY+fl+UxUMw0in7d1nJHJs3HkQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wkTuleS9DHJC0G7tS/eMFS7ja8EBDrcwLDf1Boymq1EB50c8Z9z+zSRKQUwP58Lty
	 XBcthB7UuWOa+HJ9k633JYz5evL/fSO0Cf/UXAdflPu2qmDsoP9VgQPzksuQOlrDnn
	 LUbDyJ2ZT2RtgiWhA1gL9z4YPaJw7nJ+AFza5obA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbgCXQwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:52:13 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43453 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbgCXQwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:52:13 -0400
Received: by mail-lf1-f68.google.com with SMTP id n20so13820044lfl.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 09:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WsR634IM9mmhNsoHiRslx4q1ur3OKG9sqLOfW3mTlvE=;
        b=Z4pJJsNRptNjfG3P3MoBuNrYlnzenPIYlkT2d80DcIZW7UeaJ7NzLHI1ja4yIjcDoc
         /iKfJJvm1iYP31UYLTqjCrBqL5Uar8necO8dCIgcOuI51Nj7AidT3P8YaYaCV6jUFzMJ
         fsKqZJnyfGhT7+0lEb4rByJaviH4S/tML+mT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WsR634IM9mmhNsoHiRslx4q1ur3OKG9sqLOfW3mTlvE=;
        b=QRid/3txVm81qvO9r5NM/4S414c8tjhtqlC0pnxC41OzPPJOcJLDqKfXEkw12WbqXX
         BOSILeJbufdxb2G5yxphM+HPchwptq5lC2UO02XJdD54rZFC6k3x/pbS+TlLud8AUVX4
         SCK/zgJOmgYY0d2iYNBTiZC0GJkFwnQdBt/JEJFmtMToxA43DHe3NtRvr46DcbzwS+YG
         1sW7N97FjHlk5bM4dKnrV8/KhnfsN/uzhF8JeXeQzkz+3QL+KkDVGc1XoLGSBkZUjhi6
         skpnb7lupF+/va/t3RR3F24EoSvI1lb2NT4MzjA75hKLPbQkk7GR72ldG8OKTmdKkxQx
         tUbg==
X-Gm-Message-State: ANhLgQ1MoOeva4TBWKV2oG5sua+hucXq3BC3ynAP9vWROubb5ATVItpZ
        2MPpjno2n+r3tKG0yksFl4xJ9KDM5/M=
X-Google-Smtp-Source: ADFU+vuSuUgn4kN/5nfxD1d6oxkY1oSybWR9vvUzFAW84B6ZfQuGGHLzmz6j7H0lYK/03HXcRrgeSA==
X-Received: by 2002:ac2:484f:: with SMTP id 15mr16910092lfy.3.1585068730051;
        Tue, 24 Mar 2020 09:52:10 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id l7sm3722496lfp.65.2020.03.24.09.52.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 09:52:08 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id c20so13859269lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 09:52:07 -0700 (PDT)
X-Received: by 2002:a05:6512:10cf:: with SMTP id k15mr17550349lfg.142.1585068727556;
 Tue, 24 Mar 2020 09:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200324084821.29944-1-masahiroy@kernel.org>
In-Reply-To: <20200324084821.29944-1-masahiroy@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Mar 2020 09:51:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjEi4VoT8qkBhrBtdZ27shyrPwo0ETpuOdxk5anHtQqhQ@mail.gmail.com>
Message-ID: <CAHk-=wjEi4VoT8qkBhrBtdZ27shyrPwo0ETpuOdxk5anHtQqhQ@mail.gmail.com>
Subject: Re: [PATCH 00/16] x86, crypto: remove always-defined CONFIG_AS_* and
 cosolidate Kconfig/Makefiles
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jim Kukunas <james.t.kukunas@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        NeilBrown <neilb@suse.de>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Yuanhan Liu <yuanhan.liu@linux.intel.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        intel-gfx@lists.freedesktop.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 1:49 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> If it is OK to queue this up to Kbuild tree,
> I will send a pull request to Linus.

Looks fine to me, assuming we didn't now get some confusion due to
duplicate patches (I think Jason got his tree added to -next already).

And yeah, that end result looks much better.

             Linus
