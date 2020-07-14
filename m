Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3558AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11F6322518
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594744783;
	bh=VXBDgTJLVKWPVuRwGZc/xyeARiY3XELOkWmvVP1dLgw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=N5ZH3qHjEaIbg8hBsM2YAwcXB5S8eRr5cHRR/IBMusjBRYDdlg8xxoCn8R4gs4zMz
	 D/AXKoexnHkvjXxIvfgsE90pZZRAVCyQMoOV4Md6NHgIhhlVIqnMmZcxefrKeA+rWE
	 dA0ukg9HiEiPXH0GhjOxFtNsVWmgypHqXB3lW3VQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgGNQjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 12:39:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbgGNQjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 12:39:41 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A501922475;
        Tue, 14 Jul 2020 16:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594744781;
        bh=VXBDgTJLVKWPVuRwGZc/xyeARiY3XELOkWmvVP1dLgw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=0DE1cZNs4i1Blxp5k1J4/D1Qca6QXL8nIgyyo5l/CQNesPqvFOquXf/Mhxd5T92iK
         YvKEKsmr4E5Isdg5UuWo5sRnRFAiX0OhUOWq0xK15h+le7tHVwU4+Lfg0sGi5eqfCD
         gR9s4bzH5q6X7pL80M4wavbK0v3o+H19pRKyHGMA=
Date:   Tue, 14 Jul 2020 17:39:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     - <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20200623113915.791386-1-yamada.masahiro@socionext.com>
References: <20200623113915.791386-1-yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2] dt-bindings: ASoC: Convert UniPhier AIO audio system to json-schema
Message-Id: <159474477218.998.6916116867302380188.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jun 2020 20:39:15 +0900, Masahiro Yamada wrote:
> Convert the UniPhier AIO audio system binding to DT schema format.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Convert UniPhier AIO audio system to json-schema
      commit: 3d04d1cc48838f9ae6617a97bbb2c16f06f01144

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
