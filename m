Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD6FC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58ADA206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PF0R3SfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgGXUnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbgGXUnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 16:43:42 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C11C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 13:43:42 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id g7so2963423ejw.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 13:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GsJgK7I58ZbRpNM3/ClUx7KPh0wfxlGWyzakGfdqg3Y=;
        b=PF0R3SfHH8RVUjcPLj8/BK4who6GgfWlSRk1IUrGLn5lMqksU9S2WfWaTFWfn1agHN
         l9xBEpq0RBjDb+TQ9M73cXP15o7saZ4PnuWAZiQU/KjuzniJXhheegYkG91Y9KuBMVM4
         y0QX7h5FIyBoURUdHzn5Wt8R4U/7Yu+nUOkxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GsJgK7I58ZbRpNM3/ClUx7KPh0wfxlGWyzakGfdqg3Y=;
        b=D4aqj+IzzB0hUFoL048MM6/ni7+rMv3im0QnTqL9V3esUeDUTHbvy/pdAVcaIb/VM6
         qYc4X9fC+O7cKQ5maed8MDo49Ap25Mf7y92qfgY6rtKW8pdDsFitT5uZW9dlIL6tSKUD
         jZ1HRk2UA3kPvMqVt8uq1UivbEmvYIqW9jm+LqLUcJJOE9oVu8KXziaDiw86prSa4JrK
         PepYRpdO87HhxJ3i050MfyXLxBIhpoPId3cyUvcJHF5053uYiSzFQt5X//5Y3hcGfYFh
         ozq+Sy0Ord/1FApnAJ7XoKrR1q7DG0zz9CG2n+/jbQsZyEz9ie7BHKbKvZMjWo9VYfI9
         UNbg==
X-Gm-Message-State: AOAM530J2G9WZadiY6uQNnc12EcHrnHIm2UFFEiFRCn9RHhx2I6Tn1k0
        wuff0yCVohnIZJreELGXYW780v1Y/Rw=
X-Google-Smtp-Source: ABdhPJzqX8XmuNA48ER+Syb7X/fOIcKtOrtPbp6c98kpAox2vVJDNKqyty8v0e4FguefOgzz5N3wpg==
X-Received: by 2002:a17:906:2b50:: with SMTP id b16mr11201157ejg.410.1595623420147;
        Fri, 24 Jul 2020 13:43:40 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id r25sm144550edy.93.2020.07.24.13.43.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 13:43:39 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id k20so1667719wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 13:43:39 -0700 (PDT)
X-Received: by 2002:a1c:7d12:: with SMTP id y18mr3870968wmc.115.1595623418776;
 Fri, 24 Jul 2020 13:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200723230344.1422750-1-swboyd@chromium.org> <20200723230344.1422750-3-swboyd@chromium.org>
In-Reply-To: <20200723230344.1422750-3-swboyd@chromium.org>
From:   Daniel Campello <campello@chromium.org>
Date:   Fri, 24 Jul 2020 14:43:02 -0600
X-Gmail-Original-Message-ID: <CAHcu+VaW56YSj2NiPvLNZBtgbVUHrBOACKXU18wg2j3M7_TQsQ@mail.gmail.com>
Message-ID: <CAHcu+VaW56YSj2NiPvLNZBtgbVUHrBOACKXU18wg2j3M7_TQsQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: sx9310: Add newlines to printks
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 23, 2020 at 5:03 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Printks in the kernel have newlines at the end. Add them to the few
> printks in this driver.
>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Daniel Campello <campello@chromium.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Douglas Anderson <dianders@chromium.org>
> Fixes: 72ad02b15d63 ("iio: Add SEMTECH SX9310/9311 sensor driver")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/iio/proximity/sx9310.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Daniel Campello <campello@chromium.org>
