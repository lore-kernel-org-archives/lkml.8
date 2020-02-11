Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4C3C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5632086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="1tAsP1W7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgBKJf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 04:35:27 -0500
Received: from mail1.perex.cz ([77.48.224.245]:56140 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727556AbgBKJf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 04:35:27 -0500
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id D4441A0040;
        Tue, 11 Feb 2020 10:35:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz D4441A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1581413724; bh=9IvGzzJGYDpncBJXTDMIMmetMvPwcS5FQO6sWG2ZxZw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=1tAsP1W7o90yfr++XbusgfY8zfv4DAXfLPRYYILiXMMlAqIlryn66KifzDWpXbhJk
         g1UeIqDxhktfoUsaJHSGVLpu6adOeEFYzUkRjZ//2GOP7AusIvsx7+Njcgn3Fqsa+s
         iPy1whLIQ627dViOqlOXVUp3y3DfP7IQaMEDR6TI=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Tue, 11 Feb 2020 10:35:19 +0100 (CET)
Subject: Re: [PATCH 2/2] ALSA: hda/realtek - Fix Lenovo Thinkpad X1 Carbon 7th
 quirk value
To:     Benjamin Poirier <benjamin.poirier@gmail.com>
Cc:     Takashi Iwai <tiwai@suse.de>, Kailang Yang <kailang@realtek.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20200211055651.4405-1-benjamin.poirier@gmail.com>
 <20200211055651.4405-2-benjamin.poirier@gmail.com>
 <b23abac0-401c-9472-320c-4e9d7eab26de@perex.cz> <20200211081604.GA8286@f3>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <901c395a-7fb5-5672-5955-d6d211824177@perex.cz>
Date:   Tue, 11 Feb 2020 10:35:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211081604.GA8286@f3>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 11. 02. 20 v 9:16 Benjamin Poirier napsal(a):
> On 2020/02/11 08:40 +0100, Jaroslav Kysela wrote:
> [...]
>>>
>>> In summary, Node 0x17 DAC connection 0x3 offers the loudest max volume and
>>> the most detailed mixer controls. That connection is obtained with quirk
>>> ALC295_FIXUP_DISABLE_DAC3. Therefore, change the ThinkPad X1 Carbon 7th to
>>> use ALC295_FIXUP_DISABLE_DAC3.
>>
>> The volume split (individual volume control) will cause trouble for the UCM
>> volume control at the moment which is the target for this device to get the
>> digital microphone working. If there is no possibility to share DAC, it
>> would be probably more nice to join the volume control in the driver.
>>
>> Have you tried to use 0x03 as source for all four speakers?
> 
> Front speakers are fixed to 0x02. Node 0x14
>    Connection: 1
>       0x02
> 

Yes, you're right. I forgot that.

>>
>> Why PA handles the rear volume control with the current driver code in the
>> legacy ALSA driver? It should be handled like standard stereo device. I'll
>> check.
> 
> The device comes up with "Analog Stereo Output" profile by default. I
> changed it to "Analog Surround 4.0 Output" to test controlling each
> channel individually:

Yes, but does the volume control work (does PA change the appropriate ALSA 
mixer volume)? Sometimes, it's difficult to see the difference between soft 
volume attenuation and the hardware volume control.

> 
>>> pavucontrol controls are reported with the device configured with the
>>> "Analog Surround 4.0 Output" profile.
> 
>>
>> You should also test PA with UCM.
> 
> Please let me know what do I need to test exactly? I'm not familiar with
> UCM.

Just install the latest pulseaudio (latest from repo), alsa-lib and 
alsa-ucm-conf (also from repo). If pulseaudio detects UCM, it has the preference.

						Jaroslav

> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
