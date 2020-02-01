Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EC6C33CB2
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 03:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D54206D3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 03:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580526809;
	bh=pkj/HRmp1kZutuM7txEcL8Rjj1677eYFvrkkpwcUni8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=e7M2qSQUGZA1mPwgQE5ed4zW99Gzheb7awmq/lgGGj7BvwpQhRM73sBdm1Y/Tg2f+
	 RtrNYFAjY/xAIAvFupiXifI3s2m9ZrKJc1jHmOqSNBZqpnRs8+0XzbWJXALvqS00aL
	 TBZ2I4bVRgghezRe8cw0xaJy2asS4qOeZyHSxL60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgBADN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 22:13:28 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:55760 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgBADN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 22:13:27 -0500
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 0113DLDm009510;
        Sat, 1 Feb 2020 12:13:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 0113DLDm009510
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1580526802;
        bh=ksQtQURl2x42JI5HQi3g0Y259IHl4s45ZmZXBUB6zak=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BKn59/y8oLy5s+zElQZstrBnxuRT/En4Uk0ewz0YHhUghhiOGwcpbXzudpVR7Vghr
         9mKewyp/X4WHlbPEWYTGfpCZ2T14ZhmHX1irTSz9egdZ5eebHprlCAN2P7O6CfrvcP
         6WDqeMTJ8c2ig+6pmylzHhD1CwfOnypLbTJuBy+MXAddCtE8PNIBeWboVa1mJK5I7E
         5vdWhuIzXa/RslVDdVlbMY4HbIaSN74abqGyxg4Y747RXhTvTYBIzNCqMUT9C7VVYC
         yzfM6u3lQJ0KkAKV5yo8NfS2XlcwaRIdO0awMeLQENwXM2OTthyiBNE63a+loJNewK
         b4ooOb2jVBTeQ==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id g23so5658323vsr.7;
        Fri, 31 Jan 2020 19:13:21 -0800 (PST)
X-Gm-Message-State: APjAAAWqv52asO21QBX8wHc1l7J2SCU/sodCq8AS9cmF697eCsfz3etq
        +w/y71+DcgBq7jHipnyXc06V/MeoVnr2kin84eM=
X-Google-Smtp-Source: APXvYqzdoalu+SqrZSQ+9JZSGhwOlYChlO7/PUp3X0NlVSrxUrHnl+0z0oyYRupVB2AZWxU3Qsw1wHGmnNQbqIxUzi0=
X-Received: by 2002:a05:6102:3102:: with SMTP id e2mr8819451vsh.179.1580526800711;
 Fri, 31 Jan 2020 19:13:20 -0800 (PST)
MIME-Version: 1.0
References: <20200122100344.50751-1-vincenzo.frascino@arm.com>
In-Reply-To: <20200122100344.50751-1-vincenzo.frascino@arm.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 1 Feb 2020 12:12:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNATxbGWGW19N9H-HAiSY0AL0iFs8D_H0DEKmEfTGTT88iA@mail.gmail.com>
Message-ID: <CAK7LNATxbGWGW19N9H-HAiSY0AL0iFs8D_H0DEKmEfTGTT88iA@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Sanitize make randconfig generated .config
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.


On Wed, Jan 22, 2020 at 7:03 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> "make randconfig" calculates the probability of a tristate option (yes,
> mod, no) based on srand()/rand() and can be fed with a seed.
> At the last step of randconfig some option are chosen randomly and their
> tristate set based on similar mechanism.
> After this passage the resulting .config is not sanitized, hence it
> might result in an inconsistent set of options being selected.
>
> This was noticed on arm64 using KCONFIG_SEED=0x40C5E904. During
> randomize_choice_values() CONFIG_BIG_ENDIAN is enabled. Since CONFIG_EFI
> was enabled at a previous step, and depends on !CONFIG_BIG_ENDIAN the
> resulting .config is inconsistent.
>
> Fix the issue making sure that randconfig sanitizes the generated
> .config as a last step.
>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  scripts/kconfig/conf.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
> index 1f89bf1558ce..c0fcaa4e9762 100644
> --- a/scripts/kconfig/conf.c
> +++ b/scripts/kconfig/conf.c
> @@ -654,6 +654,11 @@ int main(int ac, char **av)
>         case randconfig:
>                 /* Really nothing to do in this loop */
>                 while (conf_set_all_new_symbols(def_random)) ;
> +               /*
> +                * .config at this point might contain
> +                * incompatible options. Sanitize it.
> +                */
> +               sym_clear_all_valid();

Thanks for the report, but clearing
all the valid flags is a big hammer.
I do not think it is a proper fix.


I checked the code, and I noticed the root cause of
this bug.

I will send a different patch later.




>                 break;
>         case defconfig:
>                 conf_set_all_new_symbols(def_default);
> --
> 2.25.0
>


-- 
Best Regards
Masahiro Yamada
