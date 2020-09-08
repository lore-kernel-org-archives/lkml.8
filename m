Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0E4C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1609221D20
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599585772;
	bh=luI7DSIeuNgw2n7bHdR4GLN46L7NHNK8S2snlSCQbck=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=Tn3yqbX06O4q3M3CYKraKLrtTK6XettDpYm33MiNBcydZFrezd1zfSC5R+Wu/DIg0
	 AGNiGv+oBSidO3ERwlKXdGXx8PySBKfqIwGew4DVYPeiUwZeY7la1Zt0WGJ9v6eP/R
	 CF1s0ZZ3+B+TqFDiaWjIYn2EUJtWB0JsNaxFxUJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgIHRWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:22:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731777AbgIHRVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 13:21:52 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EB622087D;
        Tue,  8 Sep 2020 17:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599585712;
        bh=luI7DSIeuNgw2n7bHdR4GLN46L7NHNK8S2snlSCQbck=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=dFlnBsh7xLTYLjXPmcTtF99utgCGYMRv8WlLIvMvkiLdI/wr5bH2/bE+bHAjpmBxr
         +4jrbwjwD6njveoL9Vb4CJANBgwqdQMcxn6oyhC+Z4+7goB4r8UcUT9aoXjAImUEvN
         CPIieMIpKZQy3aF+488qeOCkXgX50/wQwUyo5vnA=
Date:   Tue, 08 Sep 2020 18:21:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ikjoon Jang <ikjn@chromium.org>, linux-spi@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Bayi Cheng <bayi.cheng@mediatek.com>
In-Reply-To: <20200826091852.519138-1-ikjn@chromium.org>
References: <20200826091852.519138-1-ikjn@chromium.org>
Subject: Re: [PATCH] spi: spi-mtk-nor: support standard spi properties
Message-Id: <159958565716.16771.18117309566354827719.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Aug 2020 17:18:52 +0800, Ikjoon Jang wrote:
> Use default supports_op() to support spi-[rt]x-bus-width properties.
> And check dummy op's byte length instead of its bus width for output.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-mtk-nor: support standard spi properties
      commit: a59b2c7c56bf795cc13139d2634e86a3da7a0314

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
