Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D78AC54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 17:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1690A206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 17:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587834029;
	bh=5O4LNtg1EhFNZrxk948hI8QM0uY4TeStGEPjHhCNeZw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nzfrXJHUncuH2PRjEBFA6ZQ/qQbxPOVdAmCbmxGr76RAjY74fQo5ssECoZFfZMY+F
	 0msaqKuY5spSHhLwqgu57iIjoghLFrgNFGkZDR71i1QBSruBi2ZVgnESacDmhXnoJm
	 dEMXqQLTsA9Ux4idYng/XV1xHHeMNE2Ij5oTd1Kc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgDYRA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 13:00:28 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:26282 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgDYRA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 13:00:27 -0400
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 03PGxoLm011656;
        Sun, 26 Apr 2020 01:59:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 03PGxoLm011656
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587833991;
        bh=VnhUaEJBvj3k0twTEkqFsazSDaBUCEHUWDFZemmD5lk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EJqXMn/1Qy6IgzfPvZQeAyY7hGifftUpwUDyj0K1aALJT7+kALrdSePZtPGL5+iSq
         zD44Cwjt/JNMC85pf9dD2i+w2YTSCqpaAfslBxYMunf79ZHa5z/zW/TPTBhjoUHEe/
         HrK0aWiLI5s6k+XLXb+UVcW5HCZVK1iwQGdHogn1wZmTcmRBi07GwWD5iTeWMzaaKI
         7019n8BLhmYYRZzEdmBcQKPKPVTZwNgAkFOzao3N7anQG0snDJ8LOy9m/jNinYnrZb
         CZKH90gAaOr0kB4L6ecDpjH5AAqNgA3InZxIEpGwJfICFSYxp39O/ziT6723ZSLguP
         J3UxLkNTHyhRQ==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id f5so2826514ual.5;
        Sat, 25 Apr 2020 09:59:51 -0700 (PDT)
X-Gm-Message-State: AGi0PuZXvglESAj6kUWx+qy1zUTKQRlFQsuYMnmV76Kl9D7sLqRXDuDG
        vHj+lD8djCu4ltCtRsw793WfAfWR3Jxu8o693oQ=
X-Google-Smtp-Source: APiQypLhVGzu1tyERlviSVzmX/3PeMYCT8/uqmM5ayUKtVHlX4zSNmAm0ig0rnNrigvlCrg1dKxH6xaEFpgARt3fcMA=
X-Received: by 2002:ab0:1166:: with SMTP id g38mr11987377uac.40.1587833990035;
 Sat, 25 Apr 2020 09:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200413153320.93316-1-masahiroy@kernel.org>
In-Reply-To: <20200413153320.93316-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 26 Apr 2020 01:59:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS0vPy0nY8YqzsWWoSB5rgxqSe9_KLCsJoUAu_F5=57iQ@mail.gmail.com>
Message-ID: <CAK7LNAS0vPy0nY8YqzsWWoSB5rgxqSe9_KLCsJoUAu_F5=57iQ@mail.gmail.com>
Subject: Re: [PATCH] kconfig: do not use OR-assignment for zero-cleared structure
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 12:33 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> The simple assignment is enough because memset() three lines above
> has zero-cleared the structure.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/kconfig/symbol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
> index 3dc81397d003..9363e37b8870 100644
> --- a/scripts/kconfig/symbol.c
> +++ b/scripts/kconfig/symbol.c
> @@ -831,7 +831,7 @@ struct symbol *sym_lookup(const char *name, int flags)
>         memset(symbol, 0, sizeof(*symbol));
>         symbol->name = new_name;
>         symbol->type = S_UNKNOWN;
> -       symbol->flags |= flags;
> +       symbol->flags = flags;
>
>         symbol->next = symbol_hash[hash];
>         symbol_hash[hash] = symbol;
> --
> 2.25.1
>

Applied to linux-kbuild.


-- 
Best Regards
Masahiro Yamada
