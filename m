Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349FFC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 22:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1089E20774
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 22:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="OC/hLkJc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbgE3WJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 18:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729083AbgE3WJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 18:09:55 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F2BC03E969
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 15:09:55 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s10so1744410pgm.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 15:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=IJG975TaiBmIzLOVZ3nGyQfAGrYF+nqirpk8j/Gw4m8=;
        b=OC/hLkJcKCfkGjca/ksMnRr18G7AnBBEf/2e93joZYzpvYe3dvBkCGIxx0GpjR0Bbn
         kz+ua65cRcjsMcjmRHDj0QbWXekl2mV9OQWjob9+bBdNRCMPbb4MxojQ/icpHT556XTA
         arNOf4B4/useyzw6ykKvZ6z7REkUIC6K7wyL6YiaLb2m939w6d41FkzWfAuZfOHbTHLJ
         uMxHXRPJsrQC9MxrQaUAmWzoT966BsE6PSbjkVSzWbndG2+Z39TGgQO+iHJ5tir7lgin
         a18DwZ/j4ZneYPlAEjRqswtTczuCXR7TxTVcyHerjpKC0U7gGppEaQ8j1C4qiwHhd6Yd
         fEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=IJG975TaiBmIzLOVZ3nGyQfAGrYF+nqirpk8j/Gw4m8=;
        b=G9hVUSgBQ8eTBWNbpFThHOBglWArVONokGm+y+TENJ0YtMJmCx2WD7f5nErnsRhxyf
         EVtxH+JEL9XBuPZlY+lCreeoOgrUsNQekg2eiawHgyZz91bLERBoZ39d5KQkIgCHY2gy
         Q+ZW/ZIqSViVJfAL51x/g/M+TxttAtkd/AKX9jJIYTzgaP5FVad/vOGxjhGBAND1F/ZB
         Ve1yf8t/Gv7hCzD34jZSS+4IZd/U9yIFUNJsx1XmjMxFUCZWouacTqY7U93bY95jPalq
         64olD0l/PvYxgrjIe/ggP37CU8UhpI/yhUzCBmcaFLP8WdsDEwcEONuR4+vUcSumhsbi
         2ZxQ==
X-Gm-Message-State: AOAM531jVzHKBjoBelAul/ZAjaeVs+n3TbR8bkbvWQZAo0aRZzvtG+3z
        7jOhxXzfK2rh6tQ4m+1t9WVZZQ==
X-Google-Smtp-Source: ABdhPJyw1L2yZts8THEmLvBEWQkmWYc16lkejAQ1R9GVuduClxKl8KSpejZFvIg8PQL+n7hgheZizw==
X-Received: by 2002:a62:168d:: with SMTP id 135mr13680179pfw.239.1590876593499;
        Sat, 30 May 2020 15:09:53 -0700 (PDT)
Received: from ?IPv6:2600:1010:b04c:ab45:e4c2:341d:a35e:6a40? ([2600:1010:b04c:ab45:e4c2:341d:a35e:6a40])
        by smtp.gmail.com with ESMTPSA id j10sm3021457pjf.9.2020.05.30.15.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2020 15:09:52 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC] seccomp: Implement syscall isolation based on memory areas
Date:   Sat, 30 May 2020 15:09:47 -0700
Message-Id: <AF65147C-15DB-4BA4-A08B-55676B489BA5@amacapital.net>
References: <20200530055953.817666-1-krisman@collabora.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Gofman <gofmanp@gmail.com>
In-Reply-To: <20200530055953.817666-1-krisman@collabora.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
X-Mailer: iPhone Mail (17E262)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 29, 2020, at 11:00 PM, Gabriel Krisman Bertazi <krisman@collabora.c=
om> wrote:
>=20
> =EF=BB=BFModern Windows applications are executing system call instruction=
s
> directly from the application's code without going through the WinAPI.
> This breaks Wine emulation, because it doesn't have a chance to
> intercept and emulate these syscalls before they are submitted to Linux.
>=20
> In addition, we cannot simply trap every system call of the application
> to userspace using PTRACE_SYSEMU, because performance would suffer,
> since our main use case is to run Windows games over Linux.  Therefore,
> we need some in-kernel filtering to decide whether the syscall was
> issued by the wine code or by the windows application.

Do you really need in-kernel filtering?  What if you could have efficient us=
erspace filtering instead?  That is, set something up so that all syscalls, e=
xcept those from a special address, are translated to CALL thunk where the t=
hunk is configured per task.  Then the thunk can do whatever emulation is ne=
eded.

Getting the details and especially the interaction with any seccomp filters t=
hat may be installed right could be tricky, but the performance should be de=
cent, at least on non-PTI systems.

(If we go this route, I suspect that the correct interaction with seccomp is=
 that this type of redirection takes precedence over seccomp and seccomp fil=
ters are not invoked for redirected syscalls. After all, a redirected syscal=
l is, functionally, not a syscall at all.)

>=20
