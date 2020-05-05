Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96BEC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 05:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92184206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 05:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SM7cLj32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgEEFgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 01:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgEEFgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 01:36:20 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D111EC061A0F
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 22:36:18 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x2so356375pfx.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 22:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=PgNn3V7/MzuRcjOMN9rd19kSSaAjSXc1sbvAQljU/hA=;
        b=SM7cLj321gsqku/RcDGUTvjhUWhaWgSRlq+T4JlGUjnomhg0gFtNX4IPqFznQGaCE0
         fJ+ioa3bAOkK0uMmzhCYvKPr5NydIsmo27aIJ5EDtHwGsuykNx/UOt15PO5YBLJ24CbA
         H87V4WJ1KvGvLgl9IN6GleQbJKC8t08luv4wE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=PgNn3V7/MzuRcjOMN9rd19kSSaAjSXc1sbvAQljU/hA=;
        b=ShtWHlFRrVCYKWB7YrEOfrjadMT+87BqxPYzDZVRyzlJYByPR26q5xpxDFsLp52rnb
         9timotf/W9JP++zb9Bx1DysbKQG6L5lbzUg+5jBNUer+hL1XNIQspBCJfyzNlW3MihfO
         WrrqzzbXrth2f77mDchMT1TtK3d/scn91kMsRCkFFl/2o8ubfOMOonZAcNflDDmXimLD
         Pwe+N/GaypLq9V6tNA4CV3MxuqmJQK2NJdUjqWsucd54lzrzZsy8Qf2S7FRH7xxD5w1L
         s3JS+JM7rVHipcoPjl3qDotua5e8GtWWx93pHlJybi+gJsaY9rJqoREXQVoKieiCcqMd
         bG3g==
X-Gm-Message-State: AGi0PuaXNw45GGkeijfAavXBTEqViVKys2v3LuWqLEMdxcO9e3RXz6F3
        SH1EAEcUuPxXE5A2G4XhxEKV8A==
X-Google-Smtp-Source: APiQypJCj1XTR2XkP+3PzHlfBOHxZ/4kCpbE0LsmFF42bc3+AilTA09X7ifq6p9O0wuvwLTx9dfT6A==
X-Received: by 2002:a05:6a00:d:: with SMTP id h13mr1562393pfk.254.1588656978175;
        Mon, 04 May 2020 22:36:18 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h17sm803393pfk.13.2020.05.04.22.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 22:36:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200504213225.1.I21646c7c37ff63f52ae6cdccc9bc829fbc3d9424@changeid>
References: <20200504213225.1.I21646c7c37ff63f52ae6cdccc9bc829fbc3d9424@changeid>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Fix off-by-one error in clock choice
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, seanpaul@chromium.org,
        robdclark@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sandeep Panda <spanda@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Douglas Anderson <dianders@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Date:   Mon, 04 May 2020 22:36:16 -0700
Message-ID: <158865697643.11125.1165741750015641823@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-05-04 21:32:29)
> If the rate in our table is _equal_ to the rate we want then it's OK
> to pick it.  It doesn't need to be greater than the one we want.
>=20
> Fixes: a095f15c00e2 ("drm/bridge: add support for sn65dsi86 bridge driver=
")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
