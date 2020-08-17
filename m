Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480FFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 22:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ED0B2063A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 22:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597702409;
	bh=5UQ4hE7OhlafVDnLkqDCjvyLjZQoSJpBMKESbllqE0I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PtBY7bSBdyLM8muyQqpuXq8J99CtrNQZQXrnXe7Qd6qvn0FZa82722iNUKAJaMdV9
	 b85ODnMJ4saGGUo3Ru2x/jPT8PomkiWcs/+qEBDYc5VfhGPpDp/YkXTQcex2cG4OYB
	 qhYmCEqY5nPei6pjNoNZ+XFwKfMqi9w9lgHA1t4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730477AbgHQWN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 18:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730429AbgHQWNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 18:13:09 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB42DC061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 15:13:08 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id t23so19221928ljc.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 15:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=26LrDJXqJLI6TFM10r1vs3mU6KeP0Tqlx0OGxUpHgLM=;
        b=gBDu5V7G1HFcoj4N3yt3hf/J8px7HDGic43uxR5FXb1kXpR+lrm8bxoaAx8mEtSsmL
         uYMYjA6rc1irgw6iTnUR6Gui0Ys8KiGgV19BjiPY8YYpbALXS7lQArBKGBEoL9zkKgfA
         aCFG6DmlY9VUjKrDWFahAC0fBF/JADFwEWOR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=26LrDJXqJLI6TFM10r1vs3mU6KeP0Tqlx0OGxUpHgLM=;
        b=kWLEVMGlBQOTXpTpuO5pxXA5W4I8zubfP8AF5quIEfPJ5XxAz6i4Iu8kIQg3cZH4lZ
         Nr2utSyWGTArW24ebCjHhTjuDG/PhF2AgskMYCExegABKA5iz56/gL0YEb4zE/UQL4G5
         72LR+c0D6x7MQEEI0hOJyIBTcKWgy6u64kS/4l77/uLtVv1sAh+cxPc2RDYlJcwefaHv
         njbFyXQ1q+8CPT0bgZ4RxC4CS0AL5tfdVqexdytN7ziaQxbKGwwJiwrSyVAztPkzQHwT
         k/4MwzqUzHQlAq1H5Z3/bavERhPOHbSDOiAnRwjfqU8qfoER53DR6hyB71YnXGETBwsL
         kpJQ==
X-Gm-Message-State: AOAM532AAIoh9JpEnQ252McbEfhooC/lccySeTTzzUXw3Xk2PEDf5VB/
        MCkDMObbX107PgIGS8USinZOmRrtz+hyMA==
X-Google-Smtp-Source: ABdhPJxQMy19ezvjI9+69a606wcQhCjRDFU2s7MSajlgCgwcpOh2clz1WlhXryPxYqXHd8eGBa0zOw==
X-Received: by 2002:a2e:8652:: with SMTP id i18mr8038969ljj.323.1597702386713;
        Mon, 17 Aug 2020 15:13:06 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id w19sm5282286ljd.112.2020.08.17.15.13.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 15:13:05 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id i80so9135932lfi.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 15:13:05 -0700 (PDT)
X-Received: by 2002:a05:6512:241:: with SMTP id b1mr8253411lfo.125.1597702384913;
 Mon, 17 Aug 2020 15:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <c6fda26e8d134264b04fadc3386d6c32@gmail.com> <20200816175303.GB1236603@ZenIV.linux.org.uk>
 <20200817204223.GB12414@amd> <87lfid6kpi.fsf@x220.int.ebiederm.org>
 <CAHk-=wj04wKCjHz6b6d7N58xoS4AftnwTUBaXsEekQ5RhfWVnw@mail.gmail.com> <20200817220908.GA3701@amd>
In-Reply-To: <20200817220908.GA3701@amd>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Aug 2020 15:12:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh7Rn=8mVi_KWV71ZaQ2HrCz240DbjEJMDdARTwB3CYvA@mail.gmail.com>
Message-ID: <CAHk-=wh7Rn=8mVi_KWV71ZaQ2HrCz240DbjEJMDdARTwB3CYvA@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Yes. Finally remove '-Wdeclaration-after-statement'
To:     Pavel Machek <pavel@ucw.cz>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Witten <mfwitten@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        John Levon <john.levon@joyent.com>,
        John Levon <levon@movementarian.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 3:09 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Submitter believes "wild variable placement" can help with
> #ifdefs.. and that may be actually good tradeoff.

I agree that it can help in some cases.

But it can also make it really hard to find the variable declarations
in other cases. I've seen a lot of code that ends up actively
declaring the variable close to where it's used (because people find
that to be locally more legible) and then it just means that people
who arent' familiar with the code have a much harder time finding it.

I'd instead try to discourage people from using #ifdef's inside code.

              Linus
