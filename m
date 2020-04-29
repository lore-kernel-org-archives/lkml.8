Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96ECFC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 23:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 739C42082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 23:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eA7p5JCB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgD2X05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 19:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgD2X05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 19:26:57 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE3CC035495
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 16:26:57 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id 1so2593531vsl.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 16:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wzW2QoswANOc4BdubXXSnIPlG+98WpqoMVNvKMZnN90=;
        b=eA7p5JCBVyNn88KfixBzJiT1YbieVZWfEMsnVvZKOME6ZOaQyKuCYAlB9zqkCbaLX6
         Z8PSkYKabeGxUhxqpr4bIZyvkRrU40wg/ObnKdb+hwBj37ZYmQc9xjlvRK0BUOPT8m4c
         Waxov2b/Z7BTAuQ6+05KRfg+QVkMcrq4i2i3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wzW2QoswANOc4BdubXXSnIPlG+98WpqoMVNvKMZnN90=;
        b=Fpe4Ku37spsJXwt3XADU0j5IfEYsfsE0IQSkhQrGzL3oxYC7laSOaFfw3BA3t8OPNz
         r7BsG/VUcUbci5LCqj5pASEIBInXWQhTxt1jKSHIcNGJYOtBMCgV+lmKbYVJBU/dGE1k
         kigXHYe8sJmrc6AYC3FbG4QMkgVkPHEcsMKkkMymxK7rPVexo1c5QlXBqwkUBvQpoPKF
         0DFE6cNxNKGt08PyixVt2juTvQni72JUsYSExYthIH8zijHfRwZQecCFLHl+mAKGVSmw
         Sk9FcyFgqTzV3KB4kz1+XoQ5GEk6bNLxmecvNdz6iThek3ISIP/tL+kwsZjXDaVZ3Rjw
         aCKw==
X-Gm-Message-State: AGi0PuZBUZZiM/8HDZwoF2biH2dHUNE9onFAzh7QPKrbqoDhm1QEkMG4
        NTVO3Pil3fEgPhs4Oon2n9kBNqx3u8I=
X-Google-Smtp-Source: APiQypLgPO178cp2aefQwsBuBOkvjwdoq9M1oU5WBgKU1OPUn+IQY1O5JpEtf/xPZuYEm35Vg3/e1A==
X-Received: by 2002:a67:d81b:: with SMTP id e27mr900645vsj.40.1588202815926;
        Wed, 29 Apr 2020 16:26:55 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id n193sm299006vkf.43.2020.04.29.16.26.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 16:26:55 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id y185so2600030vsy.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 16:26:55 -0700 (PDT)
X-Received: by 2002:a67:bd07:: with SMTP id y7mr796832vsq.109.1588202814031;
 Wed, 29 Apr 2020 16:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191004073736.8327-1-cleger@kalray.eu>
In-Reply-To: <20191004073736.8327-1-cleger@kalray.eu>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 29 Apr 2020 16:26:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WgUNySbRE9dZys28fFo3eZwf_2=cj68jaw1ftakJDzVQ@mail.gmail.com>
Message-ID: <CAD=FV=WgUNySbRE9dZys28fFo3eZwf_2=cj68jaw1ftakJDzVQ@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: Fix wrong rvring index computation
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Clement Leger <cleger@kalray.eu>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Evan Green <evgreen@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri,  4 Oct 2019 Clement Leger <cleger@kalray.eu> wrote:
>
> Index of rvring is computed using pointer arithmetic. However, since
> rvring->rvdev->vring is the base of the vring array, computation
> of rvring idx should be reversed. It previously lead to writing at negative
> indices in the resource table.
>
> Signed-off-by: Clement Leger <cleger@kalray.eu>
> ---
>  drivers/remoteproc/remoteproc_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Randomly stumbled upon this in a list of patches.  This patch landed
in mainline as:

00a0eec59ddb remoteproc: Fix wrong rvring index computation

Should it be queued up for stable?  I'm guessing:

Fixes: c0d631570ad5 ("remoteproc: set vring addresses in resource table")

-Doug
