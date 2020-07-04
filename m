Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D86C433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 13:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8A40208B8
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 13:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0AQLqmB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgGDNUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 09:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbgGDNUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 09:20:42 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DB2C061794;
        Sat,  4 Jul 2020 06:20:41 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id l12so37255104ejn.10;
        Sat, 04 Jul 2020 06:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FxeWfdeiZs/rAf+ljgMaCrJoKxPAwF3x7YpavGdK0aI=;
        b=k0AQLqmBs39X8hgGcZfrSBkkff33qKuj+PAa3/3V65/noDmQ9W9gBdNBEIm3GAiYWG
         K6z6S2fEzf0frf6VKldY8Gd2e3labO3XqPacm0GwJL0ye56QlNoLrQvh71TI/xADk4Uh
         ZkXB8LqAQ2QGY5G8fXCYj2K/pROMoNUc2tXHyIV+em8G8bX4fkC8m+EBzByr/hRBUdQc
         RkNjsKRyV9TcZLk3EruvbcRuMlkJxEtQ34ZyIW5oxcPuvABduPtZpncxH7AvHqQCOqBX
         JCEH2AQ0xqWNz0m0odvp1ziGDp9a0jNHZZakGHeTRWpHkhw8Wlo3hjBRgnzW4nZOzCKk
         AK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FxeWfdeiZs/rAf+ljgMaCrJoKxPAwF3x7YpavGdK0aI=;
        b=i/eBDyrujDQFc4aJUDVEmndn4BWwgOCCyfmB3Z99rox1sdPy3tq+5dzpqL1F3hZthO
         OzHyeJP+VA5WwO/UpP0GotnK4aGt+o7XiFRytbuV8w1G1czBpMLfouSZwkZSAMODm2/p
         dn3fsbe9/gkmDol+FxNybn1ueAAUxwt2j1I/84erRBhAaYe7JcIyW9vv+JLieL6Noxqq
         08AyqrfaLgIVJ1ZkG1Vt+tM4W7pc/wOiToQ2g31b5C0FL4bJNyDY6MHklzia2nCiAEiw
         amwmanDZQvRDG3UUgbmd64KrsLogkP4fXuOo0rZi55dhJcxhsE5iTI7OKUp6SXJWMqS9
         VLWw==
X-Gm-Message-State: AOAM532Itmt5/+rdo5c51nS/Ze5072k3yqICUq5Q43jVTab2MykB2t9n
        ScnDlieabOa0KCuGJI8CpQ3exdP8CAe+js/f7pI=
X-Google-Smtp-Source: ABdhPJyN0L6Lg+tDrvxAD4o3/ArnPQHIneDzLuy5Y3L9y8VnRCiaTHn+7cc8WOa3IbxOlmbcK4A+SFhO5NQmPPcgJZQ=
X-Received: by 2002:a17:906:70d5:: with SMTP id g21mr19049076ejk.340.1593868840390;
 Sat, 04 Jul 2020 06:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200704122809.73794-1-konradybcio@gmail.com> <20200704130922.GB21333@willie-the-truck>
In-Reply-To: <20200704130922.GB21333@willie-the-truck>
From:   Konrad Dybcio <konradybcio@gmail.com>
Date:   Sat, 4 Jul 2020 15:20:04 +0200
Message-ID: <CAMS8qEU7owyk0ELmfE7f6Q_C0RT0cy3N=WtP0DzEUhV6KPnDhQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Implement qcom,skip-init
To:     Will Deacon <will@kernel.org>
Cc:     skrzynka@konradybcio.pl, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        jcrouse@codeaurora.org, john.stultz@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> It would probably be better to know _which_ context banks we shouldn't
> touch, no? Otherwise what happens to the others?

> Do we not need to worry about the SMRs as well?

This was mimicked from CAF (think [1]) and the SMMUs don't make the
hypervisor angry anymore, so I wouldn't be too picky on that if it works..


[1] https://github.com/sonyxperiadev/kernel/blob/aosp/LA.UM.7.1.r1/drivers/iommu/arm-smmu.c#L4104-L4109

Regards
Konrad
