Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08070C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF4E920888
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592485757;
	bh=Wz8/bOunSjW5fydHgst0DIKygPVfQS4J/kwnhHQlihs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=a0DVi0Pzru+i8baaFBoaaKgj7Ptnc3RFXXtLQ6DinPFvo6vVO/Hh/QQW8tCvGbfx+
	 M2PxqJrQGRqT2QeB0OX1sV7qu5hu50EPgyaMzYVIP9AaR1+ziOErkq880q5cuuNp9r
	 g5q4ZkEVLb50yq/xpQg1VsEZXgm+i0fDX9Ur0jeg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbgFRNJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 09:09:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbgFRNJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 09:09:16 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FC4120707;
        Thu, 18 Jun 2020 13:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592485755;
        bh=Wz8/bOunSjW5fydHgst0DIKygPVfQS4J/kwnhHQlihs=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=sqTNnRwiIJ2ahkMXxnpiz373DvoGyA3TQdGseAAKA+kpq/zpJp8QjdqVDTgMgVuC5
         9NiQKthJcu+bzN8yRbIIqywYDPnfFnLM+ofTPsAPwhNywXx5endgDv6ufuBscXSAmz
         MWmGBaUUAEpxbFCilLZ0XCf3kEkE6i2K+2DU7EhI=
Date:   Thu, 18 Jun 2020 14:09:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     linux-kernel@vger.kernel.org, lgirdwood@gmail.com
In-Reply-To: <20200617223247.25566-1-rikard.falkeborn@gmail.com>
References: <20200617223247.25566-1-rikard.falkeborn@gmail.com>
Subject: Re: [PATCH 0/5] regulator: Constify some static struct variables
Message-Id: <159248575341.21561.10817745653684251777.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jun 2020 00:32:42 +0200, Rikard Falkeborn wrote:
> Constify some static struct variables to allow the compiler to put them
> in read-only memory. There are more of these, but I figured I could
> start small. Also, is one patch per driver a good resolution or too
> fine-grained?
> 
> Rikard Falkeborn (5):
>   regulator: anatop: Constify anatop_core_rops
>   regulator: cpcap: Constify cpcap_regulator_ops
>   regulator: ltc3676: Constify ltc3676_regulators
>   regulator: max8907: Constify static structs
>   regulator: max8997: Constify struct regulator_ops
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/5] regulator: anatop: Constify anatop_core_rops
      commit: cae62a937912bd4b3faf8e268cc0ffcf00ec5850
[2/5] regulator: cpcap: Constify cpcap_regulator_ops
      commit: bcf39c1eb1e059ec612bf06f4aa7b3972dcc85e8
[3/5] regulator: ltc3676: Constify ltc3676_regulators
      commit: b37f076d4bfdd29b3aa497480b226759f659e25f
[4/5] regulator: max8907: Constify static structs
      commit: b08af72d6e5319e96527816c4b3b08d0b1a6f242
[5/5] regulator: max8997: Constify struct regulator_ops
      commit: 9ed84d24de480e81294e00814c142234bc17ce0c

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
