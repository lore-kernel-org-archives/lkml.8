Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD05C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CB0A20732
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592850425;
	bh=aoJ9miK+e2ZVJy9d01gYV0oReu4uD5k/CKRPZqPMqTw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vD7+ou5em7icywv4xR1mk5leWt3YjpqNflUbwD5GdjnZU/iO3utIh59ETjgfrckQ/
	 y+SuMvdw8vJWZDKEsaFLUeGd+IvF75Brw/ww3EOGRmrl6w7sQBdPQlmvH3Oby/N2kW
	 aCMA6VgbH7fMQzVwNRiSrpUhqz8A/PnJ5NVqrlF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbgFVS1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:27:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730264AbgFVS1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 14:27:03 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FD9F20771
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 18:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592850423;
        bh=aoJ9miK+e2ZVJy9d01gYV0oReu4uD5k/CKRPZqPMqTw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eZHALR4VqOpD+zFK2o3UqHkKnJ0ZdacZD1RLqHm7rHE53JdP6ok7y8NTNRasAfKyb
         mz4q+f/KShuqux485xIP1Vt/+9msVv50mXUDDgCgnlEqIXCBTXinAuhuq2ykYR89iA
         0UoUOgwPck3i63c1lqRbfXtOaBgsxbKJXVOrJ/rc=
Received: by mail-wm1-f51.google.com with SMTP id t194so511243wmt.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 11:27:02 -0700 (PDT)
X-Gm-Message-State: AOAM5319Bpkad0rthYm+uC0iLUJuILrc4zOkInid+lHK+SW+REphg/kk
        H1SF3ebRhbCkge9n8Z7iM5yTjGN03el0Xqqoipzwmg==
X-Google-Smtp-Source: ABdhPJw4vi4x3WSZ0Jc6EgkyyYB7opzrsEcePwc/ximBHkdKW9EHlb4C3byWV5x+srfZuryalW61VVM57jgKBZgpnvQ=
X-Received: by 2002:a7b:c92e:: with SMTP id h14mr2495146wml.36.1592850421551;
 Mon, 22 Jun 2020 11:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200619174127.22304-1-bp@alien8.de> <20200619174127.22304-3-bp@alien8.de>
 <CALCETrXXzt8WZMs3dsReCJ5wdF3zhxFmUtGnmdCgV7_exFUKKQ@mail.gmail.com> <20200622171240.GI32200@zn.tnic>
In-Reply-To: <20200622171240.GI32200@zn.tnic>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 22 Jun 2020 11:26:50 -0700
X-Gmail-Original-Message-ID: <CALCETrV87t=meNgb1zqz_E5=XaifttX79DMeLK87k1DvzVER1Q@mail.gmail.com>
Message-ID: <CALCETrV87t=meNgb1zqz_E5=XaifttX79DMeLK87k1DvzVER1Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests/fpu: Add an FPU selftest
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        jpa@kernelbug.mail.kapsi.fi, Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 10:12 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Jun 19, 2020 at 11:00:28AM -0700, Andy Lutomirski wrote:
> > This should be cc-option, not cc-ifversion, I think.
>
> Why?

For all the ridiculous distro gcc versions out there.  Also, it seems
less fragile, since it tests for what you actually care about

>
> > But maybe we should consider dropping the problematic GCC version
> > instead? The old GCC versions with stack alignment problems are
> > seriously problematic for x86 kernels, and I don't really trust
> > kernels built with them.
>
> Can't - we just upped min gcc version to 4.8:
>
> 5429ef62bcf3 ("compiler/gcc: Raise minimum GCC version for kernel builds to 4.8")
>
> I mean we could but everytime we do that, it is all a big bikeshedding
> discussion. Even though almost everyone is using gcc9 or so to build...

Phooey.

>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
