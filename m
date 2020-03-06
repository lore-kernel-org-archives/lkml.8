Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF5FC10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 20:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32919206E6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 20:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgCFUdq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 15:33:46 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:33269 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCFUdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 15:33:45 -0500
Received: from [192.168.1.183] ([37.4.249.171]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mq2vU-1jeN9h0Z0c-00n9yz; Fri, 06 Mar 2020 21:33:27 +0100
Subject: Re: [PATCH] ARM: dts: bcm283x: Use firmware PM driver for V3D
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Cc:     devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        wahrenst@gmx.net
References: <20200303173217.3987-1-nsaenzjulienne@suse.de>
 <736f0c59-352b-03b2-f77f-bfc22171b3fb@i2se.com>
 <03fcb1e2bc7f3ff389b6dfbf3964e159a93ae835.camel@suse.de>
 <d3d40174-9c08-f42f-e088-08e23c2dc029@i2se.com>
 <f2ec22160ac86aec8d252ade7d6eb8789777cc42.camel@suse.de>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Openpgp: preference=signencrypt
Autocrypt: addr=stefan.wahren@i2se.com; keydata=
 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 AQ==
Message-ID: <01ceb60e-a791-b6ca-352e-ad2e79f264e3@i2se.com>
Date:   Fri, 6 Mar 2020 21:33:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <f2ec22160ac86aec8d252ade7d6eb8789777cc42.camel@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Provags-ID: V03:K1:u+EseD9Ih7mod1fhH/Pdgh/fp0W2D2m/EzFB4lsw/lodf8gCHCU
 SKtZV+752kEyEdC+quRwxwrI3fw9ZOnNDSRpX1LEmV3pomvT730VEDfQbvHXNqod3k7NhAX
 IZnPlIbMHuXdyk8dR2JLJL3wfyqEMJ8etIAGwme1M+CwbMTVtaVMCFTPUgdpy8nDwLgCPr4
 ZSsZNltulnE4H4/AVCRWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QBbaB1y8KJ8=:ZYjE5OHv/iFsetiK4D4yCr
 kl44n0JSzMvgBBFxvYY/mgfz3JUmZKw3cFefCwgadkbIN+pRThPJnHzX9qUPLmeGC2NGqiZx4
 v3HTq58tHCokKgL6ZkWs6gwO5sxel3d5VFtEko6DVi89ZAVcQYFWWaAHdnamPZu04yvsZJXsW
 +zh5VHtvWxzbH3m2EVoMTUnOsxKX3qg5WUeUp3fRQLCot8dhk8BzEoHhmPtpFNB+0Euk8DX7E
 Geno+FsZQpg6246FaFMPPK5vrJhqHf7VLXr4N2g+a9Atc8Fz1iIDFKYcn9uQOweyX5o9qUyiN
 rDhOFXqkRbYR3nUkiS6dnv1GdEoGNSj69MkJFfZQ/iD+wzCTd5n6Ip14rzLdBkXdCZmt3OWpP
 8jALEixzLzUIkmCOSFqh3pWCTNY5STmO1EBXfjfImD1wAKJm/WbbpnIWl1lZCRiRSSXGRwR1h
 smLxDKjPk4hVFn/0pLcdmKMPHxIDkzST5JaLtENy21CcXNZz9fYlEU4j0/Gw4LTu9h/nQi5c7
 hflqIAYjrQsR7hQ9EQov7vYoG+hZrTUfag/5f/uqdZ2h0VS9B/URixBb50FX9SxXlAT3jZaxj
 2rTpeIzY58x4fQYfF2iZWD3DTnlmQrInEo23ubrxuAndFpssFHWObVsNpWss58wZIkWJ8ntMN
 w1YdjAXi66j66fcPsOc1Z95eFQMXEkE5yyxCXN92gtdLJA8AYD35A+tqEvHKMLNDkszdLrQmp
 2zR06Dtgg3vGBg2ogXenadsyUQuUqMVpDChIYNQCi1Upl0MRvyNWoItcDT1p2ji94cQBbndKT
 OXiRR5OrDkg6e93NGEp5HhVTXmyigLTuqIwrxpDqNfgQSjYSuidEUarpLjecQJmHQREX0X0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

Am 05.03.20 um 11:44 schrieb Nicolas Saenz Julienne:
> Hi Stefan,
>
> On Tue, 2020-03-03 at 20:24 +0100, Stefan Wahren wrote:
>>>>> Note: I tested this on RPi3b, RPi3a+ and RPi2b.
>>>> as i already wrote this prevent X to start on current Raspbian on my
>>>> Raspberry Pi 3A+ (multi_v7_defconfig, no u-boot). We must be careful here.
>>>>
>>>> I will take a look at the debug UART. Maybe there are more helpful
>>>> information.
>>> It seems we're seeing different things, I tested this on raspbian
>>> (multi_v7_defconfig) and on arm64. I'll try again from scratch tomorrow.
>> My modifications to the Raspbian image (from 13.2.2020) are little:
>>
>> - specify devicetree to config.txt
>> - change console to ttyS1 and remove "silent" in cmdline.txt
>> - rename all original kernel7*.img
>> - copy dtb and kernel7.img to boot partition
>> - copy kernel modules to root partition
> Would you mind retesting with the latest linux-next? I validated an image based
> on 5.6.0-rc4-next-20200305-00001-g285a7a64cd56 and a fresh raspbian download on
> RPi3a+ without X issues.

i retested with todays linux-next and the issue persists on my RPi 3A+ /
HP ZR2440w with this patch applied.

I will try more hardware combinations tomorrow to see, this issue is
more board or display related.

Best regards
Stefan


