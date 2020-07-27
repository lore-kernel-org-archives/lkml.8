Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEDAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EA4820738
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgG0Htl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 03:49:41 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:49773 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgG0Htk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 03:49:40 -0400
Received: from mail-qt1-f171.google.com ([209.85.160.171]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MmU9R-1ki8LS0GDx-00iQrk for <linux-kernel@vger.kernel.org>; Mon, 27 Jul
 2020 09:49:39 +0200
Received: by mail-qt1-f171.google.com with SMTP id b25so11538091qto.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 00:49:38 -0700 (PDT)
X-Gm-Message-State: AOAM531x8u5CXtQTSfWSDrreOdb0juCJhNPaphjFiz8wO4S3OBXLW0/d
        zspr+RSjtzmXBxNxlPeY5fznhx5d9Ho+H2DD8rs=
X-Google-Smtp-Source: ABdhPJyqvtFtc9EeRn23Z++9snt24Adrey6DZY0MGaUrfMzSaEFa1Rx5bauVO7MVoNlBp10B/WVA2Ld+bxrUKqWk8nE=
X-Received: by 2002:aed:2946:: with SMTP id s64mr614510qtd.204.1595836177987;
 Mon, 27 Jul 2020 00:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200726043948.1357573-1-daniel@0x0f.com> <20200726043948.1357573-7-daniel@0x0f.com>
In-Reply-To: <20200726043948.1357573-7-daniel@0x0f.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 27 Jul 2020 09:49:22 +0200
X-Gmail-Original-Message-ID: <CAK8P3a39E2ww_nuR0PHxT=Lnqsu+-mkHdbT+TzSnH6mYA7pKeA@mail.gmail.com>
Message-ID: <CAK8P3a39E2ww_nuR0PHxT=Lnqsu+-mkHdbT+TzSnH6mYA7pKeA@mail.gmail.com>
Subject: Re: [PATCH 6/7] ARM:mstar: Add syscon node for "pmsleep" area
To:     Daniel Palmer <daniel@0x0f.com>
List-Id: <soc.lore.kernel.org>
Cc:     SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:BIN1nKwO5OyDJZP5VcffJDmmkyLkZJ27LEzfx9XapM2fEemNskh
 wLhRObCNnuVEsrUaLlyZcB99Yo7JemJrNxnN/qjCIijSHgNGPa4P7W243s2Ag6qG2R6aMIV
 HtmI/MGMsMNyGLowsA6bk8WM0JrKlI+ThP3IX9ByY1mTtQhqU7pyBjjAOV9PvZe+ueBVdjz
 FSVNCpGflgB370noq7/3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DcSsac6gRNs=:MKtDngoHSRyVWOyNjPRL5E
 mPAoMDsJOBQdKwpIcwOg7QFvvrzFKgHy09xa5rPsxkfh7KlYbaH2Dlp8LKVP3LOPs/XN6TYQg
 u2JHG4c9hmjZpJyHQekrmubujBUftjcVxD3pkUafMYULMXGhW3sb3grKbowu0hvopy8mcyboQ
 i9eNQLclquPBEe5lr9xp/V566QFGDdyPt4qwT88o3ZKV22c7Uskd5qN+fASbE4MN4KmXQTSnz
 29zWlIHaWMZF72oojMRxUiNINTJ4RLyvBYm3CxzZCKAxu2RDMKwHaseu+GfhKFNEt0db8J/oi
 pL+nxW5AROQQL1m3xrc9wq/K+3k2U7zGrlFpP5nDdhUBR8BeYo0A857wdChjjIs0YWcuxQ3z/
 YUsrqWiLR8dzx9ydwys0T+T7j+WfIWjXUNzpi7F/+DeVrcc3GvbSpnkBaexzXHMPXW2ldZ6/B
 AQ1ZL7YbA6PHo8vLUEKg1Ombpf5L/JJTGTjcVxTL6bSc43CiTtnptSmH2pzOlMhC0pP4FhR2t
 r1S+DAQFDPXwzRzaHep1wIUa/ByApNfc+TzLN/jqRVMS1szyQk0oM3FgsS+p6JCaBHHmqA2hS
 uAn0UywcQNQjBFHVRNEgqYDPZgFzX0uGZAo+KAWULxtJWf3ES+TSEKjGhHxM7DYWiJUq422rb
 hokBW9G4zLfFg/X8y2ZP3UAH9DB65rV67KQ7tS1I1+Yd1dNZyFtNZF7uQSaGZYa3Dv+TmciEB
 aaKY4IBoEWAPLIO6V/e+FBmwc+fpFR/5FPL0nlyy3zZNjcF1IbLmzNUDO1aB1QnvSKYYtiTpZ
 6EIYYKPqyZeVRaAExswAaO3Z4sC+NW6VdmlVmYX/nLtOHnq5QKuuw/6o4Q1lx+tfudoi+YR8t
 YU4o4uetOu1zUioWgeYDa6wnKwdPBD72q/uJ3XMYcW7JXjQ3NVAgeWu2yRen2exxUiLQ4arJD
 cAdbbeyPSgf1BwN07o2S2gsYwhxguFkxiaW3DrFIJpKx+jUvqO3uY
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 6:40 AM Daniel Palmer <daniel@0x0f.com> wrote:
>
> MStar v7 SoCs contain a region of registers that are in the always on
> domain that the vendor code calls the "pmsleep" area.
>
> This area contains registers for a broad range of functionality and
> needs to be shared between drivers.
>
> This patch adds a syscon node for the pmsleep area so that other
> drivers can access registers in the area.
>
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>

I think it would be better to add a more specific compatible string in
addition to the "syscon" one, to make it possible to later add a proper
driver for this area, in case there is a need for that.

       Arnd

> ---
>  arch/arm/boot/dts/mstar-v7.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
> index a73b1d162dfd..c8b192569d05 100644
> --- a/arch/arm/boot/dts/mstar-v7.dtsi
> +++ b/arch/arm/boot/dts/mstar-v7.dtsi
> @@ -73,6 +73,11 @@ riu: bus@1f000000 {
>                         #size-cells = <1>;
>                         ranges = <0x0 0x1f000000 0x00400000>;
>
> +                       pmsleep: syscon@1c00 {
> +                               compatible = "syscon";
> +                               reg = <0x1c00 0x100>;
> +                       };
> +
>                         l3bridge: l3bridge@204400 {
>                                 compatible = "mstar,l3bridge";
>                                 reg = <0x204400 0x200>;
> --
> 2.27.0
>
