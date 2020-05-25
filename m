Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434BDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 16:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18D6D2071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 16:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ojfn8Jqq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbgEYQP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 12:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgEYQP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 12:15:56 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B745AC05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 09:15:56 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z26so8976851pfk.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 09:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gq7KDxytrwBv3Ee6LFih9/KTjS7vsScQxcda5nNQ+Ms=;
        b=Ojfn8JqqBQKNdvSd4HpjRqRwRnE62A/rHtJxs74MU9uf7cmH1r7hohAX2tdclJ7BXj
         xdPhMSF97utN4AWhwYJAIpwX9YaKuJdWNsEv0OirKVrVWS3gPlLxyPMZVHAOm9v+AoJv
         FBEmR2ClctF/sTe6tSDkzC2LLnoEfpxFHgPPWbNkwE83qPdcPmgPVms84DR+Co1Yw+Wt
         gvvS1hjOfSjAfWC+s7njQ625zkmNisqy0UZ23ceVy0bH0WJioV8r1Dngn17Kgk7dFX0n
         fS9b3YYpaHIUB4RxhdPqtfkW6C8kE/aZGNbXl+3A129MLcAtqpUu0H7HMWC2Q0cqFJNN
         bokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gq7KDxytrwBv3Ee6LFih9/KTjS7vsScQxcda5nNQ+Ms=;
        b=IDUpO6cy/8FRxL0LZ2ijgDdZOGShXR/zvruzcyopPea3F8eKLQIu4oIkPDuSJgowG8
         ro64e22utABk21wQ4JDQ/DmoethvVR6RbZ5uy6dwt+D2eaoSRRUpEGScI44Q8qmtirC6
         X4dzMjH5Q2SpayzNxvwEe/vuX0Zgl9P9ljSyLjkGjKOt5EfN+Y7gnR9atzGjNko/ymk6
         YkJuXbV0hV5PSyPuFbiE1n8jiBNoIffzpyfO9Wuip+Px/zG37U2jGiPAYiIejn757Jfv
         vALS3ymbtPtcaPjs12An48mvUjoEHRPjmkoh8cVh5gN6vEJmnQNJ5DrXOyalHvHB1aNS
         8+Kw==
X-Gm-Message-State: AOAM531DL5/1NCqaomxbgNZsVZuX3BhsdAxqgkffENestf9Jztbqtamb
        PaumrLS43PuTsJWM2rv11/+5L5DFth4=
X-Google-Smtp-Source: ABdhPJx5O26DBjPbD+W02Sji+TfR+vDgK84YFsKmX7EKqaRnHafICtceif3e2vp0vgA6JP89sQ1Zrg==
X-Received: by 2002:a63:e549:: with SMTP id z9mr13461127pgj.213.1590423356161;
        Mon, 25 May 2020 09:15:56 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id i10sm3040188pgq.36.2020.05.25.09.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 09:15:55 -0700 (PDT)
Date:   Mon, 25 May 2020 10:15:53 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCHv3 0/2] Add support for replicators which loses context on
 clock removal
Message-ID: <20200525161553.GA31527@xps15>
References: <cover.1590171891.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1590171891.git.saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sai,

On Sat, May 23, 2020 at 12:06:50AM +0530, Sai Prakash Ranjan wrote:
> This series is mainly to add support for replicators
> which lose context on removing AMBA clock like on SC7180
> SoC where replicator in AOSS domain loses context.
> 

I am good with this set but need a reviewed-by on the DT binding before I can
add it to my tree.  The same goes for your other set[1].

Thanks,
Mathieu

[1]. "coresight: etm4x: Add support to skip trace unit power up"

> v2 - https://lore.kernel.org/patchwork/cover/1244340/
> More discussion is found here - https://lore.kernel.org/patchwork/patch/1231182/
> 
> Changes since v2:
>  * Added DT maintainers which I missed in v2
>  * Added proper kernel-doc and header as per Mathieu
> 
> Sai Prakash Ranjan (2):
>   coresight: replicator: Reset replicator if context is lost
>   dt-bindings: arm: coresight: Add optional property to replicators
> 
>  .../devicetree/bindings/arm/coresight.txt     |  6 ++
>  .../coresight/coresight-replicator.c          | 55 +++++++++++++------
>  2 files changed, 44 insertions(+), 17 deletions(-)
> 
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
