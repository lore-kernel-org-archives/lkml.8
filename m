Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E50C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 15:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D60AC20738
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 15:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="NR0cgf5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgGSPZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 11:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgGSPZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 11:25:10 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C9EC0619D4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 08:25:08 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m22so9102878pgv.9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 08:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=G6noA34E2/1K2YEmWWWvytBE/BSHjy5e1V9oQ5WK4u8=;
        b=NR0cgf5cBbpYVGAMHvjRCO4t6MnPwJdvoE3mJ1A0kCTMWL8b7WKtAqxAdN1ZGdxydD
         mjsN5H2vv/M5XsiCu5TYyUOat0KmRvmljU9H10ydknjN3e8jaWT97EHTFJNOPnUhEBgS
         KBsyycqGNhcnPulvUkmZzqhwSP7mMQm9pBD97x8CfHB2LNQ5oLtoRdBpsogce6KZrJ1/
         57SKOjao55eQdoJlPAPc8UVNys2HZ48ffsyBHTROtacZhM+kvn9IjK7nxIEFqUorF5tZ
         GwaVXiUtQuqa0pvHTkxVHlduKz7IO1SSTe/aMMG0gFyp+wc0Co6Fy+z+LUGaid1KpaiQ
         NA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=G6noA34E2/1K2YEmWWWvytBE/BSHjy5e1V9oQ5WK4u8=;
        b=OoI6cbq+VGFk1tGS8z6vwuNTjHCetS7POWQL48LPiVK7C5HJiJR/meqmZof4Knob5C
         oLP3IMhJwAckA5ximsiGOQh0bayTSrf6WmsVo1j8m/auu9mzv0Ue92T1vCi1uOsYfjkY
         FY0+YRaqkFzeOA1mDajIe4w3NB1OJPGjOWX5R1SbILTbq5JrrHt4JrMXQ+EVj1XQTHRe
         WbY2K/IBS70zkEYYb2nbt5rgiJIBe0Kg6bLpl6FZnzbNHqzQIP65GqU4apSK0Q7Z3OZS
         mr5HQV8T0BzksjzT5LW1mpHO4cLUyKtswKSeyMojnukI2LxkEq0QUhRdHV9a/b/KcVfW
         ED1g==
X-Gm-Message-State: AOAM532i4ufHL6LYbP+BgQU5yPM9Cc4HGb/Bt/MJRa6LhPg98LfWnnh+
        d7pdNtYEkIqnto90FYjjhdy5UA==
X-Google-Smtp-Source: ABdhPJxuE7qpwKlTTYqMwf/wSgZDSPJ+s6c+g2banxhS6ephCD2iCZG8IP76J+p+dQqsR9MRV3i6YQ==
X-Received: by 2002:a63:3c41:: with SMTP id i1mr16186511pgn.349.1595172308247;
        Sun, 19 Jul 2020 08:25:08 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:c0b0:ea7d:297a:9f43? ([2601:646:c200:1ef2:c0b0:ea7d:297a:9f43])
        by smtp.gmail.com with ESMTPSA id n22sm8499202pjq.25.2020.07.19.08.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jul 2020 08:25:07 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [patch V3 01/13] entry: Provide generic syscall entry functionality
Date:   Sun, 19 Jul 2020 08:25:05 -0700
Message-Id: <A790AF9D-3BF7-4FEE-9E29-7C13FA3FE0C3@amacapital.net>
References: <87v9ijollo.fsf@nanos.tec.linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
In-Reply-To: <87v9ijollo.fsf@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 19, 2020, at 3:17 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> =EF=BB=BFAndy Lutomirski <luto@kernel.org> writes:
>>> On Sat, Jul 18, 2020 at 7:16 AM Thomas Gleixner <tglx@linutronix.de> wro=
te:
>>> Andy Lutomirski <luto@kernel.org> writes:
>>>> FWIW, TIF_USER_RETURN_NOTIFY is a bit of an odd duck: it's an
>>>> entry/exit word *and* a context switch word.  The latter is because
>>>> it's logically a per-cpu flag, not a per-task flag, and the context
>>>> switch code moves it around so it's always set on the running task.
>>>=20
>>> Gah, I missed the context switch thing of that. That stuff is hideous.
>>=20
>> It's also delightful because anything that screws up that dance (such
>> as failure to do the exit-to-usermode path exactly right) likely
>> results in an insta-root-hole.  If we fail to run user return
>> notifiers, we can run user code with incorrect syscall MSRs, etc.
>=20
> Looking at it deeper, having that thing in the loop is a pointless
> exercise. This really wants to be done _after_ the loop.
>=20

As long as we=E2=80=99re confident that nothing after the loop can set the f=
lag again.

> Thanks,
>=20
>        tglx
