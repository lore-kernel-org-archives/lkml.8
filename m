Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4232DC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20DF120736
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ZV4DwxDz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgDUOPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 10:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDUOPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:15:15 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFDEC061A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 07:15:15 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id u13so16657167wrp.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 07:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:subject:in-reply-to:date:message-id
         :mime-version;
        bh=XMNV+Kczq0nA9dcErNoCOMd6R2vnUVAmmDTt4s05utw=;
        b=ZV4DwxDzR7niBZe3R/Pmem48lFSMPZpe429hx55ySMuwjJ/ey0sP3KeD00iSoj/tfg
         sSJLQURqzUNrI6jqva80Qy3uzTmatdC8IXuQC2NMjJKwMEFBAzkwl+hx2nmP5azkJQtW
         AfEurxmKwaKwQlmFBbMB2D7VnKUkMGKCD86LyaePYqCDGmg9/Vjw2qN/8hS5Jcdp7VM7
         ZmwwK8J+g4q19oRBd4r2/U9/jCQMirUE9fQiA7o4co/Hf7YS2PP84prIWzn0llzggAo2
         2tCdb1rN1UzkxRZwmjKofnbss/oeWv4ECkojnusd1SYCUHRjpcpiBBW+AoB9vueCrd/O
         E4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:subject
         :in-reply-to:date:message-id:mime-version;
        bh=XMNV+Kczq0nA9dcErNoCOMd6R2vnUVAmmDTt4s05utw=;
        b=MFR8xkRUsk/0s/PfZglS2P/k+tr8Ct5VPkeXCWMH+apMuBtYCAseQAIIQEk1PeWEiY
         SRqRzfHw8FuiVowBgUgidbD1xBghcNxvDDEoPgnVdfU8mVoBgV336FF6YJ4fzLreEVh+
         HO0bswgzvzeZUNxyInXskJX0sGVluwwlWrqvh5Dy+adaZBMLV4h8mnYEi5cqt/137K2O
         aSBPpgJY3+GK86Z+/yqH/IOpsMEVNKlVmmTVH/Qe54UUcTBAgljYHvpIN6pCtchEZK/Z
         3WkQJxQRgAqgRtmxFseieTBuJDnwyi67WP/7morFQC0tbCSdHf6JJJidVrLNoWhdH5el
         0DJg==
X-Gm-Message-State: AGi0PuanblNE1hGPQVh2D8VmgET50Pe2TicIoSaZ3sr5sywr2AYfu6iF
        AlJfpyF9jb5Zm8R1o4yIkBuFoQ==
X-Google-Smtp-Source: APiQypKB2/otB/702T2JCDtluRFeUpsSB5O2TeMlFoB2ZJbS1yFix9xgffVtwXjP2pc3SMR7wHpbJA==
X-Received: by 2002:adf:eecc:: with SMTP id a12mr23824779wrp.112.1587478513735;
        Tue, 21 Apr 2020 07:15:13 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id z76sm4221908wmc.9.2020.04.21.07.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 07:15:13 -0700 (PDT)
References: <20200415095927.3780-1-christianshewitt@gmail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     chewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson-g12b-khadas-vim3: fix missing frddr_a node
In-reply-to: <20200415095927.3780-1-christianshewitt@gmail.com>
Date:   Tue, 21 Apr 2020 16:15:12 +0200
Message-ID: <1jh7xdorgv.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 15 Apr 2020 at 11:59, chewitt <christianshewitt@gmail.com> wrote:

> From: Christian Hewitt <christianshewitt@gmail.com>
>
> The frddr_a node was accidently deleted when creating a common dtsi for the
> Khadas VIM3/VIM3L boards, preventing audio from working on the VIM3.
>
> Fixes: 4f26cc1c96c9 ("arm64: dts: khadas-vim3: move common nodes into meson-khadas-vim3.dtsi")
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
Tested-by: Jerome Brunet <jbrunet@baylibre.com>

> ---
>  arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
> index c33e85fbdaba..c6c8caed8327 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
> @@ -154,6 +154,10 @@
>  	clock-latency = <50000>;
>  };
>  
> +&frddr_a {
> +	status = "okay";
> +};
> +
>  &frddr_b {
>  	status = "okay";
>  };

