Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC205C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 22:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF60020705
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 22:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n+bPBIjW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgAaWi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 17:38:29 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:41947 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgAaWi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 17:38:28 -0500
Received: by mail-vs1-f67.google.com with SMTP id k188so5381877vsc.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 14:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A/QwXMv8QAmipbLMot4MaxUhNNvwb0UK1sNHG1c0AVY=;
        b=n+bPBIjWQxxmXcyNtF2EyFmopFozDQdpVp68Vj3mgGrFckg86ApNTNEWR0uFO0/7DG
         vyaxvdDQ9kAE++SLmKRA5v1t6u/ZjszK4NJAbdXgkmSgqli8p4OjpqQKtuJ6Scaf7brq
         ZmpnT/9SmPlPX8EFH7dJW+bzBbfm/BGo+QXbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A/QwXMv8QAmipbLMot4MaxUhNNvwb0UK1sNHG1c0AVY=;
        b=KGqAQNVYnS4nVpgmFVnqxDmrZPbk152dDtkxFj/+79LmPGhsI/3RJq3miwdV2wxIwp
         cj9YYo9xXxzupp5WFqaVYFBqBbXi8Vzwwf80gkjTUW8xf5mstUQXd6J6WCHvuAwY7Ztf
         BLrqAy2CCiyNpziy522HkQt5yNa8SKK14Vn/N6GMO0VtTJGprDcO4csLA6VPpBIsWbmN
         E+3fCCESgXZbL7IaBLVhtxPL3mfn3Ca6j8S8MEqwnr2MucD3Imo1uXFRoWBzyWL0JnHk
         tH2LDyI2vWZzxNZKFGp+boOWLbf3LDfDLPnx5UJmnsul+rupXtLCJ8IwQgrdL3LLBIVo
         /76g==
X-Gm-Message-State: APjAAAURnqAmAHlCAqEDI8JN4tlvFlyzwgnR12S27zuJcLI2qY8b5yAV
        YCm3JaLr9Itu9K/IwwUp0E1wMlg0mGU=
X-Google-Smtp-Source: APXvYqxi8hpVxLQruNLzUZJEOwIj1luKQ5b0h3iH/55yelGORNxuPLXm5f381FCAk3dlAPEuCWZrEg==
X-Received: by 2002:a05:6102:7a4:: with SMTP id x4mr8234875vsg.85.1580510307281;
        Fri, 31 Jan 2020 14:38:27 -0800 (PST)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id g26sm3068513vkl.16.2020.01.31.14.38.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 14:38:26 -0800 (PST)
Received: by mail-vk1-f177.google.com with SMTP id w4so931652vkd.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 14:38:25 -0800 (PST)
X-Received: by 2002:a1f:a9d0:: with SMTP id s199mr7858217vke.40.1580510305500;
 Fri, 31 Jan 2020 14:38:25 -0800 (PST)
MIME-Version: 1.0
References: <1579774675-20235-1-git-send-email-kalyan_t@codeaurora.org>
In-Reply-To: <1579774675-20235-1-git-send-email-kalyan_t@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 31 Jan 2020 14:38:14 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XnS893yXNcm6RKV_3Do5b8hR2=nj=Y03Ymw7fbU+Zwng@mail.gmail.com>
Message-ID: <CAD=FV=XnS893yXNcm6RKV_3Do5b8hR2=nj=Y03Ymw7fbU+Zwng@mail.gmail.com>
Subject: Re: [PATCH] msm:disp:dpu1: add UBWC support for display on SC7180
To:     Kalyan Thota <kalyan_t@codeaurora.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Harigovindan P <harigovi@codeaurora.org>,
        travitej@codeaurora.org, nganji@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 23, 2020 at 2:19 AM Kalyan Thota <kalyan_t@codeaurora.org> wrote:
>
> Add UBWC global configuration for display on
> SC7180 target.
>
> Signed-off-by: Kalyan Thota <kalyan_t@codeaurora.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c | 58 +++++++++++++++++++++++++++++++-
>  1 file changed, 57 insertions(+), 1 deletion(-)

I didn't do any sort of review of this patch, but I can say that
without it the screen on my sc7180-based device is super glitchy and
when I add this patch in the glitchies are gone.  Thus:

Tested-by: Douglas Anderson <dianders@chromium.org>

...one note is that the subject of this patch seems a bit
non-standard.  I would have expected a tag more like "drm/msm/dpu:"
instead of "msm:disp:dpu1:".  Presumably if the maintainer cares when
landing he/she could fix that up, but something to think about for
future patches.

-Doug
