Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006F7C5518C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF98F20787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587559863;
	bh=R8mR6GpMuum7Mx4R5xu3L8qN6++1a41Ocyl6ssZGeR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R5MSaup2u9Fkk7KHF7ZwBsL7/A4bE4As/JXiCtK5ZeaIbt8B9Ikoz/KTAHupxdgYt
	 Luc2UXw2difsMKOOlMZpLMkmuYa6/KNTDIInKBAq7/7GRt0X77c0n5+U5B6x0jpfsx
	 och3/jxg9HsJTb8rv9XwW+ghseolYuxVq2NkQcy4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgDVMvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:51:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbgDVMvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:51:01 -0400
Received: from localhost (unknown [49.207.59.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A01420787;
        Wed, 22 Apr 2020 12:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587559861;
        bh=R8mR6GpMuum7Mx4R5xu3L8qN6++1a41Ocyl6ssZGeR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O2YmO+Z57EikXuZrboqa2mTiCQVBTzI+TJCaZZemDw7141Sf/+MqTSUayZFgVIQ32
         8lXD64tcleJTi3s24zlJir79vcLq2ror9bjn0VUiy+w1QD/vaMyRnJJ94eVjIYbWuB
         c2eDi3MQ9HjyQAz4yNiQNJAjA4ekNGaspvFxm/AM=
Date:   Wed, 22 Apr 2020 18:20:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: db820c: fix audio configuration
Message-ID: <20200422125054.GQ72691@vkoul-mobl>
References: <20200422101922.8894-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422101922.8894-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-04-20, 11:19, Srinivas Kandagatla wrote:
> After patch f864edff110d ("ASoC: qdsp6: q6routing: remove default routing")
> and 9b60441692d9 ("ASoC: qdsp6: q6asm-dai: only enable dais from device tree")
> asm dais and routing needs to be properly specified at device tree level.
> 
> This patch fixes this.

Reviewed-by: Vinod Koul <vkoul@kernel.org>
Tested-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
