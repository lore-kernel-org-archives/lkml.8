Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3048C433E7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A0972076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lnD2/ao0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgGPNOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 09:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbgGPNOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:14:43 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A657AC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:14:43 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h19so7030181ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bBoOhm+GV/yHPZh33fMz2aVrUQ8YpA+qKh/3LyamqOs=;
        b=lnD2/ao0AusGxOT5rQ8o0aaxmWDu0KuU4mCKD8GmqAlMnn61XfetlQXd8z2nAXa/Ev
         PCrXuisiZHfDNjy/LFjKhyZycHaPjSTyZZPWNRuCVY4x7yhf6ZPpZa+v9HAvPoGKdePt
         N5yz0o10tcqY7jUPAS8+k26sWFXuz5v4TsN7XPjROpVsUivQcGtf6IDFAfgybSqYGHQK
         9vGqxoV4+59ruRRjdAlbb5WQqaKpN8E1tSZXHPxXkaEN8+Zcbrqc92K4eU4I+CZ8k6jT
         7IjxGhlU6lszhda2/pjerfnJDRz9dcNyBdsL0Ih5CSPOMXZwY0nAQblu/+5w0jdMMIKb
         csbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bBoOhm+GV/yHPZh33fMz2aVrUQ8YpA+qKh/3LyamqOs=;
        b=DUj/oNMATyenVJziGPnpYE7rcDsGdbmXnxjmedyUcx8lUCZq8hHhihLTuE4+UKqkl9
         GflKvMmkTxEj0G3LrR1zWpX4nwWs657b+oNdGMCLCdFgWKis0pCrKoRUNNarVGknAsqY
         H1lPBtXNcU66R/c767lATCCgV7FpS8BCEY28ev2Z9JtsALj4HjoBIuUUcl0Yn37dZaQt
         /0Q0zGdscY/qxyINr76MQK1iqOdiKsH7/ngHVWzLM26zHKtLcEpeGBwOpj/G2H6kC2Gw
         upf86bNZUBSEiYfTP+xIL8ctUTHMDBo2g9DJItfgNSC+78xhcTJ/zv7zDocskggOxyTA
         AghA==
X-Gm-Message-State: AOAM530o8gQI4NiYMpnNT+99vWvQtojiqTZabg/sJKJSv5Y7b4HgE1EE
        y1cXRuNRPNm41Ziin6TpckQZ/JBRuQeu5B1ohKQ4yA==
X-Google-Smtp-Source: ABdhPJwmvWwrnn/zXFAaqbiFIZZ2k9t59pLji33UNkp5uvoqHLuaSdq0MMGTcbRxQFHJ1hNqXP/I0e7IFNSw0UUqHHo=
X-Received: by 2002:a2e:810a:: with SMTP id d10mr1948021ljg.144.1594905282186;
 Thu, 16 Jul 2020 06:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200713144930.1034632-1-lee.jones@linaro.org>
 <20200713144930.1034632-17-lee.jones@linaro.org> <20200713200244.GA23553@piout.net>
In-Reply-To: <20200713200244.GA23553@piout.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Jul 2020 15:14:31 +0200
Message-ID: <CACRpkdYcr9Tzt+=15KGhcbiBRhyZWYw8=ieNs=ZaX8CMdZv9qQ@mail.gmail.com>
Subject: Re: [PATCH 16/25] arch: arm: mach-at91: pm: Move prototypes to
 mutually included header
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 10:02 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> On 13/07/2020 15:49:21+0100, Lee Jones wrote:

> > diff --git a/include/linux/platform_data/atmel.h b/include/linux/platform_data/atmel.h
> > index 99e6069c5fd89..666ef482ea8c0 100644
> > --- a/include/linux/platform_data/atmel.h
> > +++ b/include/linux/platform_data/atmel.h
>
> The plan is to get rid of that file so you should probably find a better
> location.

OK I dropped this one patch from the set for now.

Yours,
Linus Walleij
