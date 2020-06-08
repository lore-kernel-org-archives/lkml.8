Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56DEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 22:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1AAC20760
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 22:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BLSZRjuy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgFHW0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 18:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgFHW0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 18:26:03 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04562C08C5C4
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 15:26:01 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id n70so2567172ota.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 15:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bc9tsjIFv/jB6QM+YnSZNZcJOlFnkdAaejqLZYVYxEA=;
        b=BLSZRjuywFEWfrzDsWBfP9L/UD63HowwitzIJ8ZQDiSGzaYpks1b2U9LlDoJlCAh1B
         7bRYKtOaOCcX+qfCaB6XxW9qtpsYVIXv/rO7pUoQsHxqBBQwuNStQYxxdUZrcY2sVEaF
         JRUw0EUxUgkG0aW2gXuz6MlGRVnC8wq/zbzOso/uojEYoGpZkJ3lkVls7CABw8X8WADe
         InLkZddLI8woa2s6PnDkQfNqc7WBwUC3zdRkcvTRJYZ00vxHgTbPq4RmVVRCVUhaua0h
         NLDvKCNa9F/wn2ffBc3CxlbvQsUPJagssMuZmOxuDDe5F4a5UBg6InhK9JLs8kq2F5Dx
         M4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bc9tsjIFv/jB6QM+YnSZNZcJOlFnkdAaejqLZYVYxEA=;
        b=ito828qwu3A+kfB0rbRmh96Ebo4xOJI7MuALrP1dQA39ec02B9DoK6H1Tjfz2Spppx
         vorHRsLcSOnJ6RbFV7mZJ/VCxKJdTiiSBJkHSwzb53A+j+tDWpnKDRGPSS3Q7zADyrwB
         NKx7Jg4eeGTxHTaq99xkirvIpnfXyAThB6pydXqnyfOEKpX47DUVNt91InplcyNakbs+
         wbPmsv9pMm9M+X1679rIjD7UdCQdj7CHaJOkeLz92YB3qK6qK65bI1Ci6QrONGth7iji
         ulT49utLUXi1IdMXY1g+MiNHUe826z0YrFMF69O0zp8O7aBtJKxP2TJUMb3BhGigaZAN
         ZZaw==
X-Gm-Message-State: AOAM532fdxi/ueavFr/P1iMYXOsM6tqXMrys6p2JEBVHcjkqTpPoRlmj
        mHHDwUbCJ9bg0lUUYN8sM5BNU3hTQ0U5cgDRSvbd6g==
X-Google-Smtp-Source: ABdhPJyMp64A28sOxzeSkkFqGhDUVU7DykXVmi2Ng6Irnv+4+gn54jjMjWOaLN2VKHEcZDo9gLdLayjCOhVevAod6FU=
X-Received: by 2002:a9d:26:: with SMTP id 35mr12455930ota.352.1591655160681;
 Mon, 08 Jun 2020 15:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <1585044079-358-1-git-send-email-kalyan_t@codeaurora.org>
In-Reply-To: <1585044079-358-1-git-send-email-kalyan_t@codeaurora.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 8 Jun 2020 15:25:48 -0700
Message-ID: <CALAqxLViRrga-XW2o1J1JutFdS1d-qmmgOrEP2beNygw3A7H4A@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/msm/dpu: add support for color processing blocks
 in dpu driver
To:     Kalyan Thota <kalyan_t@codeaurora.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno@lists.freedesktop.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, mkrishn@codeaurora.org,
        travitej@codeaurora.org, Doug Anderson <dianders@chromium.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Sean Paul <seanpaul@chromium.org>, hoegsberg@chromium.org,
        Rob Clark <robdclark@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 1:17 AM Kalyan Thota <kalyan_t@codeaurora.org> wrote:
>
> This change adds support to configure dspp blocks in
> the dpu driver.
>
> Macro description of the changes coming in this patch.
> 1) Add dspp definitions in the hw catalog.
> 2) Add capability to reserve dspp blocks in the display data path.
> 3) Attach the reserved block to the encoder.
>
> Signed-off-by: Kalyan Thota <kalyan_t@codeaurora.org>

Hey all,
  With this patch now merged upstream, I'm seeing a regression on
db845c that I bisected down to it.

When I boot up I see:
[   40.976737] [drm:_dpu_rm_check_lm_and_get_connected_blks] [dpu
error]failed to get dspp on lm 0
[   40.985600] [drm:_dpu_rm_check_lm_and_get_connected_blks] [dpu
error]failed to get dspp on lm 0
[   40.994587] [drm:_dpu_rm_check_lm_and_get_connected_blks] [dpu
error]failed to get dspp on lm 0
[   41.003492] [drm:_dpu_rm_check_lm_and_get_connected_blks] [dpu
error]failed to get dspp on lm 0
[   41.012283] [drm:_dpu_rm_make_reservation] [dpu error]unable to
find appropriate mixers
[   41.020369] [drm:dpu_rm_reserve] [dpu error]failed to reserve hw
resources: -119

Over and over, and the display doesn't start up.

I suspect we're supposed to catch the following check before the failure:

+       if (!reqs->topology.num_dspp)
+               return true;

I suspect the issue is in dpu_encoder_get_topology() we don't fully
initialize the topology structure on the stack before returning it.

Does that sound plausible or is there likely some other cause?

thanks
-john
