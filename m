Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED86AC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A54EC206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f6wfaq6d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgD1Kgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 06:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726328AbgD1Kgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 06:36:42 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A83C03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 03:36:41 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k1so24068120wrx.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 03:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BHqjt1t2DhfWJ1/1kKGvSeNrwY7VYPAdj03G60NkxGk=;
        b=f6wfaq6dWOosZttEbWFUigERrQKtyelJdzMu3KaOhe+0LwI9pFLOjTiSMzZuuUnqdQ
         x3MOI9EKRfhZWLSjWNdNwE1uXVk1ZZOXgpeWYol8IAO6IhLCK3cmADCySsZO1Vx3EQPu
         W5xirJ5ip6/i/LLqEBJiLl9A5owHAGqXmdPPP83hbkWagVeIrFkoh2FYhvpx70/X3+nT
         gIF4PEdmE3qZgUwSJ0WUjx7xXVvQPrmPzTcJq8qMhFtq7ku4PvdhRLC03ZZjpH5rRdyw
         WXRdo3u5N1qgX3HeyBU/AN+B0CoMFe6YLszKgHajxzLP+PYti+wzgzks93/Vv0W+GgzR
         dnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BHqjt1t2DhfWJ1/1kKGvSeNrwY7VYPAdj03G60NkxGk=;
        b=cjbuZyM7TNXM4v3wmbI0pHGkKooWGqzsAUorPEgrbSGhz4B/Nx20vE9whUn1hgsA95
         NAj0Ay3cYNOINj19W4HMArXZdP/LmgpwWciaYGlTKXanSOCfVRMRd8d/M+rWItXRlXva
         yyp47jItt3xUzSZWl08ajdgoxjybeO8iY5UvU5KTbLhD18XzkG4o1yMpzTP1yaLc0tcY
         UR0ZY+7HkoSDH33ODCyxjyQC1XdAiYpyB6PzNUd6l0t3afr57Zl9upXykxGx5G1HPeQs
         vmeHv1RLIxJMRK+ssUYnW57aX5T3UxaTh+cndpY2NkfqVXQAdafzVcIEMzIuDraXDMv9
         LjBA==
X-Gm-Message-State: AGi0PuYRWE8Kh/on+JI7M7O6suQgyOtwC73FGHGRnbf21iyK2GQ4rS8f
        829Ui6kdHdQjpYlm1Doftij/Xu+BG1U=
X-Google-Smtp-Source: APiQypIhwr4oWY9O/EQP4CeY2gIrC2pk0Lyc62kILtt31clrfdbBJtYE6pA/gmyXol5Tg21gBih4OA==
X-Received: by 2002:adf:ce0a:: with SMTP id p10mr31423829wrn.89.1588070200647;
        Tue, 28 Apr 2020 03:36:40 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id q17sm2632337wmj.45.2020.04.28.03.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 03:36:39 -0700 (PDT)
Date:   Tue, 28 Apr 2020 11:36:38 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 4/4] ASoC: wm8994: Silence warnings during deferred probe
Message-ID: <20200428103638.GP3559@dell>
References: <20200427074832.22134-1-m.szyprowski@samsung.com>
 <CGME20200427074843eucas1p1a3a265df0c7f14b0aaec25eb65daf606@eucas1p1.samsung.com>
 <20200427074832.22134-5-m.szyprowski@samsung.com>
 <20200427112202.GB4272@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200427112202.GB4272@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Apr 2020, Mark Brown wrote:

> On Mon, Apr 27, 2020 at 09:48:32AM +0200, Marek Szyprowski wrote:
> > Don't confuse user with meaningless warning about the failure in getting
> > clocks in case of deferred probe.
> 
> >  	if (ret < 0) {
> > -		dev_err(&pdev->dev, "Failed to get clocks: %d\n", ret);
> > +		if (ret != -EPROBE_DEFER)
> > +			dev_err(&pdev->dev, "Failed to get clocks: %d\n", ret);
> 
> This completely eliminates the diagnostics which means that if the clock
> isn't there the user is a bit stuck trying to work out what's missing.
> There should still be a diagnostic.

The driver won't defer forever though.  The final pass should fail
with a different error.  At which point the error will be released to
the system log, no?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
