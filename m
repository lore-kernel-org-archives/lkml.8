Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B20C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AF6F20772
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593698094;
	bh=7f0we9ToVtC2sB/gdoGDHjfbF4K+7/v+D6292TCX25E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Vt0j+qM9eqTwH4kDYowgN6Ny3GOOX/aN/2QrEEdvHuVV64Rge2G59z+C4wVAvwRT+
	 2m6hXLVe8eoFe6nxh05ds7S6WYlvaekBJBpiBhbpsrY0pvXSHvrUOZEGa0mOrsuD5A
	 V5Kv3hryCwb5w0u/iTAYSSa3yAq/C6FV3E/l+rHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbgGBNyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 09:54:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729464AbgGBNyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 09:54:51 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FDBE20772;
        Thu,  2 Jul 2020 13:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593698090;
        bh=7f0we9ToVtC2sB/gdoGDHjfbF4K+7/v+D6292TCX25E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TMhYWWiElbIT4MnoxMMc2yeXHbclF3cBqeSF6fmbCBYSbEO+aY+CbSdySqW0V8fvo
         ycnjnEQa3WoARnXi7AxW76aPgELnTAMwpm5wPK+8fjG99FwJhNc1aX5pJatA6XlvNM
         mtsabmyslhxC/JeAOsYyqei532h0UHDIMHuRYRQ0=
Received: by mail-oi1-f177.google.com with SMTP id t4so5901737oij.9;
        Thu, 02 Jul 2020 06:54:50 -0700 (PDT)
X-Gm-Message-State: AOAM530MFN78fIHpJoMgo5M6OBy06Bt3NXwxoaAbd9UWVQu1kYQI+2gt
        2ywIXS9AfuuXNihRuQZ6mGDBZGbXASwFL/rtog==
X-Google-Smtp-Source: ABdhPJy7BdwSxiiHUlLu0FDHVe4/hH1/gMKwhpieAKy6KDx+1Ei/7xR4sh7fMT9qpGAHCKX7iWPY0s5PGl9LLdj/tRo=
X-Received: by 2002:aca:6004:: with SMTP id u4mr24951403oib.106.1593698089642;
 Thu, 02 Jul 2020 06:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <87pnay3ptb.wl-kuninori.morimoto.gx@renesas.com>
 <20200528223916.GA804926@bogus> <87imgfzclq.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87imgfzclq.wl-kuninori.morimoto.gx@renesas.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 2 Jul 2020 07:54:38 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+UX9c2rr+yj3E5HywhG5aWxDit1MObceVSp2UCL=MvnA@mail.gmail.com>
Message-ID: <CAL_Jsq+UX9c2rr+yj3E5HywhG5aWxDit1MObceVSp2UCL=MvnA@mail.gmail.com>
Subject: Re: Question about "xxx,yyy" style property
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 8:41 PM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
>
> The Subject was "Re: [PATCH] ASoC: dt-bindings: simple-card: care missing address #address-cells"
>
> Hi Rob
>
> I'm trying to create v2 of simple-card patch,
> And got issue which I can't solve by myself.
>
> I think "xxx,yyy" (= which has "," at the property name)
> needs special care, but it is very un-understandable...
> Now, I'm give up.
> So, can I ask you 2 things about Yaml Doc "xxx,yyy" type property ?
>
> ========================
> 1) reference own definitions from "xxx,yyy"
> ========================
>
> I guess "xxx,yyy" naming property needs to has "description", right ?
>
> But, it is OK if it references "/schemas/xxxx"
>
>         --- OK ------
>         xxx,yyy:
>           description: xxx
>           $ref: /schemas/types.yaml#/definitions/phandle-array
>         -------------
>
> but, will be error if it references own definitions
>
>         --- NG ------
>         xxx,yyy:
>           description: xxx
>           $ref: "#/definitions/mydef"
>         -------------
>
> This is the related error
>
>         -- error(?) --
>         xxx.yaml: properties:xxx,yyy:\
>           $ref: '#/definitions/mydef' does not match 'types.yaml#[/]{0,1}definitions/.*'
>         --------------
>
> # but, there is no problem if it was defined as "patternProperties"
>
> Q. The "xxx,yyy" property can't references own definitions,
>    or needs some magical extra settings ??

No, it can't. The problem with definitions is we can't really check
and do fixups on the definitions with the meta-schema.

> ========================
> 2) phandle for "xxx,yyy"
> ========================
>
> I noticed that it seems "xxx,yyy" property can't be referenced.
> Here, "xxx,yyy" has "type: object" and "additionalProperties: false"
> (below didn't happen if it doesn't have "additionalProperties: false")
>
> If "xxx,yyy" has phandle, but not referenced,
> This is not a problem.
>
>         --- OK ---
>         ...
>         foo = <&bar>;
>         ...
>         xxx_yyy: xxx,yyy {
>           ...
>         };
>         --------------
>
> But will be error if it is referenced.
>
>         --- NG ---
>         foo = <&xxx_yyy>;
>         ...
>         xxx_yyy: xxx,yyy {
>           ...
>         };
>         ------------
>
> The error is
>
>         -- error ---
>         xxx.yaml: xxx.yyy: \
>         Additional properties are not allowed ('phandle' was unexpected)
>         ------------
>
> Q. The "xxx,yyy" needs magical settings to be referenced, or can't be ?

'phandle' (among other things) is automatically added by the tools. If
'xxx,yyy' is defined thru a 'definitions' then that fix-up is not
going to happen.

Rob
