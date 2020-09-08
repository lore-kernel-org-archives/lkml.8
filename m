Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35233C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA5862076C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="Yyq6Ui0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731595AbgIHRfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:35:18 -0400
Received: from mail1.perex.cz ([77.48.224.245]:41552 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731356AbgIHQOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:14:54 -0400
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 0E7ADA0055;
        Tue,  8 Sep 2020 14:29:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 0E7ADA0055
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1599568145; bh=kcosKIyrxTELi6uq9lm5YX5Xf7aTeUo9+Do1Y4+8o7A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Yyq6Ui0q4YG2pmBriEBkRh3OfsWE6UZbY2OMvWhq9BSGI/mDX5tCea3GCTGlkwn/F
         jFIVqT/doKfy+AXLz2tcg3Ca8tkusRYBr/Hkz9krWuDAgzChdfOYd34kvSzdQpLSXc
         8fGQBF5obyA01iRD542jYi17r5hbI3WxntPKBUN0=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Tue,  8 Sep 2020 14:28:48 +0200 (CEST)
Subject: Re: [PATCH 1/7] soundwire: bus: use property to set interrupt masks
To:     Mark Brown <broonie@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        tiwai@suse.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, srinivas.kandagatla@linaro.org,
        jank@cadence.com, mengdong.lin@intel.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20200818140656.29014-1-yung-chuan.liao@linux.intel.com>
 <20200818140656.29014-2-yung-chuan.liao@linux.intel.com>
 <20200828065125.GI2639@vkoul-mobl>
 <ec5fe867-f2e4-4278-0376-e54bcdd7f94d@perex.cz>
 <20200908121133.GA5551@sirena.org.uk>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <1950b662-ec59-6603-36c7-7a41d9e8460c@perex.cz>
Date:   Tue, 8 Sep 2020 14:28:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908121133.GA5551@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 08. 09. 20 v 14:11 Mark Brown napsal(a):
> On Tue, Sep 08, 2020 at 02:05:11PM +0200, Jaroslav Kysela wrote:
>> Dne 28. 08. 20 v 8:51 Vinod Koul napsal(a):
> 
>>>>  sound/soc/codecs/rt700-sdw.c    |  4 ++++
>>>>  sound/soc/codecs/rt711-sdw.c    |  4 ++++
>>>>  sound/soc/codecs/rt715-sdw.c    |  4 ++++
>>>>  sound/soc/codecs/wsa881x.c      |  1 +
> 
>>> This touches codecs, can you Ack it please
> 
>> Mark, could you ack the ASoC change to accept this patch via the soundwire repo?
> 
> I don't have this patch and since I seem to get copied on quite a lot of
> soundwire only serieses I just delete them unread mostly.
> 

It can be fetched from lore (mbox format):

https://lore.kernel.org/alsa-devel/20200818140656.29014-2-yung-chuan.liao@linux.intel.com/raw

			Thanks,
				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
