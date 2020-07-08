Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B7EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 20:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99A46206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 20:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drdq9olW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgGHUhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 16:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgGHUhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 16:37:54 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E4DC061A0B;
        Wed,  8 Jul 2020 13:37:54 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x72so11044405pfc.6;
        Wed, 08 Jul 2020 13:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ljcNt9Q9gyoQ+/Fb061cdO0nQmkXaUZAJJkPkHoUNac=;
        b=drdq9olWal5ez1y2TdJFej07GcBIeRMEANqTT0u7bHwUbCDF5jJ4SSdsxGbL/CnKId
         efhZJpESy1Jm6sWFCNDVk7HR821YBSOksd/azKBSTO9NEMfLh0XXeZ4a6CqgMEkTJ66r
         920mDi2yinUxrwXG+GQ36ZHgcXHMVUm7cGu5diO3R/ybDFZIdh1obuVR+50M5nTJzPmE
         32vVvE3dK5IWytBsS2h9Ed1ESz3fASU0Z0bsOboJFmJuedsKS7T2R+Tw9sxOI0b43gjt
         h9h/fPIS5yrKydQZU8Xzfu4NePVJduC89xparXm98r6FAWjgxBaV16E3IeI3rNgpYYWm
         YxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ljcNt9Q9gyoQ+/Fb061cdO0nQmkXaUZAJJkPkHoUNac=;
        b=SIv5hecR9J9p2Tkq6nssPDmdsvCO1Ro6FcE59gNZ4fG9EtRew2MF1EiIOC9pRHrUk2
         jF8a/oYZBbLNhXvq2+hleAq5Fv/Lud3KgE3R8RMindSIOoJJV1RpevBG3l2WnF4urLyj
         M08VrMcERUr7IjTSQ0PiR7IVrYIIpEpbBM2GWti/oWsIAqVWrcse/AGhi68tL9nrCCu6
         L/2f7rQttCxZgcGO1xAUCyfPpXhnWlI7ZrIzcrPRDYf89hLGloNPTX9d2m6A4MjkKCgx
         wSbfiL1J/hwBvUwpOZJlbD9TAGeytzwC0o21Y5dStE3jBMIlqP8rKVy/34bPvm9p7AOm
         skaA==
X-Gm-Message-State: AOAM530Zcop6RzFIwtJYhD4qM8Dg1iHO2fWcpqTkl3/kPmc9ETh/pdu5
        UR8rJn6aphIgQUqBA6mhCEI=
X-Google-Smtp-Source: ABdhPJyPrtwfQkvn91VaFePjHd+mmgPxNNRCW36/D+GYnL7TWzlB+XRW8gav2TLMpTbep6hsFpiA6A==
X-Received: by 2002:a62:140e:: with SMTP id 14mr11831620pfu.196.1594240674079;
        Wed, 08 Jul 2020 13:37:54 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id u74sm573275pgc.58.2020.07.08.13.37.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Jul 2020 13:37:53 -0700 (PDT)
Date:   Wed, 8 Jul 2020 13:37:40 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Krishna Reddy <vdumpa@nvidia.com>
Cc:     joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        robh+dt@kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, yhsu@nvidia.com, snikam@nvidia.com,
        praithatha@nvidia.com, talho@nvidia.com, bbiswas@nvidia.com,
        mperttunen@nvidia.com, nicolinc@nvidia.com, bhuntsman@nvidia.com
Subject: Re: [PATCH v10 2/5] iommu/arm-smmu: ioremap smmu mmio region before
 implementation init
Message-ID: <20200708203740.GD28080@Asurada-Nvidia>
References: <20200708050017.31563-1-vdumpa@nvidia.com>
 <20200708050017.31563-3-vdumpa@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708050017.31563-3-vdumpa@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 10:00:14PM -0700, Krishna Reddy wrote:
> ioremap smmu mmio region before calling into implementation init.
> This is necessary to allow mapped address available during vendor
> specific implementation init.
> 
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>

Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>
