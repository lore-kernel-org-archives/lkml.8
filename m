Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB404C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C184620707
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYlMCPTl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731169AbgFWHZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 03:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730830AbgFWHZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:25:15 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED73C061573;
        Tue, 23 Jun 2020 00:25:14 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id t6so1643595pgq.1;
        Tue, 23 Jun 2020 00:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xt/VVu1bm6xh/GckfKGMv2YCPJI7Ah04aj5E/xaHxVM=;
        b=qYlMCPTlddqSo7pbSAWRTyH1yy4Dx9C7V2W+KzSxPB57u/HhkcvMp/MdGALZUzq4xj
         /gfzbYzCWbgRQAbx7qGbECpX9It+PkQjA/OWgry6ImyvYky3GDU7KOJyDKP54IchNiam
         fjn8d5zMFyF36cGssXV0qm3NuWSbcO2RI2TxZhdqpH42wmGuVbfGsY6EqsvZZckZGKGO
         EYccfnhu43tX1o/kYNNGSEI+gHDqfBWYTREe4Ca+4YT21SVMVBOwF0YxHVH0b8OFt/LQ
         DWRNbnETQw+W0d/C+lI+bhhd23EnGxYbUhQlGTuoLa9wCn8fQoWV9r0SvwZyFD+blYgF
         MDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xt/VVu1bm6xh/GckfKGMv2YCPJI7Ah04aj5E/xaHxVM=;
        b=etDlWVCPzm5ji2nRE6xwp3e1Z2qI4seU6QYV0E73+i0PxhjAGvb2OVDx9XD86fAipI
         CgdZmZkwvpdL3AecbBqmMUwDuLgxH4VAlXTds/lvY8ZHGnWnVi4dOgJS+Ut7zn5F8z0D
         gjIa8UYye/R8fEbXS6gYOk1YntKmpT6NldzvK60uY/qObo3jKeoWjXF6Jo/P1CvW2bzA
         N4NeQTrY/qqOEX9jd2ih4IbekYj31pX89RUxNrb17yjDv+c0OiVyVgOCjAQ/4uXvomrC
         cYHCpv0lZqoUsYyOKRefugAnOnN6vtc2gbZKGfr6Q1HjElZEHtCwRYKV47TEMIpcJibH
         A2yA==
X-Gm-Message-State: AOAM533W5TQknBUqhfNeaUY7lrIfRkvk31YMpBMZdTr9l0n/nCxdEiQF
        /LA1Vr19UV2k20h3DG1G81ZId7ZfrnqBUZ1PRYW/Dsos
X-Google-Smtp-Source: ABdhPJxf2Y0rS20pXyphZu92O09Fz/nvBGNSVSJ5Tr1gBa3eC82kmsw2SDdOQf2SfKFxxzhr5Q8XTgyOPzBagpc2PPY=
X-Received: by 2002:a62:5284:: with SMTP id g126mr24365325pfb.36.1592897113551;
 Tue, 23 Jun 2020 00:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200613113328.GA5400@kunai> <CANcMJZDT0oc8m1jjthVANGz6iZ+J4gv5YOqnXMLWbHtZgeQ_eA@mail.gmail.com>
In-Reply-To: <CANcMJZDT0oc8m1jjthVANGz6iZ+J4gv5YOqnXMLWbHtZgeQ_eA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 23 Jun 2020 10:25:00 +0300
Message-ID: <CAHp75Vfa_X-KR_v0bHG+mgy1q2i-_e_3Q2Akq12juviqR91PAw@mail.gmail.com>
Subject: Re: [PULL REQUEST] i2c for 5.8
To:     John Stultz <john.stultz@linaro.org>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Tom Gall <tom.gall@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 5:05 AM John Stultz <john.stultz@linaro.org> wrote:
> On Sat, Jun 13, 2020 at 4:36 AM Wolfram Sang <wsa@kernel.org> wrote:

...

> > Andy Shevchenko (17):
> ...
> >       i2c: designware: Move ACPI parts into common module
>
> Just as a heads up. I'm seeing a regression from this merge that I
> bisected down to the patch above (f9288fcc5c615), with the HiKey
> board. It seems the adv7511 (HDMI bridge) driver isn't probing, which
> causes graphics to fail.
>
> I've just bisected it down and haven't managed to do much debugging,
> but I wanted to raise a flag on this. Let me know if there is anything
> you'd like me to try right off.

Thank you for the report!

The above change was purely clean up  / refactoring to get PCI
enumerated devices used to ACPI additional data. I bet your patch is
correct, but I will look closer and see what is the real root cause of
such behaviour. I'll comment on your patch separately.


-- 
With Best Regards,
Andy Shevchenko
