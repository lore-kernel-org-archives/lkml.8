Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F29C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D19D206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="a9KTwNGb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgD1WD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 18:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726256AbgD1WD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 18:03:27 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD3BC03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 15:03:25 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id w2so220676edx.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 15:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NR54EageimV01N0+P0/H4+3jaMZG7ansJYKsbb2lDA4=;
        b=a9KTwNGb6RSAuMXlCe8SZjpdmg0EZoGvUTiAaug8rze8fhPJooZKll9Wy+yb99XNBE
         oYtD3N7zekNIIPvqfSVNNBtdyQaXp2TjZA5IH1jZvFZ7U5X7cPou/ztPOkJWBV7wxaJU
         i353STD7krdCtZjCVMT03LT8In+W3uwfWm+boXgdqBg1QhIRviE8L2UQV+LmSm/dQJNY
         DMWlhZ7oPcWqcY0POIAFgOVAUAB0LtOCYjBnF4bc53GE3dQcsRnwAGmkYc9BQGVUkYJy
         UdhvNDc7fMo6h7SN3HfdxSZvecWp2gahv+jZpT0e6POyjReeBsn5geUu3KF2LO6JV57Z
         5pVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NR54EageimV01N0+P0/H4+3jaMZG7ansJYKsbb2lDA4=;
        b=cIW2plvnDvp5JxxXKSMZsWB5dS0bNuBuQlbo0lnD2UcUseCGROhmAbgHeC2+RintdX
         yAvBrcYREnVxLksAvKQulK8NMZu9zivFsXol1CkLA4Z+Jb0D6PvCofKfk79OAcR/2CCZ
         nb5XZLDfHDSyotFq/LQfO4UZft3h5QQxDhtX23gUssrTGJUyrX1TmzsmvP+H0DYWGnm4
         UViTGKt0b2Drx4AT0OfV5LQaLAJU1sLtodDbJerjrShtZVzq7nRwRht0l2pkzVcbzs2j
         blak6KfBsJHUXduPX/0Tckeqy9Xa4yKS7cY2y8NL/XLAMbSFA3AzbrkZrFkCFBxoaEWo
         5ebA==
X-Gm-Message-State: AGi0PuYdUKttuzam5zlWRSPPh8GRgYvXLW5Ifq3ARnz2dJr4kKfjzDi5
        a0LMzUcc5Kd7M3mPBlfbE38ET0fOcYD1yO7iFZM=
X-Google-Smtp-Source: APiQypL8g6O+FG9TaqsUDLdp/pis/jgZ50o0duv/BKwjfN19GSyMMa1FelXnRXGRWclbKX2YlA92SMbDu23K6WRUF7Q=
X-Received: by 2002:a50:fc06:: with SMTP id i6mr8028590edr.110.1588111404097;
 Tue, 28 Apr 2020 15:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200428092147.13698-1-narmstrong@baylibre.com>
In-Reply-To: <20200428092147.13698-1-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 29 Apr 2020 00:03:13 +0200
Message-ID: <CAFBinCBb=FTH6aken5K9zoedBPYBJUCSj0eA+_Eghv+mnU_3vg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/meson: add mode selection limits against specific
 SoC revisions
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Tue, Apr 28, 2020 at 11:21 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The Amlogic S805X/Y uses the same die as the S905X, but with more
> limited graphics capabilities.
>
> This adds a soc version detection adding specific limitations on the HDMI
> mode selections.
>
> Here, we limit to HDMI 1.3a max HDMI PHY clock frequency.
for my own education: 1.65GHz from the PLL will be divided down to 165MHz
isn't this more like the limit of HDMI 1.2a?

> Changes sinces v1:
> - Moved frequency check in the vclk code, and also checks DMT modes
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

This looks good to me based on the current limitations of meson_vclk.c
If we switch to CCF based VPU clock rate changes then we should do
this in the clock driver by calling clk_hw_set_rate_range(hdmi_pll, 0,
1.65GHz)

The good thing is: we can re-use struct meson_drm_soc_limits even
after switching to CCF.
We will just need to set the max PHY freq using
clk_round_rate(hdmi_pll, ULONG_MAX)


Martin
