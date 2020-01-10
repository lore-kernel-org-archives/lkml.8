Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E29C33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981942087F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRxkQfBR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbgAJKWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 05:22:46 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33094 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbgAJKWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 05:22:45 -0500
Received: by mail-pj1-f66.google.com with SMTP id u63so1782657pjb.0;
        Fri, 10 Jan 2020 02:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vyGplF1Vi6uOuen6RyK+HlB7evcL/8NyYewk4/5tN0s=;
        b=NRxkQfBRn5jdfp7BxhBi+bP/wh9CvKrgYPvWQCuxGUjEX3NNRBjymX/6zsEIZLFNwQ
         v5xKlDjm5jo25jcSohiiufHlsEaPbWky050KylTLN6U5ubCCKLQIW+DXbUt5bjCgr51T
         3lE24EpXwzzrB2O+2PY6iICkpoTT2/akXSEon++gv2tVMjDe+VGfd9ZPR5xITI+fXlIy
         y0kFW1sc1ilLFQ9is02Ka0X2VWRoIO/4E+eM29mq9EYzj390vqxgTJyom+O7bcjevE+Y
         kwTGnqF1CPMK5levAQLHgLHTdwN42RXzmSYCtI11Rol4NwI2BSye3jt1BqfoUZWslDAT
         Q/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vyGplF1Vi6uOuen6RyK+HlB7evcL/8NyYewk4/5tN0s=;
        b=pQp/yT/BhatrKTM6ywVXybW/Qd96t6A/RIouhtMJ8FqrDLp0SnXrAqBsIt21Mz8APW
         Ec0e/BaDBVmrXVcchMNxcTD/idC4e4wdw52wY+CuCBgIMDaCFLcwOisgF834FPvqaEY9
         FN3Dpr2e/A5jtmTPdvWJPWCC5q5gr1XqJHNx3TdJhtZ0sE2nn0SoqCs0wW/Twcxp6lc1
         tSGIOA43HW720gNaut4/v0hQzWJavdptbVJILwLhE6Ob9p81t1lOwnscXF5IThkQilXY
         idHGhY9pjQ7pxKtTgWby3Mz1dBVsmmFYUiB2rScs/APjj/qGx1CesSrE3ldGLrzkCLiw
         sqNA==
X-Gm-Message-State: APjAAAVpP7Hex1WbKRQfW3rRzF1BgJCBfnWAIc2gA1uXNgkYVRv9hSnd
        PewbZaeVrUIf6CzWSwdClVOK8FWB2600ZyAVg1c=
X-Google-Smtp-Source: APXvYqynjA/oJmxNHuUMafw6FH+naHMqreiFQziBlP+wszsAkEpSw/6sdgnjX4MpEVs2HIzxzAyLeIIPkMckKuKrZJ4=
X-Received: by 2002:a17:90a:b10b:: with SMTP id z11mr3891518pjq.132.1578651764926;
 Fri, 10 Jan 2020 02:22:44 -0800 (PST)
MIME-Version: 1.0
References: <20200110165233.0ee71ee4@canb.auug.org.au>
In-Reply-To: <20200110165233.0ee71ee4@canb.auug.org.au>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Jan 2020 12:22:35 +0200
Message-ID: <CAHp75Vcu6JnfX13_eAy+gXu_jQMXQzcD0rSwANU2n9uS-6vmpQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the generic-ioremap tree with the
 drivers-x86 tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christoph Hellwig <hch@lst.de>, Darren Hart <dvhart@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 7:52 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the generic-ioremap tree got a conflict in:
>
>   drivers/platform/x86/intel_telemetry_pltdrv.c
>
> between commit:
>
>   ebc28a8e59ca ("platform/x86: intel_telemetry_pltdrv: use devm_platform_ioremap_resource()")
>
> from the drivers-x86 tree and commit:
>
>   4bdc0d676a64 ("remove ioremap_nocache and devm_ioremap_nocache")
>
> from the generic-ioremap tree.
>
> I fixed it up (the former removed th referneved to ioremap_nocache so
> I just used that) and can carry the fix as necessary. This is now fixed
> as far as linux-next is concerned, but any non trivial conflicts should
> be mentioned to your upstream maintainer when your tree is submitted for
> merging.  You may also want to consider cooperating with the maintainer
> of the conflicting tree to minimise any particularly complex conflicts.

Thanks, Stephen!
The conflict resolution looks correct to me.

>
>
>
> --
> Cheers,
> Stephen Rothwell



-- 
With Best Regards,
Andy Shevchenko
