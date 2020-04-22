Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC59C5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C1B020787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587559789;
	bh=D0DIFr1aVjuBuTpH7iONFJlAh5QTeFnsV5WpsD99GHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R6CuBfRPVb4GhieG2VLlQu4h3QrQ8YRThPIosowQ+etcu8TwDKCCgetHFzjFtlObk
	 LRLhFlGDeTKgN0++7mPtcK4UCeHcKjks2C5bT1vaoZKB0gcP3FLmYk9ceKazZP0PSA
	 hu4VZOUKYLSmARzj2RtumXHrR3+7VeVoTlcSznxA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgDVMts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:49:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbgDVMts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:49:48 -0400
Received: from localhost (unknown [171.61.101.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20C8120787;
        Wed, 22 Apr 2020 12:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587559788;
        bh=D0DIFr1aVjuBuTpH7iONFJlAh5QTeFnsV5WpsD99GHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iB50mrcmKPaHRvXYck/fl8KNMINR+IZcis13+lmD8pOaU6gismfl6Ttl0TxQVK0lN
         UHmOF7u89DXtdWhNCLr3cFPtVtUQ/xk3HFKtSVlmf7RKc4VxYJdRVfmE5xkv45lhZg
         CtHfqx/H6SsqeL+rs/jOqKu5kToclnntvn7vlHLs=
Date:   Wed, 22 Apr 2020 18:19:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: qcom: c630: fix asm dai setup
Message-ID: <20200422124942.GO72691@vkoul-mobl>
References: <20200422102044.8995-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422102044.8995-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-04-20, 11:20, Srinivas Kandagatla wrote:
> "direction" property is only valid for asm compressed dais,
> so remove it for non compressed dais

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
