Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC24EC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AD5C2072A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599155382;
	bh=PwReb1wR+sXRrMZqogs7x9Vmd4V3JF81RZqSgbUS1AE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eBIgFqN7nd0DGio6Nck2744Jw+gsyIbJma3ETtobldcPAJfvhrJSEeacSrNBiAJLU
	 nlyYKCqEGwj+BCoXVaDWDkyWo6yhEr1iriWDI70Ak4EXLI4QweP//9pawYoZVjkq1g
	 FgxAXH+FM+811LGN8k8C+Wo4hLmUlqxgqBi2B2io=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgICRtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 13:49:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:58790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbgICRti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 13:49:38 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A80822072A;
        Thu,  3 Sep 2020 17:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599155377;
        bh=PwReb1wR+sXRrMZqogs7x9Vmd4V3JF81RZqSgbUS1AE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qhrzzXdXDKnCyd4Ckt/77e8sctFd5/zYPH/VxgZ1/a3GPpMD09GHyD0nzB2isro/N
         CLCo7KfDkZiv70y2C0tz52eyPXiISAUHCs3HVDSAjhHtv9ku6kQjyGOED0vwfNgQqd
         MwMREmEHc0mscFdXBzHIH18iNkgdgAaOuIbmvTb4=
Received: by mail-oi1-f178.google.com with SMTP id r64so3966612oib.6;
        Thu, 03 Sep 2020 10:49:37 -0700 (PDT)
X-Gm-Message-State: AOAM530a7JrKhwk//yTG0z8WbINBEzgv4lqDuQBTYICY2P+cehIbc48J
        piQ8yNgJn6SYDSONU8s6+ZcadNb65JFlisDUbg==
X-Google-Smtp-Source: ABdhPJxcXEUSmdKY5Vsvo/Ra42Hgg8KjgnWOfsPDJWq3O7EXceTqI+C/z4ChNMurrb2zF+obJSMgWjL333ToKOp8kaE=
X-Received: by 2002:aca:1711:: with SMTP id j17mr2842660oii.152.1599155376930;
 Thu, 03 Sep 2020 10:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200830112633.6732-1-krzk@kernel.org> <159897179515.47719.6003518135515395142.b4-ty@kernel.org>
 <20200903164738.GA2929052@bogus> <20200903172645.GC4771@sirena.org.uk>
In-Reply-To: <20200903172645.GC4771@sirena.org.uk>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 3 Sep 2020 11:49:25 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL+_5Lc5vwtqnCZd6Tz9eB1m_oy2r3gtv0cbwBwKTU=dw@mail.gmail.com>
Message-ID: <CAL_JsqL+_5Lc5vwtqnCZd6Tz9eB1m_oy2r3gtv0cbwBwKTU=dw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: sound: midas-audio: Correct parsing
 sound-dai phandles
To:     Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Sangbeom Kim <sbkim73@samsung.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 3, 2020 at 11:27 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Sep 03, 2020 at 10:47:38AM -0600, Rob Herring wrote:
>
> > > [2/2] ASoC: odroid: Use unevaluatedProperties
> > >       commit: a57307ca6b661e16f9435a25f376ac277c3de697
>
> > This one should be reverted/dropped too. Patch 1 is fine.
>
> There are others?  What's the issue with them?  It'd be easiest if you
> could send patches doing whatever reverts you're looking for.

Just 1 other you picked up. See "ASoC: samsung-i2s: Use
unevaluatedProperties". Patches adding the missing properties (and
restoring 'additionalProperties' on these 2 if not reverted) is the
correct change.

I've gone thru and NAKed all of the others so more don't get picked up.


Rob
