Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B4AC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 00:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B48D52074B
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 00:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="Gdj6kN2m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbgEaA7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 20:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbgEaA7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 20:59:54 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F30C03E969
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 17:59:54 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ga6so263569pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 17:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=DjhjFd8XT3PVpUMAo4NBwDCmtRQKw/8uWc7BwYUQh2w=;
        b=Gdj6kN2m675KZ3jPAOrs0bW8hUmJz6i+11KLnT7ImZ6PcykEIyBkmt7O8gqwqHmiK+
         S0AV7eIvYyZ3BeiCaddKTT1pBt0iQ/h6nH0UTYTwUeXFeUNOgCezQ7JsLAAaHRtefhO3
         kW2Ss4ZjAJ79PNeWnlZq3+C+MmmYS/gzqtogZ6XVIJJwUdvOa/OTp4ULtvnujJorL2mX
         2mcIAto2oojAKslnz9Vg+HKuCBCyXz02wUq9TBy+b3FoOffG8qUrWjoH/EvTekdQYai8
         6Mo3U0YXuted9+I0j1O2NbFzIUajKyGuJjmQE3hPNc0iYdSm41Hhscc3Q0bZFtArT5s+
         uM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=DjhjFd8XT3PVpUMAo4NBwDCmtRQKw/8uWc7BwYUQh2w=;
        b=cuk6V+hLM4U+XNP0HVvl9VhNWV594+zocG3e2940o4LmcoA/H4gtJzQ6lyct9CUTVm
         +qR976AJeqcQOY4d4ezo+hg6v2rqAtr6JZX4K2vP+nsMHoVE1oS1agq+mcUVBWL4xLcP
         XPNLNIU/zwE0ODKT2UquRY7OGbZ3u/Ov1jEJyv55kaIRrNgHActM2LiIqEiTQ7GhwbxZ
         ndFowmVv70HVDeZLtxZ0QM7m5ylmspDxtr3PhVJEvV6YxPU8d/xIwgfQtiiTytZBIsNQ
         yGRUrQ0jdZEiCilWc+NpMDVxF2EG5K9SjB0Chr36gQ9w8adoeb+kP6eZwW5mpa4X8Ixk
         jR1g==
X-Gm-Message-State: AOAM5302li3iNegNdIUrP5FTe4W6GLxPnetrQg3qLA3gjPUc2I9TDdRY
        uZHWk/P7oW30KZHu3rN/o0sexZ1jA9Q=
X-Google-Smtp-Source: ABdhPJzdbnnmwL07quMsROiAovs/kh8goZJj6XAqksxPOVg5stBzrE3yNPfQxvp6cVn8/CpbErgvog==
X-Received: by 2002:a17:902:b097:: with SMTP id p23mr3309892plr.14.1590886793144;
        Sat, 30 May 2020 17:59:53 -0700 (PDT)
Received: from ?IPv6:2600:1010:b04c:ab45:e4c2:341d:a35e:6a40? ([2600:1010:b04c:ab45:e4c2:341d:a35e:6a40])
        by smtp.gmail.com with ESMTPSA id x25sm9660840pge.23.2020.05.30.17.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2020 17:59:52 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC] seccomp: Implement syscall isolation based on memory areas
Date:   Sat, 30 May 2020 17:59:47 -0700
Message-Id: <079539BF-F301-47BA-AEAD-AED23275FEA1@amacapital.net>
References: <85367hkl06.fsf@collabora.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Gofman <gofmanp@gmail.com>
In-Reply-To: <85367hkl06.fsf@collabora.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
X-Mailer: iPhone Mail (17E262)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 30, 2020, at 5:26 PM, Gabriel Krisman Bertazi <krisman@collabora.co=
m> wrote:
>=20
> =EF=BB=BFAndy Lutomirski <luto@amacapital.net> writes:
>=20
>>>> On May 29, 2020, at 11:00 PM, Gabriel Krisman Bertazi <krisman@collabor=
a.com> wrote:
>>>=20
>>> =EF=BB=BFModern Windows applications are executing system call instructi=
ons
>>> directly from the application's code without going through the WinAPI.
>>> This breaks Wine emulation, because it doesn't have a chance to
>>> intercept and emulate these syscalls before they are submitted to Linux.=

>>>=20
>>> In addition, we cannot simply trap every system call of the application
>>> to userspace using PTRACE_SYSEMU, because performance would suffer,
>>> since our main use case is to run Windows games over Linux.  Therefore,
>>> we need some in-kernel filtering to decide whether the syscall was
>>> issued by the wine code or by the windows application.
>>=20
>> Do you really need in-kernel filtering?  What if you could have
>> efficient userspace filtering instead?  That is, set something up so
>> that all syscalls, except those from a special address, are translated
>> to CALL thunk where the thunk is configured per task.  Then the thunk
>> can do whatever emulation is needed.
>=20
> Hi,
>=20
> I suggested something similar to my customer, by using
> libsyscall-intercept.  The idea would be overwritting the syscall
> instruction with a call to the entry point.  I'm not a specialist on the
> specifics of Windows games, (cc'ed Paul Gofman, who can provide more
> details on that side), but as far as I understand, the reason why that
> is not feasible is that the anti-cheat protection in games will abort
> execution if the binary region was modified either on-disk or in-memory.
>=20
> Is there some mechanism to do that without modiyfing the application?

I=E2=80=99m suggesting that the kernel learn how to help you, maybe like thi=
s:

prctl(PR_SET_SYSCALL_THUNK, target, address_of_unredirected_syscall, 0, 0, 0=
, 0);

This would be inherited on clone/fork and cleared on execve.

>=20
>> Getting the details and especially the interaction with any seccomp
>> filters that may be installed right could be tricky, but the performance
>> should be decent, at least on non-PTI systems.
>>=20
>> (If we go this route, I suspect that the correct interaction with
>> seccomp is that this type of redirection takes precedence over seccomp
>> and seccomp filters are not invoked for redirected syscalls. After all,
>> a redirected syscall is, functionally, not a syscall at all.)
>>=20
>=20
>=20
> --=20
> Gabriel Krisman Bertazi
