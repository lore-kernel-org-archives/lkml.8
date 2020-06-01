Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE5BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 11:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE215206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 11:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591012448;
	bh=f1z5/uW7OBRBVZllAkVJhq6872SeGT8gUyZERTleOAw=;
	h=Date:From:To:In-Reply-To:References:Subject:List-ID:From;
	b=x1Z6e0h3hi57nLIL/XY0kE1VerAv5E9axc9CBejmOrQNFIcZHe2YicGiq/DsXsroe
	 mCCaYZ26VcnCTjNIoXTsl1b9ruauK6O0DRyXNpupkAUbYrayUmMDV3JA/0jzeAJn8p
	 91FQ61KLT2fEYsOZt9JbDJfBLsuwZ1jQStjWL1mA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgFALyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 07:54:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgFALyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 07:54:07 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A75E2074B;
        Mon,  1 Jun 2020 11:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591012447;
        bh=f1z5/uW7OBRBVZllAkVJhq6872SeGT8gUyZERTleOAw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Iof3SXVW4E4gSSv7uKiW7WUxkCPa8vWNEgAYIFFP1pG/EwCnf9IHr6uFCOSc5eiSd
         cswU0T3EQUGOH6jA5t9Y+lZa4fXPRpUcbXI4zRlpDXGGLJnZaoFDaollQCRkfyAQML
         CFx1gtQuQRdIhUyUF3JknQRdqcNL4cym/Hal2VSQ=
Date:   Mon, 01 Jun 2020 12:54:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jens Thoms Toerring <jt@toerring.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20200529192538.GA28402@toerring.de>
References: <20200529192538.GA28402@toerring.de>
Subject: Re: [PATCH v3] regmap: fix alignment issue
Message-Id: <159101243960.15463.1377112309975182507.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 May 2020 21:25:38 +0200, Jens Thoms Toerring wrote:
> The assembly and disassembly of data to be sent to or received from a
> device invoke functions (regmap_format_XXX() and regmap_parse_XXX())
> that extract or insert data items from or into a buffer, using
> assignments. In some cases those functions are called with buffer
> pointers with odd addresses. On architectures with strict alignment
> requirements this results in a kernel crash for u16 and u32 values.
> The assignments have been replaced by methods that take alignment
> into consideration.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: fix alignment issue
      commit: 53d860952c8215cf9ae1ea33409c8cb71ad6ad3d

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
