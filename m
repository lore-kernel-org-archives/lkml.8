Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1286BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4F2220885
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593704817;
	bh=bD0aG0u2ZLlAlw0YpnmsiuaeOZz6sdBvO3e6Q8MM3uo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=wkWxdb0USvUq83W90wRvkUeki0MDi9O2BY9uR1cGrks8HdEOHYMcO0XwJQB5K6Z2n
	 GP5yGexi4jdiECRsh/QZWU27kOp45CvSLxlOY0enAx2F08LtUbe985tOvOQ/J6we+R
	 G+14l3JMYi8f9YlZMHfTHBbpsa3mmjuvh118ztcY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgGBPq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:46:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgGBPqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:46:54 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE28E2088E;
        Thu,  2 Jul 2020 15:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593704814;
        bh=bD0aG0u2ZLlAlw0YpnmsiuaeOZz6sdBvO3e6Q8MM3uo=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=o0HTj9G1/ZBtEaGmED0bJGtKMcdKVe2DG1IojutY2BfqSbgeCR/5rgVAllpo1ZJ/a
         YQ1fbsc8l2a1TS2qgpRB51X46ryq0fKfbbiWkBA/Mj+8QpFFQTCEGCNcQuhuO3B6Xh
         epEba2efedq643qOCpuZR3XFfP9MwjeHWY6crzq4=
Date:   Thu, 02 Jul 2020 16:46:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200702171304.68928e88@xhacker.debian>
References: <20200702171304.68928e88@xhacker.debian>
Subject: Re: [PATCH 0/2] regulator: add support for SY8827N regulator
Message-Id: <159370481231.5599.11109413621123086210.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jul 2020 17:13:04 +0800, Jisheng Zhang wrote:
> The SY8827N from Silergy Corp is a single output DC/DC converter. The
> voltage can be controlled via I2C.
> 
> Jisheng Zhang (2):
>   dt-bindings: regulator: add document bindings for sy8827n
>   regulator: add support for SY8827N regulator
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: add document bindings for sy8827n
      commit: 573016266e6767f7917feeda8e1e3b19673f4981
[2/2] regulator: add support for SY8827N regulator
      commit: 38fc6f295726366a0135ca87ab98f3ab92afd81f

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
