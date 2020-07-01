Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685C6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 22:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E51220870
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 22:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593642244;
	bh=UOXPAuNZizHV54u2UlRgg0ZGPwJiEwjwXZbEWx49rQ8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=BCaO7JusNlfe9Al7yqcRqIyXcthympQ3Yqcz0c6HpRzSePN7+mUZ/OTJejdOaxmAG
	 +wfwyuUpP0RDdWSvA2s7LVGWoVMLSC/RgcoNtWUILcvC0yONpSFObiJFuX1sp30hS/
	 MELiNlAsvQCnJfbq/JY7O15hAG/IrTX6Eto6O13Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgGAWYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 18:24:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:50958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbgGAWYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 18:24:00 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC2F72082F;
        Wed,  1 Jul 2020 22:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593642239;
        bh=UOXPAuNZizHV54u2UlRgg0ZGPwJiEwjwXZbEWx49rQ8=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=XCO6yN0SOZdO4tHwPmSJ07OoXe1xfyEgg7TnarI9gzJtngKvGuDTDCsupZcuRMzpH
         LD/NGofIded1lWgJKb2W2wlGyy/3qwEO0OWMZIFkAd2l+ieXZCu21VOp0vOCnZodvR
         n2p+XBqIPL9sgwzepKz+9MqeFD7+8n10tmdjdzMo=
Date:   Wed, 01 Jul 2020 23:23:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, Wesley Cheng <wcheng@codeaurora.org>,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        mark.rutland@arm.com, robh+dt@kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        jackp@codeaurora.org, rdunlap@infradead.org
In-Reply-To: <20200626185516.18018-1-wcheng@codeaurora.org>
References: <20200626185516.18018-1-wcheng@codeaurora.org>
Subject: Re: [PATCH v4 0/6] Introduce PMIC based USB type C detection
Message-Id: <159364222729.10880.15242810692121676047.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jun 2020 11:55:10 -0700, Wesley Cheng wrote:
> Changes in v4:
>  - Modified qcom,pmic-typec binding to include the SS mux and the DRD remote
>    endpoint nodes underneath port@1, which is assigned to the SSUSB path
>    according to usb-connector
>  - Added usb-connector reference to the typec dt-binding
>  - Added tags to the usb type c and vbus nodes
>  - Removed "qcom" tags from type c and vbus nodes
>  - Modified Kconfig module name, and removed module alias from the typec driver
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: Add support for QCOM PMIC VBUS booster
      commit: 4fe66d5a62fbe1b050e783e7a01f986632c08c44
[2/2] regulator: Add dt-binding for QCOM PMIC VBUS output regulator
      commit: a824bab7c62d7ecd8ccfe9693da7ccb7e4683760

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
