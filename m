Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41F3C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 13:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78C9720866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 13:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YI5fYDIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgHNNSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 09:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgHNNSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 09:18:17 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09D9C061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 06:18:16 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id z6so10708191iow.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 06:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d2PB/319L1J3UbSsvQXsk+iqaXbh8YEkFfuDe3hnFHE=;
        b=YI5fYDIxlyNW2uGLyD7wh7pch8oOC4a9BM9XzcAV3uzZReGiSnYl8Fzr0GLs8CDPS8
         hbrlmLFTzWfNSKJxC4C7bPefxFdIhNnPRT407Vluos3iBg1hJMvtQHoXZln5na/PQ78L
         yPzVrnSv9VjO5zXwGXHhipg/o6uqzMv7JueLQxV9vudzz95WjoOWWcuRm13N2La14f+C
         UWnlV15BX6PNArrSpyjbkVWLOmpdu+kxCr2jSBZd+UiFBzHhXTCgvoWYwr9F0V0ck2h3
         K1fKgj2AhZGavQoDjUS2fDu/NW4+4MdAvBU4gALuq6tceMnoSbS9VcanPVHg5Zn2SHQ8
         DAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d2PB/319L1J3UbSsvQXsk+iqaXbh8YEkFfuDe3hnFHE=;
        b=Xvgtt8SLKZLNzJK9had6AGvA5d6Uz2a4cf8QcmGcXN+k0opd8wTDsou1lw2g436An5
         FFv7JTtXBwlppisCsye8p0C63EeAG1sWEOYBFnfT8PvdC2m/WG1O0vjBRgzdy+hpHmQZ
         LwnUQyy1GAzhT3ZU6u2V7EFqk1tCoGRDB/eB4pvujEgzeo0I3IUVVu0hLh2LOoikIR3R
         hpH2e0SxZOM2l8sEutlvjNEQvOlNYhUeqT2orfX98+2PiRnEBSgo9sExNf1l4DWxhYfa
         3OfMg+HOBfEZGSHgZxMauHR8cFl7v9NmLRWCcDu82sXEBJ1GVgUklq0QQ/mrgZ69VUwA
         ZnEA==
X-Gm-Message-State: AOAM531V3YbScGaRg1nAymIkOPo7W+5v98K7V0hkdDs72px8oEgdjx5P
        BpQrAFDlhkzVzY/WjYflfarAMSGOeA3cNirhcf+/4w==
X-Google-Smtp-Source: ABdhPJwYd8jpI65/wtT2fNRZWRhTYTd4FnLcZufGtZBAixlBWVHmz9K/7rA4kw/6OBJZEDtXxlHLFhaUiHeMnLm74jQ=
X-Received: by 2002:a02:a584:: with SMTP id b4mr2653129jam.68.1597411096065;
 Fri, 14 Aug 2020 06:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <1597401954-28388-1-git-send-email-jiaxin.yu@mediatek.com>
In-Reply-To: <1597401954-28388-1-git-send-email-jiaxin.yu@mediatek.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 14 Aug 2020 21:18:05 +0800
Message-ID: <CA+Px+wUYYV=AS51i=7sbLDJ980om5mDp=YwVuOYzEy01WxTf-A@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Add mediatek codec mt6359 driver
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, howie.huang@mediatek.com,
        eason.yen@mediatek.com, shane.chien@mediatek.com,
        bicycle.tasi@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 6:47 PM Jiaxin Yu <jiaxin.yu@mediatek.com> wrote:
> Jiaxin Yu (2):
>   WIP: ASoC: mediatek: mt6359: add codec driver
>   WIP: dt-bindings: mediatek: mt6359: add codec document

Please remove the "WIP: " prefixes and resend again.
