Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C07C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0218620B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="r7tHGJO6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgFOWvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:51:49 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:56930 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726452AbgFOWvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:51:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592261508; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=ezmSdU6tYLdFTOr1T+ah81x42+90GeQROYmrVSVF2Ys=;
 b=r7tHGJO6MAv47wxpJmg4zH6O1OrZHjtdu2IcpaS43yNmITwHKD7S3xc0eoBjaDeHV+cvMOAd
 nCYwZ0p2D8X4Cv4CTA1bTRdQ+I2MdnAxv0iQpIjC6Eu1uxXzrFzs/u5C7Mbs7pp5txNnGdZf
 sCHa4mSFsA6uXphaOJkxW/Ejpwc=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ee7fb83c4bb4f886dc87531 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 15 Jun 2020 22:51:47
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 25C20C43391; Mon, 15 Jun 2020 22:51:47 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tanmay)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C0D19C433CB;
        Mon, 15 Jun 2020 22:51:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 15 Jun 2020 15:51:45 -0700
From:   tanmay@codeaurora.org
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     robh+dt@kernel.org, sam@ravnborg.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        seanpaul@chromium.org, robdclark@gmail.com,
        aravindh@codeaurora.org, abhinavk@codeaurora.org
Subject: Re: [PATCH v6 0/5] Add support for DisplayPort driver on
In-Reply-To: <159200440578.62212.5195358467251573190@swboyd.mtv.corp.google.com>
References: <20200612015030.16072-1-tanmay@codeaurora.org>
 <159200440578.62212.5195358467251573190@swboyd.mtv.corp.google.com>
Message-ID: <1eda01da33b620ddee5162be3326853f@codeaurora.org>
X-Sender: tanmay@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-12 16:26, Stephen Boyd wrote:

Thanks for reviews Stephen.

> Quoting Tanmay Shah (2020-06-11 18:50:25)
>> These patches add support for Display-Port driver on SnapDragon
>> hardware. It adds
>> DP driver and DP PLL driver files along with the needed device-tree
>> bindings.
>> 
>> The block diagram of DP driver is shown below:
>> 
>> 
>>                  +-------------+
>>                  |DRM FRAMEWORK|
>>                  +------+------+
>>                         |
>>                    +----v----+
>>                    | DP DRM  |
>>                    +----+----+
>>                         |
>>                    +----v----+
>>      +------------+|   DP    +----------++------+
>>      +        +---+| DISPLAY |+---+      |      |
>>      |        +    +-+-----+-+    |      |      |
>>      |        |      |     |      |      |      |
>>      |        |      |     |      |      |      |
>>      |        |      |     |      |      |      |
>>      v        v      v     v      v      v      v
>>  +------+ +------+ +---+ +----+ +----+ +---+ +-----+
>>  |  DP  | |  DP  | |DP | | DP | | DP | |DP | | DP  |
>>  |PARSER| | HPD  | |AUX| |LINK| |CTRL| |PHY| |POWER|
>>  +--+---+ +---+--+ +---+ +----+ +--+-+ +-+-+ +-----+
>>     |                              |     |
>>  +--v---+                         +v-----v+
>>  |DEVICE|                         |  DP   |
>>  | TREE |                         |CATALOG|
>>  +------+                         +---+---+
>>                                       |
>>                                   +---v----+
>>                                   |CTRL/PHY|
>>                                   |   HW   |
>>                                   +--------+
>> 
> 
> I've never seen a block diagram for a driver before...
> 
It is here for v5. https://patchwork.freedesktop.org/series/74312/

>> 
>> These patches have dependency on clock driver changes mentioned below:
>> https://patchwork.kernel.org/patch/11245895/
>> https://patchwork.kernel.org/cover/11069083/
> 
> These are merged right? Don't need to include this if it's already
> merged.
> 
Ok Thanks.

> Can you include a changelog in the cover letter too so we know what has
> changed between versions of the patchset?
> 
Sure.
>> 
>> Chandan Uddaraju (4):
>>   dt-bindings: msm/dp: add bindings of DP/DP-PLL driver for Snapdragon
>>   drm: add constant N value in helper file
>>   drm/msm/dp: add displayPort driver support
>>   drm/msm/dp: add support for DP PLL driver
>> 
>> Jeykumar Sankaran (1):
>>   drm/msm/dpu: add display port support in DPU
>> 
> [...]
>> 
>> 
>> base-commit: 48f99181fc118d82dc8bf6c7221ad1c654cb8bc2
> 
> What is this commit? I don't see it in linux-next.
Here: 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20200603&id=48f99181fc118d82dc8bf6c7221ad1c654cb8bc2
