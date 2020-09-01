Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A920C2BD11
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 306F02078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598971988;
	bh=fCAv1y//4a6UC8MVETGKggnvPbFkFDYGouK55xIoJqo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=UZgF3JPd/ek5C4bS/6YhnxeyLcqYcvCg5wAT5GAPqnG8ahl+SRJSDCl09krg6dbTj
	 ErYdD4S9ZLX24c42WRNW7yHOCL5+dePYgug/kgki+v2ocAbVe66MNbCGZjqAP47wEk
	 wZ0hEx9IoMzv9eHQWax2Q4YPYMActJiI+00y5kvw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgIAOxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:53:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728469AbgIAOuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:50:51 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB76A215A4;
        Tue,  1 Sep 2020 14:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598971851;
        bh=fCAv1y//4a6UC8MVETGKggnvPbFkFDYGouK55xIoJqo=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=g4S0BMe/r8cu4FMwk0ntbalQbZsJaQSAhjHnAiabD+OgG0sBV2KQVfFMq+FF0NDV6
         054WFdeOA6VomWybTpZkwG0dvwGCXdVtM1injYU3jWjUld85qzz8zc93Q2UqHRzWLO
         XRYipEN0LwQx/gRIv6oBJ+2KgesA+KqvugcK5CEg=
Date:   Tue, 01 Sep 2020 15:50:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        linux-kernel@vger.kernel.org, cychiang@chromium.org,
        alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20200828162005.1.I4f67f494c4f759b0e5c7f487e040dfdcf16e0876@changeid>
References: <20200828162005.1.I4f67f494c4f759b0e5c7f487e040dfdcf16e0876@changeid>
Subject: Re: [PATCH] ASoC: rt5682: Prefer async probe
Message-Id: <159897179515.47719.15361648860135990824.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Aug 2020 16:20:27 -0700, Douglas Anderson wrote:
> The probe of rt5682 is pretty slow.  A quick measurement shows that it
> takes ~650 ms on at least one board.  There's no reason to block all
> other drivers waiting for this probe to finish.  Set the flag to allow
> other drivers to probe while we're probing.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt5682: Prefer async probe
      commit: 160c174ff6972bb56bf48ac3335297889839e1f1

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
