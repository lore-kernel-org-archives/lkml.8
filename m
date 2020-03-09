Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69A8C10DCE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 00:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC6A820674
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 00:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583714506;
	bh=peSznHXuJCkl787BSO8M25FvbBx4U3yhqJmtG64E19I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=v/65V03C3jhx6IbDy6MEafiI9aPJsVdrlxZfB/qWXkeTNi6wERADmQ1GpGttPKkzy
	 ETTuY8Hk/pDGjl8RyPy0136SjS7f9QAKcTPO1LJHBGr9FxXl+xkH7yHjs1RELmOGpg
	 TRTz9Atak0BdCYvSBmHmiWsdgoyLi1h3Q84rf+aY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgCIAlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 20:41:21 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:48723 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgCIAlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 20:41:21 -0400
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 0290eso0024295
        for <linux-kernel@vger.kernel.org>; Mon, 9 Mar 2020 09:40:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 0290eso0024295
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1583714455;
        bh=Zp+vgNpNVW0FeI5TnKPcJs7XrT2/R3BYpxjqyKXAZhE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dUOyaAMC3hAoJM4oTt3lDkKSQ9JhqOLYbs1LwUl5Mvlt51B9rg4UT1fZlnvANKmUS
         L4oOX7sbHQ3ruD44JXNNc1e+aq4lM4aPGWsPQ6aeJMRmVLddYunh+lD6YXLRWZWq18
         TvL75pYcsEVH2Ip+qyc4YxphFhdFDVD9B8XI3FSpWLe/2cTmdoXoD52Ezlgc18mzDa
         uYcHF5XYIi2MDTjWHfPyO8VLNvy7D3DWuVqfXLNib28UsPsvZOvsJMBLMMTGrAUdWy
         sm2cLvYtMbakdJaoGhlPrIJS1722s5Yo1TCSU2dVpGGanUOICxXtmIpzvPplwpvNgJ
         8FqHLNimi1DwQ==
X-Nifty-SrcIP: [209.85.222.53]
Received: by mail-ua1-f53.google.com with SMTP id b2so249194uas.13
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 17:40:54 -0700 (PDT)
X-Gm-Message-State: ANhLgQ2kJb7EKexvMzjQznnpDvXdSm3vC+TYkyaMPLe/e1BvNaxElBI2
        5voAtCHcug6hiWSnoZ1UEvjQ/gQoWgYl6zz+jtM=
X-Google-Smtp-Source: ADFU+vuK90NERaSZutUzObSHlLcopxkRoeH64KbFM2rz/IJDFVXn35+kHG7NgCo/SoWrLWl54Sr0mfdSBe9O78Ht36Q=
X-Received: by 2002:ab0:3485:: with SMTP id c5mr7077286uar.109.1583714453622;
 Sun, 08 Mar 2020 17:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200306160206.5609-1-jeyu@kernel.org>
In-Reply-To: <20200306160206.5609-1-jeyu@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 9 Mar 2020 09:40:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNARZ4VgaCa_TiDBG-99amBGTTXTQMs9LsK3nO4k+y-5KDQ@mail.gmail.com>
Message-ID: <CAK7LNARZ4VgaCa_TiDBG-99amBGTTXTQMs9LsK3nO4k+y-5KDQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] modpost: rework and consolidate logging interface
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Matthias Maennich <maennich@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jessica,



On Sat, Mar 7, 2020 at 1:02 AM Jessica Yu <jeyu@kernel.org> wrote:
>
> Rework modpost's logging interface by consolidating merror(), warn(), and
> fatal() to use a single function, modpost_log(). Introduce different
> logging levels (WARN, ERROR, FATAL) as well. The purpose of this cleanup is
> to reduce code duplication when deciding whether or not to warn or error
> out based on a condition.
>
> Signed-off-by: Jessica Yu <jeyu@kernel.org>
> ---
> v3:
>         - remove level variable from modpost_log and just call fprintf in each
>           case
>         - remove warn_unless and just call modpost_log() directly
>         - fix checkpatch error:
>                 ERROR: space required before the open parenthesis '('
>         #102: FILE: scripts/mod/modpost.c:61:
>         + switch(loglevel) {
>
>  scripts/mod/modpost.c | 68 ++++++++++++++++++++++-----------------------------
>  scripts/mod/modpost.h | 14 ++++++++---
>  2 files changed, 40 insertions(+), 42 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 7edfdb2f4497..a2329235a6db 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -51,41 +51,34 @@ enum export {
>
>  #define MODULE_NAME_LEN (64 - sizeof(Elf_Addr))
>
> -#define PRINTF __attribute__ ((format (printf, 1, 2)))
> +#define PRINTF __attribute__ ((format (printf, 2, 3)))
>
> -PRINTF void fatal(const char *fmt, ...)
> +PRINTF void modpost_log(enum loglevel loglevel, const char *fmt, ...)
>  {


This series looks good to me.

I can queue it up to kbuild tree
if there is no objection.


I just noticed one nit.

Now that modpost_log() is the only user of PRINTF,
we can delete PRITNF, and directly add the attribute
to modpost_log(), like this:


void __attribute__((format(printf, 2, 3)))
modpost_log(enum loglevel loglevel, const char *fmt, ...)
{
       ...
}


If you agree, I can modify it when I apply it.


Thank you.



--
Best Regards
Masahiro Yamada
