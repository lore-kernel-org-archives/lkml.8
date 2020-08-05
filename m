Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6359C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8F652250E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596656754;
	bh=N/7riuh0kCfKhos4maGk+jEUgro5VvU/il+Kcj9x3Nc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SmO/iwAnZ643QfPWNkwKwvH/m2yO28UfZYngmtELL+LCG9Xynm9BrnrCP10RMvQjs
	 WKg6/AEU/3+60lIK2dCbggOXQVQnnp2sFgUm34EVyFVVJU+i5ibnYNRgFAWGaxwIvt
	 JoZj5tU/bN0dLBuTNUpZULfF+tZ2FbO2aubnlrVo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgHETpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbgHETps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 15:45:48 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486D8C061575
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 12:45:48 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id x9so49101663ljc.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 12:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YMknd1+dlXX/Q3YM8+W65fV77VdzsmUF/OU4h6Xq9xE=;
        b=ZAog/SvHzVeXNMZb2Fj5fRotY3ezW+cicXN46stQ1/EcG2JvDXQPNisMdRpFYwto3Q
         Dv3M/sBUceZ5Dyhdv1XWGkFmj4MJymVOF7batv5qAvZjxsoQDutBTN4BJSi6RVDxcp3D
         +gb2PdLmzPW3FgOKTKFIsirWz5+LHUS5bP2gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YMknd1+dlXX/Q3YM8+W65fV77VdzsmUF/OU4h6Xq9xE=;
        b=USmsfdciSdr11akVF9BYLNoHknZATLM3jBJkVvSN+qkVgf4aerYrMcK0R16dcE3uGO
         RJKxdPxTT4nfE1tpY8BflLNcT5K0fryo463HlIJmWy7YBIlT60IzqV4XPjOJ3C1Z2x8V
         kU3qakAp49KSB/UFiOs+w1okro7/moJtC8xuDjJ5dn0CTu3xYF1puoTUuVFK8hRTYHhr
         stKp6CuMiSNhYKSm4G4vJAqXp6GvDtFi2P6nBEY7iYk6+ZCvhNPS7W3N9ZbwOdlcjRQd
         tMfzN56koAzxO6ASEmCYBmnGYji0mtfPTHpykMKb6h6iYEpkfFMebz7qdyDOxHaY6CGQ
         AUqw==
X-Gm-Message-State: AOAM531K0wdsgKktZ8+M370QVUDyKu0iZiO2TYkCYjkwjOzL92WPdysf
        fCIY8NlqKUkIOQyBD0OA4dOPJgYG0Ho=
X-Google-Smtp-Source: ABdhPJxbttMueh0g+FJQJHAU0nMBUlO+pk/KI159Lt0689bPr4sf3zDhDeQzL2MVZHxWRslyCJhDhw==
X-Received: by 2002:a05:651c:1a7:: with SMTP id c7mr2279863ljn.345.1596656745353;
        Wed, 05 Aug 2020 12:45:45 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id s4sm1553029lfc.56.2020.08.05.12.45.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 12:45:43 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id j22so19005357lfm.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 12:45:42 -0700 (PDT)
X-Received: by 2002:ac2:522b:: with SMTP id i11mr2306959lfl.30.1596656741926;
 Wed, 05 Aug 2020 12:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200805153506.978105994@linuxfoundation.org> <CA+G9fYv_aX36Kq_RD5dAL_By4AFq=-ZY_qh7VhLG=HJQv5mDzg@mail.gmail.com>
 <71a132bf-5ddb-a97a-9b65-6767fd806ee9@roeck-us.net> <CAHk-=wi0WGMs6+Jz6rXbQO4mfzf8LGVc3TwmCdz0OwRtj7GgMQ@mail.gmail.com>
 <7e1c9df5-d334-461d-56fc-53625c6ca163@roeck-us.net>
In-Reply-To: <7e1c9df5-d334-461d-56fc-53625c6ca163@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Aug 2020 12:45:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1m3VFa6Sz96gxNjKCOH21jDuuODm46-VAukD5YGc1yA@mail.gmail.com>
Message-ID: <CAHk-=wj1m3VFa6Sz96gxNjKCOH21jDuuODm46-VAukD5YGc1yA@mail.gmail.com>
Subject: Re: [PATCH 5.7 0/6] 5.7.14-rc1 review
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <maz@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 12:24 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 8/5/20 11:37 AM, Linus Torvalds wrote:
> >
> > Because the trivial fix would be something like the appended, which is
> > the right thing to do anyway.
>
> Correct.

I'll take that as an Ack, and also remove the crazy reverse include
from archrandom.h that most definitely shouldn't be there.

It's now commit 585524081ecd ("random: random.h should include
archrandom.h, not the other way around") in my tree, because a grep
for "archrandom.h" shows that now the only place it exists is
<linux/random.h> and a few files that cannot possibly affect arm64
(because they are on x86 and powerpc, neither of which has that insane
reverse include).

               Linus
