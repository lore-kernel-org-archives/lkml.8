Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A50BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C61320781
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AKN3YODj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgGVS4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 14:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgGVS4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 14:56:05 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36959C0619E0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 11:56:04 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id q2so3020103qkc.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 11:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8WNY2CxXZhFyfG36mcsmoWBP8jQf9E5iWxL+7JoT3QM=;
        b=AKN3YODj3oyzXTuDCkjFiRx0ubFOmPCQyRU7fSCndkoxtuG4njAUVt86VxdbEmeZWH
         nQUV6h5cPqeK7nkdDMlMAjFK6gbzsIvnHpks8GHXexeutGJsMkxN9hgnekcV3UpiFHUV
         qHlGyLUtb7QLXv1Fhih+NZHslV0yIvhUjuh24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8WNY2CxXZhFyfG36mcsmoWBP8jQf9E5iWxL+7JoT3QM=;
        b=Pwvj1GPLpe+0Y0sFr8nDdKWvMxKZfGHk5ZqPXp0PIf2NGfyq1mwUEqDiqFjBMDYNeH
         RG5NfAh4Dsb1ueBWsJx0yIIMxopJTp2/GmAiMzBVCv76HgWLidlPeeyhUePcWUn0IL3l
         S5vGhOSE3vGlsoNJwSBhXUV25/SQQCEZ2im/KdEBPrdrKETwj61P/5fXBsiqbOCx2CHN
         ma8TQsAf5meqYl6OgICPwcX2ixT+qP4JlU/LEM+JQh3f11zfPGKJSXIQ5JDyt6eK/0qS
         DGONrIoEoiBwIV9BUYa8lLMCQgHE7uCg3L9x8CudifHbfbMV3GP+PW/pqAmZ0OkqgfHj
         5FgQ==
X-Gm-Message-State: AOAM5320P7iLNQCqilF8JcCtBU4inkHsuTn1yi22kpLZJdQwpqbLjUWl
        wLUiy+JtjqXCHCkDiyBfKwrCdl/xD5nYLSNyHXRQ6g==
X-Google-Smtp-Source: ABdhPJwb65YS/eaVNn6Kf/wrD2aPtRHefUwDZ/rAHS4qc8uKXBuMDd+ibHTV4AgX/xTWLNRhJrW7AUkQcQer7DxWZ6g=
X-Received: by 2002:ae9:e641:: with SMTP id x1mr1422408qkl.424.1595444163106;
 Wed, 22 Jul 2020 11:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200722184358.GA15694@embeddedor>
In-Reply-To: <20200722184358.GA15694@embeddedor>
From:   Michael Chan <michael.chan@broadcom.com>
Date:   Wed, 22 Jul 2020 11:55:51 -0700
Message-ID: <CACKFLik4j4w-EHfJQt0-PA6O0FUp_Np8W4KaDwosQGL2niNP2A@mail.gmail.com>
Subject: Re: [PATCH][next] tg3: Avoid the use of one-element array
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 11:38 AM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> One-element arrays are being deprecated[1]. Replace the one-element
> array with a simple value type 'u32 reserved2'[2], once it seems
> this is just a placeholder for alignment.
>
> [1] https://github.com/KSPP/linux/issues/79
> [2] https://github.com/KSPP/linux/issues/86
>
> Tested-by: kernel test robot <lkp@intel.com>
> Link: https://github.com/GustavoARSilva/linux-hardening/blob/master/cii/0-day/tg3-20200718.md
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Michael Chan <michael.chan@broadcom.com>
