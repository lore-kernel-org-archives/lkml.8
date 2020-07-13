Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D798DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9EC520663
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iz1kpOyX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgGMGvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728628AbgGMGvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 02:51:14 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB71C061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 23:51:14 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f18so12031904wml.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 23:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XtqBoIrlR/rKjGKe/kJfJA9m7jssET7vVTff1SRKfT4=;
        b=Iz1kpOyXeERVc160JxW7TBcIMts9gBt6OzZQ42NyzP7L65h8SiePRFEfs707PyxatA
         r42kEqzFhLAsoY2mu7wmHpSOaN6PeM0w3rYTnO9V1vKq09ZHG6LgmUJwBjYXfjFegJsf
         hJEKYFPJGRs7aJdfkFT5wJSXgqo9OSRDJ3KVhIE+6Cf0GkriovHjFIKBzPsD0SEPPMqg
         49C5LIMpFYW8THARpmq21W+xRCQmrvf5/bJ+Q8xn/fbn/U40oHFzxPbh17EVRuFF+PAJ
         X51qp7Bkkz4cbe9aQLLZ9o/UvF3K3x64HOLbASb/HzW64cIMgKHsrCGLvC6Mr3xehxgk
         ve6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XtqBoIrlR/rKjGKe/kJfJA9m7jssET7vVTff1SRKfT4=;
        b=M2Wfzy54pLAWLxNBT9tS9g6XeRHF3czFxkyyU8f6Z5s1hfzKo+cInAtnwirWfrD9y4
         DvnNgV0wevSKq1e+eGDxmAab2kkMpZViW1Q0oy9yQ8hvpfL+9VjQpp0COetCoa3ZYkQZ
         lyittIY75N1Tpb3fKnkjp4hruQgapji0qqpPjHq06S+FaxleKcZTkuPmfpIMJ9Hd7MrQ
         rXI/2T4iKhEnWf4rdLtSvqX4Mo9nDwIlEPE3cGk/BE9xDurquILfITiP39htyDlrEwwS
         snZ4lNGM4mQC5HrSesS35j56yAvT7gTDBrLwvG6Phl89DBkRhH6pwS9ea8GnnaYndwzq
         isYw==
X-Gm-Message-State: AOAM5338RQBbfp0It2wT7hhfjKHhCy3EOVk3uw9eRpr/r7vkrKVWxRMI
        KogMk5XZirSjxexYf1kVrF2KPQ==
X-Google-Smtp-Source: ABdhPJy8OEkwK2hosu91yGd1UjKt6vgKwMfNBMFBiiqF6YAhQ7DiMfBX6YGkHs1p4KY5vObROeab5Q==
X-Received: by 2002:a1c:a7c4:: with SMTP id q187mr17053090wme.0.1594623073259;
        Sun, 12 Jul 2020 23:51:13 -0700 (PDT)
Received: from dell ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id z16sm22066765wrr.35.2020.07.12.23.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 23:51:12 -0700 (PDT)
Date:   Mon, 13 Jul 2020 07:51:10 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Gene Chen <gene.chen.richtek@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, shufan_lee@richtek.com,
        cy_huang@richtek.com, benjamin.chao@mediatek.com
Subject: Re: [PATCH 1/4] mfd: mt6360: Refactor and fix code style
Message-ID: <20200713065110.GB3500@dell>
References: <1594117856-14343-1-git-send-email-gene.chen.richtek@gmail.com>
 <1594117856-14343-2-git-send-email-gene.chen.richtek@gmail.com>
 <b9540dc6-4d43-45e4-8878-15d2df24a268@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9540dc6-4d43-45e4-8878-15d2df24a268@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jul 2020, Matthias Brugger wrote:

> 
> 
> On 07/07/2020 12:30, Gene Chen wrote:
> > From: Gene Chen <gene_chen@richtek.com>
> > 
> > Rearrange include file.
> > Remove brackets around raw numbers.
> > Indicate sub-dev compatible name by using "-"
> > Combine mt6360 pmic/ldo resouces into mt6360 regulator resources.
> > Rename mt6360_pmu_data by mt6360_data.
> > Rename mt6360_pmu by mt6360.
> 
> That seems like a lot of cosmetics. Why is this needed?
> If you think that's needed it should be split up in different commits, each
> explaining in the commit message why you do that.

Agreed.  This set is still not broken up enough.

Please place each logical change into its own patch for review.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
