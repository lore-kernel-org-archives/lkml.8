Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DE2C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 23:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8178921702
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 23:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L3CaE1u0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgGTXc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 19:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgGTXc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 19:32:28 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1B9C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 16:32:28 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id w17so9402624ply.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 16:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=+uXLuocAO8lxCToiXlu/ReZ2hnWMT9ytGR6dkaeKVcg=;
        b=L3CaE1u0T+Opv+kLiWcX3Ec5X59jjbA9ANZp1cgG9bOS3DXa2o1L9a9YEcj4cXlKC2
         YpsMhC0kPyoFSgBcTddfFOIKE7LiXt/QMGZWsarCu2NGjirgyXZxVIhiB74qP1gv62v9
         Q1bvn8ox2SETeiMeFmiw8sTgBuT2J4USRqn5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=+uXLuocAO8lxCToiXlu/ReZ2hnWMT9ytGR6dkaeKVcg=;
        b=YhqOtSS1hheTeXENhGlBmufsj7y03BgzXreiHkSPMzXzPvRX0psnIuNk14sPeGGeHI
         AOAeE4JfhAcXf3LSJbR903xv5D2OMOTtq/av4DMLFgc1Jkg+dZIx/hlo5L1U5GKkDw1m
         e5CNi5pooqCTLNsk36JA2GqtNiNbCGcvcLyGneSYfjpQN01wUMLF+/Ej8p/OPCvoRL5f
         4GnT5LE489zfGPPG5/uN1/WRxbV1VHbSRHWV4jMEjXbmB5y7VC1pc1921iHMLvRA42d2
         lEoFEvfs5sSLDpW9bTJKhJTaDP/DmymdpsefbOnx37DjhO3vX23ABr+7N1Cft0w0+zWs
         Ko7g==
X-Gm-Message-State: AOAM532sy9zPOnOo4IQUOe4osm2Qa3bLs9cdt97uJLATwyXqKlyty/K1
        GarNkOGC9Cq45to7KeX97ZSfPA==
X-Google-Smtp-Source: ABdhPJyzZqIFkJvQhLWQiuq3uOD8kLbvlBxMBgJb3gbD3D7nIYizU92Vunzu1FrFGUCCZSH/KMaTmw==
X-Received: by 2002:a17:90a:7487:: with SMTP id p7mr1715589pjk.233.1595287948100;
        Mon, 20 Jul 2020 16:32:28 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id a9sm18301137pfr.103.2020.07.20.16.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 16:32:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <91a8eef836c1939cb57942c6fdcf2772@codeaurora.org>
References: <20200707184125.15114-1-khsieh@codeaurora.org> <159527632812.1987609.6364896740387949838@swboyd.mtv.corp.google.com> <91a8eef836c1939cb57942c6fdcf2772@codeaurora.org>
Subject: Re: [PATCH] drm/msm/dp: Add DP compliance tests on Snapdragon Chipsets
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     robdclark@gmail.com, sean@poorly.run, tanmay@codeaurora.org,
        abhinavk@codeaurora.org, aravindh@codeaurora.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
To:     khsieh@codeaurora.org
Date:   Mon, 20 Jul 2020 16:32:26 -0700
Message-ID: <159528794676.3847286.1584696687662833591@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting khsieh@codeaurora.org (2020-07-20 15:48:13)
> On 2020-07-20 13:18, Stephen Boyd wrote:
> > Quoting Kuogee Hsieh (2020-07-07 11:41:25)
> >>  drivers/gpu/drm/msm/dp/dp_power.c           |  32 +-
> >>  drivers/gpu/drm/msm/dp/dp_power.h           |   1 +
> >>  drivers/gpu/drm/msm/dp/dp_reg.h             |   1 +
> >>  17 files changed, 861 insertions(+), 424 deletions(-)
> >=20
> > It seems to spread various changes throughout the DP bits and only has =

> > a
> > short description about what's changing. Given that the series above
> > isn't merged it would be better to get rid of this change and make the
> > changes in the patches that introduce these files.
> >=20
>=20
> Yes, the base DP driver is not yet merged as its still in reviews and=20
> has been for a while.
> While it is being reviewed, different developers are working on=20
> different aspects of DP such as base DP driver, DP compliance, audio etc =

> to keep things going in parallel.
> To maintain the authorship of the different developers, we prefer having =

> them as separate changes and not merge them.
> We can make all these changes as part of the same series if that shall=20
> help to keep things together but would prefer the changes themselves to=20
> be separate.
> Please consider this and let us know if that works.
>=20

I'm not the maintainer here so it's not really up to me, but this is why
we have the Co-developed-by tag, to show that multiple people worked on
some patch. The patch is supposed to logically stand on its own
regardless of how many people worked on it. Authorship is a single
person but the Co-developed-by tag helps express that more than one
person is the actual author of the patch. Can you use that tag instead
and then squash this into the other DP patches?
