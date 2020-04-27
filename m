Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1CEC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8D05206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588003844;
	bh=6y+UP73Vxjpn15HNvNYlaPBEXH1uzwIZb3nl5q1GqOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J/TbdKVR7v1GDh9pqTDPQhavOTRfGBJL+HC7lGkyh8Eah7OjguwAPowvcCsZ/wuEO
	 yiYUGuPyfmRuJUHhPWsLsZkMnlJRowktiGIpai6k/T1dr7MUraZjJTMEjwu7/u+GrF
	 oFxY7CVUwmeIawtpL5YftjSN6sscqyAojOXDAP/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgD0QKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:10:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbgD0QKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 12:10:42 -0400
Received: from localhost (unknown [171.76.79.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2FC8205C9;
        Mon, 27 Apr 2020 16:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588003842;
        bh=6y+UP73Vxjpn15HNvNYlaPBEXH1uzwIZb3nl5q1GqOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aR1yAoAqwS+RgrXbE1AAsuiTXEZV7W92AcrPzeyict0PPlEUiEHKWRkvmzMO4oKO1
         8t1vZ23bc52pz9LNTyHP2+DXUHAnnbaSQ9r7UrlG/lPkXnZN2nk3zjzIC/SsQo75Oa
         DMs/H54jSMbM7I0mxVYOer0nm3Bobcrh/qb1G+S0=
Date:   Mon, 27 Apr 2020 21:40:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pierre-Yves Mordret <pierre-yves.mordret@st.com>
Subject: Re: [PATCH 0/2] STM32 DMA Direct mode
Message-ID: <20200427161038.GJ56386@vkoul-mobl.Dlink>
References: <20200422102904.1448-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422102904.1448-1-amelie.delaunay@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-04-20, 12:29, Amelie Delaunay wrote:
> By default, the driver compute if the FIFO must operate in direct mode or with
> FIFO threshold. Direct mode is allowed only if computed source burst and
> destination burst are disabled. But with memory source or destination, burst
> is always > 0.
> Direct mode is useful when the peripheral requires an immediate and single
> transfer to or from the memory after each DMA request.
> This patchset adds a way to force Direct mode through device tree.

Applied, thanks

-- 
~Vinod
