Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BCFC34022
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF6C2469F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582819688;
	bh=ysYhI3xNQIjzc2dGJdewuVXd6f+7rHa1HDdT+1mizK4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rrhErYy2o8K3jGsuj+6+piFidsgJI6gjuYDQUoBJPVSAfTf6zBPZId0Hu69Ogon87
	 wQd63OP167FRfR8xB8IUq0gUEDq1qrqs9gH4WXN1TqkEcaj/nfVG9rCHqFq2BXHM+w
	 SGioOraVWqZT+LUHVFV+YEbH1/m2BwSZXFWqq4KE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbgB0QIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 11:08:07 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:59758 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729134AbgB0QIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 11:08:06 -0500
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 01RG82o5014642;
        Fri, 28 Feb 2020 01:08:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 01RG82o5014642
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582819683;
        bh=2GBQ3T84PygQ3hlQ0Zt65wpjsaJMk5y7xuzfjqDlX/M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ge9qk1kFaz/KlqoC2TlfSvoOP6YzKF6Z5gkfDFCqM79PJJhRudUMEOMEEXkqiHlBQ
         K0vK0fCa6fZr5xNfbMoPZh65Mj5iuYDxOTunwbWk4lfXMvNrq7FsPmz809LmHl+V68
         s5Xtkj+UQWhflps8Hp7pvWn51d4q3VafiKaiVb1WW8s5lyL1Fkk/45TIUH6mSIwwa7
         aFLYOGlEzEgiRtgFeSm517Wl5h472Oao5NdfAaAyhrQO27/XOp6WdHJKHsZjX5J2nR
         EHhwVUBF7Se0BgwLWe4JNrRrMws0e8fwa3iR689Cgp+8Cdy8yD6yzVi+oy6KoDinsM
         PaV34L8QJaE3Q==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id m4so2158421vsa.12;
        Thu, 27 Feb 2020 08:08:03 -0800 (PST)
X-Gm-Message-State: APjAAAXrHx6wxt14EOxODXod9Fc1MdXr2MXCHP6Uj1HbqmMsDEZqPwth
        28u3HWMbpIVjJO04QRUZvGGtxUgAeAQs1UYjbck=
X-Google-Smtp-Source: APXvYqwBz+7kDkeD1Oj7Hgy9GOm3HydsOLY9fK6t7GjMF2R1tPJCKmNMjHGBRTNEE6xgIz1rmc9IezBxoMsoXrCtR64=
X-Received: by 2002:a05:6102:48b:: with SMTP id n11mr3058742vsa.181.1582819681690;
 Thu, 27 Feb 2020 08:08:01 -0800 (PST)
MIME-Version: 1.0
References: <20200226174458.8115-1-masahiroy@kernel.org>
In-Reply-To: <20200226174458.8115-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 28 Feb 2020 01:07:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQxD6FkYRoz+Cn=SVFr8So-m0=Qf0rASFxM_-01FC1_-A@mail.gmail.com>
Message-ID: <CAK7LNAQxD6FkYRoz+Cn=SVFr8So-m0=Qf0rASFxM_-01FC1_-A@mail.gmail.com>
Subject: Re: [PATCH] kbuild: get rid of trailing slash from subdir- example
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 2:45 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> obj-* needs a trailing slash for a directory, but subdir-* does not.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Applied to linux-kbuild.


>  Documentation/kbuild/makefiles.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
> index 0e0eb2c8da7d..c9adfa1f9e21 100644
> --- a/Documentation/kbuild/makefiles.rst
> +++ b/Documentation/kbuild/makefiles.rst
> @@ -765,7 +765,7 @@ is not sufficient this sometimes needs to be explicit.
>         Example::
>
>                 #arch/x86/boot/Makefile
> -               subdir- := compressed/
> +               subdir- := compressed
>
>  The above assignment instructs kbuild to descend down in the
>  directory compressed/ when "make clean" is executed.
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
