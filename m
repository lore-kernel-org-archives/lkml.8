Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F83C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 15:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02AD6207D8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 15:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593098556;
	bh=T9T+XktWc/y/agyyR157EduSdla1lMbIrZ9U4CWPXpU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=OKzpfxk5p0iRs3VNF5zkzqkyKRdgLpl5pn8DbjZ9Z9gUEL1Hbo9bjcX23MH26VDUX
	 C2k30gEvSByNvbzvcpOTV7QxV1xhCmXXihC3wtoAkg69hYqlohkESTOs/H5tZpa6Kf
	 d/Qp7i3MzEcuL7N4inYS81kies9tvm0V+KboZF2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405758AbgFYPWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 11:22:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404580AbgFYPWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 11:22:34 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7EEE207BB;
        Thu, 25 Jun 2020 15:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593098554;
        bh=T9T+XktWc/y/agyyR157EduSdla1lMbIrZ9U4CWPXpU=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=VACbpW0TlzpKwtu5sHRWEuIBX5MMJzn5jTIAz2rqpvyqz2wAm5XZrzjiFXgtKAtWB
         QcYofTIWlmOWkjbFRT8zzFRCcp4ofUUYhrC2J6m9MwGp2d0QVqzsAQ+5QBOYNxC7R9
         lvDmnB6BNaAXreDqZQqghWrsiC5XzMg8l68aplV4=
Date:   Thu, 25 Jun 2020 16:22:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Seth Forshee <seth.forshee@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Support Opensource <support.opensource@diasemi.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20200624171010.845271-1-seth.forshee@canonical.com>
References: <20200624171010.845271-1-seth.forshee@canonical.com>
Subject: Re: [PATCH] regulator: rename da903x to da903x-regulator
Message-Id: <159309855196.31078.16845028603750026381.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jun 2020 12:10:10 -0500, Seth Forshee wrote:
> This module shares the same name as its parent PMIC driver, which
> confuses tools like kmod. Rename the regulator driver to avoid
> such problems.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: rename da903x to da903x-regulator
      commit: f16861b12fa05717489e0c8fbe93a0b9346a6839

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
