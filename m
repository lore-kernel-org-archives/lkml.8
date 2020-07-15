Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496D8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 05:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2470E206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 05:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594792526;
	bh=hXitGvBy4q4UxWhILLT47/NgtafkwUzAP82GjnYPK0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=03Kv77dWBwAJj3e9lc1JyLbGFtKyy3Z6JxBC+AtsbSV4uyz6+XVIdF1+HuNK9FlHt
	 bG6m90/irtGdjcSCf+QYvYT9ahvJbyyVvzmMsbAoqoV58kg0gMQI7SKeDwBYsjKM40
	 WkR4SQg7SJt6tiAGGTik3W0bBHrE8VRaixCViDpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgGOFzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 01:55:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbgGOFzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 01:55:24 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2182B20663;
        Wed, 15 Jul 2020 05:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594792524;
        bh=hXitGvBy4q4UxWhILLT47/NgtafkwUzAP82GjnYPK0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B/Q8NeOtpDqVK/keLWY37zAQuZvy6GGSrRLq0Lopr2JMQBozbK2pm7SKDNvbYz1Gg
         ExgEpLZSutlHb0+kTtxibb3V0XjcvUfNBe5SPr8q1digLS3m243JprW7fI0CTAJxHj
         YVjRAvSl6098idKtaD0XXO3lpVoEc5sZ0RFQU6Rg=
Date:   Wed, 15 Jul 2020 11:25:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sugar Zhang <sugar.zhang@rock-chips.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/14] dmaengine: pl330: Remove the burst limit for
 quirk 'NO-FLUSHP'
Message-ID: <20200715055519.GS34333@vkoul-mobl>
References: <1593439555-68130-1-git-send-email-sugar.zhang@rock-chips.com>
 <1593439555-68130-2-git-send-email-sugar.zhang@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593439555-68130-2-git-send-email-sugar.zhang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-06-20, 22:05, Sugar Zhang wrote:
> There is no reason to limit the performance on the 'NO-FLUSHP' SoCs,
> because 'FLUSHP' instruction is broken on these platforms, so remove
> the limit to improve the efficiency.

Applied, thanks

-- 
~Vinod
