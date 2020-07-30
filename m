Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E8DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 15:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50DF520838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 15:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MGZ/ahYt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbgG3Pha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 11:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729484AbgG3Ph3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 11:37:29 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A33C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 08:37:29 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id e22so4858238pjt.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 08:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9SEQ1OEv82nHNMdL9SqhRCzSBouc4sokzr4x8Hh1/DI=;
        b=MGZ/ahYtIdiF9ni3ETE3Khx9UnzPeaO4A/M7nSu0MJyY5+bCzMAsEhfkzzy2Gy2vHu
         N6joxF9xSH76v6buIa+i8zHYXDLBXuMJT6TDd7p3WcnMb9N2l3Szxxl333c9/wjLes+C
         KtGkEIWrsimjwMDomJX3xuQeVyWoSYJbL0I3PyBtDVqJClaQgg9l4+QISP2TJ2TKivAo
         prRKjq++Yg1p+fpQMs+eU75sFdgTQy1OezcxkoAtTcQky2LSiVUmrmEZ3bdWem0LD+gh
         BUuZmuoHDN7Lc3ZjsiqvPDeGFq3/uxgCTXRPlI9G52R9C+UxF/divsyP6+uS1leZZniY
         d9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9SEQ1OEv82nHNMdL9SqhRCzSBouc4sokzr4x8Hh1/DI=;
        b=ULMFpBrjTdlKvfpB3mnpm7fI289oJpQA2lGiOaF0DwlaDszs8ewCNKnoQR6K84EzD+
         NSzkFnpMrhcsCgGwsEwLCtAngYUN85Dl2o0wa3JjRJpxtV4a8z+uZJYiV+jUjemWSvTQ
         wO6J1PfFrqBRvRRBnOhdMfJH20UsOgZORkhdqwmpm+wIXPEg3+vuNrvC7vm0gABxCaF4
         wc99gZwuygaCW+RL2xT1gfRj5wMmPyybNDP4Tdb+9/b5wloDsAy05fUDjiGOFqJfFXoB
         fBDpPU411W0hKCx5pzKxwPNBlx2yAi5hlcRm7BkBn91838p+At7c1HUfL5TgZs2Imcm7
         nLfw==
X-Gm-Message-State: AOAM532oN4CDxT1zLvzvoTGaPJQ9xBt4riZT8pSVvaWlYNuLBtqKU7vj
        daC+cfbLJle6knqHfWf0lh87hg==
X-Google-Smtp-Source: ABdhPJwQyi8M14QMhOXfHbSaGH7VCYAkvRqASesnwEbOczg1tB8ocLA9RDU1wXDJ/FEr3D1Nv1dW2A==
X-Received: by 2002:a62:520b:: with SMTP id g11mr3981023pfb.168.1596123449285;
        Thu, 30 Jul 2020 08:37:29 -0700 (PDT)
Received: from localhost ([106.201.14.19])
        by smtp.gmail.com with ESMTPSA id f29sm6943179pga.59.2020.07.30.08.37.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Jul 2020 08:37:27 -0700 (PDT)
Date:   Thu, 30 Jul 2020 21:07:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Akhil P Oommen <akhilpo@codeaurora.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@freedesktop.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Matthias Kaehlcke <mka@chromium.org>,
        saravanak@google.com, Sibi Sankar <sibis@codeaurora.org>,
        Jonathan <jonathan@marek.ca>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH v5 0/6] Add support for GPU DDR BW scaling
Message-ID: <20200730153722.cnpg6n6tnmvjtuso@vireshk-mac-ubuntu>
References: <1594644106-22449-1-git-send-email-akhilpo@codeaurora.org>
 <CAF6AEGtAEwZbWxLb4MxaWNswvtrFbLK+N0Fez2XYr7odKZffWA@mail.gmail.com>
 <20200720100131.6ux4zumbwqpa42ye@vireshk-mac-ubuntu>
 <CAF6AEGurrsd3nrbB=ktZjWfKTNbKwPHYwTFiZdD-NOW1T7gePQ@mail.gmail.com>
 <20200721032442.hv7l4q6633vnmnfe@vireshk-mac-ubuntu>
 <CAF6AEGuhQcRskGhrFvmCf5T3EcZ9S+3LRdZBiaDYqF34yZjd+A@mail.gmail.com>
 <20200722053023.vwaoj5oqh4cazzzz@vireshk-mac-ubuntu>
 <20200730051045.jejrtkor3b32l2qe@vireshk-mac-ubuntu>
 <CAF6AEGuzff9+Wy4EHx0aDx1gBzSEGh--yqT5rnwLHp=U6amnyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6AEGuzff9+Wy4EHx0aDx1gBzSEGh--yqT5rnwLHp=U6amnyA@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-07-20, 08:27, Rob Clark wrote:
> Hmm, I've already sent my pull request to Dave, dropping the patch
> would require force-push and sending a new PR.  Which I can do if Dave
> prefers.  OTOH I guess it isn't the end of the world if the patch is
> merged via two different trees.

I don't think a patch can go via two trees, as that would have two sha
keys for the same code.

Though it is fine for a patch to go via two different trees if we make
sure the same sha key is used for both.

Will it be possible for you to provide a branch/tag of your branch
that I can base stuff of ?

-- 
viresh
