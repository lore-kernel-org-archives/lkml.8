Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B984C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 18:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5919246B4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 18:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582914840;
	bh=TSNQCA1Exsa7QfsZgI9mkBIAC6wC3EJrT4A5gDzeVzI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hn34Rt/rpJkpPJglrNrp1OusTDa+J6SrbPll/OOyX8H4c3gF0wE+nJu28WVzmW58k
	 jh1UZc14vvnhCB2OytIKEeESs8+p0gS8xIaar4cEz9eOSaqDlae8qdyxM6ANlbnsij
	 yNdyJ1yxzBbXvyiBbhT+/RQW+l9mPORlrG1HiyfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgB1Sd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 13:33:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:37598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbgB1Sd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 13:33:58 -0500
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3837246B4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 18:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582914837;
        bh=TSNQCA1Exsa7QfsZgI9mkBIAC6wC3EJrT4A5gDzeVzI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oedgajeASovWNO/YwKEhpY+sk+u+CfRWjW4yvSbyuUuC4X82Kj78N3wrVMEgyVCgH
         YwAXWT5D2ZFekYaoC4akotCAffMqRYQPnBGN5yZ7CkBqGMR0iE2PRboPVDm9rPsE17
         dirwgWAVfYWrdXlpD4iikr010aXnzWinASbeV7Ic=
Received: by mail-wr1-f53.google.com with SMTP id z15so4147849wrl.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 10:33:56 -0800 (PST)
X-Gm-Message-State: APjAAAUVS4ol6e+CuJ23G4iBN6CSJL/OEe+DcAj8FSWeFOZXBGIt9xRO
        ZY3UePq9M9TbfEc+903aA0706KnSB1weV03oYQIovA==
X-Google-Smtp-Source: APXvYqwsBPbbv5cvX6V4djekx2UfEy3YjYti3weZSVB2SxoL3aNFLGMfR9RJKvzWIyfWriXnTqgf6uDX+r4LERVQNWk=
X-Received: by 2002:adf:df0c:: with SMTP id y12mr5910882wrl.257.1582914835223;
 Fri, 28 Feb 2020 10:33:55 -0800 (PST)
MIME-Version: 1.0
References: <20200227132826.195669-1-brgerst@gmail.com> <20200227132826.195669-2-brgerst@gmail.com>
In-Reply-To: <20200227132826.195669-2-brgerst@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 28 Feb 2020 10:33:43 -0800
X-Gmail-Original-Message-ID: <CALCETrWqmpChXCs0b-rO4X-yKKy0Afy3ioaK01ZmeiCvsN=3+Q@mail.gmail.com>
Message-ID: <CALCETrWqmpChXCs0b-rO4X-yKKy0Afy3ioaK01ZmeiCvsN=3+Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] x86, syscalls: Refactor SYSCALL_DEFINEx macros
To:     Brian Gerst <brgerst@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 5:28 AM Brian Gerst <brgerst@gmail.com> wrote:
>
> Pull the common code out from the SYSCALL_DEFINEx macros into a new
> __SYS_STUBx macro.  Also conditionalize the X64 version in preparation for
> enabling syscall wrappers on 32-bit native kernels.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> ---



> -#define COMPAT_SYSCALL_DEFINEx(x, name, ...)                                   \
> -       static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));      \
> -       static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
> -       __IA32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)                           \
> -       __X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)                            \
> -       static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))       \
> -       {                                                                       \
> -               return __do_compat_sys##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));\
> -       }                                                                       \
> -       static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
> +#define COMPAT_SYSCALL_DEFINEx(x, name, ...)                           \
> +       static long                                                     \
> +       __se_compat_sys##name(__MAP(x, __SC_LONG, __VA_ARGS__));        \
> +       static inline long                                              \
> +       __do_compat_sys##name(__MAP(x, __SC_DECL, __VA_ARGS__));        \
> +       __IA32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)                   \
> +       __X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)                    \
> +       static long                                                     \
> +       __se_compat_sys##name(__MAP(x, __SC_LONG, __VA_ARGS__))         \
> +       {                                                               \
> +               return __do_compat_sys##name(                           \
> +                       __MAP(x, __SC_DELOUSE, __VA_ARGS__));           \
> +       }                                                               \
> +       static inline long                                              \
> +       __do_compat_sys##name(__MAP(x, __SC_DECL, __VA_ARGS__))
>

This hunk looks like a pure anti-cleanup.  I much prefer slightly long
lines over messy excessively multi-line macros.

Other than that:

Reviewed-by: Andy Lutomirski <luto@kernel.org>

--Andy
