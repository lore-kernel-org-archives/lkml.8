Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABF1CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A89523126
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589371857;
	bh=ItqlsvjtJFlnpbgopffGeZnbekcgqwy053JRaa7MfkY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=Az9Pc5Tq5L96IAglrGNJGRWV/Y8RMisuwYXtQcj64kXn1FJUklgKS3eKoyV/TH5Vt
	 kqEypNkOrMVsIhMnbdmOLtNGnmmVYZtBHjvZmvaHG+QB64p7itj+KMqu2Q/uvByLr0
	 pcfnwi/iJpqzyfvDuxntlBxiu7Du2uYDp5YPkyj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731777AbgEMMKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 08:10:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731067AbgEMMKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 08:10:54 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DA2A2176D;
        Wed, 13 May 2020 12:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589371853;
        bh=ItqlsvjtJFlnpbgopffGeZnbekcgqwy053JRaa7MfkY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=NIpeH8JINQ83+XQx9u9ruU//bUY+9ccuGn8MDn4Ge5JtUs7gMSahuq9UWWaAGjNaC
         nqWoVT7zmFuV5QFv6xYwkd5bsuu+uk2tDO2Wm2cOJ5kKJRUvXQvYLLbmwM+RImUte2
         8S529gVB5KTREkcygKx584jliyf6ifC7M6GHpctM=
Date:   Wed, 13 May 2020 13:10:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-spi@vger.kernel.org, linux-clk@vger.kernel.org
In-Reply-To: <20200512204543.22090-1-robh@kernel.org>
References: <20200512204543.22090-1-robh@kernel.org>
Subject: Re: [PATCH 1/5] spi: dt-bindings: sifive: Add missing 2nd register region
Message-Id: <158937185132.39109.17103954100758193517.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020 15:45:39 -0500, Rob Herring wrote:
> The 'reg' description and example have a 2nd register region for memory
> mapped flash, but the schema says there is only 1 region. Fix this.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.8

Thanks!

[1/1] spi: dt-bindings: sifive: Add missing 2nd register region
      commit: b265b5a0ba15b6e00abce9bf162926e84b4323b4

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
