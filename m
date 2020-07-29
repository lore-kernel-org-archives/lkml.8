Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC965C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB3E52084D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="NEIJjohV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgG2JOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 05:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgG2JOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 05:14:07 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8FFC0619D2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 02:14:06 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q76so988957wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 02:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UP89gGtNifZ2OXiYa2igFr8vAWMBLRJL0ocxb3qTc7I=;
        b=NEIJjohV6bX1tKEzqf+d3D5YWkpcvrUyHjdAD7fzT7Rjms6K9mKPEiKdljtYOh4rOA
         zZWmulfdjV2YX09WLBGwAufZi38QenV6qAA9nJYmi2uZZjdLhOkuQAKS/JegMqn1YMzU
         8yIVkUZ2zLd+yFcPDVkfQsL5WhoYKUn6ct5yY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UP89gGtNifZ2OXiYa2igFr8vAWMBLRJL0ocxb3qTc7I=;
        b=q8tRjhnhIep3fshDuvYUVTGw6bThObedCBISVyD70lD6Jeu740MbUh+402Cw6r3DcD
         /e4K+yEGLEVkXBINCsROnuFRHkP8Z3oT5XUGX1L/rmlA4NLT5jMzMGf4uIuJGfn9zfv9
         rFS8PD5r/YmtP78mbHDRnd1lo8itAxBfwJOqq6db0P3BsYjYG40tiu1F6H7+zubeuAgA
         LMFQcfe6xXRrlTVW+fq2iOiR/hoRPpveoavDnbq8yd/U0lZPFvdOdlCaK2uzPjHd/xAT
         s5G5qKAh9y9wTtr+YrLkz7MW02yWxZMcFZETfaCODkeK/fQshehgiOaIKoyTGAfI0BYQ
         6hoA==
X-Gm-Message-State: AOAM533USsD9qfKGuH2ud33P+NThhYVDs+q1Bf37ar5gjLcA80njTKjM
        sIqyicpZduuCN+V/oOcROtqvVH6DtgiMbpMJvmAQcQ==
X-Google-Smtp-Source: ABdhPJzZV+e1UFgavtykineiuRZ18D0h683RmsaU4kIGW+k7U8arE7aPOvS325+KBzLbYn/obtxmBpD3rS4T2RCsBao=
X-Received: by 2002:a7b:c0c8:: with SMTP id s8mr8087059wmh.4.1596014045518;
 Wed, 29 Jul 2020 02:14:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200728100321.1691745-1-daniel@0x0f.com> <20200728100321.1691745-2-daniel@0x0f.com>
 <20200728191842.GB2778962@bogus>
In-Reply-To: <20200728191842.GB2778962@bogus>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Wed, 29 Jul 2020 18:13:54 +0900
Message-ID: <CAFr9PXkwpNAhQvOJFqLUm-uWoaH=nsNiq_y+OgTf8Z60i4RhRw@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: arm: mstar: Add binding details for mstar,pmsleep
To:     Rob Herring <robh@kernel.org>
List-Id: <soc.lore.kernel.org>
Cc:     SoC Team <soc@kernel.org>, DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wed, 29 Jul 2020 at 04:18, Rob Herring <robh@kernel.org> wrote:

> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +         - enum:
> > +             - mstar,pmsleep
>
> Needs to be SoC specific. Random collections of bits are never
> 'standard' from one SoC to the next.

I don't have a manual for any of the chips so I can't say for sure but
so far all of the chips in this group (ARMv7 based MStar/Sigmastar)
has the same layout for the registers i.e. the reset register,
the resume address registers are at the same place for all of them.

Does calling it "mstar,pmsleepv7" make more sense? I'm not sure what
to call it really.

> If your never going to have child nodes, then you can just add the
> compatible to syscon.yaml.

Considering the above would it make sense to drop the specific
compatible string for now and just leave it as syscon until there is a reason
to make it more specific?

Thanks,

Daniel
