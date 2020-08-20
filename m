Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11545C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 21:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBA1A2177B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 21:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597960123;
	bh=23yUEfhFOmQ/QJGKJF2s1PtUXf40Zt+kxozKC+ATEgk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=xQLVM3Szsb7bihjwaMEF+Id1l9AjXighXRRmRA/w22SvsndgjE97HmxYAxNdB/lEb
	 Z1JoCpbxHY55MWQ0WzXJVQGeMaNnLC3MvIhFu9QonjGc9njdl5KlZGFBRd96YRP6y4
	 qU/W0SgoEmG74NMkNhSlMCPy377XqB6Idgv3+dPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgHTVsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 17:48:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbgHTVsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 17:48:41 -0400
Received: from localhost (cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net [82.37.168.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EB8D2075E;
        Thu, 20 Aug 2020 21:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597960121;
        bh=23yUEfhFOmQ/QJGKJF2s1PtUXf40Zt+kxozKC+ATEgk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=lwaNkhwhgJpbE/zhVTfYZlNlh5BcgLwoBKqVYtgciUf+XphecrM4e40zZWnoPhWLr
         7LR9JTFTO6VfDbLvzPuUiDJm4fBse8n5dQQE45mqwRzNjQb/wxGiAHr1b4b98oZVQp
         gLXN8JhF5q2DsgDXOykirQXl1G7iYuLaKS2mwiRQ=
Date:   Thu, 20 Aug 2020 22:48:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>, matthias.bgg@gmail.com,
        robh+dt@kernel.org, tiwai@suse.com, linux-kernel@vger.kernel.org
Cc:     eason.yen@mediatek.com, tzungbi@google.com,
        linux-mediatek@lists.infradead.org, alsa-devel@alsa-project.org,
        howie.huang@mediatek.com, linux-arm-kernel@lists.infradead.org,
        shane.chien@mediatek.com, bicycle.tasi@mediatek.com
In-Reply-To: <1597913493-10747-1-git-send-email-jiaxin.yu@mediatek.com>
References: <1597913493-10747-1-git-send-email-jiaxin.yu@mediatek.com>
Subject: Re: [PATCH v6 0/2] Add mediatek codec mt6359 driver
Message-Id: <159796008815.44152.16317052982855858224.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Aug 2020 16:51:31 +0800, Jiaxin Yu wrote:
> Add mediatek codec (MT6359) driver
> 
> MT6359 support playback and capture feature.
> 
> On downlink path, it includes three DACs for handset, headset,
> and lineout path. On unlink path, it includeds three ADCs for
> main mic, second mic, 3rd mic, and headset mic.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: mediatek: mt6359: add codec driver
      commit: 8061734ab65498f4802578564fc0948ec9aaf933
[2/2] dt-bindings: mediatek: mt6359: add codec document
      commit: 539237d1c609c0fd23389369939b5cc93feb16fb

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
