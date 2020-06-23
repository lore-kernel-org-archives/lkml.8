Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90E2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A49C020724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592911982;
	bh=sYM42tP6vSo8oEBHm3PelGnthTPPshAVGLXL///pyqs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zBL+UBKy5hoqow3Gi+zgUL7CqHIqGiNp4z5raMaE/6kd7nWlnXWqwaXlPPLNsJCnR
	 UGIl2peB95m8LBE9Bg6bIxuOuqhyWDo6snvonWajPrxZZPBdQQty2qmVlN6pSogrmk
	 /HrOG5Hu+Gw0MDR13gk06Ax4r1CAeYMCcWe/V2fo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732470AbgFWLdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 07:33:00 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:49940 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732328AbgFWLc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 07:32:56 -0400
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 05NBWUe9027207;
        Tue, 23 Jun 2020 20:32:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 05NBWUe9027207
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1592911951;
        bh=/bby6eiaoafnsKasvD+44XkuZDUwzMZIHd9Yc7kyG3A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yk9h8fxKWFn7hj6Cdl7Mx7QH4Jd6HPEDhWjMtLtp7s2NVOXrE+8yc7f3ZwqnfCbCa
         ac/Op0VEg3quw+stSY22mCenxyJJbH1wgYKMdpdMRiH6tta2ptiX6hGsgQ2OQyPZxO
         zXoNB19h7+sMP2F0k/hlWYdEiU8+9PH4aKrgNWbWDE3uRtMdRKBVSeBbRgidfBqFCj
         7FbrCGYtkBgepwzBFLlACjhU2gbVWtX/gMc3NnnQ/wB+Ix+5Goy2iv8F+CuksLqt5q
         9P82b/F8y/D10unfy6larAuWM0AVqIgNWjDLSSR6NpnfokMEqZAqHycUD+oXTwKdmH
         9U7F9BKa38tpQ==
X-Nifty-SrcIP: [209.85.222.52]
Received: by mail-ua1-f52.google.com with SMTP id i8so6671588uak.9;
        Tue, 23 Jun 2020 04:32:30 -0700 (PDT)
X-Gm-Message-State: AOAM53066gMLIGwx09WvtMb++Cv+IJ2gyiiQTXC8U+P2K12RwUTas1Pl
        knkTPtNRCrinuDDYP1nPXy9dmV7IE8PnwJr3lOY=
X-Google-Smtp-Source: ABdhPJycnTrfA31vybeM0h39X3HSjsSRYxa5A9nDB0CSrKvTSk51+WjWwDYWqRwDacxbVagUuPP34EDE+eseNUUiHV0=
X-Received: by 2002:ab0:156d:: with SMTP id p42mr14817199uae.121.1592911949417;
 Tue, 23 Jun 2020 04:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200623062812.705264-1-yamada.masahiro@socionext.com>
In-Reply-To: <20200623062812.705264-1-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 23 Jun 2020 20:31:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS0GAUT-CYijWCetRgSXAaiHzwb_JE5RY0ECr68BDBk4Q@mail.gmail.com>
Message-ID: <CAK7LNAS0GAUT-CYijWCetRgSXAaiHzwb_JE5RY0ECr68BDBk4Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: bus: uniphier-system-bus: fix warning in example
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        DTML <devicetree@vger.kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 3:29 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Since commit e69f5dc623f9 ("dt-bindings: serial: Convert 8250 to
> json-schema"), the schema for "ns16550a" is checked.
>
> 'make dt_binding_check' emits the following warning:
>
>   uart@5,00200000: $nodename:0: 'uart@5,00200000' does not match '^serial(@[0-9a-f,]+)*$'
>
> Rename the node to follow the pattern defined in
> Documentation/devicetree/bindings/serial/serial.yaml
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  .../devicetree/bindings/bus/socionext,uniphier-system-bus.yaml  | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/bus/socionext,uniphier-system-bus.yaml b/Documentation/devicetree/bindings/bus/socionext,uniphier-system-bus.yaml
> index c4c9119e4a20..9fa4f891fa00 100644
> --- a/Documentation/devicetree/bindings/bus/socionext,uniphier-system-bus.yaml
> +++ b/Documentation/devicetree/bindings/bus/socionext,uniphier-system-bus.yaml
> @@ -87,7 +87,7 @@ examples:
>              phy-mode = "mii";
>          };
>
> -        uart@5,00200000 {
> +        serial@5,00200000 {


I think '5,200000' is a better unit name.

Will send v2.



>              compatible = "ns16550a";
>              reg = <5 0x00200000 0x20>;
>              interrupts = <0 49 4>;
> --
> 2.25.1
>


-- 
Best Regards
Masahiro Yamada
