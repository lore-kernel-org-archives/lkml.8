Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AE3C55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 15:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F09F420661
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 15:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588001924;
	bh=MoIe11DQSWtChVptu/m8TuymgTP9ioN5hAFwu8OcYcg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=0UDJfNvXm86p9J79qpQb3aVsjzcgBiZ37Jxb2UXesfC6ml8jejGyv9oz8+ji8e4Gb
	 MwS8J7lnEvOKMNPBgjjWzkpVZaQLIE/F3po1zHNTmGnBi72aZoNb7uvxEvnRDOfTYD
	 NejdjtNX7BOQiW0IPz8r6yYGezyzC4LZa+EYd3Bk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgD0Pin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 11:38:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbgD0Pin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 11:38:43 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 593D820656;
        Mon, 27 Apr 2020 15:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588001922;
        bh=MoIe11DQSWtChVptu/m8TuymgTP9ioN5hAFwu8OcYcg=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=wLDDt+GptShmRbKn29dgwTGGpPlHiDyZWHlmkcXA/DyRzOxaHrye6x8lnW8RMqF/k
         5T1EvfNrXWHjK55ISLZr6xNqyS6yzY+cAJaIGd80hpdCWiI4lnZbcADvyBwCbDjSHf
         l4sd383PU3tO4tK4zALWqYuJjyk2JQja6WL0mgeI=
Date:   Mon, 27 Apr 2020 16:38:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     Nehal-bakulchandra.Shah@amd.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
In-Reply-To: <1587844788-33997-1-git-send-email-sanju.mehta@amd.com>
References: <1587844788-33997-1-git-send-email-sanju.mehta@amd.com>
Subject: Re: [PATCH v2] spi: spi-amd: Add AMD SPI controller driver support
Message-Id: <158800192031.8067.12914149173076417179.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Apr 2020 14:59:48 -0500, Sanjay R Mehta wrote:
> This driver supports SPI Controller for AMD SOCs.This driver
> supports SPI operations using FIFO mode of transfer.
> 
> ChangeLog v1->v2:
> 	- Fix up to handle multiple receive transfer case.
> 	- move chip_select in transfer_message, flag device as
> 	  half-duplex and some cosmetic changes.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.8

Thanks!

[1/1] spi: spi-amd: Add AMD SPI controller driver support
      commit: bbb336f39efcb1b5498f65f59f9af5773ad6dc2b

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
