Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE0FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 12:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C61232081A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 12:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591966754;
	bh=MOisnVR7xN196Vij8YxIMm0XOUOnJWc3H0WUG7ZRCII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UD1OHPVQxyY0ERDar4fqAVMdNEchwko+LRjT+nf08nEkSIdEnuEtQBhFWytUu7JMS
	 LYTz8jyW2Bw/tw2EBtKDAVgHKe8BFzKj3v8Pw2u4ooQxDZI/58QpuUQXuBamWetHFt
	 26KCDmf4xk9P/3Qi6I9jA80HRe3kgs51RUpHF2QI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgFLM7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 08:59:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgFLM7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 08:59:12 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9EF120792;
        Fri, 12 Jun 2020 12:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591966752;
        bh=MOisnVR7xN196Vij8YxIMm0XOUOnJWc3H0WUG7ZRCII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kQsq7JozANtrHKWLEFccqZ89ztT9sqw2oRX2EqEwJbncOTSnQP8cp0wnGtV1rAplx
         wAw6BBieie+gUNDWzcacm30OttEHw7HyE6gd27PwDXGYDMCCiF4SB73sZsljKZ18ok
         7CDQCvAj5yWKKxh503YfDlqUCFha0CFkv3V4eXH0=
Date:   Fri, 12 Jun 2020 18:29:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 1/2] ASoc: q6afe: add support to get port direction
Message-ID: <20200612125907.GG1393454@vkoul-mobl>
References: <20200612123711.29130-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612123711.29130-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-06-20, 13:37, Srinivas Kandagatla wrote:
> This patch adds support to q6afe_is_rx_port() to get direction
> of DSP BE dai port, this is useful for setting dailink
> directions correctly.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
