Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0857C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 05:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C97662064C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 05:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wFYPLNpI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgGVFa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 01:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgGVFa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 01:30:28 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA73CC0619DC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 22:30:27 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u5so571357pfn.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 22:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dl6zwzhq+FsMerc9qwgjpE1ja24WRPYdLlSyn3M9Lhc=;
        b=wFYPLNpIceaExhbJzjXzj6tDwJR+E2dHZTr/ewhWaneEnAkKVT4tW3ngs4Ana5WOY4
         JfAbIvMdjf1VIJe9UXtwIm9fjoqxZ4usIYpwHCVaZavJIFFd+fnrU6vME5UiA3OflLMv
         PjFwR9gTJfbDkCNCnxFjdkM5ybfl439hSbbNWHF+AANDuDpkYtixQfBLNPZswGRM2DZc
         A+KAoq8xOpfUBwZcC55ebWCtTICdrxK1ie00kDe8G4+14vi1XxzOFtfhfeTXnUap7efU
         QN1XAOgUSvgdOOotJ2DjwrU3ZOPO07v9BSL1HUBLvu0PwWszIbIqxbQX6Ez2fani/u8w
         0nmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dl6zwzhq+FsMerc9qwgjpE1ja24WRPYdLlSyn3M9Lhc=;
        b=adlZn+5OmkhEbQbVIy7Ba+YbUu3Fe0eVefvjsQ1oqZ4SinxhZE+XteTlQy1/TumILB
         BysGMu4ZfwrF/q4s9RQCRmdUUGQDSypQlNY0s1eGSv+E90yXTJBiRy/SVp7fGBV7UKvX
         zvvZf1oOrHP9IM7UFiXNz3EbVYJOghbUj/s2IDuPAfJCMXCFsUJeXOQoqPGnP3y8t3/d
         YYnEGG1rX/r6XDNCoTLV5b8gQ9jX6jv8tJ71mSIo6QxhIC9FG/yaHvI7GHVXF1f8Em/i
         olOCaiAvA4XJQm5TGa0ACfHWY01uQ3Od+CnmPvsJrj5+kasJtIwGr5mgo4PpN6Q4ziB8
         ZPIQ==
X-Gm-Message-State: AOAM530oErOp0tYPRyOIpIwltuTNVMI1Y49neRsNrOL+EjUc32H59IE0
        oGAY2z3rEJ5cKxvs4E+il6Z14Q==
X-Google-Smtp-Source: ABdhPJwOr+y0DG+QB+DOdgrlRofbLELHLiFlXrD3oG8oQpR/O3B/puROrAIHaF3LxSmr19O0mGHgVA==
X-Received: by 2002:a62:8fc6:: with SMTP id n189mr25703478pfd.10.1595395827137;
        Tue, 21 Jul 2020 22:30:27 -0700 (PDT)
Received: from localhost ([182.77.116.224])
        by smtp.gmail.com with ESMTPSA id ml8sm4857037pjb.47.2020.07.21.22.30.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Jul 2020 22:30:26 -0700 (PDT)
Date:   Wed, 22 Jul 2020 11:00:23 +0530
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
Message-ID: <20200722053023.vwaoj5oqh4cazzzz@vireshk-mac-ubuntu>
References: <1594644106-22449-1-git-send-email-akhilpo@codeaurora.org>
 <CAF6AEGtAEwZbWxLb4MxaWNswvtrFbLK+N0Fez2XYr7odKZffWA@mail.gmail.com>
 <20200720100131.6ux4zumbwqpa42ye@vireshk-mac-ubuntu>
 <CAF6AEGurrsd3nrbB=ktZjWfKTNbKwPHYwTFiZdD-NOW1T7gePQ@mail.gmail.com>
 <20200721032442.hv7l4q6633vnmnfe@vireshk-mac-ubuntu>
 <CAF6AEGuhQcRskGhrFvmCf5T3EcZ9S+3LRdZBiaDYqF34yZjd+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6AEGuhQcRskGhrFvmCf5T3EcZ9S+3LRdZBiaDYqF34yZjd+A@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-07-20, 07:28, Rob Clark wrote:
> With your ack, I can add the patch the dev_pm_opp_set_bw patch to my
> tree and merge it via msm-next -> drm-next -> linus

I wanted to send it via my tree, but its okay. Pick this patch from
linux-next and add my Ack, I will drop it after that.

a8351c12c6c7 OPP: Add and export helper to set bandwidth

> Otherwise I can send a second later pull req that adds the final patch
> after has rebased to 5.9-rc1 (by which point the opp next tree will
> have presumably been merged

The PM stuff gets pushed fairly early and so I was asking you to
rebase just on my tree, so you could have sent the pull request right
after the PM tree landed there instead of waiting for rc1.

But its fine now.

-- 
viresh
