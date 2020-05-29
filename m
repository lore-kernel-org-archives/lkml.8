Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD1BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 759542077D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590776256;
	bh=pgAqEdUzKcUwBwqLNg3BHrONspnV+MTWLHGiKTihzWI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uum13R9HTLjwFy8h840fIGFdGrmptk+PiHk8ZQ6G04vbrJgG/4UUIbFwwL+GTO1/n
	 qs10N3sUSJRlxxY65yNNViJMeE+bP3Q3h+dlTONh5qy95iuUVFctzjE6exNd39bSLX
	 smA22BnnRw76olNOsqAl74gPetefcWQa2PTrGW4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgE2SRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 14:17:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgE2SRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 14:17:35 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76FE42074D
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 18:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590776254;
        bh=pgAqEdUzKcUwBwqLNg3BHrONspnV+MTWLHGiKTihzWI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1qnqp/VG2qJfOQvt11etNhVK5pyb+DDPgPUh7Tc5edJQkoUiVJiIgkfpCCzD0EmLT
         i6O1qr1mG6XFloeP5uSVGfEmAzLy89wVfJglBVPBY2YQKGNR7mFB53jcmHKv7/ASzU
         Jez1mX7CXvjLhXbsNxInxh+8iJPvJqfwM4Vgn0d0=
Received: by mail-wm1-f53.google.com with SMTP id l26so4553958wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 11:17:34 -0700 (PDT)
X-Gm-Message-State: AOAM533IYBs72mrZ1mhV0j17YvOdpuuCOrtUOLh+hEiLdjprJ2SkEL2O
        ps4R/tUWJYncH1cNPIl8AKy3W1DOMsquIQ5/F9XqaA==
X-Google-Smtp-Source: ABdhPJzFB/GIiTKjLSZ3XNJ0Vr3xMJDHga1nj6HPKxmmkly82dc1ymgLmihBOqwPLIZGoNfPw5CXdhfe4EMW8drvKxg=
X-Received: by 2002:a1c:80d4:: with SMTP id b203mr9755071wmd.138.1590776252949;
 Fri, 29 May 2020 11:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200526043507.51977-1-laijs@linux.alibaba.com>
In-Reply-To: <20200526043507.51977-1-laijs@linux.alibaba.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 29 May 2020 11:17:21 -0700
X-Gmail-Original-Message-ID: <CALCETrW7Lg9YGeJ=xQ51Hd_XA8W0tCXNeSGDQYiEACd1+gy7Bg@mail.gmail.com>
Message-ID: <CALCETrW7Lg9YGeJ=xQ51Hd_XA8W0tCXNeSGDQYiEACd1+gy7Bg@mail.gmail.com>
Subject: Re: [PATCH 0/2] x86/entry: simplify RESTORE_CR3
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 9:35 PM Lai Jiangshan <laijs@linux.alibaba.com> wrote:
>
> When I searched percpu data touched by entry code for #DB
> protection[1], it seems to me RESTORE_CR3() does too much work,
> this patchset simplifies it.
>
> Patch 1 enhances 21e944591102("x86/mm: Optimize RESTORE_CR3") for
> kernel CR3.
>
> Patch 2 *reverts* 21e944591102("x86/mm: Optimize RESTORE_CR3") for
> User CR3.

This series looks correct, but I don't think it's 5.8 material.  I
also want to try moving all this code to C, so it's possible this
little series will become obsolete.

>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: x86@kernel.org
> Link: https://lore.kernel.org/lkml/20200525145102.122557-1-laijs@linux.alibaba.com
> Lai Jiangshan (2):
>   x86/entry: Don't write to CR3 when restoring to kernel CR3
>   x86/entry: always flush user CR3 in RESTORE_CR3
>
>  arch/x86/entry/calling.h  | 36 ++++++++----------------------------
>  arch/x86/entry/entry_64.S |  6 +++---
>  2 files changed, 11 insertions(+), 31 deletions(-)
>
> --
> 2.20.1
>
