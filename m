Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915DFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 10:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 638882076B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 10:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597227404;
	bh=4FzYyW5JJNVBQO4GB8avNDtPRVKFwQlJedNUISU2tsE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=N1ZkQFKgA3CfMRjk78/tJA9vwI1UQxFQq6j7shiYBvNYYmq55FPkyh1+hFuMUfc7Q
	 t9nAXOWn9uaBc3c6JewwoJdH0z+GxPK8A27bC2rrbLdXgoPpVmqffMhEeGtqsdaRzR
	 tALt5YZoIPsNGM4qUpyuJZ8WI4PcfrgreHJxvXLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgHLKQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 06:16:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbgHLKQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 06:16:42 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A85B3206B2;
        Wed, 12 Aug 2020 10:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597227402;
        bh=4FzYyW5JJNVBQO4GB8avNDtPRVKFwQlJedNUISU2tsE=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=1dgB38ARzjRx/PgOGShQd/GmWjSnHlV3Xz0JgrmYSxmpl8tE+d4JV/xCtK8GQ8h14
         0LprerGEAt3dt0vddiE0IR2RXyCx4YdElutOvy0FJVQBf1Ma+h7ydZuMUNszm1RPIb
         RP6f1HJJYVq9olYriMZurPncvITiUAo1ZE6qVWPI=
Date:   Wed, 12 Aug 2020 11:16:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com,
        john.stultz@linaro.org, alsa-devel@alsa-project.org,
        stephan@gerhold.net
In-Reply-To: <20200811120205.21805-1-srinivas.kandagatla@linaro.org>
References: <20200811120205.21805-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 1/2] ASoC: q6afe-dai: mark all widgets registers as SND_SOC_NOPM
Message-Id: <159722736188.10105.1473595017449198199.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Aug 2020 13:02:04 +0100, Srinivas Kandagatla wrote:
> Looks like the q6afe-dai dapm widget registers are set as "0",
> which is a not correct.
> 
> As this registers will be read by ASoC core during startup
> which will throw up errors, Fix this by making the registers
> as SND_SOC_NOPM as these should be never used.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: q6afe-dai: mark all widgets registers as SND_SOC_NOPM
      commit: 56235e4bc5ae58cb8fcd9314dba4e9ab077ddda8
[2/2] ASoC: q6routing: add dummy register read/write function
      commit: 796a58fe2b8c9b6668db00d92512ec84be663027

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
