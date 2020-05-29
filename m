Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF27BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 17:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BE9720897
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 17:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590772724;
	bh=4mxOlAMlrg9LOuBVaJ3Lv63Dwxs9nV/mEb4tMFkxJgw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=DFrWoQaNPDd/XXXjYvX9Gare+OyJeIK+9X/zCT+F0T7+7jokWdGaubSpSU50TRc18
	 T+Syq3JN/DMJz5jV+/6QZ7KN+TD4g4OH+CiDTShM3zwo9pVVSTcYGVkuAtmVdzt68U
	 AXrfn2ZpWIfGYbw8fDUDXZAXN3BC+er5Owoub/tE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgE2RSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 13:18:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgE2RSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 13:18:43 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B9BD2074D;
        Fri, 29 May 2020 17:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590772723;
        bh=4mxOlAMlrg9LOuBVaJ3Lv63Dwxs9nV/mEb4tMFkxJgw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=yDnEn002K6KwchpFjotldajIe+XsklIQxLjooaQAfTmiJQaLFkNQpsnnXxrRWA/hM
         we6k79QKxDHizz+AdRymGN1R4SX+nVldVnWGN0jL4gdZIDmQpv9R51nr97O6mzSkHx
         cJJ5IoZnE5uctXhjLWv0GhyoTFmawqiU01cSQ1i8=
Date:   Fri, 29 May 2020 18:18:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        liang.j.jin@ericsson.com, Sergey.Semin@baikalelectronics.ru,
        lars.povlsen@microchip.com, andriy.shevchenko@linux.intel.com,
        fancer.lancer@gmail.com, robh+dt@kernel.org
In-Reply-To: <20200529155806.16758-1-dinguyen@kernel.org>
References: <20200529155806.16758-1-dinguyen@kernel.org>
Subject: Re: [PATCHv4 1/2] spi: dw: add reset control
Message-Id: <159077271266.17043.7681179786954514180.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 May 2020 10:58:05 -0500, Dinh Nguyen wrote:
> Add mechanism to get the reset control and deassert it in order to bring
> the IP out of reset.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: dw: add reset control
      commit: 7830c0ef26cb73b653c2db2f3ca7be08f44fa046
[2/2] dt-bindings: snps,dw-apb-ssi: add optional reset property
      commit: 2604d48702fe14fb3e97701269dd5e66b392b904

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
