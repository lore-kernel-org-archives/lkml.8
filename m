Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4DCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 02:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 910202075E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 02:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F0R4Xzwn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgHRCyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 22:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbgHRCyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 22:54:16 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CF2C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 19:54:16 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k13so8510999plk.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 19:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=289GtmYrcRm91a6nEwufxSTLcmmJ736QYsqJVvByhuU=;
        b=F0R4XzwnnyqJHeJUCbyzmsjQbgLmf6rtTWog/sUoI47YLSbJ8JoxlnSuZIjhmZRnD7
         PRTrg+5BrkQnwc/ATTQrVjVZtmD41vm4U96/65810PzS3l1PbpLMpknDkhaiFHoqtISO
         81C+y5KZesPUR9nF08uNbJSJYGENGbKx8hOdb5p/6/BPfiHG/Lwzv7DwayK+n8YIBubE
         kC+M8cW1gq8jFmKQkGaNeNK4OxjrkVLqKB2uTZU0/ONxvgvGwWEusVEtiTe7XCWsVIWz
         1QgVVSzhDWZqp2M/I6u566I3JNIsy2cbnGbN94fLjJGXWMh0bLlt9I8AiiBdkBWeVTow
         9ijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=289GtmYrcRm91a6nEwufxSTLcmmJ736QYsqJVvByhuU=;
        b=h4EFEF66Iv9unVRpC7cZqSoeSI7li2gSNSc5+hTFAJTvIVliEi4Narf+k9wjed0MXo
         maYAhByiBTXZ175kj9Ss8QX5Q6/cZv7TTqG+UPW6GddRMhBZaK+VUYLMuZpg1OEktc0R
         ApkEidQfasAS3M1zDvMB8vOcnKw1MKUgeR73XOA36f3MjFf6DYQhztirrxU4nJXXXqn3
         LCsXdrRIpT39jYuRLMT7QFKplO515n0Ipm8/23Dg4pvo1qbR9f56HE6w/GWtmvIotzRI
         nui9DKmrrQWadS651vSb8DozT3HL80rmK/FIYYMzE22QSrYdWKgPgjrvvpC/OSMiP20/
         j2Rg==
X-Gm-Message-State: AOAM532x5AVXnCq9zhdg4Kp5r5PbsVjfBpcNNP6e6JTrc+VnHTSFFb7P
        0DXyy1Z7Dlhj2jG06/Pa+tRA/6+Y+GXN
X-Google-Smtp-Source: ABdhPJyMXBWy1Xrp26PFY2sg+IztE08qWr/nquNlkaQiKfmiT6PpwKjMSkYjogqAPMKcRd4NlkgxRQ==
X-Received: by 2002:a17:90a:19c2:: with SMTP id 2mr14568659pjj.6.1597719255463;
        Mon, 17 Aug 2020 19:54:15 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:796:aa9c:e184:5916:ccba:b6d1])
        by smtp.gmail.com with ESMTPSA id nu14sm20149111pjb.19.2020.08.17.19.54.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Aug 2020 19:54:14 -0700 (PDT)
Date:   Tue, 18 Aug 2020 08:24:08 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] MHI stuff for v5.9
Message-ID: <20200818025408.GA13207@Mani-XPS-13-9360>
References: <20200723142738.27159-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723142738.27159-1-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 07:57:37PM +0530, Manivannan Sadhasivam wrote:
> Hi Greg,
> 
> Here is a single MHI bus patch for the coming v5.9 release which fixes
> the kdoc comments.
> 
> Please apply!
> 

This lonely patch seemed to have fallen through cracks! Will include it in
v5.10 series.

Thanks,
Mani

> Thanks,
> Mani
> 
> Randy Dunlap (1):
>   bus: mhi: fix doubled words and struct image_info kernel-doc
> 
>  include/linux/mhi.h | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> -- 
> 2.17.1
> 
