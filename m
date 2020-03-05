Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957D3C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 02:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E20C20842
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 02:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583374402;
	bh=Q3dyJVCSKLTlHK4WdzTkZBvaDgQxTN0vBib+xbmRByw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zv2a0K+jqZA60x0eZn4rEPFUcy84V5KpmcI7T+PRPDVTv/G21zflD82sSdywDtxrz
	 1TAUrxb9/uzMbWgP0kxRjvDTuZWsNFIBs0GlZ1ze/t+VRjO8H2ZnkOXNoGJrbQIK1f
	 DQo200XPKesum2kDgjh8937eq3RNhChSsrd8wn58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbgCECNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 21:13:21 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:25818 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgCECNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 21:13:21 -0500
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 0252D4aq011371;
        Thu, 5 Mar 2020 11:13:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 0252D4aq011371
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1583374386;
        bh=i38L4CZuze6o3qgJUcAOrEN1m2jRJ9rJ+COdhmiG0YA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fvA+f8+T82m3JfuKmP+AmtfbUcV1s1oS5fGbmzXIjyQlGNbKeZ/o/YR8Fvgz7/U//
         ewU3M3+vlfgNms4arnt5tkdOkFJHoThi0avcnhXhl/Y2rq3aRRZUJDriuvS79OgByA
         o/Znt5v957R1qXpuP+44LU6b6FACvzKtVT6d7Fod0SaMDPy5SfwRW9LeNxmNsINzln
         dr0AyE8ZuF0bWl4HmxDa1zvWudTWEedc+OLFQvLYaAoi6Q+8pV9buAW9DFAVC567zt
         5FaWW3xs9T6x0LAgpMIiDmGM0b30Tj1TqkShVM04yWfrxI6MoLvgc9Tz/aDW5ieRoj
         LlhrUUYcol5tw==
X-Nifty-SrcIP: [209.85.222.53]
Received: by mail-ua1-f53.google.com with SMTP id q17so1499086uao.12;
        Wed, 04 Mar 2020 18:13:04 -0800 (PST)
X-Gm-Message-State: ANhLgQ1C9SqG7MVv7kRMgoeNLmcgFMoD6qmGuF7M9qxzBN2mpwwIxiJT
        XBmSkB9Iok7ABrM+P8O/cTjD78VS/cZw+fuy5+k=
X-Google-Smtp-Source: ADFU+vs/Pu2ed2sR0oW20ntvvxgfxlnra6Twe21C4iAbS1shyvN0JW2AjSLleYhv1w35TfURGofOQTP7JU4kyBG5pXw=
X-Received: by 2002:ab0:2ea6:: with SMTP id y6mr3375191uay.25.1583374383374;
 Wed, 04 Mar 2020 18:13:03 -0800 (PST)
MIME-Version: 1.0
References: <20200302223957.905473-1-corbet@lwn.net> <20200302223957.905473-3-corbet@lwn.net>
In-Reply-To: <20200302223957.905473-3-corbet@lwn.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 5 Mar 2020 11:12:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNASjQdawQ5OJjTxR_NJkjVjXvzpSjPSRP5Fsm0DJAN+_FQ@mail.gmail.com>
Message-ID: <CAK7LNASjQdawQ5OJjTxR_NJkjVjXvzpSjPSRP5Fsm0DJAN+_FQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] docs: move gcc-plugins to the kbuild manual
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Michal Marek <michal.lkml@markovi.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 3, 2020 at 7:40 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Information about GCC plugins is relevant to kernel building, so move this
> document to the kbuild manual.
>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>


Acked-by: Masahiro Yamada <masahiroy@kernel.org>


> ---
>  Documentation/core-api/index.rst                   | 1 -
>  Documentation/{core-api => kbuild}/gcc-plugins.rst | 0
>  Documentation/kbuild/index.rst                     | 1 +
>  MAINTAINERS                                        | 2 +-
>  scripts/gcc-plugins/Kconfig                        | 2 +-
>  5 files changed, 3 insertions(+), 3 deletions(-)
>  rename Documentation/{core-api => kbuild}/gcc-plugins.rst (100%)
>
> diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
> index b39dae276b57..9836a0ac09a3 100644
> --- a/Documentation/core-api/index.rst
> +++ b/Documentation/core-api/index.rst
> @@ -102,7 +102,6 @@ Documents that don't fit elsewhere or which have yet to be categorized.
>     :maxdepth: 1
>
>     librs
> -   gcc-plugins
>     ioctl
>
>  .. only:: subproject and html
> diff --git a/Documentation/core-api/gcc-plugins.rst b/Documentation/kbuild/gcc-plugins.rst
> similarity index 100%
> rename from Documentation/core-api/gcc-plugins.rst
> rename to Documentation/kbuild/gcc-plugins.rst
> diff --git a/Documentation/kbuild/index.rst b/Documentation/kbuild/index.rst
> index 0f144fad99a6..82daf2efcb73 100644
> --- a/Documentation/kbuild/index.rst
> +++ b/Documentation/kbuild/index.rst
> @@ -19,6 +19,7 @@ Kernel Build System
>
>      issues
>      reproducible-builds
> +    gcc-plugins
>
>  .. only::  subproject and html
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 38fe2f3f7b6f..f508f6c783d6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6934,7 +6934,7 @@ S:        Maintained
>  F:     scripts/gcc-plugins/
>  F:     scripts/gcc-plugin.sh
>  F:     scripts/Makefile.gcc-plugins
> -F:     Documentation/core-api/gcc-plugins.rst
> +F:     Documentation/kbuild/gcc-plugins.rst
>
>  GASKET DRIVER FRAMEWORK
>  M:     Rob Springer <rspringer@google.com>
> diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
> index e3569543bdac..f8ca236d6165 100644
> --- a/scripts/gcc-plugins/Kconfig
> +++ b/scripts/gcc-plugins/Kconfig
> @@ -23,7 +23,7 @@ menuconfig GCC_PLUGINS
>           GCC plugins are loadable modules that provide extra features to the
>           compiler. They are useful for runtime instrumentation and static analysis.
>
> -         See Documentation/core-api/gcc-plugins.rst for details.
> +         See Documentation/kbuild/gcc-plugins.rst for details.
>
>  if GCC_PLUGINS
>
> --
> 2.24.1
>


-- 
Best Regards
Masahiro Yamada
