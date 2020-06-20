Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192C5C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 19:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBFDF2399C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 19:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592680477;
	bh=xG8B55ghwpn4HM6tdinVQ04uQEWLde3hKvgF7C6UOBo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pi4xkls5z3qVcJQCLAxVQjylsbIPHhDEDx3fhT0hVnA9k5d5/c8WZXndnx45YnGcs
	 XCKlhsY1J+RHAtEb9G0TByCMlt+KsiG6Cb/d7/L/idDo33aPhVo9tHkWjw6uEz9CDZ
	 AAF7h47l3zgltkCval8ihbTEsRiURdcgynpkRAwQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgFTTOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 15:14:35 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46990 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbgFTTOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 15:14:34 -0400
Received: by mail-lf1-f67.google.com with SMTP id m26so7408081lfo.13
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 12:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rLT5NQm5Gdiao5LFnbXicx4H9nK0dIz0m6pUUgA2bUM=;
        b=QewcG8XnW47c4csRZDroyH9m6W1rqSNfm8JCmtq6PTU7UzF/6GQR48pqd+++JAq2d5
         7fdIZvuI42lUbBQW7UAHvgnGzbNn5laVHOPdLWnSg+3S9kR8VckTTkuLHUxVECpFnsZQ
         dpEqU5rfpJ1MkZWAedQDJskUfNU5BX1E6lvZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rLT5NQm5Gdiao5LFnbXicx4H9nK0dIz0m6pUUgA2bUM=;
        b=J59hY+PSyD60CspILegWZpM1SCwmHgDCYY7CkLrezJOHLTu/QvPLxixZ6wU2nNfOWy
         WSaNYzHyT938ICeJ1eswhqkMh9R/wng0rsBx05u13x/fgJuIV7vDpbvdmFLL5pchdYd+
         jr+PY3OCFQ+wDJ4Z1Bxl4ejEl/aLQR656orFnt5vrr14Y/BYE2J7ooUnQcoj5GYzO7UC
         9mi3m26sMh2U3Fi1hdJ7pj2W9UEkAEwbTd2fu64fAPuCcLA4TX0aB4JsLICl2xKQA1nv
         jlM47ACRZQRrVe+NFaIdpCH1uI02G31syuHwelqwiDdQZwQdimkaVv50XsqLhOApulLd
         IOpA==
X-Gm-Message-State: AOAM532QqFt8leYyahjJ3zCv01mKvaVjFoNaE4A95ErKYHvrA8IokAtN
        Hr8vjVVyE4d2K0C/+wY9Tew97iSgg4w=
X-Google-Smtp-Source: ABdhPJybRrGxQ3V9/cDjMa56DmLUJdR0dE+ZhGVBT8yi26It/ciMErlbhHXWecc6XPiU3aJiJgDyUA==
X-Received: by 2002:ac2:5e34:: with SMTP id o20mr4241378lfg.5.1592680412563;
        Sat, 20 Jun 2020 12:13:32 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id d3sm1953898lfe.93.2020.06.20.12.13.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2020 12:13:31 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id n24so15064471lji.10
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 12:13:31 -0700 (PDT)
X-Received: by 2002:a2e:b5d7:: with SMTP id g23mr4462227ljn.70.1592680410966;
 Sat, 20 Jun 2020 12:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <90024a5c-ea67-2529-e330-3a4f0bef6596@linuxfoundation.org>
In-Reply-To: <90024a5c-ea67-2529-e330-3a4f0bef6596@linuxfoundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 20 Jun 2020 12:13:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgO-3ZNiaM5gFbgtaSmEYnyZ10TUZz_JgXdzaK54xp1Kw@mail.gmail.com>
Message-ID: <CAHk-=wgO-3ZNiaM5gFbgtaSmEYnyZ10TUZz_JgXdzaK54xp1Kw@mail.gmail.com>
Subject: Re: [GIT PULL] Kunit update for Linux 5.8-rc2
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 10:28 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Please pull the Kunit update for Linux 5.8-rc12.

This doesn't sound like a fix for after the merge window. Explain.

              Linus
