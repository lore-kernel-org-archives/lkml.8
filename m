Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA060C35249
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 22:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D0D82063A
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 22:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="SyDcx8BL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgBAWbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 17:31:35 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:43422 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgBAWbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 17:31:35 -0500
Received: by mail-ot1-f44.google.com with SMTP id p8so10113864oth.10
        for <linux-kernel@vger.kernel.org>; Sat, 01 Feb 2020 14:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vledFRn7Z60E8tODj7s6lEIfpxVdWubtPIzw9uH8yGk=;
        b=SyDcx8BLMtgoky+tTl6Nk9/MatXJVKpZjQYWVd4bqABD/q2NQyWoA/2hQMVtS9ivoR
         swGdNirkNDunw7EmT8cJTxSIPa7Z7anTP1jBUBRGvC0oRLWNNZeb3NQs+Wd9Dr3ORXru
         D36Tg5rSJqoa7JEZnzZevcJCiWt4fYJoalt+B9F1YUvc7cb7IIs9zyQzVbtW6mpHqrdB
         HNN6ePlAjLwqC7zTRxLOn/M2Pra0Y3oHWmQHdu3OJFZCSk4a9Bmcp9fuSX1H6BbTI9M+
         JboRWQOsGvzvxIsiht5fLLUvL/6N0p48ld24J1sguAcFtJk55OEd07tMJ4YM9wdueDzZ
         xocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vledFRn7Z60E8tODj7s6lEIfpxVdWubtPIzw9uH8yGk=;
        b=QmvCRn0TnybXWfy+VUPMTRI0wow4pag9o4FaTJZYLWWhu4c01v9GUq/8qkA3um0Y83
         5127yXC4tv+pYzOo1dorIMV08lRi+LrvbU+KeuenOsH1ZxOL781ZHzhT5p4njgqjfi1T
         6Z/Rb1/WOBzkFWk6StwoS6PvXK18Kd9G54Hj8Z1LX9FDOR5rAZ2K/SNXrDV34lIS0xYf
         oVaOm5QAqj4ahzH2ekKFWPrqzEGvMUXM8HFJCtyZGWz8flXglNsz7zmcMICVqbmy47Y3
         kSH5RP0w2Mne5IgOep6xxyvwQgMocSodFGDfnjMu+QrF/pQlNzS6Uxg4/QdXkoDty37b
         qLCw==
X-Gm-Message-State: APjAAAVN7QzA2sEnv1PfyCgXl2STRudlYEU04V6C4vpKvcX7t+Wu7/zv
        g8i2I9LnLSoFZhwcFp49tNWOtzZEpZkbXnYutJCdrw==
X-Google-Smtp-Source: APXvYqxQpxCAlwtYOtwXVIc12Ei5uSnk9P4ZyxLNkOzBYWFgZKN5KvosWUwuzqLyTYeruhlV9aNYh7AYZVD40vf+mzQ=
X-Received: by 2002:a9d:4e99:: with SMTP id v25mr12894918otk.363.1580596294666;
 Sat, 01 Feb 2020 14:31:34 -0800 (PST)
MIME-Version: 1.0
References: <CADDKRnANovPM5Xvme7Ywg8KEMUyP-gB0M-ufxKD8pw0gNwtFag@mail.gmail.com>
 <CAHk-=wjOXE4cqFOdtSymYnMMayZq8Lv7qDy-6BzCs=2=8HcoBA@mail.gmail.com>
 <20200131064327.GB130017@gmail.com> <CADDKRnATVt9JjgV+dAZDH9C3=goJ5=TzdZ8EJMjT8tKP+Uhezw@mail.gmail.com>
 <20200131183658.GA71555@gmail.com> <CAKv+Gu-oPrM7oh-oTbpQsUmXcYvp9KxjXFb3DUGk__qu59rdBQ@mail.gmail.com>
 <CAPcyv4j7oraMPOhSePaXhULaNJNTFTx+TcJ-y2bqQmvNsTQDmg@mail.gmail.com> <CAKv+Gu-bAbc7a1-H5gadQ=YkfKpQUt__3J5cctDNLz1g8gH92A@mail.gmail.com>
In-Reply-To: <CAKv+Gu-bAbc7a1-H5gadQ=YkfKpQUt__3J5cctDNLz1g8gH92A@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 1 Feb 2020 14:31:22 -0800
Message-ID: <CAPcyv4gPrJe2DSPyPJjJQLakEVs3w6x-jDVbX7iydw3D9C4iRQ@mail.gmail.com>
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

On Sat, Feb 1, 2020 at 1:49 PM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Sat, 1 Feb 2020 at 22:44, Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Fri, Jan 31, 2020 at 10:45 AM Ard Biesheuvel
> > <ard.biesheuvel@linaro.org> wrote:
> > >
> > > earlycon=efifb may help to get better diagnostics, but you will need to use a camera to capture the output
> >
> > https://photos.app.goo.gl/uA3Wkaxc8x6A4gK47
>
> Yeah, so it definitely has to do with the n_removal > 0 path.
>
> Did you try the change I suggested to Joerg?

Nice, it worked.

Tested-by: Dan Williams <dan.j.williams@intel.com>
