Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SHORT_SHORTNER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FAEC35249
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 21:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB9F2063A
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 21:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="tUusQ/h0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgBAVoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 16:44:18 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:42632 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgBAVoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 16:44:17 -0500
Received: by mail-ot1-f46.google.com with SMTP id 66so10069127otd.9
        for <linux-kernel@vger.kernel.org>; Sat, 01 Feb 2020 13:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AIzUquiVguipC0H3ByxHWCR0gXlRVz0vM9wVlXep22c=;
        b=tUusQ/h0B8wJIB/O/zajLgvXX7nhE7rTHy3UyJQToFAzEQfyb076+LeH2pkkfpbd2G
         7XS5ETe+jNlBnrsG2J7WWtUAcyhiZpx9QSGocHUVa9fEU7xRovGl6ArpsYwar34TEsZu
         yo9KbvduBoWeoinQuna0q3GKpvyIg7GDR3pwuN4VBdBLDWPSStAfgIO5670jXgrE1g++
         0FsCwPa6Fydmoh+JJle+SwYWRIAnxPokM1Jy+psmWsZ3MeJhVcW3fUuYLHvskqIGDXKF
         4YYaocghjwjbT7p4H7Wlz7c0D/MabpewmqpejefAl+U1dimrJR4ITk6oVeiwX+GQh/p7
         e7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AIzUquiVguipC0H3ByxHWCR0gXlRVz0vM9wVlXep22c=;
        b=a52x7P2ujtc/IkJrCoLQeHFgsyn2BvfX24LH7V0+Do+9iraS5JSIWB3+CRM/I1CfCc
         NtP1HqzSBqFsJryNA0c41ciykRvuXGCf20OtxvCcsYZWXriWeSh+7bA7D2zg1QIkXPT8
         PJCA1LdWsXgS7aotaiU/qjdhIxCZhBbQuY3KthMD/DTLVcrTsPVQ1k4sVuMiKVg7l3n2
         7Ixv29ttlqN1CUQ7pfPbe1N3SGC5qrF8ZC4PvCMGxdgLSCSL/j+BDAnIfXoqmoBKFg0b
         piXXJBrKkBY8WpYeO4JIFpoaavlM30I4wT0nGI3GhMabifa1u5GzEf6N1k3Ti7Ag+3IM
         L2yA==
X-Gm-Message-State: APjAAAXwEpzkfNGocB8e/lLz10mcMRSrJLTbVBl8nHueUSxrljnFZ7nN
        sFi91cjNoLIP2GjId0WbgqePTQOphZAnyuyJSrBJkg==
X-Google-Smtp-Source: APXvYqwsY4XZ0tQh2aedC/mdZZ+XvefZoMP3SbsapVlxCXuZD5xthkQRfN85rkyerCy6ubFYNf20sEbblaG3w2fLubU=
X-Received: by 2002:a9d:4e99:: with SMTP id v25mr12798289otk.363.1580593456605;
 Sat, 01 Feb 2020 13:44:16 -0800 (PST)
MIME-Version: 1.0
References: <CADDKRnANovPM5Xvme7Ywg8KEMUyP-gB0M-ufxKD8pw0gNwtFag@mail.gmail.com>
 <CAHk-=wjOXE4cqFOdtSymYnMMayZq8Lv7qDy-6BzCs=2=8HcoBA@mail.gmail.com>
 <20200131064327.GB130017@gmail.com> <CADDKRnATVt9JjgV+dAZDH9C3=goJ5=TzdZ8EJMjT8tKP+Uhezw@mail.gmail.com>
 <20200131183658.GA71555@gmail.com> <CAKv+Gu-oPrM7oh-oTbpQsUmXcYvp9KxjXFb3DUGk__qu59rdBQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu-oPrM7oh-oTbpQsUmXcYvp9KxjXFb3DUGk__qu59rdBQ@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 1 Feb 2020 13:44:05 -0800
Message-ID: <CAPcyv4j7oraMPOhSePaXhULaNJNTFTx+TcJ-y2bqQmvNsTQDmg@mail.gmail.com>
Subject: Re: EFI boot crash regression (was: Re: 5.6-### doesn't boot)
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 10:45 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> earlycon=efifb may help to get better diagnostics, but you will need to use a camera to capture the output

https://photos.app.goo.gl/uA3Wkaxc8x6A4gK47
