Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4157DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1890820732
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lRzqiLuR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbgFVU2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 16:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728361AbgFVU2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 16:28:37 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C3CC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 13:28:37 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id o15so10391431vsp.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 13:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/mKQob2TcXV+3bi2u2MxE4v2x49LHk6pqKAA851megE=;
        b=lRzqiLuRgFSf5qcalDvWRL4YbaOQjHCkIkS1z5jnftIuujWTgyicIdl0B3e48B1VQc
         jxfPF2B38RxGI3M1N+8iAp8EJBK/mNFW88o9CRBomgNN3BbrS8IK5fgOjUfRWAReLCVZ
         hXzlEE7ISDIQaPItEDQ0AnroKyoMxwdSONEfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/mKQob2TcXV+3bi2u2MxE4v2x49LHk6pqKAA851megE=;
        b=DpYR2b1NZS1dIQYrSBcf1S4p9vuQsmDrzNXXni5f/Wm/hNA/bm0lfT5J8/wtToNuXl
         OGiOspDo2SCqGEiSYQPAhylcNeXFMBjqLoVW87CLsK4TjFPVmFz5duL8MUk9AxqLpuF7
         0jZvg6kbJ1ctKeYA9z3JSxyS4XLYidxASPMUuPkCr9jtuIEa7AKMaJDxlMFei6vVFTin
         VkklRLkidkjbk/BhwlxPrfglWo3Bxy54IDb5WU+we70DbOwS0iHT31tR/IKFWitBPFRX
         2cbpOzQJ8uYpBxxM3IpNa66gNX05bBFZ7vF+azIQSEg5ooyhPthaHNBQXv3sJTnPJ99n
         SiAw==
X-Gm-Message-State: AOAM530IZeaMY7w64l8J8qQXKuNCmvGrv2MW+V946jc0OS0mfTuI1Que
        gi/BtgJuGF8z2k8HwtDHLh/iQSipIn8=
X-Google-Smtp-Source: ABdhPJzrexIofazKnMVF4Qw2Kw8jzia3vSI9nQ03JR7TO9YkRghBv6HpOJ2k8cumPN2jEaBe0l0K7g==
X-Received: by 2002:a67:db88:: with SMTP id f8mr17505158vsk.165.1592857714081;
        Mon, 22 Jun 2020 13:28:34 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id e187sm2047891vse.32.2020.06.22.13.28.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 13:28:33 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id l10so10429615vsr.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 13:28:33 -0700 (PDT)
X-Received: by 2002:a67:62c4:: with SMTP id w187mr15458333vsb.109.1592857712942;
 Mon, 22 Jun 2020 13:28:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200622121548.27882-1-stanimir.varbanov@linaro.org>
In-Reply-To: <20200622121548.27882-1-stanimir.varbanov@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 22 Jun 2020 13:28:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WF4Sc5yDRc0FgtkqVvDr3brXA7ttTFU6nozCNwBfSQ9w@mail.gmail.com>
Message-ID: <CAD=FV=WF4Sc5yDRc0FgtkqVvDr3brXA7ttTFU6nozCNwBfSQ9w@mail.gmail.com>
Subject: Re: [PATCH v3] venus: fix multiple encoder crash
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        "# 4.0+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 22, 2020 at 5:16 AM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> From: Mansur Alisha Shaik <mansur@codeaurora.org>
>
> Currently we are considering the instances which are available
> in core->inst list for load calculation in min_loaded_core()
> function, but this is incorrect because by the time we call
> decide_core() for second instance, the third instance not
> filled yet codec_freq_data pointer.
>
> Solve this by considering the instances whose session has started.
>
> Cc: stable@vger.kernel.org # v5.7+
> Fixes: 4ebf969375bc ("media: venus: introduce core selection")
> Signed-off-by: Mansur Alisha Shaik <mansur@codeaurora.org>
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>
> v3: Cc stable and add Fixes tag.
>
>  drivers/media/platform/qcom/venus/pm_helpers.c | 4 ++++
>  1 file changed, 4 insertions(+)

The code is the same, so carrying over my tested tag [1]:

Tested-by: Douglas Anderson <dianders@chromium.org>

[1] https://lore.kernel.org/r/CAD=FV=Vt8je1AtT8id-rPC3JToF_7uGKpC-uDuSpzCkwi3e4Sw@mail.gmail.com/
