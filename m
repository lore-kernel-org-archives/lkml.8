Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09132C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1F8B2078A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vKwc0hm9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgHQHaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgHQHaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:30:11 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96E0C061388
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 00:30:10 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id s1so3565724iot.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 00:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=njImXme8DvFmBmmBNjNQkbOdGSjHzwAWepRldmmnkFM=;
        b=vKwc0hm9KMhrs8R9lVS1+IPdDcR9wpOy8T7gFNt5q2QV3lOt6h/3fdoj6kEeqgp8aN
         58J0ceAUIVAOo+etWCr23cZzpX2S1j9MNwnY2cgfEKSU1kQgW1rb8mNawPAJL4/yX8ZI
         A5l3InaUTt8Trss2ZBvCyyKe76g9Y+vpkC+ac9yxPdy1RJID9vGjFt1o4WVpv4/HgNRz
         v+y4X8vu2FtjiwjaZ6h6atRbrGngkkDptjZXg2LM6devwJofRgz9k/zfdmL3Zb/cUQ1p
         dJzOX7GPWZLtp6FaHawv72tIIjSDJC/DtTRUeuECn9u3bcdSoOORu29S0KVlBclwYQUy
         tRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=njImXme8DvFmBmmBNjNQkbOdGSjHzwAWepRldmmnkFM=;
        b=J3zlqoQs5x18K4qugMWJmQQEz22jPmbgFYW1c/ym7FS5jaJjblGG4TS0zjpQBiS+B4
         9bkFtwSXPkQo0UY35EBNTUv9Pg2sKRKzaX7qKBBkczcu0skT4OIgxdMQ86Iw6C73zfrV
         7Szn1peaiDFXBlYG+NMYzZI/hARiIkzzYOGWWcaQX+TdObNVZkZ5c4hIGmf7Axsz/4Eu
         1gM0Lh2gdFBhyEi9De2xCUMgI1k4NAiwqSoZ451uNFxbM5NMuxX+trvLltHiJAvZrEOE
         jt9GDuBYPeZ8Y1MX1ECBcsM4Hpku96yZRj0NHxaVNK7M7idlpqedyVcSH3SHjBadoGAs
         VA4g==
X-Gm-Message-State: AOAM532OT814HMt6yGV2/FrbFFcNeiqpjM8I9q5+5mbC1POsFGFmTZrn
        G1adUf7QU+daAmQZ3GNNQ3oqfbeiHdDvsbdLSi9Pig==
X-Google-Smtp-Source: ABdhPJwCa0E+vAfxwNpCUTPIUSspheXu7A+kHNdN+DzANKgmK0a/mh8mC9JzSsxmyLAcqGudRpVCGbTB72ZlRdctp5Y=
X-Received: by 2002:a05:6638:2515:: with SMTP id v21mr13267320jat.109.1597649408741;
 Mon, 17 Aug 2020 00:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <1597644455-8216-1-git-send-email-jiaxin.yu@mediatek.com> <1597644455-8216-3-git-send-email-jiaxin.yu@mediatek.com>
In-Reply-To: <1597644455-8216-3-git-send-email-jiaxin.yu@mediatek.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Mon, 17 Aug 2020 15:29:57 +0800
Message-ID: <CA+Px+wXSbGLb+AZnF8ETRycRUVjqk4xacm5DH6MzuMw0vh6Wzg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] dt-bindings: mediatek: mt6359: add codec document
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
        bicycle.tsai@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 2:08 PM Jiaxin Yu <jiaxin.yu@mediatek.com> wrote:
> +properties:
> +  compatible:
> +    const: mediatek,mt6359-sound

The compatible string has been removed since v3.

> +required:
> +  - compatible

The same here.

> +examples:
> +  - |
> +    mt6359codec: mt6359codec {
> +      compatible = "mediatek,mt6359-sound";

And the same here.
