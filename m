Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443ACC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22BEA206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sfBZhgvd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgHRJua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 05:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbgHRJu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 05:50:28 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48768C061342
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 02:50:28 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c15so17602007wrs.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 02:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KDn/L/KgtGjfXOwvFM3d0ycolsRtvWGhY+IU39u+X2I=;
        b=sfBZhgvdUnGznJEo+Fcb9wMuFjWPXc+9UyK5W7mn6ZVikBjC9pqwkoJi5IafZR0gkl
         vgL1ZKVd5RDfHNTuPkY3RFpg7AUtf3pNQi3J0mZpOMUC4qmcxHW5XLiUcOdGEllDSyLf
         s/Eq4wUgkxMzpcZ5VGQfC2USDRS28oFOKG4naOfGrXD2liqaJDkHhTjmQJfK7qYw/0x1
         kH3nYgWp/zwaj2VKMDJPyxYcCnAWU/+gx0CeriL/zJ3TjEDFYabY86wIKDQDVhaveEEm
         pGmuCMyTVATxmjOk3r+EzalELAUljZdQEdjZ+hDwTuOdd6565PXAA36XbpmoOqNP0gOx
         tSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KDn/L/KgtGjfXOwvFM3d0ycolsRtvWGhY+IU39u+X2I=;
        b=hcJB+gBnd45cIDU10BkJed5RwQoVkFx/v9q/Wh2TWhQ8R1Yuck8TiDPhXE2kh6/6l2
         SdH53HZmON+q1fsoAFO5PTMk919tIXw0zKKzVkIzxkrdRnHCoTQs30lI0WNy1V5zhA7I
         vHlLIR1e6Gc0DwdBknHQ+EpYwa/vjgMGYh8fQo5wPpxDE0Ylh3pU+yOHoge2WxNyY+jc
         xGrGHNL+lEkOt1kymolRc85TCdo/i+GooJNP7wEfq3Um3LfUaHicX3KS3jlvaX3ZvEPE
         JKIg74JbEOOldYs3dVoODl5YjwrSA+fB2Lisv0+MZXHMS7ytchXKHwffs8FrpDV7Yk1s
         5bFw==
X-Gm-Message-State: AOAM5326e3+I/IQ/X8c0s/+6xfT5kRNz7ZTfHTdIQ8drgHLOVR1GRXfT
        tvG/wIGbm690SA+g9/+oiVCbEw==
X-Google-Smtp-Source: ABdhPJz1F0Shr79zg0ZgvQ3EF447qJ/7AgvM1fwOZGThYbUCe++2sCbkQwJc4VdZGNq+dmjgy0daFQ==
X-Received: by 2002:a5d:6348:: with SMTP id b8mr19151821wrw.362.1597744226614;
        Tue, 18 Aug 2020 02:50:26 -0700 (PDT)
Received: from dell ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id h10sm33963387wro.57.2020.08.18.02.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:50:25 -0700 (PDT)
Date:   Tue, 18 Aug 2020 10:50:24 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Christian Lamparter <chunkeey@gmail.com>, davem@davemloft.net,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        Christian Lamparter <chunkeey@googlemail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 08/30] net: wireless: ath: carl9170: Mark 'ar9170_qmap'
 as __maybe_unused
Message-ID: <20200818095024.GZ4354@dell>
References: <20200814113933.1903438-1-lee.jones@linaro.org>
 <20200814113933.1903438-9-lee.jones@linaro.org>
 <7ef231f2-e6d3-904f-dc3a-7ef82beda6ef@gmail.com>
 <9776eb47-6b83-a891-f057-dd34d14ea16e@rasmusvillemoes.dk>
 <87eeo5mnr0.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87eeo5mnr0.fsf@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Aug 2020, Kalle Valo wrote:

> Rasmus Villemoes <linux@rasmusvillemoes.dk> writes:
> 
> > On 14/08/2020 17.14, Christian Lamparter wrote:
> >> On 2020-08-14 13:39, Lee Jones wrote:
> >>> 'ar9170_qmap' is used in some source files which include carl9170.h,
> >>> but not all of them.  Mark it as __maybe_unused to show that this is
> >>> not only okay, it's expected.
> >>>
> >>> Fixes the following W=1 kernel build warning(s)
> >> 
> >> Is this W=1 really a "must" requirement? I find it strange having
> >> __maybe_unused in header files as this "suggests" that the
> >> definition is redundant.
> >
> > In this case it seems one could replace the table lookup with a
> >
> > static inline u8 ar9170_qmap(u8 idx) { return 3 - idx; }
> >
> > gcc doesn't warn about unused static inline functions (or one would have
> > a million warnings to deal with). Just my $0.02.
> 
> Yeah, this is much better.
> 
> And I think that static variables should not even be in the header
> files. Doesn't it mean that there's a local copy of the variable
> everytime the .h file is included? Sure, in this case the overhead is
> small (4 bytes per include) but still it's wrong.

It happens a lot.

As I stated before, the 2 viable options are to a) move it into the
source files; ensuring code duplication, unnecessary maintenance
burden and probably disparity over time, or b) create (or locate if
there is one already) a special header file which is only to be
included by the users.

The later option gets really complicated if there are a variety of
tables which are included by any given number of source file
permutations.

The accepted answer in all of the other subsystems I've worked with so
far, is to use __maybe_unused.  It's simple, non-intrusive and doesn't
rely on any functional changes.

> Having a static inline
> function would solve that problem as well the compiler warning.

This time yes, but it's a hack that will only work with simple,
linear data.  Try doing that with some of the other, more complicated
tables, like mwifiex_sdio_sd8*.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
