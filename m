Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15550C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B2820719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585245466;
	bh=HDcqsps3y7sE+bgHTDL/9DN90HLJP7jG1o+L1gkMqcU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nM0pH2GHC91v5F3J7wP4GEnfNjAn7y9fL2GU2xXuOXBxpdlufJetg/SJcHw1PdvWC
	 3wiJItuohRhdvY3JyDNFHXTyjcssNKawpG29u/loiJ5KLocw9TvxctXiqgg73OD6Ul
	 To5u5CQIh9KGqyVK1IzXDWm36yFpprao3kWnydd8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgCZR5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 13:57:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgCZR5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:57:45 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1C5F20719;
        Thu, 26 Mar 2020 17:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585245464;
        bh=HDcqsps3y7sE+bgHTDL/9DN90HLJP7jG1o+L1gkMqcU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c+xFFnm+etNnSRJ/Ah2FXe6leOx9wiOBgkJS7CvbgiEZgApTFpZ3/9Cdon8aSqb2g
         p6ZTb53C4xfj63XEAZyIeqabtx5o541mzYHoGP0rQMQUOL2TOlUa0B9TI7xwF3PW0w
         tVkCytw1QKCpW2IuTmyu2BRHJEWwR4Z8p97pPVeQ=
Received: by mail-qv1-f45.google.com with SMTP id ef12so1453169qvb.11;
        Thu, 26 Mar 2020 10:57:44 -0700 (PDT)
X-Gm-Message-State: ANhLgQ35UzvCsk5EIoQssQLo5H7G86fAAlVM6ESI+fae4M9nD3RppheD
        InIcJ5Xaexv6s5XK4s1PU0AaCkrAH2SwE57NhQ==
X-Google-Smtp-Source: ADFU+vtKM5v5e4VeFhzjzjeoNb+xYN0ZFLlxsancYFl7GdsDvmsfoY88t4i3YV+NkEMqB3PBeSG500K8p1dCCg5Gp6M=
X-Received: by 2002:ad4:4829:: with SMTP id h9mr9006254qvy.135.1585245463794;
 Thu, 26 Mar 2020 10:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200326161046.12111-1-narmstrong@baylibre.com>
In-Reply-To: <20200326161046.12111-1-narmstrong@baylibre.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 26 Mar 2020 11:57:32 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+zDO3vEkZ5r28_GbnUECo5BfRNFF5PJc9wL0x3mS3FGg@mail.gmail.com>
Message-ID: <CAL_Jsq+zDO3vEkZ5r28_GbnUECo5BfRNFF5PJc9wL0x3mS3FGg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: usb: dwc2: fix bindings for amlogic,meson-gxbb-usb
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     devicetree@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 10:10 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The amlogic,meson-gxbb-usb compatible needs snps,dwc2 aswell like other
> Amlogic SoC.
>
> Fixes: f3ca745d8a0e ("dt-bindings: usb: Convert DWC2 bindings to json-schema")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/usb/dwc2.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml b/Documentation/devicetree/bindings/usb/dwc2.yaml
> index 71cf7ba32237..b7b9ddcbc637 100644
> --- a/Documentation/devicetree/bindings/usb/dwc2.yaml
> +++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
> @@ -49,7 +49,9 @@ properties:
>        - items:
>            - const: amlogic,meson8b-usb
>            - const: snps,dwc2
> -      - const: amlogic,meson-gxbb-usb
> +      - items:
> +          - const: amlogic,meson-gxbb-usb
> +          - const: snps,dwc2
>        - items:
>            - const: amlogic,meson-g12a-usb

Perhaps combine at least all the amlogic ones to a single entry.

>            - const: snps,dwc2
> --
> 2.22.0
>
