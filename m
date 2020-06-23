Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED0EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C42B020706
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592900405;
	bh=N6xBdgfy9cybA35PYpnxYo3cgCwij+m9MQXhOo5E9Mc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jSpvC6SxsdBZqu0fAXUTbUps3/vpwa9UjC7LSh3GSgWDMpgedmgZcTPpuvh9Tz70v
	 08WuCHKKsAoMDvimnP6PTcMFdEdR9MpukR+WxNqVkrR2z2QwTE/DpoUnsP1/79e8qX
	 dfRU8Zh/1s60oSdoke0oWIGJUHba6myqWHBPTH6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731722AbgFWIUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 04:20:04 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:64590 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731158AbgFWIUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 04:20:04 -0400
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 05N8Jl9a010963;
        Tue, 23 Jun 2020 17:19:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 05N8Jl9a010963
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1592900388;
        bh=2OjMFHqm51sb9jiQQ2/IvsQGVydM45w2tk+5HJLOKG8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jQAMEx/RAWsgGUFmwgqMwePX2jVmJR/GQ95yuPh0+2Kgbc+7RxuXzqP6AtVWbOaaD
         IMBv0nvDRAs/pUFl3lpc2nwiPX5k95RcxByUNdIwoGVElhwiEJj0JlfOgUBwb4aVa0
         5x34tA0O6EY8eaxwW8BbxSN34hh0m4IjOEYXJWD6q7njwpE2Ry4GCT8J1YwdeTyhIc
         EJ06EGYhWP1Ha5zl+1Bs66PziNiXgq5JE1pr6KbT617yxpz46yT6lhKSGHUbM2LZqV
         AJlenIYzOLbBdqQneXCJYZtdC1vA4Re8tsD5wuls63EMZkYEUaQOkicfXovgrGN/lE
         WwFrD+dyDZsSQ==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id y123so11221109vsb.6;
        Tue, 23 Jun 2020 01:19:48 -0700 (PDT)
X-Gm-Message-State: AOAM532Ki/gRegk4KLS6ZmY6NU6S9nNbVDSaFlWIu+ltBuRXP1zgLTmB
        EiSDwogq/6tDyahkThem0MCFJuWLBymfvRHRzzg=
X-Google-Smtp-Source: ABdhPJzw1xkC0RbI+3+8HkPVPBdIKzXE+InrN5h820fsqRCVLZTNnAh2QWLPvuc+9cYaOIGfNhQpEbOvMbALRDnECCU=
X-Received: by 2002:a67:22c7:: with SMTP id i190mr19292230vsi.179.1592900387462;
 Tue, 23 Jun 2020 01:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200622120039.453616-1-yamada.masahiro@socionext.com>
In-Reply-To: <20200622120039.453616-1-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 23 Jun 2020 17:19:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNARCCejeFObzvUjzVVp_qXYH59gbxJZx+VQpvO3-196LKQ@mail.gmail.com>
Message-ID: <CAK7LNARCCejeFObzvUjzVVp_qXYH59gbxJZx+VQpvO3-196LKQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: ASoC: Convert UniPhier AIO audio system to json-schema
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        DTML <devicetree@vger.kernel.org>
Cc:     Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        - <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 9:02 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Convert the UniPhier AIO audio system binding to DT schema format.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>


'additionalProperties: false' is emitting a warning.

I will add patternProperties
to take care of sub-nodes.

I will submit v2.


-- 
Best Regards
Masahiro Yamada
