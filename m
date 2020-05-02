Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E485C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 15:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACDD32072E
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 15:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588431858;
	bh=kCtnSdHwkAp2lOklp+z0M+hBKzuMdIcNMircwOeNkCY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aj3Iu/AhlYW1qscnlJ27WaBBTGDnsBNXRHqu1v+C0KysI8N14+NCQcRAqlFZgrJBF
	 Mmg8cPjh6jdOXm9ynb475X5GvKFhZJdJWPbHhouE8hV1QwipoF9l8ucDM5vNW0AOKt
	 zUHqUqz0YdOZCXCMy/vosu4XG/VS5xOMZMdb9794=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgEBPER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 11:04:17 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:48645 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbgEBPER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 11:04:17 -0400
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 042F43bi028934
        for <linux-kernel@vger.kernel.org>; Sun, 3 May 2020 00:04:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 042F43bi028934
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1588431844;
        bh=DMFnL4Ja0ytXLUSslY0x5/p22BzQ4UAUV+62ACuyysQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Aaef2tA5bhM68oFBSPc3aAjVXTHBzg4wvC5CM69KmQjAWqqYZkbBDZ2h7zoOKiMve
         xKHTsM9HnJhQattM9rgn18389ernwpwz2h9P8yAKLVYu9/zNqH9ByXdYD/VAURfaw0
         lmdUr6fUn0KBiFrQxFl5BK3sE5vB3rl9lHgEHjhngqo/fOFSlV8yY2tfTaHEaDx5NV
         Nmz+B0qmDGUh+YFOFl3qzeuH7wo7YRwO6e82tRlsZgN5IF/jwQfSG9020K+ysi9+s3
         PEZBKugnWxiIQrGFw6V7kvN2o6P4S4z0ddj49ANfcXE2ef+U2ayRu5g6PbBjpeeFX5
         zH8uSkt8iYeig==
X-Nifty-SrcIP: [209.85.222.50]
Received: by mail-ua1-f50.google.com with SMTP id m9so4778584uaq.12
        for <linux-kernel@vger.kernel.org>; Sat, 02 May 2020 08:04:03 -0700 (PDT)
X-Gm-Message-State: AGi0PubLnPaP/07i1ohjkjUu5Lndk/5hlC6BEIqJ0rwH5q76AatG4H+x
        ELnPa7Th51pZXoyX4UgQTGleRuMatOkOHAyikqs=
X-Google-Smtp-Source: APiQypKYU379ZG2zUNV9c+3y8UZrlzOKgE4riQVGDpCQP+GZinRb3+Z4tsJ4iySUD93U14eljHqVMjapOYXtMJXn6zc=
X-Received: by 2002:a9f:28c5:: with SMTP id d63mr6212285uad.25.1588431842760;
 Sat, 02 May 2020 08:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <1588370065-30312-1-git-send-email-sidgup@codeaurora.org>
In-Reply-To: <1588370065-30312-1-git-send-email-sidgup@codeaurora.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 3 May 2020 00:03:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNARPH+hZdo-0_pmOzZNqTHj7rJTMQq9Nd_F-oyqK2zJrtQ@mail.gmail.com>
Message-ID: <CAK7LNARPH+hZdo-0_pmOzZNqTHj7rJTMQq9Nd_F-oyqK2zJrtQ@mail.gmail.com>
Subject: Re: [PATCH] scripts: headers_install: Exit with error on config leak
To:     Siddharth Gupta <sidgup@codeaurora.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 2, 2020 at 6:55 AM Siddharth Gupta <sidgup@codeaurora.org> wrote:
>
> Misuse of CONFIG_* in UAPI headers should result in an error as it exposes
> configuration of different targets to userspace.
>
> Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
> ---
>  scripts/headers_install.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
> index a07668a..bd6c93a 100755
> --- a/scripts/headers_install.sh
> +++ b/scripts/headers_install.sh
> @@ -109,7 +109,8 @@ do
>         done
>
>         if [ "$warn" = 1 ]; then
> -               echo "warning: $INFILE: leak $c to user-space" >&2
> +               echo "error: $INFILE: leak $c to user-space" >&2
> +               exit 1
>         fi
>  done


If you want to change this,
please update the comment at line 67.

Also, rename the variable $warn to
something else, $error or $leak_error, etc. ?



-- 
Best Regards
Masahiro Yamada
