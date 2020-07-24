Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E9DC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80E5D206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gTwVBgw3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgGXU1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgGXU1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 16:27:34 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA38CC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 13:27:33 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id g22so2493545vke.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 13:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b2ruj0z8uszwGspJCW6p4c9P/N6BQb51KF9h33pNyFs=;
        b=gTwVBgw3J0BD/uJ5XicjBCeS+kjnEBhCXyjixE8mPUgsBsei2Y9WlpbTkFCkqVV7Zb
         RoIyUfEgwdF+XErM9mrmXe2hv5+O9Da2Q2MpiA00rDeJfjOMpn23dTjk8NKhDCclzXqi
         msFpOIG/Xnb1D9ankx7iexK8zmAvem+uYH8LA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b2ruj0z8uszwGspJCW6p4c9P/N6BQb51KF9h33pNyFs=;
        b=k880qS7wiivcGPWLQBx33bKgNZKSwzp7HIMdy5FyPeZkAEY20dHiZw97iSphEYABB3
         Jvz15SQMSMfMZW0i9u1EDm82MNUfD6GmcPvmycRLZe8sydvhSN3PI2bTpfZnGYLoS3b1
         HvaaAHLyCMcQwb2VbaMIPVY2Wfzkif76FRPwq3qAmwn+bCT3jl+CcIditNxCndLVEMzr
         pJ4aaZ2klBHoEWF3x46nmRSBzIta1WeaDgf67LV0OGmMHAbPmFiLTUAIM6RcUTkjN/k5
         7U6YOQfQVFgapM8qJ/391T/fqxJjowa2hqUVuOC+1rDrnlyflBcYJ7TWJ+GKOoybSNPO
         jDnA==
X-Gm-Message-State: AOAM533W0N5hh6sg8BGHta1qF5UsoVoI9v6vr1QjLFnVmH5GSLTWdikm
        Q5Pl6hxtzB9WYEdkiW8WXwMwNREXUl8=
X-Google-Smtp-Source: ABdhPJysKP9iLCOiCO0CEaiU/5yFOkN2F+HdnPPGnYgS76k+HJuecp8lEeqK1QBBiuVeGA2nRcqHGQ==
X-Received: by 2002:ac5:c74b:: with SMTP id b11mr9224371vkn.73.1595622453029;
        Fri, 24 Jul 2020 13:27:33 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id q83sm244524vkq.46.2020.07.24.13.27.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 13:27:32 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id s192so2497628vkh.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 13:27:31 -0700 (PDT)
X-Received: by 2002:a1f:4e81:: with SMTP id c123mr9478657vkb.100.1595622451504;
 Fri, 24 Jul 2020 13:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200723230344.1422750-1-swboyd@chromium.org> <20200723230344.1422750-3-swboyd@chromium.org>
In-Reply-To: <20200723230344.1422750-3-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 24 Jul 2020 13:27:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W9Ksm+=EdkLB2xenXxx5PoB_z3E7Vfi5JQ0a+dJj2dMQ@mail.gmail.com>
Message-ID: <CAD=FV=W9Ksm+=EdkLB2xenXxx5PoB_z3E7Vfi5JQ0a+dJj2dMQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: sx9310: Add newlines to printks
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 23, 2020 at 4:03 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Printks in the kernel have newlines at the end. Add them to the few
> printks in this driver.
>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Daniel Campello <campello@chromium.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Douglas Anderson <dianders@chromium.org>
> Fixes: 72ad02b15d63 ("iio: Add SEMTECH SX9310/9311 sensor driver")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/iio/proximity/sx9310.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
