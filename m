Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F1CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 11:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4386720772
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 11:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591012443;
	bh=Z6/HOwnszRThPkaov002ejmLJMmfDqRW3FNyjto3D7w=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=IBxU5w5tLgbuv5IlYMOmoi8yAf6OXX3cdtDBWEwlinGSu6vJrjD1VbgfrznKqtXQ2
	 PEE5OoL2GEvhfif6HQpK0szh5IVVA9VOX4M/J51Z4KyzxAjRPOu31P64T3rTKDZzQ6
	 CmmOecGnaY/GRey3/pRIoO9s14VOLtA6jucN89nA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgFALyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 07:54:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgFALyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 07:54:02 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 434B2206E2;
        Mon,  1 Jun 2020 11:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591012441;
        bh=Z6/HOwnszRThPkaov002ejmLJMmfDqRW3FNyjto3D7w=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=zIASx6a7HZJKj6StIQ4R7Q5vrMSaU2sIw+dylGl5/xl53crAkUR6pgzdKjQBffvXg
         3m/4eXHtzGa6aAXgnRLgBOy34pS6AI4o5scaoN1hFBNPw6ljL7yXUb9B6Zcl1R94a0
         hJGHkCUWPO9ZLKZGCnTQjF8N0qatVRY5QppnEGv8=
Date:   Mon, 01 Jun 2020 12:53:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jens Thoms Toerring <jt@toerring.de>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20200531095300.GA27570@toerring.de>
References: <20200531095300.GA27570@toerring.de>
Subject: Re: [PATCH v4] regmap: fix alignment issue
Message-Id: <159101243960.15463.7213725042081680986.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 May 2020 11:53:00 +0200, Jens Thoms Toerring wrote:
> The assembly and disassembly of data to be sent to or received from
> a device invoke functions regmap_format_XX() and regmap_parse_XX()
> that extract or insert data items from or into a buffer, using
> assignments. In some cases the functions are called with a buffer
> pointer with an odd address. On architectures with strict alignment
> requirements this can result in a kernel crash. The assignments
> have been replaced by functions that take alignment into account.

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
