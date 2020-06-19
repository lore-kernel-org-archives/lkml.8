Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DF1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D1C3214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jjyeZkkQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731259AbgFSIVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 04:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730849AbgFSIUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 04:20:23 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8F8C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 01:20:23 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id jz3so3803081pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 01:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=3/EAr2y0sc9d0konJThPJ+OgywU1nfaO8eAafmovNU0=;
        b=jjyeZkkQunEwop9f0LcDn+xOYox58f+EyJWfWwuKPsT2m3jeeEXzsNwKB8Y2i9wcl9
         vo65pKBvtPpVUYXK51tqsLJ5wDkY59dFhtjw/6t1w+SMfcdH0GrEThb79HPhXJ+amXFR
         ldpGJoI0uNoaCKlCymivglXrHLHKLZn7CAa1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=3/EAr2y0sc9d0konJThPJ+OgywU1nfaO8eAafmovNU0=;
        b=PeY5nWQo7X1/C3ZyG7vSmh+ddLysXjiCrc4cNZg94mtp/hkAcCQq237hsNxDkdS6xh
         hyJQGrhH2IxKQuXITp5uIhALtzV6WQpLYJhnAPg+WDfVHZn5GY7W9dCsY7dt0eBXjrvC
         17riOfc8KCgLIobVLvbMFoCJoFiIwt3mjF/2gNS2mTDsWccPqYT2M/O8p8H3ZgGJ+D3I
         F4OEVRF0XG49XDFnF1Cf3jx6B6g4Yfu+dA+548x09/UDAy+AE8RzQmN6Wx6/HZIv3lOy
         V2jOR0oICzNxee6HHsPQuKTgAtQRYzTpEEkXSJPXp3W/t6YJXmUT4OMNqdYEM1PaHADF
         uf1A==
X-Gm-Message-State: AOAM530zX1S4VQPT2RICjAsLLh2Ku9QUceQIm18towxJyPgOQF8yqp1A
        x+XGxMAyfO/HO0QQzR351vbH/w==
X-Google-Smtp-Source: ABdhPJwDYhRixLXDiLuE5z9EfNBJNzp4oZwlJ5YgbWv4V4xHUKOmq4b2mrDu7UpTh4t5Iyj085GNfQ==
X-Received: by 2002:a17:902:8544:: with SMTP id d4mr7371334plo.234.1592554822936;
        Fri, 19 Jun 2020 01:20:22 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id j10sm116707pgh.28.2020.06.19.01.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 01:20:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1592485553-29163-1-git-send-email-mkshah@codeaurora.org>
References: <1592485553-29163-1-git-send-email-mkshah@codeaurora.org>
Subject: Re: [PATCH] soc: qcom: rpmh: Update rpmh_invalidate function to return void
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        rnayak@codeaurora.org, ilina@codeaurora.org, lsrao@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>
To:     Maulik Shah <mkshah@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, georgi.djakov@linaro.org
Date:   Fri, 19 Jun 2020 01:20:21 -0700
Message-ID: <159255482149.62212.13349249528460316271@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2020-06-18 06:05:53)
> Currently rpmh_invalidate() always returns success. Update its
> return type to void.
>=20
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
