Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74E7C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C396D20727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XottLg9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgENOMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 10:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbgENOMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 10:12:24 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F9BC05BD43
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 07:12:24 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id h188so2016633lfd.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 07:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DkzKtHfHzDrv9acZGYhRUV9tmRVRbn6arGIc1dXkxBI=;
        b=XottLg9cQaTSjBHR11pedGRx+Glhzf+8Usg9K//kY6W0jNVJL1plss0LJBLgC3nXhz
         M7/NBircuUPinVKCHjYMUacfV2lTSjNWOTELV64WKqTIb+VoAHkWrKK+LyXiKxtTc91H
         EkpxcjLeryrGNDHr3ahfTehONNWh2vDTvJC3KrUAVwr5ekDS6uVYv5S8fYzsZqRMeDcg
         U9QIPtq8KUiqElnQ2rNtYXfrfX1ML51sOsdTUPKMJPSEfu+9xo31LZcyI4nCectwBKUP
         tA1N9H4f3nEE3y6yZE9MxWwkMpIknY1ov4rh2crp5UPVHztPX919W+E1wCHPIKL0EBRz
         aJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DkzKtHfHzDrv9acZGYhRUV9tmRVRbn6arGIc1dXkxBI=;
        b=LGrT8JyKK26lC1oGg3/WMn13GuCj4yrCTL5II/d1LWLnrnJ3NKsk51P4wD9KvaUICl
         K6uxHWWcSnOuRsewHe5unF7Ui4t2yEOk7X7xGyS7o9iYp7ThhLsBVwbVk6/S6qLzJ9I5
         RmzYY6NwLU8nX9cHy/ei3cv9HuRHaqHz9tqEnOmI3rRAUuWZj5+A9Bmb3sisfy4x++Qf
         FzB1fDHc3FluCUqa3yJ/4vHUds13wf+BuWFFNdNEagvN3JJ5Pgc5u9Wg1DIfDgtEZHjg
         B1Bcg2FlmJnyTOy4+D21+JEWTjU4I6peNIWgDE2HhNhAb8QtbdqiikK8FT2hHzrGfWXc
         fS/w==
X-Gm-Message-State: AOAM532o/C0IgPyiQ/DhukIfp7Qv/TSXX7hsmZ4NEWToBFzAhxqVIvU3
        01/noOnBmUkYPsbF9hoNTzasYV+k5Wzn95GzN/5zeg==
X-Google-Smtp-Source: ABdhPJzbFJbGyW1QIZoQeEMNyecliP3FhYfrVVsA0/vlx9bAuXukGyGD9ZMmozQ02I6kOFg4AohML8Hs61aAnqoqEGA=
X-Received: by 2002:ac2:5e70:: with SMTP id a16mr3507458lfr.77.1589465542377;
 Thu, 14 May 2020 07:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200417061907.1226490-1-bjorn.andersson@linaro.org>
 <20200417061907.1226490-2-bjorn.andersson@linaro.org> <20200429213453.GA32114@bogus>
 <20200514060422.GL1302550@yoga>
In-Reply-To: <20200514060422.GL1302550@yoga>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 May 2020 16:12:10 +0200
Message-ID: <CACRpkdZpfgb0wwt2FUwqPab4XhtLXfDWOvZLdCc+NF-mVJkKYw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: qcom: Add sm8250 pinctrl bindings
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 8:04 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Wed 29 Apr 14:34 PDT 2020, Rob Herring wrote:
> > On Thu, Apr 16, 2020 at 11:19:06PM -0700, Bjorn Andersson wrote:
> > > diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
> [..]
> > > +#PIN CONFIGURATION NODES
> > > +patternProperties:
> > > +  '^.*$':
> > > +    if:
> > > +      type: object
> > > +    then:
> >
> > Needs a $ref to the standard properties.
> >
> > Would be good to show a child node in the example too. (And try having
> > an error in a standard property type to verify you get an error).
> >
>
> Finally looked into this.

Can you send an incremental patch because otherwise I have
to revert the patch that I merged (maybe to trigger happy, mea culpa).

(If it's too hard I can just revert it.)

Yours,
Linus Walleij
