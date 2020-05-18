Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC98C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66527207C4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Evwhtrr7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388017AbgERS3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729420AbgERS25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:28:57 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6DBC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 11:28:57 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id u35so5226245pgk.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 11:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B7TcTnxdgBKTVFL5gUH9Cy+Jbda1czl9E/pUOuzMN/k=;
        b=Evwhtrr7DfFquZt/cm+QLYTGVqidVIKhvJS22rNpNJk94fG/F9IzQhDU4y/bCEU4cH
         xd+K0m6JnG5eb4d5M7YXq22v9ymYRgljTktq1YE98d9c1ZmfHOsOmS8lske6MfpztrSe
         NRMzZXp+d2uuIbdUtV6Dcuz5dAbQ4ji99HeIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B7TcTnxdgBKTVFL5gUH9Cy+Jbda1czl9E/pUOuzMN/k=;
        b=jZYfhxFsLW+iIWAPcXon89/zswiY6dlpqDT+UtLPrUA46uyfFDnW0pBnq0I3crnhhP
         hPx1LzMVHMjzzCYadcxfnTnWUSR52GVc1MelnupYuz5mxpyTqcJXT55qp1pMV2udTeM8
         x/mhDh9ZAZ/vTydnITdVNqhP68lc/p/pBrluqFbzy7V9sXRL375VXAWUhTxJ6LqPKQi6
         IDjjioefVvALzRarFtvEPO4mCwpyQX6dBONUFQLJ3EfZRjKGX9gkpeatAuCfJIrb93aB
         /Ztgkp3+tKNxqR9AtdyWqKrNZh/L40aM9w4qvRX7RH6Wyd85N3LQesn4jDkus8G7SZgF
         1w9Q==
X-Gm-Message-State: AOAM532XqeNwKMnuRaybvjqZu2srdiE9gH65Niu3xLG5RyS3vbSoe98Y
        8RzHVg0BvzD9NX4PkAGLD9XgXBxI8Rc=
X-Google-Smtp-Source: ABdhPJw3/2Xp/R1HnQ+kB5Y6oOzLGx0iJJNyb0SKhYm0sW1E3i03qvSm1fcancEYIjJhXEsOEXv+DQ==
X-Received: by 2002:a62:3c5:: with SMTP id 188mr17329329pfd.41.1589826536395;
        Mon, 18 May 2020 11:28:56 -0700 (PDT)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com. [209.85.215.170])
        by smtp.gmail.com with ESMTPSA id n9sm210504pjt.29.2020.05.18.11.28.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 11:28:56 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id u5so5233827pgn.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 11:28:56 -0700 (PDT)
X-Received: by 2002:a67:d199:: with SMTP id w25mr5312377vsi.169.1589826154516;
 Mon, 18 May 2020 11:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200506140208.v2.1.Ibc8eeddcee94984a608d6900b46f9ffde4045da4@changeid>
 <CAF6AEGvXkeOrHGMHo=C1zXhDc9rquQJc8oGDB4VDfhTfdtqyTg@mail.gmail.com>
In-Reply-To: <CAF6AEGvXkeOrHGMHo=C1zXhDc9rquQJc8oGDB4VDfhTfdtqyTg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 18 May 2020 11:22:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V9Aphv=sV36CcK=ka2zNh7Hwiog4qiUEC7wpgjqYSi5Q@mail.gmail.com>
Message-ID: <CAD=FV=V9Aphv=sV36CcK=ka2zNh7Hwiog4qiUEC7wpgjqYSi5Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/bridge: ti-sn65dsi86: Implement lane
 reordering + polarity
To:     Rob Clark <robdclark@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Rob Clark <robdclark@chromium.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sam,

On Fri, May 15, 2020 at 2:43 PM Rob Clark <robdclark@gmail.com> wrote:
>
> On Wed, May 6, 2020 at 2:03 PM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > The ti-sn65dsi86 MIPI DSI to eDP bridge chip supports arbitrary
> > remapping of eDP lanes and also polarity inversion.  Both of these
> > features have been described in the device tree bindings for the
> > device since the beginning but were never implemented in the driver.
> > Implement both of them.
> >
> > Part of this change also allows you to (via the same device tree
> > bindings) specify to use fewer than the max number of DP lanes that
> > the panel reports.  This could be useful if your display supports more
> > lanes but only a few are hooked up on your board.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
>
> Reviewed-by: Rob Clark <robdclark@gmail.com>

I guess get_maintainer is somehow not tagging you and I haven't got it
through my thick skull to CC you each time.  If you're willing, I
think this patch is ready too.  Happy to re-post it with you in the To
list if it helps.

-Doug
