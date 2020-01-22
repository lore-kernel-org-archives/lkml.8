Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588DFC2D0CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 00:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27FC221734
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 00:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DWQ4HXOB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgAVAQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 19:16:01 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53626 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728797AbgAVAQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 19:16:01 -0500
Received: by mail-pj1-f66.google.com with SMTP id n96so2196290pjc.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 16:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AJgdk09nXreBwR2XdsLZzQRBLyEn8ggTyXdPCR3F/pk=;
        b=DWQ4HXOBa9pQ0M8sOA2Sd3qHAHcrlQLTe2JrHuNdz18KafSyptiZE7RqdJi/nCE6IG
         FpDiVn9w1MZnBYJvWSzzypf5v6M01bQwGrYqlao3JIdjlsEFn5rHShH/fx9FBzUF/sfZ
         4hcAd/JPKjPr4VdY+eOfz3I9gQARiCYrK0HnLoVIHIqXL1cgky48U+sDQH7Db6cfu0zz
         iTsgpdf7nEzqo9kSNy6naBMnvp38FUVLLGtglkmirVKk2Q5S4K2B0yuG5iLqBeAab0Np
         7PxNVqIztcpaOp3Z2NTuCJ4unC6HnEmqoQoKKu4oZdfpoNNAnM4+F08JmOM6xoxdmQ+O
         Co2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AJgdk09nXreBwR2XdsLZzQRBLyEn8ggTyXdPCR3F/pk=;
        b=QE3zz6CshrZ1odUgmqSZyn7rYhJMq5+5tp3PuJwtvA0wQGMuQGut2Hsa6aU30mZYto
         5+JfMjTDtLn3ZreN21LwYm+P2gRJsqrOLx6dwCoxSrGx8uHJquMSaOvyF4/arT1ZczLb
         8r65Poe2fhAZbVzjb/lZUJZljxht2RnxOz/BbTyUfhn/Ww2PHyWNBi26lgwqy8SrL8/8
         qhkBJgSfMx6bZTdvRniBAW7JUKfC3XPbJzf/N/aCItTm8/wSBydtZWLtmi8PuNhYBsVs
         jGdnFkRyOoHOmGzk1UBYrLJzSQFaXvkpmOdmqaiJI18rVnCiQWII7PXI24TYa8LDK4F4
         n3cw==
X-Gm-Message-State: APjAAAVRyJ+sQRI/onwTnzN7kP3V1Wh6FRgiJHv2O8WaJJhdoFzS22cL
        3hsF4KJk2kNgdFcAMiR/cmB5uA==
X-Google-Smtp-Source: APXvYqzUsYiT/dSZn4sUaakbc/TkX3nd1S+XLUr4HIKJyKmXU3QpumWaw6v1tUH4lDO9g8GhOJEhcw==
X-Received: by 2002:a17:90a:f30d:: with SMTP id ca13mr1249187pjb.27.1579652160317;
        Tue, 21 Jan 2020 16:16:00 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u26sm42602678pfn.46.2020.01.21.16.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 16:15:59 -0800 (PST)
Date:   Tue, 21 Jan 2020 16:15:57 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     ohad@wizery.com, linux-omap@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 0/3] Some improvements for OMAP hwspinlock
Message-ID: <20200122001557.GC14744@builder>
References: <cover.1578453062.git.baolin.wang7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1578453062.git.baolin.wang7@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07 Jan 19:13 PST 2020, Baolin Wang wrote:

> This patch set did some optimization for OMAP hwlock controller with
> changing to use some devm_xxx APIs to simplify code.
> 

Applied the first 2 patches, thanks.

> Baolin Wang (3):
>   hwspinlock: omap: Change to use devm_platform_ioremap_resource()
>   hwspinlock: omap: Use devm_kzalloc() to allocate memory
>   hwspinlock: omap: Use devm_hwspin_lock_register() to register hwlock
>     controller
> 
>  drivers/hwspinlock/omap_hwspinlock.c |   45 ++++++++++------------------------
>  1 file changed, 13 insertions(+), 32 deletions(-)
> 
> -- 
> 1.7.9.5
> 
