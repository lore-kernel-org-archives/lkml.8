Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43F0C3F2C6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCAAD246A0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Atc7La5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbgB1Aj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 19:39:58 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:37391 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730266AbgB1Aj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 19:39:58 -0500
Received: by mail-il1-f195.google.com with SMTP id a6so1269691ilc.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 16:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KDsHPEMEcTwRgeb/iNiTV6IpI9t3W9CMpECto7c90A0=;
        b=Atc7La5H+LegTjWVZT04sLRjPzVAOpA0sWNj+uHM3BwD4HLr94mxkHp63f2W8hP2ge
         xx0Y9IafJ34HVdvZfrpZpss9lW/lfnKO4KfCyiYi9wqEiVdwtu/DNu2iDmvPsPhqnqwm
         ZfCrglGUAkL+XrCgZnf+T9r0aDlg4W/tn97ilSRlmhBno5pFT4bi3EeeDnc+A/ADcM6u
         AoKIH1arUvqXVk7/FDrjkX1fW5dH8qR2VAGD4dzNGNVv4Dz3Ze3ChVRQW6Z5oj40kPVX
         tAgi6UUffyJkw5iHN8VlL9hE5GIP4E1E9YeQZt5rvIStzOMRZIcGKNArn49fDMVsyKve
         k3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KDsHPEMEcTwRgeb/iNiTV6IpI9t3W9CMpECto7c90A0=;
        b=F5IqAPa8lz+U/KrnABKEfJaax+kwdbldbdRghHuYQznSHUqu3kiG0yFDFRJMSs9/8g
         Zen4unXoX67lMDUkbIjIw/c6iRArcpg3gFqaLWbg4HkXVHHjdmrjwNzWCDsNbaxHX1vA
         Ul4QMjMboAeChZs2VUb6DJ4XRKDBaNB0dXynIYHfGedwPl6LlqAsnGLX+g2HuIsvIA9b
         50l9PWLQxmFNweZUxwjG7nk2mdeZ2qj6E1wqGNVYqRoK4QjdNG7tTOLmV1Jz2Tvy2Xbf
         /1SYsbJTdkjhO0UQzwhjeqsgNyShmXAwo9e51MJBNbQWz8x8I32q8xxODv6Mpe2ovu7r
         cySQ==
X-Gm-Message-State: APjAAAUUGkua12uVzKSYhsacrqqpwKCanARfXzlk3+oy0CqsAE22I95K
        JbUJFm2OHRqrLdsPFx7uu0CSNotkUOCoaBes5A4m85Kt+iM=
X-Google-Smtp-Source: APXvYqzNaK5KxS0ZthkWM6JRuw+ucg0Nie/YR4ITxYxFem3/A4eewvhuqJO0BUJ/bFXTj2bi9Jjjac2W3NA4n9IX8iA=
X-Received: by 2002:a92:9f1a:: with SMTP id u26mr1964392ili.72.1582850396051;
 Thu, 27 Feb 2020 16:39:56 -0800 (PST)
MIME-Version: 1.0
References: <20200227182210.89512-1-andre.przywara@arm.com>
 <20200227182210.89512-14-andre.przywara@arm.com> <20200227223523.GH26010@bogus>
In-Reply-To: <20200227223523.GH26010@bogus>
From:   Olof Johansson <olof@lixom.net>
Date:   Thu, 27 Feb 2020 16:39:44 -0800
Message-ID: <CAOesGMg1AiF5kLipKpD+3BYNE1hPfs2XYwSnFr0Szp3t=4zw-w@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] MAINTAINERS: Update Calxeda Highbank maintainership
To:     Rob Herring <robh@kernel.org>
List-Id: <soc.lore.kernel.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Robert Richter <rric@kernel.org>, SoC Team <soc@kernel.org>,
        Jon Loeliger <jdl@jdl.com>,
        Mark Langsdorf <mlangsdo@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 2:35 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Feb 27, 2020 at 06:22:10PM +0000, Andre Przywara wrote:
> > Rob sees little point in maintaining the Calxeda architecture (early ARM
> > 32-bit server) anymore.
> > Since I have a machine sitting under my desk, change the maintainership
> > to not lose support for that platform.
> >
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  MAINTAINERS | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Acked-by: Rob Herring <robh@kernel.org>
>
> Send a PR to arm-soc folks for this and the dts changes. I'll pickup the
> bindings.

Given that it's likely to be a low volume of code, we can also just
apply patches directly in this case (if it's easier than setting up a
kernel.org account, etc). Andre, just let us know your preference.


-Olof
