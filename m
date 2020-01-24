Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878C6C35240
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 02:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E3021835
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 02:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Q+FTstpa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbgAXCtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 21:49:05 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:20553 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730335AbgAXCtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 21:49:05 -0500
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 00O2mu79013861
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 11:48:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 00O2mu79013861
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1579834137;
        bh=fgdYLukdlEYXMD3VBQ4VxMdRlI/yjUSeaDi+4lfkCjE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q+FTstpafcV8F+hlZSNnpLo/bgF9ddwS3JoBuD3Sv5/ebipJjSpb6kw+m/oPjiDlF
         PMzN0bsZ8Uf7Ewdqf1qWffPodbkMGEi2ryCmHQNIazD0mY9VqgwNKkqaCD3WC7HtGq
         U4dWeLEoctRHRCtzbNxh127TaGJUT6Lltgx8ZTsZyh6IJdFYKZSh6N973CRsRTOLhq
         ZAmqOHUEE8Mdcz5ew5czC2rKZk16bypKOlYKnx/nxBDVNOA77epIsoc46I3JXHc+HG
         DZw9sje+7MaHuq5ZeBG0AqeJQOMm4Xpd0ltlBbNS1BvTzZ5XShWLpsUxwq20YmS8tT
         jcbDY+P2c93fQ==
X-Nifty-SrcIP: [209.85.221.173]
Received: by mail-vk1-f173.google.com with SMTP id s142so143015vkd.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 18:48:56 -0800 (PST)
X-Gm-Message-State: APjAAAUzRGhfXt2mNlDMP7AvoeSslXuBeh5y2KBGxOEziesHAGptAZom
        BVRm1I7vn0fJoq/aJ6sHBQeFIPEo96LPhUg8drM=
X-Google-Smtp-Source: APXvYqw73o8Lg4XxHWHTAaXgs8weOQ1oCX6Ih9rzdMg/Fy/BRjtW98hfNn9vKQrXn/WsIl6YfMwWb377nOPY08AzxK4=
X-Received: by 2002:a1f:72c3:: with SMTP id n186mr763524vkc.12.1579834135531;
 Thu, 23 Jan 2020 18:48:55 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNASEaiFia8NKZN8++-9RfGXOPKSFuCkdukBk9Jy7+nHecQ@mail.gmail.com>
In-Reply-To: <CAK7LNASEaiFia8NKZN8++-9RfGXOPKSFuCkdukBk9Jy7+nHecQ@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 24 Jan 2020 11:48:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT721bVwVQif--UY1dXMhq8NSRpkPOYTN-=nxyBSBOn2Q@mail.gmail.com>
Message-ID: <CAK7LNAT721bVwVQif--UY1dXMhq8NSRpkPOYTN-=nxyBSBOn2Q@mail.gmail.com>
Subject: Re: [GIT PULL] arm64: dts: uniphier: UniPhier DT updates for v5.6
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd and Olof,

I know it is already -rc7, but
it would be nice if you could pull this for the next MW.

Thanks

Masahiro

On Sat, Jan 18, 2020 at 1:20 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi Arnd, Olof,
>
> Here are UniPhier DT (64bit) updates for the v5.6 merge window.
> Please pull!
>
>
>
> The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:
>
>   Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
> tags/uniphier-dt64-v5.6
>
> for you to fetch changes up to e98d5023fe1f062bb549354a2428d930775fd67e:
>
>   arm64: dts: uniphier: add reset-names to NAND controller node
> (2020-01-18 00:56:18 +0900)
>
> ----------------------------------------------------------------
> UniPhier ARM64 SoC DT updates for v5.6
>
> - Add reset-names to NAND controller node
>
> ----------------------------------------------------------------
> Masahiro Yamada (1):
>       arm64: dts: uniphier: add reset-names to NAND controller node
>
>  arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 3 ++-
>  arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 3 ++-
>  arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 3 ++-
>  3 files changed, 6 insertions(+), 3 deletions(-)
>
>
> --
> Best Regards
> Masahiro Yamada



-- 
Best Regards
Masahiro Yamada
