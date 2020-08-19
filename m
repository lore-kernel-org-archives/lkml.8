Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8CDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 15:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D8F020639
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 15:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vyFC/q8s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgHSPmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbgHSPmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 11:42:39 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057A6C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 08:42:40 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id a5so25064612ioa.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 08:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ueFYm1qfrvuVokkg4cIykC1xT41ucWkogT7CDyG2LEU=;
        b=vyFC/q8s7Zxi5luvZu57+hMwrLU8LK8+zh8k/3QGJnwNPklGHQVFn2JSh/YLamJcLL
         dVyeG61lKntoHmN6060nH0IO4HWaUJX0LqqBgWtxW8WyLrtmgssiU5sjKlg4yhOX/q1t
         fdGs7fiCQ+sU2oEF/hOCkMLAqsZwGnmJHj4OpaUMI9oUOu7iL/SI8A5yu3wC5+GerAdd
         pl3GHIdx7erT7nBPzRnndZ08iGPoyojlCOo4MiTJ7ZXnz6wULYITEeIaKSor5wagiy/M
         mgDddCeDdC1Kn1z3f/ICNgJ4KaVFxiCrb1r/cqyLXk1krv+su7Z571TImb/kFrQFwsY7
         OjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ueFYm1qfrvuVokkg4cIykC1xT41ucWkogT7CDyG2LEU=;
        b=DOIrtS3Udl5DQLlGWNAYf6I1c3DdbaRLJvXle5I/oGp5cSD1c00XkU8lGxHJbOoQV5
         cRMotxgPB+JZRyNLiWjkJ2EuLo13ZR//olU4pJfBvaz1mRush1ee19PIqeFiwQwUWV4g
         W+3DKuyflnqKBQOZEvc2RoFvEeQYAayuGEv1a9xsRR4SaNeDlr0/6EY+zyBBnuZOGVmu
         O8SlF/gDtcAYvtc3EpjUSCn2/a2kCVXC1Qo/gy3W7Dd1IvJhOT5G4qcymEpbYFWIEIQ3
         3Ccu85QUm40OmvHfSGMrZSaQM6IK9yTT8GWWsKGXDat9BZkeLtXj8aoxWbAQ1OFkmRR9
         rOtw==
X-Gm-Message-State: AOAM533CsWgYxrKWl0Xr2Qjb0BlZvmnP4A/m2zpv9ZdtJxxrLVm0LRa6
        jQ1YEHnFtULPX3+jjdce6t1bLGf606TK72S3JKAmdQ==
X-Google-Smtp-Source: ABdhPJwRnmRf3OMplQbhMziRPhYyjn2uBddwGEzf/xhJv6+J11j8DMc8iwUkJYiK9rDVOAjuTBdAroFLZAE/nvkCCKE=
X-Received: by 2002:a02:a584:: with SMTP id b4mr23503993jam.68.1597851758905;
 Wed, 19 Aug 2020 08:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <1597644455-8216-1-git-send-email-jiaxin.yu@mediatek.com>
 <1597644455-8216-3-git-send-email-jiaxin.yu@mediatek.com> <CA+Px+wXSbGLb+AZnF8ETRycRUVjqk4xacm5DH6MzuMw0vh6Wzg@mail.gmail.com>
 <CA+Px+wUMXoSL6w0wBduE7obJRWgCteeT8=_=U=8LR34JKTTGZA@mail.gmail.com> <20200819103730.GB5441@sirena.org.uk>
In-Reply-To: <20200819103730.GB5441@sirena.org.uk>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Wed, 19 Aug 2020 23:42:27 +0800
Message-ID: <CA+Px+wUV89KO8JJd3+HpOrgFRSc7sdg-DBW44C31262Qx9NzVg@mail.gmail.com>
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

On Wed, Aug 19, 2020 at 6:38 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Aug 17, 2020 at 04:11:03PM +0800, Tzung-Bi Shih wrote:
> > I misunderstood.  It still needs the compatible string to match the
> > corresponding driver.
>
> No, it doesn't.  The MFD should be registering the platform device.

I guess I see.  It lists the mfd_cell when calling
devm_mfd_add_devices() in drivers/mfd/mt6397-core.c.  It falls back to
use driver name and device name to match.  As long as the name
provided in mfd_cell matches the platform driver name, it works.

But I found struct mfd_cell also contains member .of_compatible.  What
is the difference if we use compatible string (as is) for this device
instead of falling back to use device name to match?
