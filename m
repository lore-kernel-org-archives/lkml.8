Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3190C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BCE0206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598458719;
	bh=Gee9dPvWH6XsuIw+oo+dNqwhrWVftDB2FRXa2b2lzio=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MZ9xI8OKrJ9dHEG3ldEaBtabhHCxEfwR9mEZI5d73m++FcUF3vNLvX7m54Jr6EFjE
	 fm+fJ5Z12FrK+SUGBNmgi6XCIpsdKc3myJmrwEZaSPDScI8sBP01PGg8T4mBuiJRhr
	 JXhAqT7Z4JbogwSkNC2XuaJ/GTIdi32PFKIJrEnA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgHZQSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:18:38 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:39818 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgHZQS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:18:27 -0400
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 07QGI6WJ028180
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 01:18:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 07QGI6WJ028180
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1598458687;
        bh=A6WnX8uZufR8/Myk1/Me44AoLSgqsOIc6V3X17V9620=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=utef6BnPCckUPsS9T1ravFF0GLCAg5TeeyLsl3jKKuoPod18jl+wYTHwoloHrxeG4
         pGbanKeUssV/nJ/xAoXNajZHoPfqiqSSgolNv5BM5TGwO9utpOxDiUkFgIOh1E1nHT
         nFTIbDxKP7PsWO7Lr++AkPduompF21QrsXcjTgKZ2beZbczcm3y/MeGg7W0aaFAFTo
         sW2GxgGGtaM3VHAtSBgzGbwbwKfU1MaTEeESWzb3me5+2FuWh2nuwdLSnbr7dFnvw6
         a5oY21d0t1lbg1rVgQ9mie7GsjjU9ssPhZvtrBV94+7NN2Bag48cuTtsvAq8vkrc1K
         YSC6u1CZtxUcw==
X-Nifty-SrcIP: [209.85.215.169]
Received: by mail-pg1-f169.google.com with SMTP id p37so1284883pgl.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 09:18:06 -0700 (PDT)
X-Gm-Message-State: AOAM530WAwSD8HLHUf1+jefbNJtSmy1YPPZJ6GUx33DTgysriKws5RgF
        DRVgRA+MNrBcqVag1xeQOhAfPY/Ij+IBXkDM8J0=
X-Google-Smtp-Source: ABdhPJzGa4vvbqCViAw+mT451usevzxL7N9/l8ql67kzgxnSNUAJdjBWSECJtuYDe3TlBcUJrx9/lHZ4sdL/NEQz5kw=
X-Received: by 2002:a63:541e:: with SMTP id i30mr11428977pgb.47.1598458686025;
 Wed, 26 Aug 2020 09:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200819122925.18557-1-geert+renesas@glider.be> <87mu2kemvl.wl-ysato@users.sourceforge.jp>
In-Reply-To: <87mu2kemvl.wl-ysato@users.sourceforge.jp>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 27 Aug 2020 01:17:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNARNWgM5ZvRJ3OtmAcTxKsFHDMBkW7wAdQgnm_8V2EniOQ@mail.gmail.com>
Message-ID: <CAK7LNARNWgM5ZvRJ3OtmAcTxKsFHDMBkW7wAdQgnm_8V2EniOQ@mail.gmail.com>
Subject: Re: [PATCH v2] h8300: Replace <linux/clk-provider.h> by <linux/of_clk.h>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 12:46 PM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
>
> On Wed, 19 Aug 2020 21:29:25 +0900,
> Geert Uytterhoeven wrote:
> >
> > The H8/300 platform code is not a clock provider, and just needs to call
> > of_clk_init().
> >
> > Hence it can include <linux/of_clk.h> instead of <linux/clk-provider.h>.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> > v2:
> >   - Add Reviewed-by.
> > ---
> >  arch/h8300/kernel/setup.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/h8300/kernel/setup.c b/arch/h8300/kernel/setup.c
> > index 28ac88358a89a4f9..0ecaac7dd7e93d9f 100644
> > --- a/arch/h8300/kernel/setup.c
> > +++ b/arch/h8300/kernel/setup.c
> > @@ -24,7 +24,7 @@
> >  #include <linux/of.h>
> >  #include <linux/of_fdt.h>
> >  #include <linux/of_address.h>
> > -#include <linux/clk-provider.h>
> > +#include <linux/of_clk.h>
> >  #include <linux/memblock.h>
> >  #include <linux/screen_info.h>
> >  #include <linux/clocksource.h>
> > --
> > 2.17.1
> >
>
> Applied h8300-next.
> Thanks.
>
> --
> Yosinori Sato


Sato-san,


The following two commits should be dropped
from your branch.

(The first one reverts the upstream commit,
then the second one re-adds it.)




commit de98871736825349b367275b0790e42ea4157350
Author:     Yoshinori Sato <ysato@users.sourceforge.jp>
AuthorDate: Thu Apr 16 13:43:01 2020 +0900
Commit:     Yoshinori Sato <ysato@users.sourceforge.jp>
CommitDate: Thu Apr 16 13:43:01 2020 +0900

    h8300: move definition of __kernel_size_t etc. to posix_types.h

    These types should be defined in posix_types.h, not in bitsperlong.h .

    With these defines moved, h8300-specific bitsperlong.h is no longer
    needed since Kbuild will automatically create a wrapper of
    include/uapi/asm-generic/bitsperlong.h

    Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
    Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

commit ece7be2c964c2aa5015e74628ca33c03a5ff4e47
Author:     Masahiro Yamada <yamada.masahiro@socionext.com>
AuthorDate: Tue Jul 23 19:21:06 2019 +0900
Commit:     Yoshinori Sato <ysato@users.sourceforge.jp>
CommitDate: Thu Apr 16 13:40:31 2020 +0900

    h8300: move definition of __kernel_size_t etc. to posix_types.h

    These types should be defined in posix_types.h, not in bitsperlong.h .

    With these defines moved, h8300-specific bitsperlong.h is no longer
    needed since Kbuild will automatically create a wrapper of
    include/uapi/asm-generic/bitsperlong.h

    Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
    Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>




-- 
Best Regards
Masahiro Yamada
