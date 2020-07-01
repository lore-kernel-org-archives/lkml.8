Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D5FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7CEB2074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPh75AsL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgGAH0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728142AbgGAH0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:26:40 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23942C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 00:26:40 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id b92so10659124pjc.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 00:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=45+p9qFF6DBDwyHUNuh+QjqxoDwCR18zLYMQyIvcnBo=;
        b=lPh75AsLe9G9ybYhjZkjxk6QZlN5KZi2Q8aPMoLW9Ib/96WKvOA7So89gFbDEC3bE5
         JOKqxdj2ALsDZ6EcXBy0GV8uHce1Z4Czt+mgdSXsSqj7fSz1JneQ5uy4AqU3+V16rITM
         ZLb7InkKLW/bcOCCrap2HkSIAyN8eOR+TUS/CjUa5aqqk8jc7LPW0/wcG2/i8EJVXEdB
         45x2gXb9pEnb8/V88ZXNEcV8bB3102hgj55xRN//hJf5Og1dGK9V9aBsf9yzce/mCOSh
         5+EWSa7MP31xaWZoBwNrPqxFoCN4Uz3oq4twHWXYbRAYD5eE275bvRTuyBSE8XK7RX5h
         8zBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=45+p9qFF6DBDwyHUNuh+QjqxoDwCR18zLYMQyIvcnBo=;
        b=tVYxXbEH6KUQ8Nd5U8eKsC21PqHksXiucUs32RlgOBy0Jh7BNEnUDTN7S1J5QEPXJf
         dv4usMRqbhnNytpUKRz4KCGVwgWOltszioX1KQdtlC0DCM1wrNVJQfSyoXhsV3X/pguE
         xCNNc4r/+KTummW+gwvXMAspGkq/CCnEI2rWZbDnEFX7aJsNIpwFs2Plnuamt3+5O5Cq
         sxsrvMfK45FbZ+hIKrbv4aq8eVx2XMIaPnzPDq83IRiPXGZoA+MHRjbcveaysDEq7wHD
         kSmLxN28vJEEms9j69rKZ1OpEH0Gxzwh3Zdkd5srhR2dFelERn/+TGPoU2dVux3D9Vme
         ysjQ==
X-Gm-Message-State: AOAM532MJfzp5uGd4lAoyvKpJuqB1+qOPrvKl+a9RqOaIGb0hX43CmK8
        v0EU4R8G2l7Uu9LYOZimCH4=
X-Google-Smtp-Source: ABdhPJytyFDyN/TwGZv+qVxhehOYWwLSsXhJW1Lqzbm2SjT/TlbF2UwIIvovKzYRSIAv1g/v1ARpMA==
X-Received: by 2002:a17:90a:d581:: with SMTP id v1mr26662363pju.33.1593588399632;
        Wed, 01 Jul 2020 00:26:39 -0700 (PDT)
Received: from Asurada (c-73-162-191-63.hsd1.ca.comcast.net. [73.162.191.63])
        by smtp.gmail.com with ESMTPSA id o12sm5123633pfu.188.2020.07.01.00.26.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 00:26:39 -0700 (PDT)
Date:   Wed, 1 Jul 2020 00:26:28 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ASoC: fsl_asrc: Add an option to select internal
 ratio mode
Message-ID: <20200701072628.GA9868@Asurada>
References: <1593525367-23221-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593525367-23221-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 09:56:07PM +0800, Shengjiu Wang wrote:
> The ASRC not only supports ideal ratio mode, but also supports
> internal ratio mode.
> 
> For internal rato mode, the rate of clock source should be divided
> with no remainder by sample rate, otherwise there is sound
> distortion.
> 
> Add function fsl_asrc_select_clk() to find proper clock source for
> internal ratio mode, if the clock source is available then internal
> ratio mode will be selected.
> 
> With change, the ideal ratio mode is not the only option for user.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>
