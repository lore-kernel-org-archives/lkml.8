Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E1DC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7798E2076C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="De7j9nEz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgIHRff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:35:35 -0400
Received: from mail1.perex.cz ([77.48.224.245]:41554 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731167AbgIHQOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:14:48 -0400
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 897DAA004B;
        Tue,  8 Sep 2020 14:26:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 897DAA004B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1599567991; bh=EVRNY2gK6A7LOpNzRvy3Ck7Aj7kox9AUX6fO/yDNTq8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=De7j9nEzdfErbkFza6Sg2BPf8N0KjXLe73YoKCVVI1bq4z89Z7u9anFWzHcenzEM1
         sgjtsmR9XxNqbJUOPzyTer6ltVhL4jsL2fsNbFVG/Nqz/vUgnT9zWieI7x6zhzsk8w
         ZLWpe5Qf4DkDJiLoihWjxgciLu7l5Y8JF/PV4YXc=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Tue,  8 Sep 2020 14:26:14 +0200 (CEST)
Subject: Re: [PATCH v3 0/3] ASoC: Add sdw stream operations to dailink ops.
To:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org,
        tiwai@suse.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        mengdong.lin@intel.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20200904182854.3944-1-yung-chuan.liao@linux.intel.com>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <46f44acb-7d4b-965c-a6e2-98a4da79e6cc@perex.cz>
Date:   Tue, 8 Sep 2020 14:26:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200904182854.3944-1-yung-chuan.liao@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 04. 09. 20 v 20:28 Bard Liao napsal(a):
> Sdw stream operation APIs can be called once per stream. Move these
> operations to dailink ops. The linked series is "soundwire: Remove sdw
> stream operations from Intel soundwire dai".
> 
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> 
> Changes in v3:
>  - s/ASOC/ASoC
> 
> Pierre-Louis Bossart (3):
>   ASoC: soc-dai: clarify return value for get_sdw_stream()
>   ASoC: Intel: sof_sdw: add dailink .trigger callback
>   ASoC: Intel: sof_sdw: add dailink .prepare and .hw_free callback
> 
>  include/sound/soc-dai.h          |  3 +-
>  sound/soc/intel/boards/sof_sdw.c | 81 ++++++++++++++++++++++++++++++++
>  2 files changed, 83 insertions(+), 1 deletion(-)
> 

This patchset depends on the SoundWire patchset
  "[PATCH v2 0/4] soundwire: Remove sdw stream operations from Intel" and
cannot be used standalone. I believe that one maintainer should accept it or
there should be a co-ordination between Mark and Vinod to push this in sync.
We should really settle, how to accept such changes. I believe that Vinod
should take it with the ack from Mark for this case. Please, don't require to
split changes which depends on each other.

For all above patches (I tested them):

Acked-by: Jaroslav Kysela <perex@perex.cz>

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
