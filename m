Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1B1C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B1C2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UFoVyIMo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgBUPbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:31:21 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41452 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbgBUPbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:31:19 -0500
Received: by mail-lj1-f193.google.com with SMTP id h23so2600151ljc.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 07:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=umwufImp+RAKAXYwNmIfHSar8yKzL+hitzXL/t+Eqo4=;
        b=UFoVyIMokBF9uMtOCiNiPbsM2bcjPQ+rSe1suiXN9tHQ2gXelPi7omzcHdFjHomGFx
         2wXd9ifKNWI/ND8syyRtKd+Wk3RJLsAB27RsLnX3/w+pm8nGyfC5R/uS7HtXafLgra6L
         Cu5d684iOB4wqdn+8TY2FbwH0ovff16NXGl7eKvscbJaws92YsNk1QNB84h+ePLE2AHH
         fqyzrUNEo/7gmZjxOjfkpXcU8z9w003F8xC5Kp5tWkzpGAzcCzgJTzbJbdLvYcoiljMH
         1dsMko1/zy8EYMXbJ78z+RoYyexW5mlpD+2VhbAmc1QkxKXjuU0H40X94LRR9Oj99DpV
         5+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=umwufImp+RAKAXYwNmIfHSar8yKzL+hitzXL/t+Eqo4=;
        b=SAIppuesddmAUg0SAHZkBH1YTkvpTYKZ+HiI3Avis2s5h5O0Vkj5FeozegYFpRy0sO
         2s6De/ZZ8Tk6JeATc8cUcX1UXPsMzozGRJDh43JnRAnwPq8UHf1LpRvLFV26XRbFJi+C
         cyFOw8KtDnSQRyObYNNvopMrGQh8XSYsu7oMXp3aMvh3HmRf/gBjCYmSxl1ZPHbbEyVm
         YwlSa27dk2U+KWCqlYiJi0Bv6s4sNMXw8xfi5AkzS4XVkuG1XRehWvgp07TD7XpmqAyD
         G3XCbuHk9DOQUcrSPKXsntEhHoxDQJrmcq4+VRvsKgl0qhhSaIffr4Ls0hvSId9bsB1V
         Sf/Q==
X-Gm-Message-State: APjAAAWacCIOTPJXaZ+GrutQS7oSIt8/un4tN7ZQFWdEwYiEU1M+cY5C
        hMgW2fIZf5sWC+7xQVVMbA7hBvgr1RLixizKpvkaxw==
X-Google-Smtp-Source: APXvYqy40L7BUxSoL4RPpdy6dgmoozwbqU5Au4UJypIZx6/XGeiyRlZMQAfFrJbPwb+oGeu+EOX8ahlhnv3TyHgZTaM=
X-Received: by 2002:a2e:9013:: with SMTP id h19mr23128266ljg.223.1582299076864;
 Fri, 21 Feb 2020 07:31:16 -0800 (PST)
MIME-Version: 1.0
References: <bc20fdbcb826512cf76b7dfd0972740875931b19.1582212881.git.jpoimboe@redhat.com>
In-Reply-To: <bc20fdbcb826512cf76b7dfd0972740875931b19.1582212881.git.jpoimboe@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Feb 2020 16:31:05 +0100
Message-ID: <CACRpkdbXLKpzOwc7pkdPEN8DAQk64P=5qTo3HfW5tvZnYL70UA@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: ingenic: Improve unreachable code generation
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 4:35 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> In the second loop of ingenic_pinconf_set(), it annotates the switch
> default case as unreachable().  The annotation is technically correct,
> because that same case would have resulted in an early function return
> in the previous loop.
>
> However, the compiled code is suboptimal.  GCC seems to work extra hard
> to ensure that the unreachable code path triggers undefined behavior.
> The function would fall through to start executing whatever function
> happens to be next in the compilation unit.
>
> This is problematic because:
>
>   a) it adds unnecessary 'ensure undefined behavior' logic, and
>      corresponding i-cache footprint; and
>
>   b) it's less robust -- if a bug were to be introduced, falling through
>      to the next function would be catastrophic.
>
> Yet another issue is that, while objtool normally understands
> unreachable() annotations, there's one special case where it doesn't:
> when the annotation occurs immediately after a 'ret' instruction.  That
> happens to be the case here because unreachable() is immediately before
> the return.
>
> Remove the unreachable() annotation and replace it with a comment.  This
> simplifies the code generation and changes the unreachable error path to
> just silently return instead of corrupting execution.
>
> This fixes the following objtool warning:
>
>   drivers/pinctrl/pinctrl-ingenic.o: warning: objtool: ingenic_pinconf_set() falls through to next function ingenic_pinconf_group_set()
>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Patch applied.

Yours,
Linus Walleij
