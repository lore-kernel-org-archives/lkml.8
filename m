Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F703C33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 21:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3578A20643
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 21:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="rLt6old7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgBAV3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 16:29:53 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33855 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgBAV3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 16:29:53 -0500
Received: by mail-ot1-f66.google.com with SMTP id a15so10092369otf.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Feb 2020 13:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h+dn0KiVsIptEiH0UHAgyABegvS1NYJRDWPPAeNvyjY=;
        b=rLt6old7q7Gs/1mlZAJJqa/N5CNgXLULEEwIsXQ7+1jxGlyStXQhYopNzODyJyAfA9
         2SFLBnzaYhs1cVdz6USV/sP/S4HlazYnDOeu2z8wm0hfhkOOshJxOx9uuuaTmi8ceCbw
         NYjPqxFTiMXSbO0tUiRr67CWqgTsUapxhYPJXFbV5giDb89nO781fW1D1Ul/HD1qfgJ6
         2GTHw0LqAZpMKUy97zhcKwk5qDRCoqJbcyn/jfSmo9k0LNZBSkucGBURZDBd5JKpkFpX
         WeskG9WHdnvYPHzA60Jg8NL0Is0psVLIbBoZoWPEA2yW1avJ7gV4zF3L19pzs7EbhS7i
         wgtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h+dn0KiVsIptEiH0UHAgyABegvS1NYJRDWPPAeNvyjY=;
        b=ekmZeXoQcQJlKldTyNm1X58qRU7E2lyHgQXSpGes/ROXD2TY4y5/dWIr6ArZxgKVEN
         4LP8MsjxmkfguQbzm822cig8lIc91J34CeQFotWwqFidcuuCOvQTI1ZNy9ENjDyv+knS
         Ygkiqa+s7znBfJ0HdPOqzLML2RmM4G95WtJK8Ci3CtF4+0eLff5HbDyAvIe1BwRHmnp0
         W3AktPK0dAx4Fe7gspmAvQ8stIuXCIfWeAXYMH0tpFEDDXnVeFG9xo7BBIYnRkiKYbv2
         /vqlrIkKu+8VcMykV61cXJcvU5mAb8L6bZZ0SDc1u6IE2fakrWfKdnjOUdA3xSDWSsXo
         eNGg==
X-Gm-Message-State: APjAAAUzvXlDY+40wIlpUrlMQjWtp+Ijc+4pR1jCR1oBh2pBMEC4aYOW
        VSwzxXdyjdrLj3OSJ5hiZvph7qKARswWOfSOtkTOrvCz
X-Google-Smtp-Source: APXvYqwjBGIc9/Is8D2o1Wq6hM3kOd/YuY/dhpraxPel2gIUe7jqn1YefgWNL6X9F+SvxAFZPXg+RtqltR1FOcDaVTU=
X-Received: by 2002:a9d:6f11:: with SMTP id n17mr12327831otq.126.1580592592282;
 Sat, 01 Feb 2020 13:29:52 -0800 (PST)
MIME-Version: 1.0
References: <CADDKRnANovPM5Xvme7Ywg8KEMUyP-gB0M-ufxKD8pw0gNwtFag@mail.gmail.com>
 <CAHk-=wjOXE4cqFOdtSymYnMMayZq8Lv7qDy-6BzCs=2=8HcoBA@mail.gmail.com>
 <20200131064327.GB130017@gmail.com> <CADDKRnATVt9JjgV+dAZDH9C3=goJ5=TzdZ8EJMjT8tKP+Uhezw@mail.gmail.com>
 <20200131183658.GA71555@gmail.com> <CAPcyv4iYSptWo42p1Lnbr4NWRiWG2sat+f3t8Q0kPeiiXHx3fg@mail.gmail.com>
 <CADDKRnBeB5T7ZW2LxJQMR=AjD-OyOGBs4gqH0O9_frJ5zR5E7Q@mail.gmail.com>
In-Reply-To: <CADDKRnBeB5T7ZW2LxJQMR=AjD-OyOGBs4gqH0O9_frJ5zR5E7Q@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 1 Feb 2020 13:29:40 -0800
Message-ID: <CAPcyv4h0mDeOeAvsk-gA-02+XEZT7TF73iJYmHL2rcpMr=oXzg@mail.gmail.com>
Subject: Re: EFI boot crash regression (was: Re: 5.6-### doesn't boot)
To:     =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 1, 2020 at 7:35 AM J=C3=B6rg Otte <jrg.otte@gmail.com> wrote:
[..]
> > I'll take a look. J=C3=B6rg, can you paste a full dmesg from a good boo=
t?
>
> Here it is.

Much appreciated, I found an old Haswell laptop and am able to
reproduce the boot hang.
