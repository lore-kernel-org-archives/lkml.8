Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF9BC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 12:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3CFF2078D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 12:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599826918;
	bh=P+FSpMhRQYWfJVCQ83j/JR1HDo0aoiOL7Q9B8t2+jNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wQ7loxc4VW1xRE2O84OaehGhcgzQJgJ7nLPjKUHw72pbMqKFsyXN5VW92XZOurzi+
	 QBWHciT0xoTfRiHlWxNIdk9LxGh5QDAIbXVwIYJPA8m/cD0pSb6Ju3DGZrZbmfWjgo
	 Y39J+oO5uWRbvjd5tBN1ezGEl3273XnuH3OaH4rQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725710AbgIKMVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 08:21:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:59378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgIKMRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:17:17 -0400
Received: from localhost (unknown [122.171.196.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71CF821D40;
        Fri, 11 Sep 2020 12:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599826635;
        bh=P+FSpMhRQYWfJVCQ83j/JR1HDo0aoiOL7Q9B8t2+jNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KuAPW/VM1PxpeYQPg625T5U2dtwo563eZiKJULUnSIY+OaDncs2Qn/bs/5fOOxQwY
         wPhDjn9Az03BJx31K85xL/RIS4ER+CISzvk+6CvaFi7xXBjnZhJpM45l6TJe2m/3ZW
         YBNDGUItzmLXTGgT23U9Kqo9Ugkv1agJsRZV0Erg=
Date:   Fri, 11 Sep 2020 17:47:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, lokeshvutla@ti.com, nm@ti.com
Subject: Re: [PATCH v2] dmaengine: ti: k3-udma: Use soc_device_match() for
 SoC dependent parameters
Message-ID: <20200911121711.GB77521@vkoul-mobl>
References: <20200910124329.21206-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910124329.21206-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-09-20, 15:43, Peter Ujfalusi wrote:
> Use separate data for SoC dependent parameters. These parameters depends
> on the DMA integration (either in HW or in SYSFW), the DMA controller
> itself remains compatible with either the am654 or j721e variant.
> 
> j7200 have the same DMA as j721e with different number of channels, which
> can be queried from HW, but SYSFW defines different rchan_oes_offset
> number for j7200 (0x80) compared to j721e (0x400).

Applied, thanks

> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi Vinod,
> 
> Changes since v1:
> - mark the udma_soc_data for am654, j721e and j7200 as static
> 
> this patch is going to be needed when the j7200 support is upstream (we already
> have the psil map in dmaengine/next for the UDMA).
> 
> Since the hardware itself is the same (but different number of channels) I
> wanted to avoid a new set of compatible just becase STSFW is not using the same
> rchan_oes_offset value for j7200 and j721e.
> 
> Vinod: this patch will not apply cleanly on dmaengine/next because it is on top
> of dmaengine/next + the dmaengine/fixes. This might cause issues.
> 
> "dmaengine: ti: k3-udma: Update rchan_oes_offset for am654 SYSFW ABI 3.0" in
> fixes changes the rchan_oes_offset for am654 from 0x2000 to 0x200 and this patch
> assumes 0x200...
> 
> is there anything I can do to make it easier for you?

No worries, I have merged fixes into next and applied this. That is how
we typically handle this case

-- 
~Vinod
