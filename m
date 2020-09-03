Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64907C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 179F62078E
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599156548;
	bh=nPiDyoWWJzvm42z4eUx7TC5eLYWJUkO9RtvWj3RGC4o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=t15Y14Ea5C0isW2E8yX+4EIHCAP27Hi+M5vklEPaSfr/Pa4I/6KsYOlZgfz6Z9OUR
	 K9ThtQYgSXFh+hytaHnAio4XkOs/yg/aXFq3T1qKynnG6JzOK2cKWaSMKYMsAp6XKK
	 01eF30qGT7XgMgeCJ4NoC80HptgY1rQOlCgqgQPc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgICSJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 14:09:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728312AbgICSJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 14:09:04 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6C732078E;
        Thu,  3 Sep 2020 18:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599156544;
        bh=nPiDyoWWJzvm42z4eUx7TC5eLYWJUkO9RtvWj3RGC4o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LFz7ff7jI2wl8OKdb3dNWcGVE0rVk3n6ETlCP3GG74voSOa6MneV8+myrf0nV/Zef
         0JehuZ/+B0CpcMryGcvXEvezk5TOPTZBUJ8RTTPjyF4Qng70D2tVA2i5ZWGTowb/E4
         /337Yq/B4PC/K4TPEzuivLLOqhK6VHTaZj/wmpVM=
Received: by mail-ej1-f49.google.com with SMTP id e23so5152956eja.3;
        Thu, 03 Sep 2020 11:09:03 -0700 (PDT)
X-Gm-Message-State: AOAM531x7lITjeY2zkXZ6Oby0QDZdsFzYfkgYvOzL+VNu0NKXkO+EH+1
        x09mPBQtvErUdhkDNsDbpZvdukb0lMmxjiU2U38=
X-Google-Smtp-Source: ABdhPJzc1QCdeTf82nUVf10J2Sk2Ur7ILSjfNO9a+DoLfgN1J37o5UYUSobBWE4r8Ye675Mp9s0eKdYwWTi5/JRf1sI=
X-Received: by 2002:a17:906:af53:: with SMTP id ly19mr3296148ejb.503.1599156542378;
 Thu, 03 Sep 2020 11:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200830112633.6732-1-krzk@kernel.org> <159897179515.47719.6003518135515395142.b4-ty@kernel.org>
 <20200903164738.GA2929052@bogus> <20200903172645.GC4771@sirena.org.uk> <CAL_JsqL+_5Lc5vwtqnCZd6Tz9eB1m_oy2r3gtv0cbwBwKTU=dw@mail.gmail.com>
In-Reply-To: <CAL_JsqL+_5Lc5vwtqnCZd6Tz9eB1m_oy2r3gtv0cbwBwKTU=dw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 3 Sep 2020 20:08:51 +0200
X-Gmail-Original-Message-ID: <CAJKOXPe2XpciJtGAFq8c7E=7wrrzK0XUrquDCaNQK+u-2yLByQ@mail.gmail.com>
Message-ID: <CAJKOXPe2XpciJtGAFq8c7E=7wrrzK0XUrquDCaNQK+u-2yLByQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: sound: midas-audio: Correct parsing
 sound-dai phandles
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Sangbeom Kim <sbkim73@samsung.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Sep 2020 at 19:49, Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Sep 3, 2020 at 11:27 AM Mark Brown <broonie@kernel.org> wrote:
> >
> > On Thu, Sep 03, 2020 at 10:47:38AM -0600, Rob Herring wrote:
> >
> > > > [2/2] ASoC: odroid: Use unevaluatedProperties
> > > >       commit: a57307ca6b661e16f9435a25f376ac277c3de697
> >
> > > This one should be reverted/dropped too. Patch 1 is fine.
> >
> > There are others?  What's the issue with them?  It'd be easiest if you
> > could send patches doing whatever reverts you're looking for.
>
> Just 1 other you picked up. See "ASoC: samsung-i2s: Use
> unevaluatedProperties". Patches adding the missing properties (and
> restoring 'additionalProperties' on these 2 if not reverted) is the
> correct change.
>
> I've gone thru and NAKed all of the others so more don't get picked up.

Ah, my bad... Mark, I can send a follow up which restores the
additionalProperties (so kind of revert of the second patch) and fixes
the warning. Other way is that you just drop it and I will send a
correct fix later.

Sorry for the mess.

Best regards,
Krzysztpf
