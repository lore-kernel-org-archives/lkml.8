Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19458C34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E253220718
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="puy2ySPz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgBQPeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:34:05 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33855 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbgBQPeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:34:05 -0500
Received: by mail-pg1-f193.google.com with SMTP id j4so9371863pgi.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 07:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OnGntDBcyiKhIaqHVrJNbrm40qr8SM9LXEMNXQWW6ww=;
        b=puy2ySPzIMygltvNUbJE8vGf3zYfJWDb5d1gMlzL/Xhr1hVyX/AOPbH4tJy8m6CBrZ
         bOMYxrMlSPRkq7d4m4xS0UUQhkX6khSRHbB2Auv4TX6O6zaa43iDz52AQXnw0tH5hlHh
         Ei6p1C77fcO67RzPnKOeaUXQyp33kNaePe6WzzVao7Dm2hrk3n1wd0Xd00NA1+DMHUPd
         j7hh8bOQT+d5Fh2SjytG2tJYdalDhNkU5lVx8kx4t8GPbjbLaCJeDwkC/tZsnbsZbUPH
         jjGAMArjlXbqwcCByr1ZBWWe0X866EBAgE+EPaYGxCohozditLw4A44lg+/KL4wEdW5c
         4dhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OnGntDBcyiKhIaqHVrJNbrm40qr8SM9LXEMNXQWW6ww=;
        b=akEk1/P3JJm0jgZf1N1HlXXyYD+xGGY6b3ChQ17H2TCVVLd6m6AYeT/M/ZeTj7WCui
         IaN3v3WCoTzmorgmZgdGq/I+DRhBcJT7PLT5uUpQj5ynUDtlVHURLFtIVjWaSfRdLSL4
         ZCkjWpI9HtMiO+s7V4PCqsrOt6uEbJOovDeV3a6W8OXAvHOBWfsZ9Sobt9TQ7GyatzYh
         kJmx+1espnBJx/E9cYBb3uHOHqXHf8oklVlUwzU1X9qV4JoW5W7UmDKKGFg3y/qFBOX4
         FYsovI8Nd3W4VZ0GVsbIcCyVGMK3ZviosIhxu1D0P2X8eeyE1R3cOxvgT5SDBu1+gHc9
         EHpQ==
X-Gm-Message-State: APjAAAV4hx0Y3MGlECiQDJ0Sy6doiAJ3U9Dijwkntu+zxmRQQzG3Ssws
        58jcycwoM1W97ih2dUckvMdEOVo6Fqk=
X-Google-Smtp-Source: APXvYqz2CFg3GxIP/H+IgdKCxm1s0BXfvZ43HoHHoeIaCPsqWl8JRxmzOBbjGUiwrh89Li2i5GusqA==
X-Received: by 2002:a63:fc0c:: with SMTP id j12mr18071653pgi.378.1581953643383;
        Mon, 17 Feb 2020 07:34:03 -0800 (PST)
Received: from gmail.com ([64.251.70.126])
        by smtp.gmail.com with ESMTPSA id z16sm820852pff.125.2020.02.17.07.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 07:34:02 -0800 (PST)
Date:   Mon, 17 Feb 2020 07:34:00 -0800
From:   Andrei Vagin <avagin@gmail.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH 0/5] arm64: add the time namespace support
Message-ID: <20200217153400.GA26105@gmail.com>
References: <20200204175913.74901-1-avagin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20200204175913.74901-1-avagin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vincenzo, could you take a look this patchset?

On Tue, Feb 04, 2020 at 09:59:08AM -0800, Andrei Vagin wrote:
> Allocate the time namespace page among VVAR pages and add the logic
> to handle faults on VVAR properly.
> 
> If a task belongs to a time namespace then the VVAR page which contains
> the system wide VDSO data is replaced with a namespace specific page
> which has the same layout as the VVAR page. That page has vdso_data->seq
> set to 1 to enforce the slow path and vdso_data->clock_mode set to
> VCLOCK_TIMENS to enforce the time namespace handling path.
> 
> The extra check in the case that vdso_data->seq is odd, e.g. a concurrent
> update of the VDSO data is in progress, is not really affecting regular
> tasks which are not part of a time namespace as the task is spin waiting
> for the update to finish and vdso_data->seq to become even again.
> 
> If a time namespace task hits that code path, it invokes the corresponding
> time getter function which retrieves the real VVAR page, reads host time
> and then adds the offset for the requested clock which is stored in the
> special VVAR page.
> 
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Dmitry Safonov <dima@arista.com>
> 
> Andrei Vagin (5):
>   arm64/vdso: use the fault callback to map vvar pages
>   arm64/vdso: Zap vvar pages when switching to a time namespace
>   arm64/vdso: Add time napespace page
>   arm64/vdso: Handle faults on timens page
>   arm64/vdso: Restrict splitting VVAR VMA
> 
>  arch/arm64/Kconfig                            |   1 +
>  .../include/asm/vdso/compat_gettimeofday.h    |  11 ++
>  arch/arm64/include/asm/vdso/gettimeofday.h    |   8 ++
>  arch/arm64/kernel/vdso.c                      | 134 ++++++++++++++++--
>  arch/arm64/kernel/vdso/vdso.lds.S             |   3 +-
>  arch/arm64/kernel/vdso32/vdso.lds.S           |   3 +-
>  include/vdso/datapage.h                       |   1 +
>  7 files changed, 147 insertions(+), 14 deletions(-)
> 
> -- 
> 2.24.1
> 
