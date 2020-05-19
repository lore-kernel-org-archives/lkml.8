Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE60EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A52320758
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589918100;
	bh=JLU0NEysv33MM5MucZzZQHsgeXzfaNJ7YtATqrQxrCE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=q+Bfu/Vs7E1tABMBqjYj3nwOf+RSWj3BMsGPBoBkauN+XZ7vS+25+SkFsfNRMRYmW
	 NSe3fTcOtmyK0qKMT0sTOSb4HmNpbZtaHkULnY8EYBvhfhspsflosi8V3hXDFEiAx1
	 YSkSk3xgQ0DM23Wzph+Pj6xkDWJZOCXYO161jdVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgESTy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgESTy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:54:59 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7144EC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 12:54:58 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q2so1045091ljm.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 12:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=REdFGTptWqU1qPX4qurL4342JovwYtU3BmwaSdni0jo=;
        b=W9vfQUXrQkvO4DXovXCeM4zoltpY1ZvWxEMenkkAoYs6zHAKFOlS07VVGBZxcFHdnr
         5UDWGSQ+Y1VhNSe2vl8jU8Abr4KLfjA+1Yw3wmcLWjiZR9tzxuzbfsBm4Q3VARObsqvY
         bKB2U0d4amvLqbkcAdva8jfUvV9Pe5jyvgAh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=REdFGTptWqU1qPX4qurL4342JovwYtU3BmwaSdni0jo=;
        b=H9yPM3K057rIeKx/m8Zf6XWmW9G4qPempjes2vakeSIYX5HEyUEgR34+xxHlvjqkMu
         nNc/A6HiXS7UOpb0AybhXSlud7P6r1Q+e+1sWTgkvOk8AcA77W+I2agLAX2n0SMZyuN7
         c78yt+/2MclkQsVokcnQtGNBCaSTgvmGdNhB5WHL1s68hwOKfCtjj4iBJ/Q5xW63/8rH
         ARSrCU7xMW4WrPRrABVoA7Th3eGqCpBH1oQ7yK5cS0ZL6UoLLf84gds6p64i4qbw0wgj
         7hCxJqrpaUasND+TeFS764hMFqPB+06XLKKPg9D+aASS2XVaR/0V2I+Vj96JsOsoNjkU
         mAvQ==
X-Gm-Message-State: AOAM5336/xXof7hGCPGv4LurRo1iINNg63qve51Nxn8tUP/bf2Ob6I3q
        jBhQu9ndUxC5LRIXFCvSc9EKnYnV8Bg=
X-Google-Smtp-Source: ABdhPJwhu1XHi4oyKgajpoPvz/b0nCfiRdHxyU92HDIiZ0+Jd5oXDEeOB2DdbCbjBRhs0FMr3mlo4g==
X-Received: by 2002:a2e:3208:: with SMTP id y8mr655866ljy.166.1589918097024;
        Tue, 19 May 2020 12:54:57 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id x28sm282527ljd.53.2020.05.19.12.54.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 12:54:56 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id k5so1037411lji.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 12:54:56 -0700 (PDT)
X-Received: by 2002:a05:651c:1183:: with SMTP id w3mr641496ljo.265.1589918096078;
 Tue, 19 May 2020 12:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <87h7wujhmz.fsf@x220.int.ebiederm.org> <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> <877dx822er.fsf_-_@x220.int.ebiederm.org>
 <87y2poyd91.fsf_-_@x220.int.ebiederm.org> <202005191220.2DB7B7C7@keescook>
In-Reply-To: <202005191220.2DB7B7C7@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 19 May 2020 12:54:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg=cHD0oZTFgj0z33=8H8yKEcbn=eNpTj19GPEgJwrQzg@mail.gmail.com>
Message-ID: <CAHk-=wg=cHD0oZTFgj0z33=8H8yKEcbn=eNpTj19GPEgJwrQzg@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] exec: Generic execfd support
To:     Kees Cook <keescook@chromium.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 12:46 PM Kees Cook <keescook@chromium.org> wrote:
>
> Though frankly, I wonder if interp_flags could just be removed in favor
> of two new bit members, especially since interp_data is gone:

Yeah, I think that might be a good cleanup - but please keep it as a
separate thing at the end of the series (or maybe the beginning)

                Linus
