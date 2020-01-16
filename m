Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B741C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 20:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A67206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 20:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579206177;
	bh=AWTq77yPH1eJXFHw5c/ihwZ/W+ttmiGY+qYVIL2DNXo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Dm0BXdgZeDmypdRA2owyBviWbjAJ+9qHcIAqeGhDr/VxSLObQQ9QiyqEj34hcu/Jx
	 IlPe8fTSOO5r7fgLOYjsJEqKKYlAkbY+MIacOlnKNpLa3o1Fx5oMnNwUxg2fJ75C68
	 L9vYeK7mne7afT9TeYa/uBdNAR0YQHPv5uYw7JCU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387775AbgAPUW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 15:22:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:40262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733278AbgAPUWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 15:22:55 -0500
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABD922081E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 20:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579206174;
        bh=AWTq77yPH1eJXFHw5c/ihwZ/W+ttmiGY+qYVIL2DNXo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WjiY6Fz2v1BRFwTw8CEV+ZGeTVwybGg7qEvOG+e6kceB8oCBxevUtjC+sxHFejHAw
         +oKShNXbfNSUG124nEjNg9pxFVCYhjNP142xTdOd2FqkhnrKlA/xPHMGsS+TxqWkRE
         U5OV05EgZIcNAZu83S6Cza9kPCZDXt9/fFQCjNYE=
Received: by mail-wm1-f53.google.com with SMTP id p9so5156353wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 12:22:54 -0800 (PST)
X-Gm-Message-State: APjAAAVz0yTMhsVFSlTyDrlUjQIAT0Pa65ponkGojZ9j9DzRFBO38Xy+
        2ObTdk4XnnLAhA1P3eflzNA5CR6bQqmtPDRULS3PMg==
X-Google-Smtp-Source: APXvYqye2EDj0a90ApFnSVIDyfTmrBlVCmi50h4FuEffTXlFfhQYLFZAcgiL0SS3ilsUicD1HIv6uxzlc43xpc781uA=
X-Received: by 2002:a05:600c:20c7:: with SMTP id y7mr802627wmm.21.1579206173156;
 Thu, 16 Jan 2020 12:22:53 -0800 (PST)
MIME-Version: 1.0
References: <cover.1578934751.git.christophe.leroy@c-s.fr> <381e547dbb3c48fd39d6cf208033bba38ad048fb.1578934751.git.christophe.leroy@c-s.fr>
 <87ftghbpuu.fsf@nanos.tec.linutronix.de> <d2de3211-9d7c-513e-fe0f-8bdce623fb65@c-s.fr>
 <b5fddcf8-99ff-fc0d-40c0-0eb81ad4e94a@c-s.fr> <87k15rwuxm.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87k15rwuxm.fsf@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 16 Jan 2020 12:22:41 -0800
X-Gmail-Original-Message-ID: <CALCETrWOENu2k3aGNO-oiY1Sj8=cG9mMZ8eOepHOzdu25vFVVA@mail.gmail.com>
Message-ID: <CALCETrWOENu2k3aGNO-oiY1Sj8=cG9mMZ8eOepHOzdu25vFVVA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 08/12] lib: vdso: allow arches to provide vdso data pointer
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Andrew Lutomirski <luto@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        X86 ML <x86@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 2:35 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> static __maybe_unused int
> __cvdso_data_clock_gettime(clockid_t clock, struct __kernel_timespec *ts,
>                            const struct vdso_data *vd)
> {
>         .....
> }
>
> static __maybe_unused int
> __cvdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
> {
>         const struct vdso_data *vd = __arch_get_vdso_data();
>
>         return __cvdso_data_clock_gettime(clock, ts, vd);
> }
>
> and then use __cvdso_data_clock_gettime on PPC and let the other archs
> unmodified.
>
>

FWIW, I did some experiments on x86 with gcc 9.2.  gcc 9.2 uses
rip-relative accesses if I simplify the config enough and otherwise
materializes the pointer.  Presumably it decides that the code size
reduction is worth it if there are a lot of accesses.

I suspect that tglx's suggestion will be fine or at worst will add
negligible overhead on x86_64.
