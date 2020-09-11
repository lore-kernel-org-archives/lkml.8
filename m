Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4C0C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FA82206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvFBFtLv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbgIKJFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 05:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgIKJFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 05:05:53 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0393C061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 02:05:52 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id u48so2887890uau.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 02:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jH7JkBiuZ9sVw7vzrouZ9jGYwqPEO3SQXnY4jpBJ1lg=;
        b=CvFBFtLvADTL+ZXLIuyymiu4NtrOuc23XOu6Bg+3E7IXB5v8ZHkiVSGa2kWClggfeC
         fwxohmyS4adJoFsi9/PlwNCBbgcHuAD9zYE24YqwVX0iLyNh+cSGPII1CnWkJpiZY790
         rw2e88e80/RMPnWca8tMuGFrCCjAw3BkFhFGmMlv/0wYWMpKWPacYr/inv5g32zHMSiI
         Mx0ayPNUzuFv15Ky4SUc19u5pVHCqAXUFh2zMStaJ2QvuZ6GDncoSVJLNbf0GadC8Rw7
         E6vbug4oPWOLoWFglsRzvcP8gRWJb7fuJZDF6smLfWG0sbp/PSUpwp/1SaLH+iY2g/aV
         fBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jH7JkBiuZ9sVw7vzrouZ9jGYwqPEO3SQXnY4jpBJ1lg=;
        b=cXTxRgZTaIqomcCRb+X4ocfAbkC+u6iTgZ9ej+EO/Vvc7rGwjYEiZcLhmJPRHD09DX
         hOgZezWrcdlpGbfwp/Z5IVCWnYJuMA5r2H2thW1V+6ZMf5oHqyPfxAHe4aot/Fs1/cxg
         +rrUEx2bQIXS6WDtCJrhRNQZJ+SzITKs034l2Vrh4Ztle7p/lKU1AiSMw7iZa9nfe50T
         RqP9aMwdNPf6dz1eUXQGsSBYcyFeW/LXtufGyY7ZaemLxzBpBjroALAyTR5VF5sI2MiQ
         MLQ5f+fTBcDQozDQYTZTM70lb+VUd2YnpIItWL07LMTz7QgiBI5lcZWGFav/TmWwdf+5
         xqLA==
X-Gm-Message-State: AOAM530R6umZvkcHVPrn0izUWqyRnRgLjx+5ugjFkJiRtu/VpNp09/a4
        vb3dUreY9Bxq1/4eVj70va9yXDJY7nx7ELyTxqt58ItRXtA=
X-Google-Smtp-Source: ABdhPJwqljlKSOdXZEO+eXrSHtmP1N51bpykO9Hj/AjC2dKQqQq03LZ/AFLt1QdN7o1M+yvJaxHsDNOxmb0QkvYgHZs=
X-Received: by 2002:ab0:2652:: with SMTP id q18mr367153uao.124.1599815151793;
 Fri, 11 Sep 2020 02:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200814090512.151416-1-christian.gmeiner@gmail.com>
In-Reply-To: <20200814090512.151416-1-christian.gmeiner@gmail.com>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Fri, 11 Sep 2020 11:05:40 +0200
Message-ID: <CAH9NwWeBGBrX=+_2hGRbh4MwKTmK37FvrvHd2-YxSK6eHRmJhQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm/etnaviv: add total hi bandwidth perf counters
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas,

almost one month has passed since I sent this little patch series - is
there any update on this?


Am Fr., 14. Aug. 2020 um 11:05 Uhr schrieb Christian Gmeiner
<christian.gmeiner@gmail.com>:
>
> This little patch set adds support for the total bandwidth used by HI. The
> basic hi bandwidth read-out is quite simple but I needed to add some little
> clean-ups to make it nice looking.
>
> Christian Gmeiner (4):
>   drm/etnaviv: rename pipe_reg_read(..)
>   drm/etnaviv: call perf_reg_read(..)
>   drm/etnaviv: add total hi bandwidth perfcounter
>   drm/etnaviv: add pipe_select(..) helper
>
>  drivers/gpu/drm/etnaviv/etnaviv_perfmon.c | 78 ++++++++++++++++-------
>  1 file changed, 55 insertions(+), 23 deletions(-)
>
> --
> 2.26.2
>


-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
