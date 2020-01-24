Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9908C35240
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 03:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F71221835
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 03:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="pWDNEp8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730724AbgAXDWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 22:22:24 -0500
Received: from mail-il1-f176.google.com ([209.85.166.176]:37835 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730663AbgAXDWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 22:22:24 -0500
Received: by mail-il1-f176.google.com with SMTP id u14so574640ilj.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 19:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RO4QmiYLbmwlmb+nj9OQJ/MLdymgjHxPp+7GD55K2+4=;
        b=pWDNEp8jENP4snua1ds4FSGEO11qSlGUwMJrC6nSQ0WXAS/rIHF0AbRouLd0/81O1b
         Zs2Zn7d6bkF3oT94zw8z6ZbSRo+W+6xa+pJtqLAQUxeJwz1vTImSwY0wmZBnKqXXFKY2
         Wch+CJpZg2UNEfH0+9OjUn817jjXjlIKK4aCfs908JOd0HvTt6XZW+dNmJCb+lDg3wZi
         TlplFr4Ql/B7os0PnvgEMWaM3+f+v7k7vfKVeK+Vpf9+Y/gAK7tqwg1a9M7OqPdbVo92
         VZphWftzj2y2hjIL2F3pd6/anjSoAeCQ+20Iu5s5gTf4HQEGLTocG+s+lMZYzHS9hOwH
         3vSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RO4QmiYLbmwlmb+nj9OQJ/MLdymgjHxPp+7GD55K2+4=;
        b=YiQwC7Aa6XFo+Zcg37JUpB3wsPVgJD/YxP1A/rnlmM54plhwWQwd4GFUV1xls3ch+e
         s7spKfeESYpu3mYBfUkuUWk7Twy2RuaHCN+hQ4oKQP8HXlSD5UESYpzaFhhHM0KQYD9a
         ET3DD4pomb34o9uEcz9tVrnA/GpjMbczh5kjbVGrmLRlI01sArEijVDuNfqAUrDJWYr3
         cM7hdVAvP4WBYean7Og5SAix70CFfeO+IVInp+mQ7B4reItk5fuO6zsCm+T0P6CSTgpW
         JRDVj7tOdYIX39NqC+8lje3pGgLZZMIfAH2+OzCcrCzfePWrRi2KkKtv4nmDI0tRm2Mw
         f+Mw==
X-Gm-Message-State: APjAAAX5u+LJW99/u3L8Zhc5/DbyYKwtdiJP1eMg22fE/eePdKFjydco
        VO7mCFyTvGMRlA5ir21PFxUqLUPbxFF5INUvjfJwZ/R2x+w=
X-Google-Smtp-Source: APXvYqzKJBh0W0/XaTS/vFrA+HAX2ghLAelaK1OPwEuCWPLXiry4DfP3TQDyH/naSEb6Nq9v1wNLRPLcRmBKbMm99IQ=
X-Received: by 2002:a92:db49:: with SMTP id w9mr1223575ilq.277.1579836143272;
 Thu, 23 Jan 2020 19:22:23 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNASEaiFia8NKZN8++-9RfGXOPKSFuCkdukBk9Jy7+nHecQ@mail.gmail.com>
 <CAK7LNAT721bVwVQif--UY1dXMhq8NSRpkPOYTN-=nxyBSBOn2Q@mail.gmail.com>
In-Reply-To: <CAK7LNAT721bVwVQif--UY1dXMhq8NSRpkPOYTN-=nxyBSBOn2Q@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Thu, 23 Jan 2020 19:22:12 -0800
Message-ID: <CAOesGMgyh2NmR_AbEzC2jQe070e_u3zozWi=v7RjMXszXgetZg@mail.gmail.com>
Subject: Re: [GIT PULL] arm64: dts: uniphier: UniPhier DT updates for v5.6
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 23, 2020 at 6:49 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi Arnd and Olof,
>
> I know it is already -rc7, but
> it would be nice if you could pull this for the next MW.
>
> Thanks
>
> Masahiro

If you don't email us at soc@kernel.org, we're unlikely to see your
pull requests. :(

In this case that's what happened. Please do so -- that way it gets
caught in the patchtracker. I sort the patches to that alias in a
special folder to make sure I see them too, since I get too much in my
inbox and it easily gets lost.

Mind resending the two pull requests to that alias? That way you get
the notification email when it's merged -- if I bounce it here I don't
think you'll get it.


Thanks,

-Olof
