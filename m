Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7DFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE9A120663
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GOiXPa9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbgGGPfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgGGPfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:35:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0123DC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 08:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=qzBTvCbR+3OoqLjJh+mVqJ6CPDGK+xy5f5GtStO5FLY=; b=GOiXPa9L/WXfTTz6pZrK9bVvcX
        QqvRi9Wq9uU5OfHkGTF5gXQZ2jR/MvbXFqMZyo7U28bXpwRF0Auf1R6JCX744qWIFKIWNCHONaKpB
        MxRFZ5g1PIhl6BBMHClQdgpx3A0YH+J9ozM9X/g8lwmKIT+7g7yl1lsoEpegr1bzsov8AlH6dUZDb
        mw/YmIE2WjY1hS9vCHwa5KbuVThWhGvb+EHNSFJ1ud6undxa4hYDfbCY33ngqjbje4AbE5tnUKNsP
        y9s1Zc4jiImhlcnisWcqQych845UCGaEwEOsIZgl2KJEeL9IIYcBqxgHMpwwegBlspM8ktMQG6aUE
        oH48WPdw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jspdL-0005Sa-9K; Tue, 07 Jul 2020 15:35:47 +0000
Subject: Re: [PATCH] ASoC: amd: add ACPI dependency check
To:     Mark Brown <broonie@kernel.org>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        alsa-devel@alsa-project.org
Cc:     Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        hui.wang@canonical.com, Takashi Iwai <tiwai@suse.com>
References: <1594118813-18689-1-git-send-email-Vijendar.Mukunda@amd.com>
 <159413142467.34737.8485886141400585716.b4-ty@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <755e1c02-21d5-db66-0b52-42ad65888647@infradead.org>
Date:   Tue, 7 Jul 2020 08:35:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <159413142467.34737.8485886141400585716.b4-ty@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/20 7:17 AM, Mark Brown wrote:
> On Tue, 7 Jul 2020 16:16:41 +0530, Vijendar Mukunda wrote:
>> Add ACPI dependency for evaluating DMIC hardware
>> runtime.
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> 
> Thanks!
> 
> [1/1] ASoC: amd: add ACPI dependency check
>       commit: 68d1abe186d1c865923d3b97414906f4697daf58
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


Vijendar, you should have Cc-ed me on the patch and you should have
added this line to the patch:

Reported-by: Randy Dunlap <rdunlap@infradead.org>

Also, now
Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

although there are now 2 warnings:

../sound/soc/amd/renoir/rn-pci-acp3x.c: In function ‘snd_rn_acp_probe’:
../sound/soc/amd/renoir/rn-pci-acp3x.c:172:15: warning: unused variable ‘dmic_status’ [-Wunused-variable]
  acpi_integer dmic_status;
               ^~~~~~~~~~~
../sound/soc/amd/renoir/rn-pci-acp3x.c:171:14: warning: unused variable ‘handle’ [-Wunused-variable]
  acpi_handle handle;
              ^~~~~~



thanks.
-- 
~Randy
