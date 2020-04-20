Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7A5C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D57232082E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587394063;
	bh=e/ao3OPRg3Up068uO5kqAkXf43yc13CAhl2PZ2TOkIM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=NW65krNb8P2jo4DSvSRID/jgoZ4d5sUkekttHEsrT+Jo3prCKo5DJYl5yjZv3mv5n
	 keEt/w+TGhpGC99p5ifg9Y1oe4lT1jSKVVFLF86xQAudnhklBVx0DMLPU2AJE1YZCm
	 I9ZpiFXm+Rz1j+2QUKUA32YuVFAHRm3g1BXB+ZsI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgDTOrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:47:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgDTOrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:47:42 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B72B7206D5;
        Mon, 20 Apr 2020 14:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587394062;
        bh=e/ao3OPRg3Up068uO5kqAkXf43yc13CAhl2PZ2TOkIM=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Vw56rg/6N87yR7MAT8by2Fu4xlwJxlqMLtkikG1DE9IFNslimTgxEITfVfzgduasC
         +YswLy/JCnr2KrxRauu+IMMsWIEwQkaBObwfdoClILRmNFnIAjWKgmQ6JJrnBYA/vY
         3wj/dSg+RsTWcM709gcmi3m4k9D94L3w5DFfI1nE=
Date:   Mon, 20 Apr 2020 15:47:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Markus.Elfring@web.de
In-Reply-To: <20200420134647.9121-1-zhengdejin5@gmail.com>
References: <20200420134647.9121-1-zhengdejin5@gmail.com>
Subject: Re: [PATCH v2 0/2] use read_poll_timeout macro to simplify code
Message-Id: <158739405971.23005.4028325729913635797.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Apr 2020 21:46:45 +0800, Dejin Zheng wrote:
> Simplify implementation of regmap_read_poll_timeout() macro and
> regmap_field_read_poll_timeout by read_poll_timeout() macro, they have
> many similar codes.
> 
> v1 -> v2:
> 	- modify the commit comments by Markus's suggestion .
> 
> [...]

Applied to

	https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-5.8

Thanks!

[1/2] regmap: Simplify implementation of the regmap_read_poll_timeout() macro
      commit: e44ab4e14d6f4c448ae555132090c1a116b19e5c
[2/2] regmap: Simplify implementation of the regmap_field_read_poll_timeout() macro
      commit: 148c01d176237115d9c2805f6d29c0b6a72fbd10

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
