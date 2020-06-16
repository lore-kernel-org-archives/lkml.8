Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEAEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 20:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22C6C208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 20:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gGmk/ieG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731565AbgFPUMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 16:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730725AbgFPUMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 16:12:15 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39563C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 13:12:14 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id c11so2162829lfh.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 13:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pftCPQZs6yZlUKQCEycmHT/yr3pM22oYiEVkGmtXrxQ=;
        b=gGmk/ieGhUlMNLy05d/JBSnbT4qPZno6utnyeKNWAuQAEepAe2FPeFYuVTl1JWhsol
         l2Sp914GmfUQd8xeU1hMlQUvO28mqJlWqUhVDRlqaafotmjBU7Hq7BQH7c0IN+IR7AKc
         z652Xgqt5tP/XQ0kh9/w53MD/lDbgfOEDcwLsYtMG1gDnHPg2JHUduVSsMz+L15XB6PF
         LlGfjmFw+sCofjZ+FgtZspxRSCJgDBiG3TnkSFxSLlHW3quTa0HQ19BK5R0j+01hJ865
         8CsEoUf4J1jsF58gnBq9V8o2RQ5tR8txZeeLxgUH/BUq6zfc90iuj68fmixepnwPn58m
         woYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pftCPQZs6yZlUKQCEycmHT/yr3pM22oYiEVkGmtXrxQ=;
        b=UoEhxz6hb4QiyAEpXZrUj/7OA3uyq7gITGVYEmhIVWsMxbX/or4sjl3LVk2xDuPMyE
         Yja1UGdFO+DjHObtYxaVrwBrGjq/hwHZNTwP3J7ALeYjnQwqsJ5sdEmk6g0kHlMQtHiw
         T/T+cXP1BO8qR3AARJPFzHn+Z/gaUgZnJ71rM1k4G+8GBAUTv9CSva+8EnBov//Pja6q
         vWzNfuEFQlgWl0zcAbpdnMM77WA1WY0P0yv81cxCO/RuclaqyAvf3GrWaWQT+8QPJgGw
         7TeHgvflHqPKMWVmh+03Au9pAoXTteHfaV8EewjWvx6vA5oiEXXNSpm+s/7Cgp2c+0nd
         PLEw==
X-Gm-Message-State: AOAM531bW1EoO/EGaSMmfOaLLEazt+a+MkjwfeLvP93I51SqIoWqyC0+
        Ai9U26CkT2+DPkzr5HxlPu4Lh3h5RBqh5i5Dc4ErJ/gB5A==
X-Google-Smtp-Source: ABdhPJyGFaUB8RfIfsfrrCPrpdCoDTfp649cDB/OzO5TcXboYTnVu0uyM6t1wgGwgiqrJgrhg8Z59FROCJAY2xFuJmM=
X-Received: by 2002:ac2:5c09:: with SMTP id r9mr1762928lfp.176.1592338332729;
 Tue, 16 Jun 2020 13:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whfuea587g8rh2DeLFFGYxiVuh-bzq22osJwz3q4SOfmA@mail.gmail.com>
In-Reply-To: <CAHk-=whfuea587g8rh2DeLFFGYxiVuh-bzq22osJwz3q4SOfmA@mail.gmail.com>
From:   Gabriel C <nix.or.die@googlemail.com>
Date:   Tue, 16 Jun 2020 22:11:46 +0200
Message-ID: <CAEJqkgi3w+zvMkRBP4VtAewX1UJxrVNRQ03MtRN_yH-PwOOScQ@mail.gmail.com>
Subject: Re: Linux 5.8-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Am So., 14. Juni 2020 um 22:44 Uhr schrieb Linus Torvalds
<torvalds@linux-foundation.org>:

Hello,

> So I didn't really expect this, but 5.8 looks to be one of our biggest
> releases of all time.
>

I hit a compiler error caused by e4160b2e4b02377c67f8ecd05786811598f39acd.

x86/purgatory: Fail the build if purgatory.ro has missing symbols

Having CONFIG_STACKPROTECTOR* & CONFIG_KEXEC_FILE enabled always
results in a linking error like this:

LD      arch/x86/purgatory/purgatory.chk
ld: arch/x86/purgatory/purgatory.ro: in function `verify_sha256_digest':
purgatory.c:(.text+0x108): undefined reference to `__stack_chk_fail'
ld: arch/x86/purgatory/purgatory.ro: in function `sha256_transform':
sha256.c:(.text+0x1c74): undefined reference to `__stack_chk_fail'
ld: arch/x86/purgatory/purgatory.ro: in function `__sha256_final':
sha256.c:(.text+0x1e65): undefined reference to `__stack_chk_fail'
ld: arch/x86/purgatory/purgatory.ro: in function `_kstrtoull':
string.c:(.text+0x2107): undefined reference to `__stack_chk_fail'

I didn't look closer at that but from the error, it seems to be,
some missing -fstack-protector* vs -fno-stack-protector* checks
somewhere.


Best Regards,

Gabriel C
