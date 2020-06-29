Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D98BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C7E420672
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="np8GQKHl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388183AbgF2Upb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731578AbgF2UpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 16:45:25 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2D4C03E97A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 13:45:25 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id e3so5779063uan.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 13:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w7kFF6I/7tjyYaS1rtr5oIMqxgnM+l1sJPudiJl+Cto=;
        b=np8GQKHletK7G3CJusLVB9GC+G7QJF/kREt9GxLJ1t3Hlt3hdOPYI7AnTqvqvfjjOh
         XTfgB9NlwsFFJPFFY/3WXO2tvqKQyGWdikLrXJA5twdfvWv6WqsfZ8fbSnJ761heXjn9
         vHh9j+YN5HmSWr/N6yqL9vCMgNC/cINJ2irupbhcqOWIFiVYa2coSiBY23Qs4cG4b/ie
         cUcy4Xxu/2VK8s6dDPcsm9MWe4pGDUccuyqfsEfwzQSOtHKWPVj5rEL732Fq4SCxwmox
         8LSPZSwt63n11b2S6g6OLJdtEXt+dK5kugr9Rn/1xTEMZV2pqm/UsihoKln3VyxotYET
         UjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w7kFF6I/7tjyYaS1rtr5oIMqxgnM+l1sJPudiJl+Cto=;
        b=LozfkmMbWGM5X1matpMcTZORkYHNZtp1MxZHRxRzX5gsLrwojhVJx73Yv/KGCQP9+r
         uEiV9AUotIjzye6E5JVBnuEyOyIkdigCFkuAkgkVbGT62VkhpXalvda+6vLK2QuzOEN1
         /POBuSnNZ1fUekxA0FIrtE9Pp3hB8JvaKMcIXcwNZ4xuAULcW6o3oGZILe8RjVIT8voE
         8R78TKtgBacLACckkpjocU4LzTAdiMthlAfUb9yQZ3T1qNFo3JQMQKgRkydj1jWb9IbU
         evyjWZg8PdeOIjYyBdkKXqa7uwt350xj5r3ucU/iX0mVs8IJvH3h0bxHhCp7iiedC1o1
         HiiA==
X-Gm-Message-State: AOAM531mK7/cMdyJUNSzSJvBl7nAKAG+l6B6bfsqMqJ2OWGfwIuObmdb
        dZj1GRyJh1rEso29gpliBupTRTDSZE0n5b4NsI1cYw==
X-Google-Smtp-Source: ABdhPJxJKIf8c61d6Sxw032JzZeDqSjWcveZhm6ih/0vZLyM07fRcVrc1Lj+/k5p5DI0zMqvLZYhwCd5VnyTNVlYSEQ=
X-Received: by 2002:a9f:3b18:: with SMTP id i24mr12193440uah.52.1593463524191;
 Mon, 29 Jun 2020 13:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <1593087419-903-1-git-send-email-kalyan_t@codeaurora.org> <CAD=FV=VXAQagbM-dn7MWGm08DdBxefc4jHNbkvHzuBjSM_jWnw@mail.gmail.com>
In-Reply-To: <CAD=FV=VXAQagbM-dn7MWGm08DdBxefc4jHNbkvHzuBjSM_jWnw@mail.gmail.com>
From:   Kristian Kristensen <hoegsberg@google.com>
Date:   Mon, 29 Jun 2020 13:45:13 -0700
Message-ID: <CAOPc6T=E68D8NG+hkRH6WTnYBcCzq=-H6q1M_NVoU9S6eGkxFg@mail.gmail.com>
Subject: Re: [v2] drm/msm/dpu: add support for dither block in display
To:     Doug Anderson <dianders@chromium.org>
Cc:     Kalyan Thota <kalyan_t@codeaurora.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
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

Yes, this is a big improvement for the display I have here. Thanks Kalyan.

Tested-by: Kristian H. Kristensen <hoegsberg@google.com>

On Thu, Jun 25, 2020 at 3:21 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Jun 25, 2020 at 5:17 AM Kalyan Thota <kalyan_t@codeaurora.org> wrote:
> >
> > This change enables dither block for primary interface
> > in display.
> >
> > Enabled for 6bpc in the current version.
> >
> > Changes in v1:
> >  - Remove redundant error checks (Rob).
> >
> > Signed-off-by: Kalyan Thota <kalyan_t@codeaurora.org>
> > ---
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c     | 39 +++++++++++++++
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c | 63 +++++++++++++++++++++----
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h | 28 +++++++++++
> >  3 files changed, 121 insertions(+), 9 deletions(-)
>
> Tested-by: Douglas Anderson <dianders@chromium.org>
