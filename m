Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E013EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADE5C20738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592915958;
	bh=brixnLgiNpjH3lbCFjImUCQDCfQaPq98NKVtSPD5vJA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=VbLp+D3rXBCfEShAVhB7QnxtzHZwwy8fz7V2JRabz0FDLsCy1f088bwEliy1/3cIT
	 g1olcDCz21Wj4HZRr/hWqqUm3Xe44RCqP+g3VJQXQP/nauMNCCo0pTYjBDccXAYXTq
	 HasUTv9dd6fLuQTbKbr1sDltX48e1a0bZRN12xmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732626AbgFWMjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 08:39:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:51168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729667AbgFWMjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 08:39:17 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F91E2072E;
        Tue, 23 Jun 2020 12:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592915956;
        bh=brixnLgiNpjH3lbCFjImUCQDCfQaPq98NKVtSPD5vJA=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=DEXpRMnyA0hN2nLrUQUaQAF5UuQu06hink2m06no9o2QauJNOvWSlAPXH34wfAyhg
         3rO/xsl7WYzuXhVEBXVvpQ9zbIyP8TqC2/jtsC0dRHE8dApgPH98buqhVxKW+G+bSP
         BUqAcNoe/vNA3m3usVZ/JQbWRbujlK4jWC+ouZ5Y=
Date:   Tue, 23 Jun 2020 13:39:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>, Xiubo.Lee@gmail.com,
        festevam@gmail.com, timur@kernel.org, nicoleotsuka@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <cover.1592888591.git.shengjiu.wang@nxp.com>
References: <cover.1592888591.git.shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2 0/2] Fix unchecked return value for clk_prepare_enable
Message-Id: <159291594453.44561.1878928339657994467.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jun 2020 14:01:10 +0800, Shengjiu Wang wrote:
> First patch is to remove the check of clock pointer before calling
> clk API.
> 
> Second patch is to fix the issue that the return value of
> clk_prepare_enable is not checked.
> 
> changes in v2:
> - split the patch to separate patches
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: fsl_mqs: Don't check clock is NULL before calling clk API
      commit: adf46113a608d9515801997fc96cbfe8ffa89ed3
[2/2] ASoC: fsl_mqs: Fix unchecked return value for clk_prepare_enable
      commit: 15217d170a4461c1d4c1ea7c497e1fc1122e42a9

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
