Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836D3C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D4972080A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hEXKQqhJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbgIGRWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbgIGNrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 09:47:23 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74A5C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 06:37:24 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id w8so12526710ilj.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 06:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PZpEmEr02MkgLosT7vPqFBX5vy+59cEEz8jZk2wlsPE=;
        b=hEXKQqhJ9NmSx4YCpKMr1NwW45bcnwzOkhMBL8DjeyYLJm78qmx6PfgWclUzVWmb2h
         fxaV6Sz2P9KxPrZSNITJVINtrvSAgSVSURAAgX1ASuRkdCqb7E91FrXanXeSPkc3ujAX
         +FFNNl0haD5QGCZw+GF/SsD6+N2HO6LCjCJF+VFuY1mxeUJW36pdkCIztgxwx60mVlQc
         yje66pdfUrcr4zkkHKkQoPkqLGdiP14j1niS7UWlfzNhCz3KJsftBXf8hOEiYD7uSXY9
         mrAxej+Mmxa5Rq3IupJGnTLeDACHso2O2gLPL+GCXy5RjeQSrH+CAHW5xCBbD046Gi6G
         Fe4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PZpEmEr02MkgLosT7vPqFBX5vy+59cEEz8jZk2wlsPE=;
        b=Uqbrezxc6554nh9TqHtz9+atQ8Be9LxDJ7pucDQPXCa7/iJzye3eCQMbQlwMtr6JJV
         3ef6UNcEpl8Xn4yZ5dz/WJDRFzzlug/6agl2wDjJgjkIW/OwpoUHajC/QrheHOICh44B
         URr9qOPM6G8QAMKjbRoXbeQM++ZsntF2hEQ/ekuLTTVUyOcDLjeD3YzluBMIyuBtMfli
         QDc0zbFpZuOiIc5VkOcxKLMo6Ffah3mES7FI3/uLllp9/ATuA3h514QELAUM3TPOGYun
         b3YAoZPsgMEf6h5gn7+Te5xqY2bGnqDOodc39/hLKGdjQwQIElwcTAt49zw7GRgbqUrP
         7C/A==
X-Gm-Message-State: AOAM533Po9lwqcxmsCqlTWPfChV+sFVAWV4op5mM6wVlioQqYajwf5qB
        sYdE0FXf5QF3VfW4rKnZZ8BUoMV04xvVI8XNaYeX8g==
X-Google-Smtp-Source: ABdhPJyBenIIH2d8wv7qBpX9DpeJamhA8s78sQ62WqhL82+W2hjTg5gPuJzXToQlghF4RNr5s/7pUi3tIrgzsCAuZGI=
X-Received: by 2002:a05:6e02:c26:: with SMTP id q6mr19152124ilg.235.1599485843333;
 Mon, 07 Sep 2020 06:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <1597644455-8216-1-git-send-email-jiaxin.yu@mediatek.com>
 <1597644455-8216-3-git-send-email-jiaxin.yu@mediatek.com> <CA+Px+wXSbGLb+AZnF8ETRycRUVjqk4xacm5DH6MzuMw0vh6Wzg@mail.gmail.com>
 <CA+Px+wUMXoSL6w0wBduE7obJRWgCteeT8=_=U=8LR34JKTTGZA@mail.gmail.com>
 <20200819103730.GB5441@sirena.org.uk> <CA+Px+wUV89KO8JJd3+HpOrgFRSc7sdg-DBW44C31262Qx9NzVg@mail.gmail.com>
 <20200819194005.GC38371@sirena.org.uk>
In-Reply-To: <20200819194005.GC38371@sirena.org.uk>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Mon, 7 Sep 2020 21:37:12 +0800
Message-ID: <CA+Px+wWMH6iUzFq0g4BFC5qA993r9UBobmNAyS2ie+xDwci-yg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] dt-bindings: mediatek: mt6359: add codec document
To:     Mark Brown <broonie@kernel.org>
Cc:     Jiaxin Yu <jiaxin.yu@mediatek.com>,
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

On Thu, Aug 20, 2020 at 3:40 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Aug 19, 2020 at 11:42:27PM +0800, Tzung-Bi Shih wrote:
>
> > But I found struct mfd_cell also contains member .of_compatible.  What
> > is the difference if we use compatible string (as is) for this device
> > instead of falling back to use device name to match?
>
> That's for binding the MFD subdevice to an OF node, you don't need to do
> that for a device like this - you can just use the of_node of the parent
> to get at the properties.

There is an issue we overlooked.  In sound/soc/codecs/mt6359.c,
mt6359_parse_dt() cannot read the DT properties
(https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/tree/sound/soc/codecs/mt6359.c?h=for-next#n2640).

The original DTS is as following:
pmic {
  compatible = "mediatek,mt6359";

  mt6359codec: mt6359codec {
    compatible = "mediatek,mt6359-sound";  (1)
    mediatek,dmic-mode = <1>;
    mediatek,mic-type-0 = <2>;
  }
}
After removing the line at (1), mt6359_parse_dt() cannot read the DT properties.

The PMIC drivers/mfd/mt6397-core.c:
- "mediatek,mt6359"
- has the struct mfd_cell of mt6359-sound
- adds all mfd_cells via devm_mfd_add_devices().

The audio codec sound/soc/codecs/mt6359.c:
- "mediatek,mt6359-sound"


Here are a few options we can come out with.
1. adds back the compatible string in the DTS
2. gets of_node of parent in mt6359.c, and iterates all children nodes
to get the desired properties
3. parses all children nodes in the PMIC driver, and put them into
either platform_data or device properties
(https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/tree/include/linux/mfd/core.h?h=for-next#n77)
- The PMIC is common for several sub-devices.  It makes less sense to
handle subdevice specific logic in the common code.
4. others

Could you share with us what would you suggest for fixing the issue?
