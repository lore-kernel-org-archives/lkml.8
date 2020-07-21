Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B82C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C121820792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hVhAHlWj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbgGULwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:52:45 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14261 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgGULwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:52:45 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f16d6950000>; Tue, 21 Jul 2020 04:50:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 21 Jul 2020 04:52:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 21 Jul 2020 04:52:45 -0700
Received: from [10.25.101.238] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 Jul
 2020 11:52:38 +0000
CC:     <spujar@nvidia.com>, <rlokhande@nvidia.com>, <digetx@gmail.com>,
        <linux-kernel@vger.kernel.org>, <thierry.reding@gmail.com>,
        <linux-tegra@vger.kernel.org>, <swarren@nvidia.com>,
        <sharadg@nvidia.com>, <nicoleotsuka@gmail.com>,
        <viswanathl@nvidia.com>, <nwartikar@nvidia.com>,
        <jonathanh@nvidia.com>, <atalambedu@nvidia.com>,
        <mkumard@nvidia.com>, <dramesh@nvidia.com>,
        <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v5 00/11] Add ASoC AHUB components for Tegra210 and later
To:     Mark Brown <broonie@kernel.org>, <robh+dt@kernel.org>,
        <lgirdwood@gmail.com>, <perex@perex.cz>,
        <kuninori.morimoto.gx@renesas.com>, <tiwai@suse.com>
References: <1595134890-16470-1-git-send-email-spujar@nvidia.com>
 <159525589435.6792.708136378511410418.b4-ty@kernel.org>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <72d45476-7050-187b-19d6-2ddb9b0ba97a@nvidia.com>
Date:   Tue, 21 Jul 2020 17:22:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <159525589435.6792.708136378511410418.b4-ty@kernel.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595332245; bh=I7A23ZSDWorRZy3D4VQyChJjvsPD/dJJdKZBL01AyEU=;
        h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=hVhAHlWjK0Q60cjDRWNgeIlhcFJpQNO333aYgHZOCCeCWLvH9zsHW+xiu22sRg/+r
         qUPJTzg/eC+7GHo3Rk4CRbDSJbH6YEtLs3HWNoMgt1OUIf2VMqmt3Uu0Cqmo6xObOq
         wSjpcCcN6MdKHsyNmMieNBuXOYsb6b0LlvtgWJnr6HbpkCeCATqO68jhhdHX3vuaLe
         N6oj1m8kCUHNnWymeEArxb4n4QCI1jvYvgvijDHK9U159AFdPRD16FamIsXU/IJeqE
         nR6IAadACO3JLqykMd70eLNXo08sUtvLtRuwmgKbWE8P+d03Xr3fkELSZ54IEcG+MU
         s5YfcVms9ZWuA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 7/20/2020 8:08 PM, Mark Brown wrote:
> External email: Use caution opening links or attachments
>
>
> On Sun, 19 Jul 2020 10:31:19 +0530, Sameer Pujar wrote:
>> Overview
>> ========
>> Audio Processing Engine (APE) comprises of Audio DMA (ADMA) and Audio
>> Hub (AHUB) unit. AHUB is a collection of hardware accelerators for audio
>> pre-processing and post-processing. It also includes a programmable full
>> crossbar for routing audio data across these accelerators.
>>
>> [...]
> Applied to
>
>     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
>
> Thanks!
>
> [1/6] ASoC: dt-bindings: tegra: Add DT bindings for Tegra210
>        commit: 665308c0b44a37339b9b3368f1dd61eb66acde87
> [2/6] ASoC: tegra: Add support for CIF programming
>        commit: 1c3b89fb7e4a78ddcd627e3f218a216e2136ae9b
> [3/6] ASoC: tegra: Add Tegra210 based DMIC driver
>        commit: 8c8ff982e9e2b2eb9255fc393f938915b0ddc127
> [4/6] ASoC: tegra: Add Tegra210 based I2S driver
>        commit: c0bfa98349d1796fe754dfac7f7f505bb60dcd83
> [5/6] ASoC: tegra: Add Tegra210 based AHUB driver
>        commit: 16e1bcc2caf446fa3e1daa040b59fd6f6272a766
> [6/6] ASoC: tegra: Add Tegra186 based DSPK driver
>        commit: 327ef64702668bb754eeea80ce402454d7a1302a

I see that "[PATCH v5 07/11] ASoC: tegra: Add Tegra210 based ADMAIF 
driver" is not applied as part of this. I wanted to understand if this 
is because some more review comments are expected or there are other 
reasons?

Thanks,
Sameer.

>
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
>
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
>
> Thanks,
> Mark

