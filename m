Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9017C33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FFA02253D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura-hr.20150623.gappssmtp.com header.i=@sartura-hr.20150623.gappssmtp.com header.b="I9D+koBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgAUKeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:34:19 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38870 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgAUKeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:34:19 -0500
Received: by mail-oi1-f194.google.com with SMTP id l9so2086604oii.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 02:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a0MVgCnluJiMvFhGYkbzOfOm4vvDltuuGX2V8bpoeSQ=;
        b=I9D+koBskXL5blj9fOtJPHzQsoaNLIUHVie3LbW4BdqtIgVyV6TWic+D3oDuT1dNAi
         kqSHTeU5fBGb/sm5z0GwKrw/tJV9oiL5HWXlm2MCDA2JDHqQRQGEVJkBUbNDljOIzGTi
         CIAV+RpE6mdzABSRh2A0/73T55d4QY7nZuZdv6w71dAtYPsKX9itDvrONiDM1ydxgD7m
         GwkKwqRHovulmCn4b8C3G590wJ9IkvPpXUf0Jg/AHViwyKXlQdYKLIeXZ/VyeBYXvQ+v
         WvB40Yf8lCByo21io7yVLDgS+PBnki+gIqW/ojvdG43QHR3QQnL7fouRQTji/BumOhVo
         VhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a0MVgCnluJiMvFhGYkbzOfOm4vvDltuuGX2V8bpoeSQ=;
        b=Ye0/aWe0yAUQCrlcK7VD7lzuxglk1rvUk6olkNlC+9Dux6MUsKQwnvedfj85aZw9fl
         NnU1CThL+iGD91cUfAW8A/bBz1PVqzduttBVYqv9RuyRu8CEw6aFNcW39fgmKaj6fKwL
         kbKoo9RadZbA957tnF8+VikqePN/1VDy6p0pDwKVwTOV4LlFkAixt9BFgIyZuzdX7IEQ
         eAD/4aY72maj1QLmXMkIVuJ06Su8ueKp+sQgKJBX1cXPsOvhMpRy8k3XGKqHhA5pS42s
         wGalDxT0ISTwlUgIBczOBxLLAGWvTKwhWVcXBXYE+3HXsffgMYd5C0evZxi+VdDYgzT9
         NWvA==
X-Gm-Message-State: APjAAAXI8kkVftMTG+Y3aa951ka+kyBaWlxnAW3QG3cEAIRJ37DZqXph
        HiJTg/6/t85Cuan5jSg24BlteJT4WEUVCLr+wpV7ITz3MeM=
X-Google-Smtp-Source: APXvYqwxCUTgHCfeET2MXXcfDwKd6srogmeuOy//4ezAASWynGRuaiNf2uhm9j68C5vLFw/71bSa27wWojHBc3Cz0J8=
X-Received: by 2002:aca:4106:: with SMTP id o6mr2431621oia.173.1579602858490;
 Tue, 21 Jan 2020 02:34:18 -0800 (PST)
MIME-Version: 1.0
References: <20200112113003.11110-1-robert.marko@sartura.hr>
 <20200112113003.11110-2-robert.marko@sartura.hr> <20200113144101.GM3897@sirena.org.uk>
In-Reply-To: <20200113144101.GM3897@sirena.org.uk>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Tue, 21 Jan 2020 11:34:07 +0100
Message-ID: <CA+HBbNEBxw5B2gxJLv6sKrqszymg_ccbW6syZRiEivk+dpFpzA@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: vqmmc-ipq4019-regulator: add binding document
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 3:41 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Sun, Jan 12, 2020 at 12:30:02PM +0100, Robert Marko wrote:
>
> > +  regulator-min-microvolt:
> > +    description: smallest voltage consumers may set
> > +
> > +  regulator-max-microvolt:
> > +    description: largest voltage consumers may set
>
> Why are these explicitly specified in this binding?
You are right, I can simply include them from regulator.yaml
>
> > +  regulator-always-on:
> > +    description: boolean, regulator should never be disabled
> > +    type: boolean
>
> If it's not physically possible to disable the regulator then
> specifying this property is redundant so...
Yes, regulator cant be turned off.
>
> > +required:
> > +  - compatible
> > +  - reg
> > +  - regulator-name
> > +  - regulator-min-microvolt
> > +  - regulator-max-microvolt
> > +  - regulator-always-on
>
> ...requiring it doesn't seem useful.  All the other
> regulator-specific properties shouldn't be required either,
> unless the user specifies a voltage range we won't allow changes
> at all which should be safe and the name is purely cosmetic.
Are bindings even required at all here then?
