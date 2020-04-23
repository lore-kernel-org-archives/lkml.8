Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C95C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 780152074F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oyIVHUIM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgDWOwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726380AbgDWOwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 10:52:16 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96078C08E934;
        Thu, 23 Apr 2020 07:52:16 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id w65so3041100pfc.12;
        Thu, 23 Apr 2020 07:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/sb3dlUj5FrGwmCMaw1i7cs39EU8HrExHVtJsyVG3VY=;
        b=oyIVHUIMteQ+Jyujbx3EDLFuw+ISWFk6HIHSvS6fYlUsxnyisljN8Ia6w8b2XrbWI5
         kn/ZnFcbY+qdKeF4vLEem6y/yZrATTRtLYUbkbxX3dq1jQP4X9U7bqOquWVm5PQ58wIk
         zQFJtrba2s5XmQtB/1CUeF+UNtgy0Yi8WYrsAzHDHbkhJbbtS8LHnkI2ZWLBtfq8FGl7
         n/e8I9fe0HozYBhAYBxbmkzDW7MPkIPONX9Wc16T4KH3D7OeN4TJyax0hcFB6T5/cnEQ
         PMi7d1gyQRk9aDLupdLrXQo4rLNH0emHJrkAKy0ai5BJJ6Z8/NjsAqq8kSnh0lLmjYHd
         d3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/sb3dlUj5FrGwmCMaw1i7cs39EU8HrExHVtJsyVG3VY=;
        b=iVPE5J1N4c2m6sNJbechtJqGxq6C0vF8CwJYcm7CBQXNiA934g7f/v96eZ9dv+qaS/
         ImPEEQakcLsaI/hE0T8IhmhF0QKO8fDnhJd1pweym07BQbAJwWeULT19RzsjZZslwnj8
         LSrMZGJHYS0gOqfK9yQqzlCd9p3Gjk4a5l1938L3gnILiBU7oy9MfjKPNeSRnT87iiaZ
         01p/vaMr1RG0G+CTWTK8ZlFRP9lHavCSIPklLCZS7NIjhd80r2FrXroHe7apXf9a9Giy
         WSEqcJaJOeNkyNzJviG+7anSbHQZja/1iAKO+9ixHeB4GGLmyAABPW5UqGhq2y02D+JJ
         aVQQ==
X-Gm-Message-State: AGi0PuaiJzJGltWNvCC5LUi9/ICVAHx3qN2TpgwYaMN76Oeen3LtsDP0
        onnRv6z5JsEjqEHIbfppfwD2nIxdkVQflhf1HlI=
X-Google-Smtp-Source: APiQypJYkHlH+G01ukIQTIcX4mw/JbzhQZYKNM2IW0V/S/oVOVH5kXUElwv3U/VvSlsvXAXK2gyRX1QXlKVJiRNAlsI=
X-Received: by 2002:a62:5ec7:: with SMTP id s190mr3964136pfb.130.1587653536121;
 Thu, 23 Apr 2020 07:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200423142627.1820-1-zhengdejin5@gmail.com>
In-Reply-To: <20200423142627.1820-1-zhengdejin5@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Apr 2020 17:52:09 +0300
Message-ID: <CAHp75Vf1_SMk=_WDUrB97BGR6K6EXOdtgQ92=hTyMdVUoyWQiw@mail.gmail.com>
Subject: Re: [PATCH v2] console: console: Complete exception handling in newport_probe()
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, FlorianSchandinat@gmx.de,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 5:26 PM Dejin Zheng <zhengdejin5@gmail.com> wrote:
>
> A call of the function =C2=A1=C2=B0do_take_over_console=C2=A1=C2=B1 can f=
ail here.
> The corresponding system resources were not released then.
> Thus add a call of the function =C2=A1=C2=B0iounmap=C2=A1=C2=B1 together =
with the check
> of a failure predicate.

...

> CC: Andy Shevchenko <andy.shevchenko@gmail.com>

Use Cc: Better to read.

...

> v1 -> v2:
>         - modify the commit comments by Markus'suggestion.

What suggestion? You need to be clear in changelog what exactly has
been done without looking to any previous mail.

...

>         console_lock();
>         err =3D do_take_over_console(&newport_con, 0, MAX_NR_CONSOLES - 1=
, 1);
>         console_unlock();
> +
> +       if (err)
> +               iounmap((void *)npregs);
>         return err;
>  }

I have briefly looked at the code (it is actually quite old one!), and
I think this is half-baked solution, besides the fact of missed
__iomem annotation and useless explicit casting.
The proper one seems to switch to memremap() and do memunmap() here.

--=20
With Best Regards,
Andy Shevchenko
