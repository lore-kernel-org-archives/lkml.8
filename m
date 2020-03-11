Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	PDS_HP_HELO_NORDNS,RDNS_NONE,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_NONE,
	SPOOFED_FREEMAIL_NO_RDNS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37988 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730055AbgCKQhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:37:34 -0400
Subject: Re: [PATCH] ARM: bcm2835-rpi-zero-w: Add missing pinctrl name
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        nick.hudson@gmx.co.uk
Cc: Nick Hudson <skrll@netbsd.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200310182537.8156-1-nick.hudson@gmx.co.uk>
 <12f35cc38b87dfe27f0786c931d4434b0fecb3d8.camel@suse.de>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <620c845c-afd1-a4a4-468a-acc24299f492@gmail.com>
Date: Wed, 11 Mar 2020 09:37:22 -0700
MIME-Version: 1.0
In-Reply-To: <12f35cc38b87dfe27f0786c931d4434b0fecb3d8.camel@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/11/20 4:28 AM, Nicolas Saenz Julienne wrote:
> On Tue, 2020-03-10 at 18:25 +0000, nick.hudson@gmx.co.uk wrote:
>> From: Nick Hudson <nick.hudson@gmx.co.uk>
>>
>> Define the sdhci pinctrl state as "default" so it gets applied
>> correctly and to match all other RPis.
>>
>> Fixes: 2c7c040c73e9 ("ARM: dts: bcm2835: Add Raspberry Pi Zero W")
>>
>> Signed-off-by: Nick Hudson <skrll@netbsd.org>
> 
> I think this one has everything right. As a nitpick, there is no need to add a
> space between the Fixes tag and the Signed-off-by tag, but it's OK as is.
> 
> Florian, can we channel this as a fix for v5.6 or are we too late?

We can try, let me queue this today.
-- 
Florian

