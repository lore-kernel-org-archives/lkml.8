Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A660C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0692072C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgCMN7c convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 09:59:32 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:36953 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgCMN7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 09:59:32 -0400
Received: from [192.168.1.183] ([37.4.249.171]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MxE5Y-1jWTYB48im-00xXQi; Fri, 13 Mar 2020 14:59:16 +0100
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
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20200303173217.3987-1-nsaenzjulienne@suse.de>
 <736f0c59-352b-03b2-f77f-bfc22171b3fb@i2se.com>
 <03fcb1e2bc7f3ff389b6dfbf3964e159a93ae835.camel@suse.de>
 <d3d40174-9c08-f42f-e088-08e23c2dc029@i2se.com>
 <f2ec22160ac86aec8d252ade7d6eb8789777cc42.camel@suse.de>
 <01ceb60e-a791-b6ca-352e-ad2e79f264e3@i2se.com>
 <ddcb8fd5-9e35-454c-b38d-d36e7b41ef07@i2se.com>
 <9e685fce547d808f269e59e2290331e75c66f3e4.camel@suse.de>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Openpgp: preference=signencrypt
Autocrypt: addr=stefan.wahren@i2se.com; keydata=
 xsFNBFt6gBMBEACub/pBevHxbvJefyZG32JINmn2bsEPX25V6fejmyYwmCGKjFtL/DoUMEVH
 DxCJ47BMXo344fHV1C3AnudgN1BehLoBtLHxmneCzgH3KcPtWW7ptj4GtJv9CQDZy27SKoEP
 xyaI8CF0ygRxJc72M9I9wmsPZ5bUHsLuYWMqQ7JcRmPs6D8gBkk+8/yngEyNExwxJpR1ylj5
 bjxWDHyYQvuJ5LzZKuO9LB3lXVsc4bqXEjc6VFuZFCCk/syio/Yhse8N+Qsx7MQagz4wKUkQ
 QbfXg1VqkTnAivXs42VnIkmu5gzIw/0tRJv50FRhHhxpyKAI8B8nhN8Qvx7MVkPc5vDfd3uG
 YW47JPhVQBcUwJwNk/49F9eAvg2mtMPFnFORkWURvP+G6FJfm6+CvOv7YfP1uewAi4ln+JO1
 g+gjVIWl/WJpy0nTipdfeH9dHkgSifQunYcucisMyoRbF955tCgkEY9EMEdY1t8iGDiCgX6s
 50LHbi3k453uacpxfQXSaAwPksl8MkCOsv2eEr4INCHYQDyZiclBuuCg8ENbR6AGVtZSPcQb
 enzSzKRZoO9CaqID+favLiB/dhzmHA+9bgIhmXfvXRLDZze8po1dyt3E1shXiddZPA8NuJVz
 EIt2lmI6V8pZDpn221rfKjivRQiaos54TgZjjMYI7nnJ7e6xzwARAQABzSlTdGVmYW4gV2Fo
 cmVuIDxzdGVmYW4ud2FocmVuQGluLXRlY2guY29tPsLBdwQTAQgAIQUCXIdehwIbAwULCQgH
 AgYVCAkKCwIEFgIDAQIeAQIXgAAKCRCUgewPEZDy2yHTD/9UF7QlDkGxzQ7AaCI6N95iQf8/
 1oSUaDNu2Y6IK+DzQpb1TbTOr3VJwwY8a3OWz5NLSOLMWeVxt+osMmlQIGubD3ODZJ8izPlG
 /JrNt5zSdmN5IA5f3esWWQVKvghZAgTDqdpv+ZHW2EmxnAJ1uLFXXeQd3UZcC5r3/g/vSaMo
 9xek3J5mNuDm71lEWsAs/BAcFc+ynLhxwBWBWwsvwR8bHtJ5DOMWvaKuDskpIGFUe/Kb2B+j
 ravQ3Tn6s/HqJM0cexSHz5pe+0sGvP+t9J7234BFQweFExriey8UIxOr4XAbaabSryYnU/zV
 H9U1i2AIQZMWJAevCvVgQ/U+NeRhXude9YUmDMDo2sB2VAFEAqiF2QUHPA2m8a7EO3yfL4rM
 k0iHzLIKvh6/rH8QCY8i3XxTNL9iCLzBWu/NOnCAbS+zlvLZaiSMh5EfuxTtv4PlVdEjf62P
 +ZHID16gUDwEmazLAMrx666jH5kuUCTVymbL0TvB+6L6ARl8ANyM4ADmkWkpyM22kCuISYAE
 fQR3uWXZ9YgxaPMqbV+wBrhJg4HaN6C6xTqGv3r4B2aqb77/CVoRJ1Z9cpHCwiOzIaAmvyzP
 U6MxCDXZ8FgYlT4v23G5imJP2zgX5s+F6ACUJ9UQPD0uTf+J9Da2r+skh/sWOnZ+ycoHNBQv
 ocZENAHQf87BTQRbeoATARAA2Hd0fsDVK72RLSDHby0OhgDcDlVBM2M+hYYpO3fX1r++shiq
 PKCHVAsQ5bxe7HmJimHa4KKYs2kv/mlt/CauCJ//pmcycBM7GvwnKzmuXzuAGmVTZC6WR5Lk
 akFrtHOzVmsEGpNv5Rc9l6HYFpLkbSkVi5SPQZJy+EMgMCFgjrZfVF6yotwE1af7HNtMhNPa
 LDN1oUKF5j+RyRg5iwJuCDknHjwBQV4pgw2/5vS8A7ZQv2MbW/TLEypKXif78IhgAzXtE2Xr
 M1n/o6ZH71oRFFKOz42lFdzdrSX0YsqXgHCX5gItLfqzj1psMa9o1eiNTEm1dVQrTqnys0l1
 8oalRNswYlQmnYBwpwCkaTHLMHwKfGBbo5dLPEshtVowI6nsgqLTyQHmqHYqUZYIpigmmC3S
 wBWY1V6ffUEmkqpAACEnL4/gUgn7yQ/5d0seqnAq2pSBHMUUoCcTzEQUWVkiDv3Rk7hTFmhT
 sMq78xv2XRsXMR6yQhSTPFZCYDUExElEsSo9FWHWr6zHyYcc8qDLFvG9FPhmQuT2s9Blx6gI
 323GnEq1lwWPJVzP4jQkJKIAXwFpv+W8CWLqzDWOvdlrDaTaVMscFTeH5W6Uprl65jqFQGMp
 cRGCs8GCUW13H0IyOtQtwWXA4ny+SL81pviAmaSXU8laKaRu91VOVaF9f4sAEQEAAcLBXwQY
 AQIACQUCW3qAEwIbDAAKCRCUgewPEZDy2+oXD/9cHHRkBZOfkmSq14Svx062PtU0KV470TSn
 p/jWoYJnKIw3G0mXIRgrtH2dPwpIgVjsYyRSVMKmSpt5ZrDf9NtTbNWgk8VoLeZzYEo+J3oP
 qFrTMs3aYYv7e4+JK695YnmQ+mOD9nia915tr5AZj95UfSTlyUmyic1d8ovsf1fP7XCUVRFc
 RjfNfDF1oL/pDgMP5GZ2OwaTejmyCuHjM8IR1CiavBpYDmBnTYk7Pthy6atWvYl0fy/CqajT
 Ksx7+p9xziu8ZfVX+iKBCc+He+EDEdGIDhvNZ/IQHfOB2PUXWGS+s9FNTxr/A6nLGXnA9Y6w
 93iPdYIwxS7KXLoKJee10DjlzsYsRflFOW0ZOiSihICXiQV1uqM6tzFG9gtRcius5UAthWaO
 1OwUSCQmfCOm4fvMIJIA9rxtoS6OqRQciF3crmo0rJCtN2awZfgi8XEif7d6hjv0EKM9XZoi
 AZYZD+/iLm5TaKWN6oGIti0VjJv8ZZOZOfCb6vqFIkJW+aOu4orTLFMz28aoU3QyWpNC8FFm
 dYsVua8s6gN1NIa6y3qa/ZB8bA/iky59AEz4iDIRrgUzMEg8Ak7Tfm1KiYeiTtBDCo25BvXj
 bqsyxkQD1nkRm6FAVzEuOPIe8JuqW2xD9ixGYvjU5hkRgJp3gP5b+cnG3LPqquQ2E6goKUML AQ==
Message-ID: <bb2c7d99-06b1-d222-7f69-8ce91157bde5@i2se.com>
Date:   Fri, 13 Mar 2020 14:59:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9e685fce547d808f269e59e2290331e75c66f3e4.camel@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Provags-ID: V03:K1:oAlpbkCNljRg1lN7Z3lg1RjKLBZ7js6FA3okDbOoKe6ltR1r0RA
 04WNCricu4piLrx6sCBYZHKPLlDFWFzqqy2glhr3J1/8CPS5/tD3+med6llLrAuMHicnrpR
 s2bN8oKgKnNwbIb61zHGj/4DyswEmntb9T/riJFW+fNNJx/s2QbSes9h5NGGPCK9f9nl21M
 5WpZia91BGWT5HLe/M0gA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uw5UIjifOMU=:VmMQjSEyyc54ny49tlD5aC
 vXfYUx8yTq+ol7+elA4J0sZil0u62m3fYUkb7ma2VogdFLFd4RxKw5bjaVAKXVAif315av0ke
 SA9WzDK0ni91mxeLkyX0YOIvPlQIDfIbmppYCZZi+mWfQ2E8TTwQgv4Fi3jQAI7NSN9zNjes7
 ipeb6PjLoNMTNmzP9VlK4GEM70gESokzELsx+BwYrDzdgJOnvsbxIPwC3zFSzD0g7S/mmV8Mg
 yl2EbKFTVhxjnqG/ggXy5cY5vnvsCh/s3RdyxLbzhFT9rZ5z97LJnpWJsQk2pDzektcVWEhIS
 rR0OQay1n8r2AMEe3EgkAMn1G/7CcMEcuV1qLLMKFIBnaqH44jba+Y/N8h2tcttZobp7CbudD
 OVPCOh0MV/7ACxDkhmb8EKRWmgpyJass/gclFVDk7NiAeLIzn1HZToOn38oQq3Kh+kh/Ybxg+
 +e1sir88dNGiJ2M3seepikQ7QGaGa0ICFZSrEsXj6lZFZG+4ZHZWrGimZqr7wRNRsFeSn9pHs
 WGIM2k9/d0sHw4SojbeMTaC3h5ZP9xbDvSYPHlfPuVG8H2AvltTrC78woh0Kb2S6zx3s1c3Lw
 VvHETMUIaOvq/R2ZAfwnmVHLm/GEJ/0thoF+TpPPeSy65U/7FpNNUkx6mq1Pz44mQwrCR7rX9
 Zxwbl3VJFP1SSYwViTchLtn79ZIh9hnc7toLLwR3iRmK2Dk4fXzEKQKoLsx0rZI7j5+hFnDq7
 rHY6IAI9N8zUbWd/Z64lmSRBWy/U2dkSRfDDQAeJc+BnD6L5Rjz2ZTTsCBnqLSRIZVE40LumG
 poFNYmnfo4Moxsa/7pZn8UVKnCnB6sjcX/td3/mETPt8LxnxOrTrdmN9UK0XIpFIU+Rcff+
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

Am 09.03.20 um 20:22 schrieb Nicolas Saenz Julienne:
> Hi Stefan,
>
> On Mon, 2020-03-09 at 16:41 +0100, Stefan Wahren wrote:
>> Hi Nicolas,
>>
>> On 06.03.20 21:33, Stefan Wahren wrote:
>>> Hi Nicolas,
>>>
>>> Am 05.03.20 um 11:44 schrieb Nicolas Saenz Julienne:
>>>> Hi Stefan,
>>>>
>>>> On Tue, 2020-03-03 at 20:24 +0100, Stefan Wahren wrote:
>>>>>>>> Note: I tested this on RPi3b, RPi3a+ and RPi2b.
>>>>>>> as i already wrote this prevent X to start on current Raspbian on my
>>>>>>> Raspberry Pi 3A+ (multi_v7_defconfig, no u-boot). We must be careful
>>>>>>> here.
>>>>>>>
>>>>>>> I will take a look at the debug UART. Maybe there are more helpful
>>>>>>> information.
>>>>>> It seems we're seeing different things, I tested this on raspbian
>>>>>> (multi_v7_defconfig) and on arm64. I'll try again from scratch
>>>>>> tomorrow.
>>>>> My modifications to the Raspbian image (from 13.2.2020) are little:
>>>>>
>>>>> - specify devicetree to config.txt
>>>>> - change console to ttyS1 and remove "silent" in cmdline.txt
>>>>> - rename all original kernel7*.img
>>>>> - copy dtb and kernel7.img to boot partition
>>>>> - copy kernel modules to root partition
>>>> Would you mind retesting with the latest linux-next? I validated an image
>>>> based
>>>> on 5.6.0-rc4-next-20200305-00001-g285a7a64cd56 and a fresh raspbian
>>>> download on
>>>> RPi3a+ without X issues.
>>> i retested with todays linux-next and the issue persists on my RPi 3A+ /
>>> HP ZR2440w with this patch applied.
>> I tested my display with a RPI 3B, 3B+ and a Zero W. All of them had the
>> same issue. Btw i used this display the last years for testing the
>> Raspberry Pi.
>>
>> After that i connected the RPI 3B to my TV screen and it works with the
>> patch applied.
> Thanks for taking the time on this. I guess all we have left is looking deeper
> into it. I'll add it to my backlog for now.

i've a small progress on this issue. Without this patch applied the
simple framebuffer driver seems to win against vc4 ( = "good case" ):

[    13.400] (II) systemd-logind: logind integration requires -keeptty
and -keeptty was not provided, disabling logind integration
[    13.402] (II) no primary bus or device found
[    13.402] (II) LoadModule: "glx"
[    13.405] (II) Loading /usr/lib/xorg/modules/extensions/libglx.so
[    13.465] (II) Module glx: vendor="X.Org Foundation"
[    13.465]     compiled for 1.20.4, module version = 1.0.0
[    13.465]     ABI class: X.Org Server Extension, version 10.0
[    13.465] (II) LoadModule: "fbturbo"
[    13.466] (II) Loading /usr/lib/xorg/modules/drivers/fbturbo_drv.so
[    13.470] (II) Module fbturbo: vendor="X.Org Foundation"
[    13.470]     compiled for 1.20.3, module version = 0.5.1
[    13.470]     Module class: X.Org Video Driver
[    13.470]     ABI class: X.Org Video Driver, version 24.0
[    13.470] (II) FBTURBO: driver for framebuffer: fbturbo
[    13.517] (WW) Falling back to old probe method for fbturbo
[    13.518] (II) Loading sub module "fbdevhw"
[    13.518] (II) LoadModule: "fbdevhw"
[    13.518] (II) Loading /usr/lib/xorg/modules/libfbdevhw.so
[    13.523] (II) Module fbdevhw: vendor="X.Org Foundation"
[    13.523]     compiled for 1.20.4, module version = 0.0.2
[    13.523]     ABI class: X.Org Video Driver, version 24.0
[    13.524] (II) FBTURBO(0): using /dev/fb0
[    13.524] (II) FBTURBO(0): Creating default Display subsection in
Screen section
    "Default Screen Section" for depth/fbbpp 24/32
[    13.524] (==) FBTURBO(0): Depth 24, (==) framebuffer bpp 32
[    13.524] (==) FBTURBO(0): RGB weight 888
[    13.524] (==) FBTURBO(0): Default visual is TrueColor
[    13.524] (==) FBTURBO(0): Using gamma correction (1.0, 1.0, 1.0)
[    13.524] (II) FBTURBO(0): hardware: simple (video memory: 9000kB)

With the patch applied vc4 wins, but mode setting seems to fail:

[    13.596] (II) systemd-logind: logind integration requires -keeptty
and -keeptty was not provided, disabling logind integration
[    13.599] (II) xfree86: Adding drm device (/dev/dri/card0)
[    13.606] (II) no primary bus or device found
[    13.607]     falling back to /sys/devices/platform/soc/soc:gpu/drm/card0
[    13.607] (II) LoadModule: "glx"
[    13.613] (II) Loading /usr/lib/xorg/modules/extensions/libglx.so
[    13.674] (II) Module glx: vendor="X.Org Foundation"
[    13.674]     compiled for 1.20.4, module version = 1.0.0
[    13.674]     ABI class: X.Org Server Extension, version 10.0
[    13.674] (II) LoadModule: "fbturbo"
[    13.675] (II) Loading /usr/lib/xorg/modules/drivers/fbturbo_drv.so
[    13.679] (II) Module fbturbo: vendor="X.Org Foundation"
[    13.679]     compiled for 1.20.3, module version = 0.5.1
[    13.679]     Module class: X.Org Video Driver
[    13.679]     ABI class: X.Org Video Driver, version 24.0
[    13.679] (II) FBTURBO: driver for framebuffer: fbturbo
[    13.689] (WW) Falling back to old probe method for fbturbo
[    13.689] (II) Loading sub module "fbdevhw"
[    13.689] (II) LoadModule: "fbdevhw"
[    13.690] (II) Loading /usr/lib/xorg/modules/libfbdevhw.so
[    13.692] (II) Module fbdevhw: vendor="X.Org Foundation"
[    13.692]     compiled for 1.20.4, module version = 0.0.2
[    13.693]     ABI class: X.Org Video Driver, version 24.0
[    13.693] (II) FBTURBO(0): using /dev/fb0
[    13.693] (II) FBTURBO(0): Creating default Display subsection in
Screen section
    "Default Screen Section" for depth/fbbpp 16/16
[    13.693] (==) FBTURBO(0): Depth 16, (==) framebuffer bpp 16
[    13.693] (==) FBTURBO(0): RGB weight 565
[    13.693] (==) FBTURBO(0): Default visual is TrueColor
[    13.693] (==) FBTURBO(0): Using gamma correction (1.0, 1.0, 1.0)
[    13.693] (II) FBTURBO(0): hardware: vc4drmfb (video memory: 675kB)

could you please confirm which driver is actually working on X with this
patch applied in your case?

Regards
Stefan

>
> Regards,
> Nicolas
>

