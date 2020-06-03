Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67825C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 05:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 477D02072F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 05:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591163257;
	bh=4hV9zOYAwa5fZBm9b4fk80V+8YQ7iTXLIK7Ol3mlm5w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gLvSUGGO59H/GTW1FwbdzIItOUioKCA6nGlx+tg083+jmGa7VkRnSHfyc15NpmmYs
	 /uzpIcq3IHz36OpDY8pnKLlQbdSG5qPxDNTL6giN89zG+HR5wGM7jf/EuLIFT3uQSi
	 l7w6EcOMCA8AlKkwMSTgK5QVT9DJGN/5RXZVDDuk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgFCFrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 01:47:36 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:22069 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgFCFrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 01:47:36 -0400
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 0535lMin010013;
        Wed, 3 Jun 2020 14:47:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 0535lMin010013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1591163243;
        bh=1AYS32C3X7KLeQC7IXtA1bYPOaxXAdUOtphNneA3Mng=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l+YThKbP4i71CVKFXx++1rr8RpKprqz6eJ2pJLVk/P8Vll7uPgGUsBMzyQ5TKdYVP
         bMN8ct6flLq1OfD1Sw8fdPLz1JPSATUAeGZQAnsg4x+h9klAYuhxltn0Nhj2Cogy5y
         tXwBY7/7NeCzCx42Aj8HnyVuBRUcRuKn9lSUqj3pbjyiArls1RgXj2MiTriWZu4Zmj
         cMdQofmNdl/U5sBHLXTpHjcD+wkUJ06K09ksgf3V80eZExy+MXO7+POzDF03gVzMEU
         fHh98g/WF8XaksX9bjmOtm03rZcMDRjiVARglI6Kb1jyaCi+WwCs9mqcT5+0DmdOj8
         G+HJmhSJ/miBg==
X-Nifty-SrcIP: [209.85.217.46]
Received: by mail-vs1-f46.google.com with SMTP id t132so424745vst.2;
        Tue, 02 Jun 2020 22:47:22 -0700 (PDT)
X-Gm-Message-State: AOAM5314sO2waBPFqnOAthNFZOc4rDtrdgUmrkP+cVkTXyPxzUFrzglC
        ZBpYfUJTZQccgkDX98PYIrENxRdMHGn+eokVVyQ=
X-Google-Smtp-Source: ABdhPJw3ZQPVgzhisg7jE9+Mh/ssKPFT64P4ZAuQnK4DGUGQnuZQ9wHxr+7wxPPNzzCQUFb4k1+BM+DQXq0O+BJQUyI=
X-Received: by 2002:a67:6383:: with SMTP id x125mr110672vsb.54.1591163241712;
 Tue, 02 Jun 2020 22:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200325095326.10875-1-geert+renesas@glider.be>
In-Reply-To: <20200325095326.10875-1-geert+renesas@glider.be>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 3 Jun 2020 14:46:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNARm_EdKTeZj6FUtNnL5oZypPw1mZtcNu7Az86fKjMF24A@mail.gmail.com>
Message-ID: <CAK7LNARm_EdKTeZj6FUtNnL5oZypPw1mZtcNu7Az86fKjMF24A@mail.gmail.com>
Subject: Re: [PATCH] h8300: dts: Fix /chosen:stdout-path
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        DTML <devicetree@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 6:53 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
>     arch/h8300/boot/dts/h8s_sim.dts:11.3-25: Warning (chosen_node_stdout_path): /chosen:stdout-path: property is not a string
>     arch/h8300/boot/dts/h8300h_sim.dts:11.3-25: Warning (chosen_node_stdout_path): /chosen:stdout-path: property is not a string
>
> Drop the angle brackets to fix this.
>
> A similar fix was already applied to arch/h8300/boot/dts/edosk2674.dts
> in commit 780ffcd51cb28717 ("h8300: register address fix").
>
> Fixes: 38d6bded13084d50 ("h8300: devicetree source")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>


Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>


Unfortunately, h8300 maintainer is not responding...

How to get this in?

Perhaps, Rob can pick this up?


Thanks.






> ---
>  arch/h8300/boot/dts/h8300h_sim.dts | 2 +-
>  arch/h8300/boot/dts/h8s_sim.dts    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/h8300/boot/dts/h8300h_sim.dts b/arch/h8300/boot/dts/h8300h_sim.dts
> index 595398b9d0180a80..e1d4d9b7f6b40c04 100644
> --- a/arch/h8300/boot/dts/h8300h_sim.dts
> +++ b/arch/h8300/boot/dts/h8300h_sim.dts
> @@ -8,7 +8,7 @@
>
>         chosen {
>                 bootargs = "earlyprintk=h8300-sim";
> -               stdout-path = <&sci0>;
> +               stdout-path = &sci0;
>         };
>         aliases {
>                 serial0 = &sci0;
> diff --git a/arch/h8300/boot/dts/h8s_sim.dts b/arch/h8300/boot/dts/h8s_sim.dts
> index 932cc3c5a81bcdd2..4848e40e607ecc1d 100644
> --- a/arch/h8300/boot/dts/h8s_sim.dts
> +++ b/arch/h8300/boot/dts/h8s_sim.dts
> @@ -8,7 +8,7 @@
>
>         chosen {
>                 bootargs = "earlyprintk=h8300-sim";
> -               stdout-path = <&sci0>;
> +               stdout-path = &sci0;
>         };
>         aliases {
>                 serial0 = &sci0;
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
