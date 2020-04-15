Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5CEC2BB55
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 23:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30AFF2076A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 23:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586993866;
	bh=7JQLMa1r9P+5uVg2RKaO1qFO4AfI5Die3TppthdAnqM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=RNH57FsXNBAGVn+0evrRij4JTJ0/4uNiQGTbs+Bbd/akTMKa4eVPeCNck43qXZm+u
	 nzvat92hlcSp4WMpRs6a0+LyzdfJDGZr8EU8El/jJSPyQ3VKSGelmShPOtkuA/8LWA
	 OQxq0ml3YNn8FuImLUGsP1AYZbqhG85NElS1doY4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389882AbgDOXhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 19:37:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389819AbgDOXgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 19:36:43 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 625832076A;
        Wed, 15 Apr 2020 23:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586993802;
        bh=7JQLMa1r9P+5uVg2RKaO1qFO4AfI5Die3TppthdAnqM=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=pgkkqn/A60JlXlGe4/ux04qhA+jIQ1y6X+N3KbR+YapQRZWkLg2Zgu2RAQSn88zFq
         ptHt/Fj6SVmkPrjVX31WW4XR1vC+t/bK9SMCVFfgbk6ikAuvU3yfqr6VvIxUT7Aown
         mUNfgwbxw0HChfa4WNUKWoDE+fdVc7vBEqS+qwDk=
Date:   Thu, 16 Apr 2020 00:36:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        festevam@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        shengjiu.wang@nxp.com, linux-imx@nxp.com
In-Reply-To: <20200409071832.2039-1-daniel.baluta@oss.nxp.com>
References: <20200409071832.2039-1-daniel.baluta@oss.nxp.com>
Subject: Re: [PATCH v2 0/5] Add support for SOF on i.MX8M
Message-Id: <158699320580.11316.13339627985998445155.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Apr 2020 10:18:27 +0300, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> This patch series adds support for SOF on i.MX8M family. First board
> from this family that has a DSP is i.MX8MP.
> 
> First 2 patches are trying to fix some compilation issues, the next two
> are adding the imx8m support and the last one adds the devicetree
> binding.
> 
> [...]

Applied, thanks!

[1/5] ASoC: SOF: imx8: Fix randbuild error
      commit: fe17e6cdc0fefca96ba9659be4b2b07487cbf0c5
[2/5] ASoC: SOF: imx: fix undefined reference issue
      commit: cb0312f61c3e95c71ec8955a94d42bf7eb5ba617
[3/5] ASoC: SOF: imx: Add i.MX8M HW support
      commit: afb93d716533ddef20fc70e626f7b43f204cb411
[4/5] ASoC: SOF: Add i.MX8MP device descriptor
      commit: 58825cc2253986ec3a4d0d67b8b4dc30945afb52
[5/5] dt-bindings: dsp: fsl: Add fsl,imx8mp-dsp entry
      commit: 35a0f242520520dfa1e8eaf66f20d297b12e413e

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
