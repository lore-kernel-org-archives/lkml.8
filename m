Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463C2C2D0E5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 11:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23AF2206F8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 11:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgC0LYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 07:24:39 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:57683 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgC0LYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 07:24:37 -0400
Received: from [192.168.1.183] ([37.4.249.171]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MGgRW-1j57eA21oY-00DoGH; Fri, 27 Mar 2020 12:24:28 +0100
Subject: Re: [PATCH] ARM: dts: bcm283x: Use firmware PM driver for V3D
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>
Cc:     devicetree@vger.kernel.org, Scott Branden <sbranden@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        wahrenst@gmx.net, linux-arm-kernel@lists.infradead.org
References: <20200303173217.3987-1-nsaenzjulienne@suse.de>
 <24f850f64b5c71c71938110775e16caaec2811cc.camel@suse.de>
 <8c2bdd83-c8a9-7ba8-8d61-69594e6a2bde@i2se.com>
 <4239bf44-1a2d-09c4-fc1b-186955c062ab@gmail.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Openpgp: preference=signencrypt
Autocrypt: addr=stefan.wahren@i2se.com; keydata=
 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 AQ==
Message-ID: <216d21e5-1a69-7d76-55bb-118715b30278@i2se.com>
Date:   Fri, 27 Mar 2020 12:24:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <4239bf44-1a2d-09c4-fc1b-186955c062ab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:HuG7uCzm5sZSv/V781JbnxNGfw9eNTrd9ceDEEQiH1za3YOHg28
 oqHcXFj9VxfhL8TdKJftky6E7iK+sDMECZPtRb9NXHO/zkypN7X8bX2OmrVRBfNjX0+enVX
 OSGgT5SKr/+zUCP6s6WSViyI6+YRzVIqZ6BDobGm6+gVPFlQ50kJN6eBV2K7gkh0aCKbbLV
 iTdmJg+7yv/4ohugTSgkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MU00D6eHlgM=:EjXFpbGi/SSpjJhCoTA+0B
 BWeVSWcGKaCGJXdCWiLtx6MMFwuXDh/jxiAl8T6rst4DxZTouMaaLARlZyqe4eWG/B5rrbvn0
 /BYX3VObOyONSs1h48R/d11X44SAn7Et7pEwmFghvLqnR4j5kI5BL2zg2zLVL8L8MzISmnIWw
 bpzu7f3gq3EJwNKo2UJIqDN+9PZOyNYv+F1nZ6FcSzcz9NDCpepZPgmrPXpgT/3uFfUgeomMJ
 R2oogJKPIN8YX6JCBvq4D/t5c5HgfDYpC/Wo/HTXsJ5v4oXh+8LBwUrH2qDVIG+A5a94hk3ja
 QtNFSIavfat58qbxTi9a7slHNwQQfVe5Wr73+OoYMGUNm7fNFIJF+Ng6XeKSGY9PP5WOypG4t
 vmAHJWqTcU124bcKh3zlHIuJNh9XD4uVPJs1TF1thce37v6nIOmB5eyZX7e3yrFH3OG8qKvqG
 hcIU05Za2Yo9GXp/ML/N0Z6IWddQvvUyQ9fmUlna9D02fgj7euyoVoVfwFvKaiRL78nGaacoH
 /cha0f0gNUUILIdNREUe5jNVeyyHMzeCFDbWKgaAflzWNlxQHUWg6gF/bTF0um0R7wWO/GFU7
 Wk64YSDrEvirVkdYltdZahnTDTGu1i3a4+XrY53AMIF8AIMBIxFpxjV3Cd/BpDG+nZ93wqtLG
 /JJ5a2lnd/q9rObOLDKcQdowpWzzDVaMNgIuMmJdIlriPeKplCFRlRdzR+ZB8VDp5Zv2rt3Xl
 m2j+NVsuJzRwp/Nuf4AN4AAEn0G8RZAd9+1Xn+eg6T7GK/5BLm6pCDwWvoh/Blj0gY0DkxJ+3
 7wjNfWG5IviCOuX1i0CkQ140q72ZQJ4eMeTsQFZVpeQL8UhQaCTuY+Ys/jMhQjQn1MIB7v/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 27.03.20 um 01:35 schrieb Florian Fainelli:
>
> On 3/26/2020 10:24 AM, Stefan Wahren wrote:
>> Am 26.03.20 um 13:24 schrieb Nicolas Saenz Julienne:
>>> Hi Stefan and Florian,
>>>
>>> On Tue, 2020-03-03 at 18:32 +0100, Nicolas Saenz Julienne wrote:
>>>> The register based driver turned out to be unstable, specially on RPi3a+
>>>> but not limited to it. While a fix is being worked on, we roll back to
>>>> using firmware based scheme.
>>>>
>>>> Fixes: e1dc2b2e1bef ("ARM: bcm283x: Switch V3D over to using the PM driver
>>>> instead of firmware")
>>>> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>>>> ---
>>> now that the problem Stefan was seeing is being taken care of, I think it's
>>> fair to reconsider taking this patch. Maybe even adding a Tested-by by Stefan?
>> after applying "drm/vc4: Fix HDMI mode validation" this commit doesn't
>> cause any regression:
>>
>> Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
> Good, how do you like to see this applied? Do we need to ensure that
> drm/vc4: Fix HDMI mode validation is applied to Linus' tree before
> merging this one? Nicolas, should this be queued for 5.7 or 5.8 (I do
> not think the 5.7 PRs have been merged yet).
not sure how many are affected. I'm fine as long as both patches are
applied to a tree.

Regards

