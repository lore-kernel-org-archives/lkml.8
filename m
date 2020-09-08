Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3D5C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 641C3206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599560745;
	bh=4T4cYsTAaTqqTeL5uR3DM9l9gqIARL465lh/lL0fACc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PEhyEjIY1qHS8lPs/3d3vKg1OTdaozj9LlHpS5a3VUoilsdf5Eu/YslfyLPn8zXex
	 X++EsPuX2m66i1uXyatgSfxfRja9aqpZrtIdgCbe9cZIy6S/f6YBVYAHfLgQWo+unQ
	 D/3BwC3iKvotilSKUUH+9ZUfMWBuTl3zA5Q7Fjlw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbgIHKZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 06:25:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:35806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729372AbgIHKZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 06:25:39 -0400
Received: from localhost (unknown [122.182.239.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B2D920672;
        Tue,  8 Sep 2020 10:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599560739;
        bh=4T4cYsTAaTqqTeL5uR3DM9l9gqIARL465lh/lL0fACc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ePNFowFNixmF8ZqwqAQXMzElSQMOtja5FWVPZ49+BR6FsDwrC6UFWr9rHa5etZdBy
         4X+mKMCPddxC9uShvvU02I40sVD47SYS+z06RFQXxd3EEHEjPIH4YFDvR0mK/p3nkM
         mrQYi1B9KD7L/t1eKdCDidAsRhZX2V7Lh1HwcyRU=
Date:   Tue, 8 Sep 2020 15:55:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] phy: ti: gmii-sel: update to support multiport k3
 devices
Message-ID: <20200908102531.GC77521@vkoul-mobl>
References: <20200828201943.29155-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828201943.29155-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-08-20, 23:19, Grygorii Strashko wrote:
> Hi Kishon,
> 
> This series introduces support for multiport K3 CPSW devices like one, which
> can be found on J721E SoC (MAIN CPSW).
> The first two patches are preparation changes. The Patch 3 add support for
> retrieving number of ports and base registers offset from DT.

Applied all, thanks

-- 
~Vinod
