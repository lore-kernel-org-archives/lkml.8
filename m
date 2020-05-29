Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD867C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B364920721
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GOwvPiiR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgE2LW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 07:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgE2LWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 07:22:55 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA50C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 04:22:55 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id 17so2084793ilj.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 04:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QUz26vjSD65L7rN0EMN41DDMniwEhIkYrxKCsVJaPWQ=;
        b=GOwvPiiRbY2HA5dCwu8VwnakJLKuRTiwHSxEhSn4bfkxf6clQ/mmYJCGELf36Bynqx
         UFiqy+qXToyoSj7qbN3JgB7IwP32L7BKpjepWT21dV39n+HUyViFpownpjOP5Dk8b3Jq
         AoxC0bUc4Jm7z788Xp+J3aj7bghXACx0pZbroaqTx1inet6fdyIAdFPTHl53DkrRGXTp
         BtUSoRjI4Zj/4fAFit7YsPUG8l82exuxEtRdr8oir3Y1tnhSPFPLTl5RZBvMo4UFJ11I
         Hu/yAnsBSrSJCuytnLFUS38yj7A0kY9qrbPOBo3JSyZg48QVZaL2hqqjUMO5OOzvIS5J
         T30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QUz26vjSD65L7rN0EMN41DDMniwEhIkYrxKCsVJaPWQ=;
        b=kPgd1Mc81XTMccSGoLRws7nafTKWK3kFbwIybw3T1o4Ud4nfI/5HIr+NN7PoNV8KC1
         Z1ybBUOWiUbUSe5SexW4wsvffYBT0i3/r6gLm3YPYecEHQiZlY5I68bEGqhx6686OzWA
         x3xRW7sT2VYwCtxpgekRcw1YmU/qyT+BGhdejMkYgE/nYVXKxLpaCAxL203lUdmL9Kv9
         rApNmaZuySk1ihg+bXoKQYbpuX53NYhUOS3RKBKR8ZCwSVvZPEfJjsVoxSNb1uUPsw9t
         eHXOpvnORvmQFFenqEoH4e2Xg2yMS/djx/MCxhWrQG4frRgrRhOt59geqVVzfejB4p01
         BJiQ==
X-Gm-Message-State: AOAM5321ZTfN5bcCeV2ihg5VNRMvtFlJM/aAoQG/mRAuAtiMhRQMmRHA
        Dmk3aBN7vbFZXtfWw8XArFFCou2l0OPP+BpBAsgV7w==
X-Google-Smtp-Source: ABdhPJwec/2VZU+1E/3GRAXji8VYXzHfBrNsBh8GmHVuKkblNQOV25jI2GiT7eGXCnLm1V2eWPp2ycxf0M5Oq/IRueA=
X-Received: by 2002:a92:b11:: with SMTP id b17mr6846581ilf.257.1590751374596;
 Fri, 29 May 2020 04:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <1590750293-12769-1-git-send-email-jiaxin.yu@mediatek.com> <20200529110915.GH4610@sirena.org.uk>
In-Reply-To: <20200529110915.GH4610@sirena.org.uk>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 29 May 2020 19:22:43 +0800
Message-ID: <CA+Px+wVSwJK-=75chKLjSEe3bPRtV2wD95W5D_pdR0Pw0G470A@mail.gmail.com>
Subject: Re: [PATCH] ASoC: mediatek: mt6358: support DMIC one-wire mode
To:     Mark Brown <broonie@kernel.org>
Cc:     Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        ALSA development <alsa-devel@alsa-project.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        howie.huang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 7:09 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, May 29, 2020 at 07:04:53PM +0800, Jiaxin Yu wrote:
> > Supports DMIC one-wire mode. Adds a mixer control to enable and disable.
>
> What is DMIC one wire mode?  This doesn't sound like something I'd
> expect to vary at runtime.

It means: 1 PDM data wire carries 2 channel data (rising edge for left
and falling edge for right).

The setting shouldn't and won't change at runtime.  Would you suggest
putting it into DTS binding?
