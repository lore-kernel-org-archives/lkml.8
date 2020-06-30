Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF0BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53B5A2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ok0vl9Ax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388804AbgF3OLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 10:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729908AbgF3OLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 10:11:30 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F7BC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 07:11:30 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h19so22728655ljg.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 07:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KaJ8A/mtp7tiazUWqWYM9IFm5G1Nvqs2cqWvKn5WT8o=;
        b=ok0vl9AxjEtaqLYePLsNsU1F7UuQ/mCyacTbBucXkiBM5MoPdlgeD8vCjscO6H/YoO
         g1Y3tdvyyEKK9q2yfyRX9/W8woqV+6qqe1GPTYjJkO9URBKyG+2vC45bHjhFP+Sighy2
         dcI8F8s5Vfo8GRj3oMeByIZH7a/604pe6LCm/s6p1IQsq5+qrX/E6xr9jj/E9WES9Zng
         GiWCiezZOrh0uh1CoZcuMKEdEiqSdgeXf23b5DujkEjlrgSSWrX93szxwsGoC+pad/wM
         3rIglYZoPvhcbPpRVHCSSeoloCgm6pd895s39sP/y8I08clro7W8b/Nj6lHf1jboCDy2
         6uag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KaJ8A/mtp7tiazUWqWYM9IFm5G1Nvqs2cqWvKn5WT8o=;
        b=o195wWeaHrxrWIsZWoboNQrfJ83IMj0g3wlgdx4KFm2X+GuD2ZMjB16w6ZI52XTyLv
         VW+hJ8e8dz8dGHQa9jujndNK90PqIs1ghX80fD9ugTEWCTZm1LwverG82w589jtdHdUK
         9ZHo52j0o/Fx/hbHZWw053HIBAUpq6eKsCCbT1w89NZ6D6jWurcU0rAQuLZEydg7YbIl
         70z0dLf1dY+QQthqiavWYmwqvIkzDKawnLeppG34H5uhFLQedl163cSdUQzIFZ2WQxGM
         ki9pyJ8T0GF5j3m00Uk1Q9weji1VtS2pA1M3cXxdHbJPrFd5Jy3p332737UrYTczArQN
         DYRg==
X-Gm-Message-State: AOAM530C65ejT1FRyp9Bo9AKXOVdWDoe8w9P//lYR+QvLpTpgRQS7FCp
        9IbvT3CMov2R05s7WdEKrAgzYmY3h7nAB0ytmc4=
X-Google-Smtp-Source: ABdhPJz5MIpXGlHgP1fvLS1Lh6z16GezmdUmGLLPMdcG9JOfzkS5KaVN414xdFAZLh68lRYnPXjkaFaK/PAFHUS7YMU=
X-Received: by 2002:a2e:880e:: with SMTP id x14mr978719ljh.218.1593526288891;
 Tue, 30 Jun 2020 07:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <1593525367-23221-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1593525367-23221-1-git-send-email-shengjiu.wang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 30 Jun 2020 11:11:17 -0300
Message-ID: <CAOMZO5CZ2NhbFJJj8OAeJonA--ZfbfUWqhWCYRqeJE_v8QdKFQ@mail.gmail.com>
Subject: Re: [PATCH v3] ASoC: fsl_asrc: Add an option to select internal ratio mode
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 11:07 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> The ASRC not only supports ideal ratio mode, but also supports
> internal ratio mode.
>
> For internal rato mode, the rate of clock source should be divided
> with no remainder by sample rate, otherwise there is sound
> distortion.
>
> Add function fsl_asrc_select_clk() to find proper clock source for
> internal ratio mode, if the clock source is available then internal
> ratio mode will be selected.
>
> With change, the ideal ratio mode is not the only option for user.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
