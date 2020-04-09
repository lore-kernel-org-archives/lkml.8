Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB0FC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 16:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19ACF2072F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 16:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgDIQyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 12:54:45 -0400
Received: from avon.wwwdotorg.org ([104.237.132.123]:48568 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgDIQyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 12:54:45 -0400
Received: from [10.2.51.79] (thunderhill.nvidia.com [216.228.112.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPSA id 98CCE1C0520;
        Thu,  9 Apr 2020 10:54:43 -0600 (MDT)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.1 at avon.wwwdotorg.org
Subject: Re: [PATCH v1 0/2] Support headset on Tegra boards that use WM8903
To:     Dmitry Osipenko <digetx@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20200330204011.18465-1-digetx@gmail.com>
 <5c9c995a-a571-e543-e680-30739cb1561c@gmail.com>
From:   Stephen Warren <swarren@wwwdotorg.org>
Autocrypt: addr=swarren@wwwdotorg.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <848cc6c5-e8e4-2796-3ee1-3e12a3e92c54@wwwdotorg.org>
Date:   Thu, 9 Apr 2020 10:54:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <5c9c995a-a571-e543-e680-30739cb1561c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/20 8:52 AM, Dmitry Osipenko wrote:
> 30.03.2020 23:40, Dmitry Osipenko пишет:
>> Hello,
>>
>> Some devices have a 4-pin jack instead of a 3-pin and currently the
>> WM8903 configuration is hardcoded to the case of 3-pin jack in the
>> Tegra's ASoC driver. A new device-tree property is required in order
>> to convey that hardware has a 4-pin jack, and thus, microphone's
>> detection needs to be done in a different way.
>>
>> In particular this is needed for Acer A500 tablet device that has
>> a 4-pin headset jack, otherwise userspace sees headset instead of
>> headphones and internal microphone isn't enabled by ALSA UCM rule
>> when it should be. Please review and apply, thanks in advance.
>>
>> Dmitry Osipenko (2):
>>   dt-bindings: sound: tegra-wm8903: Document new nvidia,headset property
>>   ASoC: tegra: tegra_wm8903: Support nvidia,headset property
>>
>>  .../devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt | 1 +
>>  sound/soc/tegra/tegra_wm8903.c                              | 6 +++++-
>>  2 files changed, 6 insertions(+), 1 deletion(-)
>>
> 
> Jon / Stephen, are you okay with this patchset? Could you please ack it?
> Thanks in advance.

It looks plausible based on commit descriptions, but I don't remember
the details of those APIs well enough to actually review the code change.
