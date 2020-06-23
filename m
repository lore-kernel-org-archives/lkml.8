Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E37C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 05:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8F0B20738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 05:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oR2GDEnS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbgFWFNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 01:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgFWFNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 01:13:42 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C59C061573;
        Mon, 22 Jun 2020 22:13:41 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 80so5912403qko.7;
        Mon, 22 Jun 2020 22:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HzTUjRPxhEgtJpZSkWjXg3y2ucQ0p12YsNY/BwVBYp8=;
        b=oR2GDEnSD0fMlAe6QCKGq9+ZOBwBnkUaO1r3hNEMhjduhOKPmy8xoHwjiyNbSjZmvP
         CMqWcHjO4NrhlMdMkGyJHcpPtEQwTj2BOZI/3X6VAj/ZFIb4QVOQfu2Tpkorn2X5y2xG
         LHjhjwXDXLg4qBt0Wd854NyA4TOykkz66EJM2nxGY2FITG9d0Gtgbd7oy9PNjy8Fm/j5
         YZ7iMfbRd6ZAekr2EfqQwSd3Gss8TPZxQvxk/dEaVQ4zQlh0XwVQTssfD4gFxpNobhHF
         mkc9igDjsksoulDMPZ0H6Nell9/4jqilOR4kZu2WSJvmQKxBHQwRnIZgZgvMIqDttiPg
         /pbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HzTUjRPxhEgtJpZSkWjXg3y2ucQ0p12YsNY/BwVBYp8=;
        b=nmRXGpXo7ccgOwSEgAFeUYzuwsAamR+dfp3DPTehygKZLHk/jaYfOXBT29ryRE/y7V
         xgGzwHCJbckHWWQJhwwbDs3Qen90eWfJ8HrnSTsv7D/oSjoTOxCiV6ED17zVf8x5+mdE
         emLgCMSd6RiKyZ1m1eJ2oj0ZlKJi/Z+tV8/NymSHOwJDcHv+0WCGsYxL6fRbc/PyNF/h
         C1zqXsSIOM/H87/RnxzlYdmxyptFIfpx9bAqx4AhVDnKOQICQ1jY3cQ4vyEZ4aJUNl3d
         pZ04HyKHVWo3uIlvMttJGJHdPXKDdkmOwkCbCCi6LDLDmmHWE77HaP2PLYwFGCpmkuay
         8u3Q==
X-Gm-Message-State: AOAM5332Z8MhQdRd+xsma/QXZm/a8jAICxOic4PNy15R0hcLrUYrE2+T
        EZ6jtYzasTa55kUcXBtZxAD49MmvgAqLncdp4uM=
X-Google-Smtp-Source: ABdhPJzfa5toLWKvS3pXevR0nV8DyiuB56n4keWG8hRyMYBxy22MfXqDg/6UUlR/H6iUSAMG13i3ttR0pbnoWaYmW+I=
X-Received: by 2002:a37:6190:: with SMTP id v138mr16646545qkb.121.1592889221195;
 Mon, 22 Jun 2020 22:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <3eab889e-75b6-6287-a668-a2eaa509834c@web.de>
In-Reply-To: <3eab889e-75b6-6287-a668-a2eaa509834c@web.de>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Tue, 23 Jun 2020 13:13:30 +0800
Message-ID: <CAA+D8ANyeND269US_e3VZg-pOVJ6Beu54C2SL19h6y+ut03OYg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_mqs: Fix unchecked return value for clk_prepare_enable
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linuxppc-dev@lists.ozlabs.org, Timur Tabi <timur@kernel.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 12:08 AM Markus Elfring <Markus.Elfring@web.de> wrote:
>
> > Fix unchecked return value for clk_prepare_enable.
> >
> > And because clk_prepare_enable and clk_disable_unprepare should
> > check input clock parameter is NULL or not, then we don't need
> > to check it before calling the function.
>
> I propose to split the adjustment of two function implementations
> into separate update steps for a small patch series.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=625d3449788f85569096780592549d0340e9c0c7#n138
>
> I suggest to improve the change descriptions accordingly.

ok, will update the patches in v2.

best regards
wang shengjiu
