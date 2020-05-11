Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44653C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24788218AC
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589196539;
	bh=qMkiO+nWfOUzErqZNGHGc5Th27FIV5HW8D5tvjyuXHs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=oeWWxAfAzuBswFGdAZ+MZE0cH8F5Iw6nrSxHWO5ELouQoy/SKwoaau2K4B1nmBE8I
	 q4z+2yv1om87+jKixleTJfQF42XQLrYAtYvAiuukIUzuO+SylVvyrVV8w7C/cALrEB
	 v5rwXqaJiuPn77bsvVlCGwaTxI88crQjOzJt1F48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbgEKL26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:28:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729642AbgEKLZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:25:32 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C62C2082E;
        Mon, 11 May 2020 11:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589196332;
        bh=qMkiO+nWfOUzErqZNGHGc5Th27FIV5HW8D5tvjyuXHs=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=0oXMv+ETdO3rQxlCT0GO3lg73QBlXaBRcVjUnmUmVSboJLx5amHazoi5qvJWKDrRC
         zzEaPGumfz6VaPkcXFGWHOspaKif1CwGLM9rZiH91DnCeeV2pivO4KSRJcXUb7LItx
         EDEHzmf2oVptDj5bzZr3iOYblS4ZmO+DHjPHJI0Y=
Date:   Mon, 11 May 2020 12:25:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <1589185530-28170-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1589185530-28170-1-git-send-email-hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 1/2] spi: uniphier: Depend on HAS_IOMEM
Message-Id: <158919630590.8372.2120054682053294081.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 May 2020 17:25:29 +0900, Kunihiko Hayashi wrote:
> The driver uses devm_ioremap_resource() which is only available when
> CONFIG_HAS_IOMEM is set, so the driver depends on this option.

Applied to

   local tree asoc/for-5.7

Thanks!

[1/2] spi: uniphier: Depend on HAS_IOMEM
      (no commit info)
[2/2] spi: uniphier: Use devm_platform_get_and_ioremap_resource() to simplify code
      (no commit info)

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
