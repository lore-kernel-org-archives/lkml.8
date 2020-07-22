Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF329C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5E0B207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="elNYwD1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732233AbgGVSaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 14:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgGVSaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 14:30:05 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB10C0619E0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 11:30:04 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id j1so1490915ybh.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 11:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4e/KF48f9JUg5sygJxwMfUiq+YIbJ7Nlc7LSKPnv3rI=;
        b=elNYwD1e4l5A1KsSeru0ittmsBZcP9Qvxdm6i1W2vAadzRzceSIF8GOqVbab64YGjI
         xla+wgOFhaQAak7QezviTywlZwEDOs3EXob3DAeRjPBLlU/sRfiK0NJkdC02HnGu3cmm
         9Tza53NoK+Rx72dBOeEZt1gA3coJhMDCGjdVwsJMp35icIDjL/wLEA4XVM/l3n55IkYS
         LYiOBfmW64KojOHqjG6zVHTj5OVcDb9Q0fpMkzzJQon9sjivSRMjJguIdTyhBEQqBFMl
         I8ZkXOoRyc93D0lDVv7Jvo31XOVIfoCPP9bzu+FUgajm3oMoxsvj+snvVne/3F1M2nu0
         gj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4e/KF48f9JUg5sygJxwMfUiq+YIbJ7Nlc7LSKPnv3rI=;
        b=XE7dX6LfOuzfOq1PASjJN0OilWVm9hP/p0AbsSkiUN3ZDk1vJxy6l7N8+zuL1H+3dt
         vxj2OWRG2Kp20WZeQA14m8ItPNm+aRwYvPi6cthwOduil16sUhuAmiAnM5JCfFA6gVlR
         Q+WEACRG6uurbx3AdN6S6c9ENxwjxtCipbCTN+Ia8BzTYsJkljbm06WbzMoqSQxeMj8B
         YZSUWhxtPc5Ir1hd4V9JHJDaS0ONmix69OSQSqVEXVld1ALOGdvyixZVCyDn+MmcnlLO
         hvgV02xxJXn79BGYOCl8DECs6IA5MdhIHQSa0Zvrtc7HZW6xc9gQX9yiaCvIzlJ4P0Ji
         ScmQ==
X-Gm-Message-State: AOAM530aHcJleaFQU248XWl9Tptl66FuD4Bgjwoo+KTKj1Vy07Kg00oa
        YSIs7tj+tm48yOOl4s+Fpn2Y0vfNOU2W61dDZeLVTw==
X-Google-Smtp-Source: ABdhPJy+ZrG8SAw6xEmL/PrEzWg/CRqYaJT9N71mtGNjeBynwVo4OjeQbE9HHYEo9y47LHFPFKU+nTWaSv5a+5HPYl0=
X-Received: by 2002:a25:4e45:: with SMTP id c66mr925374ybb.333.1595442603378;
 Wed, 22 Jul 2020 11:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200721174654.72132-1-vitor@massaru.org> <202007211207.5BAA9D8D@keescook>
 <CADQ6JjU8rX2F_iBqth3u0EiA+CBgz4H+YL_-nbQ_cojYeLFXKQ@mail.gmail.com> <202007211911.666E080@keescook>
In-Reply-To: <202007211911.666E080@keescook>
From:   Vitor Massaru Iha <vitor@massaru.org>
Date:   Wed, 22 Jul 2020 15:29:27 -0300
Message-ID: <CADQ6JjUgVXBfHfb=V2ajwm=rHi12rxiqEtpivjY03xZbp6k7wg@mail.gmail.com>
Subject: Re: [PATCH v3] lib: Convert test_user_copy to KUnit test
To:     Kees Cook <keescook@chromium.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 11:12 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Jul 21, 2020 at 07:19:12PM -0300, Vitor Massaru Iha wrote:
> > When you talk about end-of-test summary, is it what is written in
> > dmesg and not the kunit-tool?
>
> Right, if I build this as a module and do "modprobe user_copy_kunit",
> what will show up in dmesg?

No, It doesn't. I'll put the messages again.
