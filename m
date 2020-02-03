Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513B4C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269C720CC7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yo1y1Xav"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbgBCSnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 13:43:05 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45822 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbgBCSnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 13:43:04 -0500
Received: by mail-qk1-f193.google.com with SMTP id x1so15238939qkl.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 10:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4PMgClN19IhUmet8zzgKP6n4a6viDIBm9kvnRUtH3mA=;
        b=Yo1y1XavCUEy1wE5P7+cmjzPnnfg1oFVKZVmBL5dtthCguCkZ1WQnpf2YAC7eHPaDm
         LAIKxbOy+zNgxZgCta9TGT+psszC8jdSUX+mmFt4blUWtcmCkMJVzzsTh65pnXnuuFti
         F2uSLrsCNrlosOXGbZRwweYEiSo/SJzkncSnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4PMgClN19IhUmet8zzgKP6n4a6viDIBm9kvnRUtH3mA=;
        b=WkKjYf3rsz4icerT/3LpGC4IorcPMNJlx8U1W3ON2CMkvyQ2Ya83jpFfaMenVEtiH9
         3vk8bOsydCFjK/L4F3vT/KTPXaD/5ouN+3nhEPjhxBSVANz8Dvi5XEFvJHKC4zNc9S7R
         CGjN1Mw1+qDAqeXJ3L0DgpSx2Drzkb9HfCZ4Y9FXTAezqvczmBiOoCTxJNQeNAUh3jfR
         WZ9rAMdsU4rRBAaR42LPPJfMk4o6BGmvOWYFVvSxZw8TRIrEQ0hGHu1fOezImkrpTkyH
         vcdH99HTV6YMdM/J5NbLuBywzI1pHWqQe2pOKvNM5Z4JiF9pX72P7VXUYJMpkfcOxigh
         ST9g==
X-Gm-Message-State: APjAAAV1qVtowcHIUqHRKoeqzDQLMfltoes9AgwunnEwEOY++W3xU982
        6XUNhpMg+17DWYqM/E7roHG5B+a3ScuUrRLcIb6K2w==
X-Google-Smtp-Source: APXvYqw1bX0A3kJ4KvUVv86WXufvnleEdtH4TO5zCbHUJmtjESA5AF1NOa9A9O2Tbs2y01O4QjbPgw6zzCm91hZD6E4=
X-Received: by 2002:a05:620a:2218:: with SMTP id m24mr25211961qkh.442.1580755381994;
 Mon, 03 Feb 2020 10:43:01 -0800 (PST)
MIME-Version: 1.0
References: <20200130203106.201894-1-pmalani@chromium.org> <20200130203106.201894-12-pmalani@chromium.org>
 <20200201110358.GR3897@sirena.org.uk>
In-Reply-To: <20200201110358.GR3897@sirena.org.uk>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 3 Feb 2020 10:42:51 -0800
Message-ID: <CACeCKaf2=_6jEaUSKgEiucmO4KNgQu7F-P2Po=UjLdfXZwm_Bg@mail.gmail.com>
Subject: Re: [PATCH 11/17] ASoC: cros_ec_codec: Use cros_ec_send_cmd_msg()
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benson Leung <bleung@chromium.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark, thanks for looking at the patch. Please see inline.

On Sun, Feb 2, 2020 at 4:00 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Jan 30, 2020 at 12:30:56PM -0800, Prashant Malani wrote:
> > Replace send_ec_host_command() with cros_ec_send_cmd_msg() which does
> > the same thing, but is defined in a common location in platform/chrome
> > and exposed for other modules to use. This allows us to remove
> > send_ec_host_command() entirely.
>
> I only have this patch, I've nothing else from the series or a
> cover letter.  What's the story with dependencies and so on?
Sorry about that. I will add you to the cover letter for subsequent
versions (I followed https://lwn.net/Articles/585782/ but I think it
only adds the relevant mailing lists to the cover letter...)
Just for reference, the cover series LKML link is here:
https://lkml.org/lkml/2020/1/30/802

Best regards,
