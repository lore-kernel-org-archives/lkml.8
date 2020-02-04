Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DFBC35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 00:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A143F20732
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 00:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VkXItU6S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgBDAWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 19:22:14 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33845 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgBDAWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 19:22:13 -0500
Received: by mail-vs1-f65.google.com with SMTP id g15so10257165vsf.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 16:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6JzKdfECxoshT8PyZexTPl31WOYvekoaoJj1TOgyVRs=;
        b=VkXItU6SO3y2jWpMgCyH42sXvEkyaTeh7YrrJfXF10BOcoXkCJ07Xp/sSFGgoieUEN
         +V5ilf5JGQ2XKWjmGM25z+sABorUTNDDAdbRINCgG1mOjZ8gzmi8zvvFPMBq73lJfdmx
         XeN3dmpIlgZJwRgq3xz1Ifi9Gfj4iWJZ4xreI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6JzKdfECxoshT8PyZexTPl31WOYvekoaoJj1TOgyVRs=;
        b=dEaNkRThzd5Ly45T2tiesLNVfasCzKEf3qaovcE41++8DqglrResOfixz/SC4s1pt1
         ynFotO18FxHXMD13Hg3Lc0s8WYqWX79Ea8D7py53COvZRLGb5Ir5lhX2jzw8/gAmWhJG
         QvKhnN5+1q2gpG3LXHvlw9OrjbBBnv8DkdztABXewWzQYLLiOeKFfQ2jyhk4zBwTRF4i
         q5sZSGGOAdu/sFi+Hj9ZdQH03ouA1g0x+BAZceUIMB1Fj/z4gTM/Re3GsiC33o7lPnvo
         SDhriQ2EHXqCVs88A8u+SLL+YNF9ARgY5/8o/LYhFAKdZgDI7Efbi0BYqEY/e2fVPWWi
         EYow==
X-Gm-Message-State: APjAAAUDQLyb4XB3/Tk5JE17cYMgbA026+L1ce+PQE1rRtulBzmSfP6V
        0jOL13mr4EfMYopihLii+mEQ7qrm/Y0=
X-Google-Smtp-Source: APXvYqynP4f7gczTtFAyyRS5SGSrzxs+g20MjjrW3g3g6GVkQ/JTbQnFhzYe252oTXxCvi1/7Iv7gw==
X-Received: by 2002:a67:fd7c:: with SMTP id h28mr16511721vsa.150.1580775731233;
        Mon, 03 Feb 2020 16:22:11 -0800 (PST)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id m19sm6922229vko.9.2020.02.03.16.22.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2020 16:22:09 -0800 (PST)
Received: by mail-vs1-f45.google.com with SMTP id 7so10197041vsr.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 16:22:09 -0800 (PST)
X-Received: by 2002:a67:fbcb:: with SMTP id o11mr16294171vsr.109.1580775728583;
 Mon, 03 Feb 2020 16:22:08 -0800 (PST)
MIME-Version: 1.0
References: <20191218223530.253106-1-dianders@chromium.org>
 <20191218143416.v3.6.Iaf8d698f4e5253d658ae283d2fd07268076a7c27@changeid> <20200203233711.GF311651@builder>
In-Reply-To: <20200203233711.GF311651@builder>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 3 Feb 2020 16:21:53 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VTKfv93BiNRYBxWg8o8YKrQy3Z85MzR8XFr=GCS5xhdg@mail.gmail.com>
Message-ID: <CAD=FV=VTKfv93BiNRYBxWg8o8YKrQy3Z85MzR8XFr=GCS5xhdg@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] drm/bridge: ti-sn65dsi86: Use 18-bit DP if we can
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Rob Clark <robdclark@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sean Paul <seanpaul@chromium.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrzej / Neil,

On Mon, Feb 3, 2020 at 3:37 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Wed 18 Dec 14:35 PST 2019, Douglas Anderson wrote:
>
> > The current bridge driver always forced us to use 24 bits per pixel
> > over the DP link.  This is a waste if you are hooked up to a panel
> > that only supports 6 bits per color or fewer, since in that case you
> > ran run at 18 bits per pixel and thus end up at a lower DP clock rate.
>
> s/ran/can/

I'm going to make the assumption that you can fix this typo when
applying the patch and I'm not planning to send a v4.  If that's not a
good assumption then please yell.

Thanks!

-Doug
