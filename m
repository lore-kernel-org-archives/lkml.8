Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AC4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 05:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5DBA20768
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 05:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWSfNpBy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgGWFc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 01:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgGWFc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 01:32:26 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447D8C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 22:32:26 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a9so2615531pjd.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 22:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Azbmlb+o4Fr+IIKuyAGgLbUxH3riL3SrFDqan1+Q4+M=;
        b=YWSfNpBy8DiSuE3KFCrrd51VFavpYZSf4IehxS6pt8vfV3qMCkCsreyShiAT+R6fLD
         6qcazoBPEvtCcEetZPDLBMsmAkp/v04ZW2cFFN/fKnHjv5h5IrzMocedHYgsxY0o/h1B
         uPSIU/Hf/OjdnrB+uczzCWgglf1A18DgHCT2oE2nzSi0LbZfLC+RYMLZWZnHPXRkklNE
         Z4lYNPZPXOTM5HoPTmTowANjCDl5E8vWiEVQkrN2qXyWmD5lNLX6pdb9HBxeuqsKshjL
         Ap/eOsPLMJZ5hTQECt33KdoA71jPCi+qMVdRx97wTmDFnSSjPPqn8LGMYYaU17giriRU
         Q8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Azbmlb+o4Fr+IIKuyAGgLbUxH3riL3SrFDqan1+Q4+M=;
        b=pXS96qZM9csF+iwE4lF0uoVOpPHimwepz8RN4Jr6dDyWzLm/8KI3J88KzgNDuD6O0i
         EYuAnLYMgBJ1ZJLiuXKa+MIp8kS/NqGOLuU1T6Pn6kbsPUjhMenuBWsflQ/8bblGSlGF
         Sx/sWb0mEQm81p0PVoZsWY3mCnoxl6NLW625xoYllJeCKkPNt9pv2tCUt1anbRtYsXoS
         TD2n0lWcD5zC1MvshXzFx4HZKJwWd48LBFtpekl8e2IPOtK7yfOutuTT0a7+61MPVfhQ
         UYiPz1DWMadalCGZnwOBkUlZu88y+M7D3sb0Uy1MBFOqTTLz6SzhXER0qHj0Dp/jYoNw
         Fr7w==
X-Gm-Message-State: AOAM532YtLvhsw+JbD0Ybxb5Cbn3ZwQW7MOgqB0AgHu7MK7h4ToHcxkJ
        9umZ8YP+QVq/Zc0z/XZHJBY=
X-Google-Smtp-Source: ABdhPJy3Ixe5NDssWl2gkYZjneUuDd6lti+TH8cvo414EnOoMUuOEVvaFkXJt4jj5434vavQPR0Wcg==
X-Received: by 2002:a17:90b:3715:: with SMTP id mg21mr2603075pjb.113.1595482345592;
        Wed, 22 Jul 2020 22:32:25 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id y65sm1438245pfb.75.2020.07.22.22.32.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Jul 2020 22:32:25 -0700 (PDT)
Date:   Wed, 22 Jul 2020 22:31:50 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_esai: add IRQF_SHARED for devm_request_irq
Message-ID: <20200723053150.GA5476@Asurada-Nvidia>
References: <1595476808-28927-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595476808-28927-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 12:00:08PM +0800, Shengjiu Wang wrote:
> ESAI interfaces may share same interrupt line with EDMA on
> some platforms (e.g. i.MX8QXP, i.MX8QM).
> Add IRQF_SHARED flag to allow sharing the irq among several
> devices
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
