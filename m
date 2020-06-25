Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA06BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 22:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85F4720767
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 22:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hQeh5IvC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404557AbgFYWVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 18:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403905AbgFYWVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 18:21:30 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F269C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 15:21:30 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id l24so2394185uar.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 15:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HiC4BtBcvypNi0TT+uKmaMyQomfNIooMQQ9SMeSvJuE=;
        b=hQeh5IvCT9+c5THqtc6WWb2AHU0aYgWF5ReZ+qFjCCpfIqgW19aaZnB90R90eRy0XI
         aqqBosgZeXnP5zp2JACRzpjqBvLLkUVWfrSy6pNESy7bXlN8NAGyTcPtiDfqcYQkAXxh
         Dtax+BMxyCZeltX5LaizJxMHd1OeZVgKaCSgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HiC4BtBcvypNi0TT+uKmaMyQomfNIooMQQ9SMeSvJuE=;
        b=ezZxIlE/0O21AOnQIMEKuA/tJyH062iyJ7ge7x8CK5fxyk74PAFcjhoipKF18fbwD1
         Bewp5fqzBj5spwJff1FSzCIURsPB70cvNZgh2sr4kGMxaR4PO76qC3zUvFl/ujEN6sCk
         OJytkXG0dAHCDfmFqG8yrCRPo9S0be0MeDtdv/quQhiUn2K6fI+VQRKvQL+3Bp1I7rJb
         eodzNiQjteTzKJoBxxcn0gAzjd4Mvm4geRbT0RnznVVH3/ixMwdKOXmGad8yXl9LO6eM
         EIS9ngVLPMu9gF2EubdhRldIde3ZHKeItzLe2R0JUIGXxzaR0+1ckNTYSV+/n6O1DXX2
         sz8Q==
X-Gm-Message-State: AOAM533o99qOQNJZd8eNoBeX+yGnrHKl9ATIdH6Z00K8Gds7X6ms8/p7
        uiCoIVCGF0tVqbzaMznEf761VltwiV0=
X-Google-Smtp-Source: ABdhPJzfUUBL3qvnemQqmnYIRmaUeBH/ur38qQpW9EcnmM4SLMyXPbWbkqffwRgGSbRRtyEHQms+KA==
X-Received: by 2002:ab0:7849:: with SMTP id y9mr105655uaq.56.1593123689085;
        Thu, 25 Jun 2020 15:21:29 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id e14sm1010421vsa.33.2020.06.25.15.21.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 15:21:27 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id o15so4435468vsp.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 15:21:27 -0700 (PDT)
X-Received: by 2002:a05:6102:20c8:: with SMTP id i8mr347826vsr.106.1593123686688;
 Thu, 25 Jun 2020 15:21:26 -0700 (PDT)
MIME-Version: 1.0
References: <1593087419-903-1-git-send-email-kalyan_t@codeaurora.org>
In-Reply-To: <1593087419-903-1-git-send-email-kalyan_t@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 25 Jun 2020 15:21:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VXAQagbM-dn7MWGm08DdBxefc4jHNbkvHzuBjSM_jWnw@mail.gmail.com>
Message-ID: <CAD=FV=VXAQagbM-dn7MWGm08DdBxefc4jHNbkvHzuBjSM_jWnw@mail.gmail.com>
Subject: Re: [v2] drm/msm/dpu: add support for dither block in display
To:     Kalyan Thota <kalyan_t@codeaurora.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>,
        mkrishn@codeaurora.org, travitej@codeaurora.org,
        nganji@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 25, 2020 at 5:17 AM Kalyan Thota <kalyan_t@codeaurora.org> wrote:
>
> This change enables dither block for primary interface
> in display.
>
> Enabled for 6bpc in the current version.
>
> Changes in v1:
>  - Remove redundant error checks (Rob).
>
> Signed-off-by: Kalyan Thota <kalyan_t@codeaurora.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c     | 39 +++++++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c | 63 +++++++++++++++++++++----
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h | 28 +++++++++++
>  3 files changed, 121 insertions(+), 9 deletions(-)

Tested-by: Douglas Anderson <dianders@chromium.org>
