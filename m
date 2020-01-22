Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C5DC33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 14:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36707217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 14:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UXXaVBIY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgAVO0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 09:26:31 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33752 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgAVO0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 09:26:30 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so7519176wrq.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 06:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BIMaHyCNAEemCVVBReOFX10rBe01Er/xRQJuR3OSX00=;
        b=UXXaVBIYsF/GqAfBQ6ItlNBN6aI8ns0AVZMJCXoYDdZt8qwCzDLsKBIKXGQuTgn60y
         rDJNiymXr9f2eBtPDIy2JSbbyYxL0eogCmnvizaCRHJsnK64+0fj8Ose8MJFhOKqtpdk
         yMOLjrSTECzsa5bIHJN9rmwC5E1wK3mh12HUbSHdF1L946sPb2U6zs5xI5GMsl1aYLR0
         0fXY0GdAgglqlKvy0Hhbo7N6NDF0njuWbJMfg1IA2QN3VszBMlsoUHfmoduiY+AL5+Vz
         B49NFepd8D5t7wZsFo0bU5PP4RgyJ90Q3MCC7AuKjnvKMFlUCESxEZ2T62Rw/tQQlgEb
         weSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BIMaHyCNAEemCVVBReOFX10rBe01Er/xRQJuR3OSX00=;
        b=js/RC/pQJZwq0aUV6mtfefBGW4OvTfFOnlWydIJ35DTr6+4PPDjVYmSDOazL48LCdz
         m45yWsz/aqvy67opsGwkwvaHMoB1REtxltmenYv3qJAvS0gRelOerzkmpTvOCbTlCVmc
         SoRjpg/7wY1H/5O7VgsHpbyPj4wK05LiJ0Abk02ym4GxaPv889jpC6sb5z5gFgevTuOx
         JtGaFgjqiPA9wbHbhVVAryKsdrablY4Cfde/W/mwumCIGMN6ZzN4B2XAaKjVn3YAxiYa
         5FOTlPJhEdOp3PH5u0kC1/crt7GxSCbJTwx/EFQDyOcFCaLXwEOu5qhK7wf9tqvtnVKL
         TZaA==
X-Gm-Message-State: APjAAAXixlJaOJv5jpL/IuxGKjuX3Dy0LjsKX7FJDyvvvJR4NpBRPLDW
        Pof+/RA7LVkq2iez6FlcqgmLoJNYIVC30O1XveqeYA==
X-Google-Smtp-Source: APXvYqyJFzZstJF6iBFk62TOdb8ZgGaKjAvslngK6XFP1DLDzT0dFBKvd+SSTXW6Y2SIeM7JNQjkQKbftkUXTss6EVM=
X-Received: by 2002:adf:e6d2:: with SMTP id y18mr11386435wrm.262.1579703188706;
 Wed, 22 Jan 2020 06:26:28 -0800 (PST)
MIME-Version: 1.0
References: <000000000000951cea059cba579b@google.com> <CACT4Y+YJmVWFEhdWCtF391EM6qN5OBGTBFLuK4tLL61RiQr+MQ@mail.gmail.com>
In-Reply-To: <CACT4Y+YJmVWFEhdWCtF391EM6qN5OBGTBFLuK4tLL61RiQr+MQ@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 22 Jan 2020 15:26:17 +0100
Message-ID: <CAKv+Gu9C1m=+VpKZ1z7QvDM6KCTrfzDxeZJDeFp9DBkKjcDiaQ@mail.gmail.com>
Subject: Re: linux-next build error (7)
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+dc92421ed22129134c0f@syzkaller.appspotmail.com>,
        steven.price@arm.com, Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jan 2020 at 15:24, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, Jan 22, 2020 at 2:17 PM syzbot
> <syzbot+dc92421ed22129134c0f@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    ba0b4dfd Add linux-next specific files for 20200122
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=17caa985e00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=7b604c617a6b217c
> > dashboard link: https://syzkaller.appspot.com/bug?extid=dc92421ed22129134c0f
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+dc92421ed22129134c0f@syzkaller.appspotmail.com
> >
> > /syzkaller/managers/upstream-linux-next-kasan-gce-root/kernel/arch/x86/platform/efi/efi_64.c:560: undefined reference to `__efi64_thunk'
> > /syzkaller/managers/upstream-linux-next-kasan-gce-root/kernel/arch/x86/platform/efi/efi_64.c:902: undefined reference to `efi_uv1_memmap_phys_prolog'
> > /syzkaller/managers/upstream-linux-next-kasan-gce-root/kernel/arch/x86/platform/efi/efi_64.c:921: undefined reference to `efi_uv1_memmap_phys_epilog'
>
> There are 2 recent commits in linux-next touching this file:
>
> commit 6616face70e25c80420539075a943ac1bc9b990c
> Date:   Wed Jan 22 09:12:37 2020 +1100
>     x86: mm+efi: convert ptdump_walk_pgd_level() to take a mm_struct
>
> commit 3cc028619e284188cdde652631e1c3c5a83692b9
> Date:   Sat Jan 18 17:57:03 2020 +0100
>     efi/x86: avoid KASAN false positives when accessing the 1: 1 mapping
>
> Not sure which one is this. But linux-next is build broken.

Does this help?

https://lore.kernel.org/linux-efi/20200121093912.5246-1-ardb@kernel.org/
