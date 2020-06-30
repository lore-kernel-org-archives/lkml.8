Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C822C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 00:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E996F206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 00:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oI50TMe2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgF3AUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 20:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgF3AUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 20:20:21 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043F7C061755;
        Mon, 29 Jun 2020 17:20:20 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l63so9059649pge.12;
        Mon, 29 Jun 2020 17:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FWK3DfhYfO3UHL4cxXA6Y0Ld3ensf1xyhgg8G+yWtcI=;
        b=oI50TMe2xBfOzc2M0pHo5fT0QTa2wegSrqG3zYGoEyAkDSI0e0QE3MM6rwT3oiC709
         KrTrfPNNGZ5nITh7cbqTtW85whu6QeWHc3gX8l98IdxZQhOW6wzJUBsgNmf0J48kpl8L
         tTj8OqyPkLrGUsQUgfISUR83GbUHSS0oFu5YR/fSjo+A4LXKB/2HHeVUiI/nULf1E96S
         WWgsa3VDgw7Ko90vklLUbSaRp1QF8WBu1BRlNhwivnLNMKEAPNcDOUwO6jeG2HfnVcLP
         0C3Ltb80596GA9SZ4GCLK6KqC7n7baElPDg3rbev7jwqZ4FhHF1EEB+0oo28YlL5LyEr
         Ya1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FWK3DfhYfO3UHL4cxXA6Y0Ld3ensf1xyhgg8G+yWtcI=;
        b=tEAGT99yZBCZHfS/I0EVowXfXZANQpurJeUBWzVxRt/+Iu/DhB9gJEo0KTUoZbMOOR
         aUYn7MQKX9UvDHd4NNtA+ysFdKvSkoQKO0jSVGtpeMTbw3F20a7UhwSICBNyiqlmOhmM
         DgNu/70tCKyFzc9hKOTlhJ5XEcRkPdE1/zg5xYLFcGOf8R8k1HwvAMOuM4fRtf2Kop3w
         TVH7hOqVe6AH7wr4q6GADwr7OJDsu9CrX4fr3F1MroBoHx8BpQYl5rA8BTF0wvDxQ+eP
         G+T1IvHBtEn4aRU+OdS9p0W820908ZyK9MwCqnSxG/GShgt6zPvJ0Uvxl6nbUn7eyTBW
         xJDA==
X-Gm-Message-State: AOAM531MCk2kuBrTMDNQ4sPjBU/SMXBAVlYVTXikeC/uM0Qb04ceU+mQ
        njACRTlLuMLKWyuX1e8liEU=
X-Google-Smtp-Source: ABdhPJyAivB5SKR3ucS3Ljurs/kgEQoxUcVTCRr2JfoIE5sQKZeOxCi0wuNgvi31rmjNjG3nBWmmoQ==
X-Received: by 2002:a63:525a:: with SMTP id s26mr12250066pgl.155.1593476420411;
        Mon, 29 Jun 2020 17:20:20 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id f6sm715556pfe.174.2020.06.29.17.20.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jun 2020 17:20:20 -0700 (PDT)
Date:   Mon, 29 Jun 2020 17:19:47 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Krishna Reddy <vdumpa@nvidia.com>
Cc:     joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, treding@nvidia.com, yhsu@nvidia.com,
        snikam@nvidia.com, praithatha@nvidia.com, talho@nvidia.com,
        bbiswas@nvidia.com, mperttunen@nvidia.com, nicolinc@nvidia.com,
        bhuntsman@nvidia.com
Subject: Re: [PATCH v8 3/3] iommu/arm-smmu: Add global/context fault
 implementation hooks
Message-ID: <20200630001947.GB7427@Asurada-Nvidia>
References: <20200630001051.12350-1-vdumpa@nvidia.com>
 <20200630001051.12350-4-vdumpa@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630001051.12350-4-vdumpa@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 05:10:51PM -0700, Krishna Reddy wrote:
> Add global/context fault hooks to allow NVIDIA SMMU implementation
> handle faults across multiple SMMUs.
> 
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>

Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>
