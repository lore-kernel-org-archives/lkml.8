Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9D9C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33A062054F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598539765;
	bh=aF7rWnhp5gUP5XrpErbK4HkQ8c+qptsAiVedxz/Iudw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=iDtxDxUmFyAAN5jtol7MqPOdy4nITDjcVj1FPlcvN2CwZbiLdRgRD/KsLa8RBNN3z
	 SUg4BPRuhempuVf9ND4Mm4W0cTQ+v6VIYUCuc3odzmbuST1vRO1ATBN+gFOVxeXzbX
	 bjLVhLZ3cYXjju2YIVXbxD0ZhaWo0OdQ3ce4Ud4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgH0OtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:49:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728177AbgH0N6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:58:20 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6318C22BF5;
        Thu, 27 Aug 2020 13:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598536674;
        bh=aF7rWnhp5gUP5XrpErbK4HkQ8c+qptsAiVedxz/Iudw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=a6YI6KgyR2y88a3nRqf6Nb/AuEcuXmAiFXmpL9HJVa2v7NprHFfusDs0DsYdJ85cL
         Lq4yItq4h5YvQ3n7wBJ6qlHAPwRUm9iDrJ8cdo9DBM5Vc5lQcaNWLVUCqCzz8jv5r0
         M8yT2dEvXm5iqqftsZnbXEs5ittx19IGCggp1xfw=
Date:   Thu, 27 Aug 2020 14:57:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Piyush Goyal <piyushgoyaliit@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20200827133419.36151-1-piyushgoyaliit@gmail.com>
References: <20200827133419.36151-1-piyushgoyaliit@gmail.com>
Subject: Re: [PATCH][next] regulator: mt6360: fix spelling mistake: "regulaotr" -> "regulator"
Message-Id: <159853663810.29977.11973693705417715617.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Aug 2020 19:04:19 +0530, Piyush Goyal wrote:
> There are some spelling mistakes in two dev_err messages. Fix these.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: mt6360: fix spelling mistake: "regulaotr" -> "regulator"
      commit: 18ccf8b9f8645e82c65c8c9c9095f456a4eb56a3

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
