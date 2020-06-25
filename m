Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD6BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AFFD20767
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHe9U+DM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406626AbgFYTeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406068AbgFYTeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 15:34:14 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D268C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:34:12 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e8so3803811pgc.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q0J5Xk6mCPnUPRpzzom1w8HYk2OMjF2U12o6CaGIZbI=;
        b=iHe9U+DMm1SaOAraCfyPB9wqg6y5TvPInl3c3iEZVoEBETKgq+z6PyVwhveT3LovV4
         xm/oCR7ZUnoOB5z9Y04zlkt6TPOSgUvxT5mTQN5hm1RDgfYWnPE5SaMpW+ENE21SsWDX
         fKIa962OVry32EYsBWkXrPYKQ5qecWRMxTWOyggjemzHIpk+t31bNHqHPlLNELxihxjb
         OCsRal6Bp7NUMXATRwhStJ0CI/PpaZx3aQZ2CpILA1jHfDHFfnJg+VTUaluwkChWgXPv
         e/NHpuuzLai7OEkTSrl3Y7PGfEeUT89AHIG4K5hsBVTGOF9SaDabkHwHQFoykfmVhMhh
         am6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q0J5Xk6mCPnUPRpzzom1w8HYk2OMjF2U12o6CaGIZbI=;
        b=mMOdMUvWOXmkUOV3Ym65rJrNxnLIW/cu++0xZOKOCoc8gRda18pIYFyu4p9N+91uc/
         K2Mp8tYMMk9tIAWQvGQ4DhWPeDPgcmNINgtFdbptNlEEQBWxRnlnXWzgOU3JWtdd5wqE
         yjDVtFPO5wpi3ekIQWWKh6USK1Y5fBg8gnQfMr4YkAVIZqKkjOq9XSbWCO0Z0XkPdCrq
         WHXCYJNYSLkMq96zIq89tF11WM1s+ZCBwFDZbwTfrpnjavWg2levQg8PnACiOzq8SJYa
         zX7RrWDlhsqxQqG6IjV+BMUZf9GsZ80TSIx36hQQhdrKyr0T7FD+PuHczIbSNYj8cNJ6
         Ykkw==
X-Gm-Message-State: AOAM531t4rTzsSA1mg4VAga7pQ3zt6wL/OktlYJj6ixAf9VTHAyNhpvg
        UyDVs+omHsk5mXFq3HWYc8nVAdTACAR/T7iT2tY=
X-Google-Smtp-Source: ABdhPJy90oRnlULXMEPkMJknatRF3lo3UkFkHpFR9sAqtWwwhfeJkySh2aFaZyvl8p4eunVSOddARuVSBSKqqEArK5U=
X-Received: by 2002:a63:f042:: with SMTP id s2mr26834670pgj.4.1593113651475;
 Thu, 25 Jun 2020 12:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200625170356.225136-1-enric.balletbo@collabora.com>
 <CAHp75VdY4TEKfZXDb-f-KC4G2XRJOdB-w4vegSWG9vULLqcUKw@mail.gmail.com> <026b38ff947e338a468567dfd20fbde1419bb094.camel@perches.com>
In-Reply-To: <026b38ff947e338a468567dfd20fbde1419bb094.camel@perches.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 Jun 2020 22:33:55 +0300
Message-ID: <CAHp75VcFeCf0vnk2Ea_-QdTW5gyRZvgEXwX7-VSd3rKch7pSwQ@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: Clarify SPDX license with GPL-2.0-only
To:     Joe Perches <joe@perches.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        groeck@chromium.org, Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bernardo Perez Priego <bernardo.perez.priego@intel.com>,
        Daniel Campello <campello@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lee Jones <lee.jones@linaro.org>,
        Nick Crews <ncrews@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Yicheng Li <yichengli@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 10:29 PM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2020-06-25 at 22:06 +0300, Andy Shevchenko wrote:
> > On Thu, Jun 25, 2020 at 9:25 PM Enric Balletbo i Serra
> > <enric.balletbo@collabora.com> wrote:
> > > Remove the ambiguity with GPL-2.0 and use an explicit GPL-2.0-only
> > > tag.
> >
> > Is there any? Last time IIRC Greg told me that in the kernel the old
> > and new variants are okay.
>
> If there wasn't any ambiguity, the older license
> style wouldn't be deprecated by SPDX.org.

They are _not_ deprecated according to kernel documentation:
https://elixir.bootlin.com/linux/latest/source/LICENSES/preferred/GPL-2.0

So, fix documentation in the kernel then.

-- 
With Best Regards,
Andy Shevchenko
