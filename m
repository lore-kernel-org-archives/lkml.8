Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B891FC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 09:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90ECD206B9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 09:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGQfkGih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgDVJOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 05:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726451AbgDVJOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 05:14:49 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6353C03C1A6;
        Wed, 22 Apr 2020 02:14:49 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id x2so1128545ilp.13;
        Wed, 22 Apr 2020 02:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oaJM9sd2m84/FAwe9eHXBdDTeN4F6hldhFPypOmqL3Q=;
        b=jGQfkGihgBMNImvVI1vDjbTMJYi4SZvE6tNyfOBPfYZn3bEQovCvH1li4tFOnBg7fN
         r1llf1CFsb7aH6vcC+/NKP4yVp6s2e4I7u5HGLZsPcFatNeJRVdxva6/3QL4W8WqQfC2
         qmBqysSH7tFf9sqMVyiQ+y5qd/aqh5np9llWiSlUKC/jJxTZC+Qd6fSeDpd5Vjuf7IZw
         ifICZdXQnAY5SLCt3lppPQP39RgdI/MZCu3yisTVdM7A4ZqG/+XZQuVehH4mksjkJI6q
         zq5X7UtSuhSV9Zhx8iLy5BXRRGBvbbMOg64ZmIOlg5dwZVl1tUtGySS+NQukSvEvCaLd
         5MIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oaJM9sd2m84/FAwe9eHXBdDTeN4F6hldhFPypOmqL3Q=;
        b=SIcZqXsr0RvDM8QisbPenUy822uh7k4sjqNcBmIps9g8G4XIycvQpD7nDev+HecRJR
         mbICFkraSuNLdw1bKIRkbV2Us+vwofqBAO/qMRILIZMryvzsTk96uh32vcT9q1Cb8eVb
         T7iqQsfC7rMb5cRvreIj/2aaQLJ/B3aapfC28K43W3PxmF3Zv8OkdPuv5ABLeHd0RhUs
         kXim3odMbIY8u5xB4CBMY2LcJDYTPV+5cAhVWOSc/UOj5HCzm+ydm9aZLzBtCMYgyotT
         9I5+RSeQyONuyQPlPdKgyBz6Ks3gHw8ZASK3+evJs0T8230Flb+zwOeYdo1BrPlSxVi2
         SJqA==
X-Gm-Message-State: AGi0PuaIgmC8uuAtEjWvyF/rGsjpZOC/8OZuQPZHbeiRv6UBc9nODQLG
        71pdD/v4r6+TT/0xFuynpcJnmYnWQfH7hn2hdfoEDKkG
X-Google-Smtp-Source: APiQypLDScpVfwL23HgjzpuY5CTZczukDxHa953XA1W3RlAHDModV6xcrO7EPTKgCdpI82cL6pUD8bhum7pmZHLY2zA=
X-Received: by 2002:a05:6e02:111:: with SMTP id t17mr13850416ilm.59.1587546888224;
 Wed, 22 Apr 2020 02:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200422041502.7497-1-samuel@sholland.org>
In-Reply-To: <20200422041502.7497-1-samuel@sholland.org>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Wed, 22 Apr 2020 11:14:36 +0200
Message-ID: <CAJiuCceWffc7O+MMK4wiGJEQ-m-4misCpq8w35_esdHVkwkkfA@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH] arm64: dts: allwinner: a64: Disable SPDIF
 by default
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

On Wed, 22 Apr 2020 at 06:11, Samuel Holland <samuel@sholland.org> wrote:
>
> As of v5.7-rc2, Linux now prints the following message at boot:
>
>   [   33.848525] platform sound_spdif: deferred probe pending
>
> This is because &sound_spdif is waiting on its DAI link component
> &spdif to probe, but &spdif is disabled in the DTS. Disable the
> audio card as well to match.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index 6f8c30d89b9b..6c233ff031c6 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -169,6 +169,7 @@ link0_codec: codec {
>         sound_spdif {
>                 compatible = "simple-audio-card";
>                 simple-audio-card,name = "On-board SPDIF";
> +               status = "disabled";
>
>                 simple-audio-card,cpu {
>                         sound-dai = <&spdif>;

This "On-board SPDIF" node is board specific and should be moved to
each board instead of be disabled here.

Maybe drop the node, and people who need it whould reintroduce it properly?

Regards,
Clement


> --
> 2.24.1
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20200422041502.7497-1-samuel%40sholland.org.
