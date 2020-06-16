Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3612DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A3B620644
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qaoLYrfY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgFPIlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgFPIlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 04:41:45 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E74BC05BD43
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:41:44 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t8so1607818ilm.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C9Ht3rje4vjIOp9lVzmW76JWjSSJxPkhpI6gvlvB4wA=;
        b=qaoLYrfYUXl7c6aIemIuQ99M8rRpyqaO/kUHXwJEBvIZyq/VBYHcareqmotJAH9lLc
         56pEn63BOGWwVz9KjHbf5jzJqdRpTOe9LPHQ6o8/VXocyVbRE8BcUkk9XWJAsk+XTYX0
         d4ZJMMkZChDt4CLKSkfnNvfDjAh7GbHJFfUdxrP2RRBdgQweOldjR14hEGuHry6x+oQR
         8jVKTb6ddwN118FUhUknxC9EjaLPKMTwRgPty/uB2VEGaqiWxjZOtPHy+CXmL6AvLn8Q
         DRfSnQsBPg61EM2Qi8JUb/2xLl3JS1LXqrUZ57SSUpgjPsAAcyQZl7lSM71JQHBzdT/p
         72LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C9Ht3rje4vjIOp9lVzmW76JWjSSJxPkhpI6gvlvB4wA=;
        b=uVUUH284M807k6H/NY+d4jaTAmy8TegYFCVgngtq3dvX4FhjiR91pt/zvi/XUbn45p
         gbq8mcUBa3YJLhhHRo+Q+AfNnf4RzDw7rq3SO6puteGDjUvA2YR21Y6IN4JyN7X2buhB
         vQmERJwojxcVIipHkcpq5Z0mcMi+YeEU7RHXKZ3R6t11xZHCoZHU/bQmp9D+BAQxjtu/
         BSrFJNoeYjfDiElpeeMVFRmeahuraQDGiIcHBkmHozrZcjO4FAUtMwz7Bt6LGIpzhWme
         qQRMxJ/bHepVhTqzCTz0hPDQ505W2e+HMP+HPt/byybPejQhpn+jU96IZPhuH+r53ycU
         LgcQ==
X-Gm-Message-State: AOAM531SkaPbajX9gOJmnGLLBpGqTVvrhNptbL8/7IK3vcNhasc9NcYH
        7uCLVZHhBdDI9/sDPUL/5VDXJbKJudNNU48S5h/ljQ==
X-Google-Smtp-Source: ABdhPJyanRIjbOuGwBP1VEFGrN5ihZSTowEWmy+4Viu43fl2xUf4wkIK3l3OyeAPICpXPk4gHBFjvCnau21slYync3M=
X-Received: by 2002:a92:af44:: with SMTP id n65mr1905398ili.61.1592296903309;
 Tue, 16 Jun 2020 01:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200616083435.223038-1-glider@google.com>
In-Reply-To: <20200616083435.223038-1-glider@google.com>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date:   Tue, 16 Jun 2020 01:41:31 -0700
Message-ID: <CANP3RGfGThsMOyi2faZmWb5S8tner-aQOsppP=_1+Fm0TDO95w@mail.gmail.com>
Subject: Re: [PATCH v2] [RFC] security: allow using Clang's zero
 initialization for stack variables
To:     Alexander Potapenko <glider@google.com>
Cc:     yamada.masahiro@socionext.com, Kees Cook <keescook@chromium.org>,
        jmorris@namei.org, Nick Desaulniers <ndesaulniers@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-security-module@vger.kernel.org,
        Kernel hackers <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In addition to -ftrivial-auto-var-init=3Dpattern (used by
> CONFIG_INIT_STACK_ALL now) Clang also supports zero initialization for
> locals enabled by -ftrivial-auto-var-init=3Dzero.
> The future of this flag is still being debated, see
> https://bugs.llvm.org/show_bug.cgi?id=3D45497
> Right now it is guarded by another flag,
> -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang,
> which means it may not be supported by future Clang releases.
> Another possible resolution is that -ftrivial-auto-var-init=3Dzero will
> persist (as certain users have already started depending on it), but the
> name of the guard flag will change.
>
> In the meantime, zero initialization has proven itself as a good
> production mitigation measure against uninitialized locals. Unlike
> pattern initialization, which has a higher chance of triggering existing
> bugs, zero initialization provides safe defaults for strings, pointers,
> indexes, and sizes. On the other hand, pattern initialization remains
> safer for return values.
> Performance-wise, the difference between pattern and zero initialization
> is usually negligible, although the generated code for zero
> initialization is more compact.
>
> This patch renames CONFIG_INIT_STACK_ALL to
> CONFIG_INIT_STACK_ALL_PATTERN and introduces another config option,
> CONFIG_INIT_STACK_ALL_ZERO, that enables zero initialization for locals
> if the corresponding flags are supported by Clang.

I'm a great fan of zero initialization as opposed to pattern.
I don't understand why clang is refusing to make this a supported option.

Anyway:

Reviewed-by: Maciej =C5=BBenczykowski <maze@google.com>
