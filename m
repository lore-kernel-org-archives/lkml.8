Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E68C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 07:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2E3320721
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 07:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588576749;
	bh=JRN6Kiqx1O4ODA2mlwCr6ZZawMu5tFYb1hU/u58xqsg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=i3RL+bh6tV9jiv6LsfQzucsGGv1VavKJIVT8LItpDprm4C3TiyRBJTBeAQ/Ow/gn+
	 GthL7tvzBdEaA0nV1Bd8+1rble27nCbmjdMe+PM7fDjMitkZx64N0pZFhzxZCjWDZB
	 oTYXPNjJxJKPiBoxwkEvn0bZz/azOFv9u6FIvDJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgEDHTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 03:19:08 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:36590 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgEDHTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 03:19:08 -0400
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 0447IqMq019915
        for <linux-kernel@vger.kernel.org>; Mon, 4 May 2020 16:18:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 0447IqMq019915
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1588576733;
        bh=Si+uHh7+JIQDmUm173RyRUWl4SOLFbyk0wxcbPR9Eng=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QJB2PJEoO2SlXyapAnkLthBSlF9o5alXfMYFBiQ7M7HzmN9+lhj6/ypahR+uZbvid
         x+zKE0C7hdQwNpW4gib9zsxXbEXb5YPeOYFHHcQXNw+qXCnEnoiSHfan+CkBihE5mV
         EP5VPIQnXA0qB+mooAd5GPzhKM3qwi09nvh2azFi12LNN1S1YXLvmzetZN5N5eaWEJ
         KQWG2IvHrW6s7cHbft+i5Yk+vJsFfO0ULwlhjl6RLW2jEwZ3CLWZxsz9S7QESanRYQ
         3i5wzPlrJabfO4b9qrnyNf5pvPIMBnkDgQhg9uH9VYwQl9+fVjkC2cnUjDjnSkJ1aE
         wNDDEuLN4aAwg==
X-Nifty-SrcIP: [209.85.222.46]
Received: by mail-ua1-f46.google.com with SMTP id z16so6166449uae.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 00:18:53 -0700 (PDT)
X-Gm-Message-State: AGi0Puaa2ooZpIRY21/Q44N85qv5kY9QKmTy9SAXMWrff318op/F88iM
        Ha0Vy97ejrlZNbX6WWuXhpajh9S04TvwDkiSVCM=
X-Google-Smtp-Source: APiQypL9xVGg6OPLgdKiadBx9SBjVLyldVIF003gBtl6vwXUrWyA/lP/CQIhzpHgetIpT0QeL1Xgdc64fbJ4AXrTeWs=
X-Received: by 2002:ab0:69c9:: with SMTP id u9mr10567025uaq.121.1588576731993;
 Mon, 04 May 2020 00:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <1588476545-21082-1-git-send-email-sidgup@codeaurora.org>
In-Reply-To: <1588476545-21082-1-git-send-email-sidgup@codeaurora.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 4 May 2020 16:18:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ55OPgiUOdoXDHqD_p3ntiUctqmVhAmO9fRuoq=uAV7g@mail.gmail.com>
Message-ID: <CAK7LNAQ55OPgiUOdoXDHqD_p3ntiUctqmVhAmO9fRuoq=uAV7g@mail.gmail.com>
Subject: Re: [PATCH v2] scripts: headers_install: Exit with error on config leak
To:     Siddharth Gupta <sidgup@codeaurora.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 3, 2020 at 12:29 PM Siddharth Gupta <sidgup@codeaurora.org> wrote:
>
> Misuse of CONFIG_* in UAPI headers should result in an error as it exposes
> configuration of different targets to userspace.


Sorry, I missed to point out this.

This statement is not precious; it does not expose the kernel
configuration at all.

include/generated/autoconf.h is not available from userspace.
So, all the CONFIG options are undefined.

Could you reword the commit somehow?





>
> Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
> ---
>  scripts/headers_install.sh | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
> index a07668a..94a8335 100755
> --- a/scripts/headers_install.sh
> +++ b/scripts/headers_install.sh
> @@ -64,7 +64,7 @@ configs=$(sed -e '
>         d
>  ' $OUTFILE)
>
> -# The entries in the following list are not warned.
> +# The entries in the following list do not result in an error.
>  # Please do not add a new entry. This list is only for existing ones.
>  # The list will be reduced gradually, and deleted eventually. (hopefully)
>  #
> @@ -98,18 +98,19 @@ include/uapi/linux/raw.h:CONFIG_MAX_RAW_DEVS
>
>  for c in $configs
>  do
> -       warn=1
> +       leak_error=1
>
>         for ignore in $config_leak_ignores
>         do
>                 if echo "$INFILE:$c" | grep -q "$ignore$"; then
> -                       warn=
> +                       leak_error=
>                         break
>                 fi
>         done
>
> -       if [ "$warn" = 1 ]; then
> -               echo "warning: $INFILE: leak $c to user-space" >&2
> +       if [ "$leak_error" = 1 ]; then
> +               echo "error: $INFILE: leak $c to user-space" >&2
> +               exit 1
>         fi
>  done
>
> --
> Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project



-- 
Best Regards
Masahiro Yamada
