Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE04C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEFCF20739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592233575;
	bh=85Zg12hlmggDcUFEqz7YM5wD8QE+kZiRdBC1+V1npKk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=Z2lYJqDUr7n1cFQcZcgcLjAn4H6pMWwYZYDoPwglPEnfLnutWqQhEKn6MzWhSh1sk
	 CurTIPqyubXps7BI7APm1VLfaqTyn98L/8JxmisygmSoatDlS9ztR7/sQ7WyKqwsyi
	 kwBXBJFz6rLFH9p68462sarocGh+w5COXeMyfqwk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730958AbgFOPGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:06:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:50696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730944AbgFOPGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 11:06:04 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FF3D20739;
        Mon, 15 Jun 2020 15:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592233563;
        bh=85Zg12hlmggDcUFEqz7YM5wD8QE+kZiRdBC1+V1npKk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=satWScQ7ePBhlvSbocIRPa4lENFNw4S6aaCSWReDRbwUH2Pb3tuyYeE002clooAJ2
         c9yPWQe4XqkNoDpepmr8xJGSdm8nLc92dVENKiZv5fdfcCFUNdmkU+4pZlqPdpRqHa
         7t1/xNIwP5WCEd7Iyws0g0RdA6X8Bh4FK9vvYha0=
Date:   Mon, 15 Jun 2020 16:06:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>, lgirdwood@gmail.com,
        Christophe.Meynard@ign.fr, Anson.Huang@nxp.com
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com
In-Reply-To: <1592171648-8752-1-git-send-email-yibin.gong@nxp.com>
References: <1592171648-8752-1-git-send-email-yibin.gong@nxp.com>
Subject: Re: [PATCH v1] regualtor: pfuze100: correct sw1a/sw2 on pfuze3000
Message-Id: <159223356166.9065.14796356122373184238.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020 05:54:08 +0800, Robin Gong wrote:
> PFUZE100_SWB_REG is not proper for sw1a/sw2, because enable_mask/enable_reg
> is not correct. On PFUZE3000, sw1a/sw2 should be the same as sw1a/sw2 on
> pfuze100 except that voltages are not linear, so add new PFUZE3000_SW_REG
> and pfuze3000_sw_regulator_ops which like the non-linear PFUZE100_SW_REG
> and pfuze100_sw_regulator_ops.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regualtor: pfuze100: correct sw1a/sw2 on pfuze3000
      commit: 6f1cf5257acc6e6242ddf2f52bc7912aed77b79f

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
