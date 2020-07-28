Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE14C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F20A12065C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="E7W+DckP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732914AbgG1Tll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 15:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732905AbgG1Tll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 15:41:41 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14159C0619D2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 12:41:41 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id s16so15798885qtn.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 12:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+oJXyfHvcy53lAyO2fdrXkaj9azqIokLoWoIQ/55Cdk=;
        b=E7W+DckP4VNYWqoPpt1xhlyAhlYu7Xo/4QS4BiNfAW6ltpeIwoiAnbMTOOu/TDbRjJ
         BIEbmU3x1k1lafHKth0kXquy6xPqIpVbeOYBC4NuuS/lfpkqksjsCJUdopnj27+qHDyQ
         PJ4swEVv70ioK15U9NuZ9iroBkeaGScMGrpN+UrgaU1rTEFMZ7A6Yel3qhiQuSQn4K+i
         DudoVWgUNDjl7woLgoCxnFjTPRhyO8zE78qmOrP5XXmDIuDuMbBLiNQFRUMDYwgM0EPO
         WzFrQCios5hDSQWDsVuGkxHyUINc/avYOc2M4OZ4d9MwBpywy8416E9bVN72sBLMl17G
         ewRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+oJXyfHvcy53lAyO2fdrXkaj9azqIokLoWoIQ/55Cdk=;
        b=D5Fj/AxKPnoT3HrkHjXXQ6chS9hCEvCGZiXm3IFYxIIC9mmamn3qBVvkhCWEXQgXGf
         a/4DYgHow1dc2g0Det33+aiBs8nGcvWZqQwMdonsQi+ntqvAXMAeQrHR4uS9F6wSr3QO
         mHCMUm01eJS9bWVkHkbXjA1bo7fGGMSLR771osZN6xvMOhlo0v0E9c9GYh62jgjFaXgZ
         g7WPmz81SO363vIIhtc8fDW6YfKXVA2J7DSifxFJlIPcNTTSAhGrGtTRNoCN36hd5KWj
         aA+m9mi12GW/ekciuMdUfBpNmJLKRTNyHHpE9GSV4Z7fR/JI2aaGkVsCVLlPH65KzQEY
         KveQ==
X-Gm-Message-State: AOAM531ApzSlQ+QwlLwMHS7aLlv5ihljcj5Z7cj3xFQMPLnzYR9cTsb7
        QAD3Jpz/gC/XKiMEm46tNLGaQw==
X-Google-Smtp-Source: ABdhPJzaxob4ToiIvp8z+VCL9GUj97VjqHBiBkH19TsREcIHObH1Arz9UB6XAuSLPa4oBiqkiMAWDg==
X-Received: by 2002:aed:3387:: with SMTP id v7mr27254682qtd.318.1595965300334;
        Tue, 28 Jul 2020 12:41:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id p36sm20735569qte.90.2020.07.28.12.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 12:41:39 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1k0VTm-000fz5-Io; Tue, 28 Jul 2020 16:41:38 -0300
Date:   Tue, 28 Jul 2020 16:41:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 4/4] mm: mmu_notifier: Fix and extend kerneldoc
Message-ID: <20200728194138.GB24045@ziepe.ca>
References: <20200728171109.28687-1-krzk@kernel.org>
 <20200728171109.28687-4-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728171109.28687-4-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 07:11:09PM +0200, Krzysztof Kozlowski wrote:
> Fix W=1 compile warnings (invalid kerneldoc):
> 
>     mm/mmu_notifier.c:187: warning: Function parameter or member 'interval_sub' not described in 'mmu_interval_read_bgin'
>     mm/mmu_notifier.c:708: warning: Function parameter or member 'subscription' not described in 'mmu_notifier_registr'
>     mm/mmu_notifier.c:708: warning: Excess function parameter 'mn' description in 'mmu_notifier_register'
>     mm/mmu_notifier.c:880: warning: Function parameter or member 'subscription' not described in 'mmu_notifier_put'
>     mm/mmu_notifier.c:880: warning: Excess function parameter 'mn' description in 'mmu_notifier_put'
>     mm/mmu_notifier.c:982: warning: Function parameter or member 'ops' not described in 'mmu_interval_notifier_insert'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  mm/mmu_notifier.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks,
Jason
