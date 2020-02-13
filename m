Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEF5C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 10:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7F72073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 10:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbgBMKAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 05:00:05 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:48531 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbgBMKAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 05:00:05 -0500
Received: from [192.168.178.45] ([109.104.45.70]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MGyl3-1jFfgV0HC7-00E8DN; Thu, 13 Feb 2020 10:59:48 +0100
Subject: Re: [PATCH] ARM: bcm2835_defconfig: add minimal support for Raspberry
 Pi4
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <CGME20200212102022eucas1p1c49daf15d3e63eda9a56124bc4eafb57@eucas1p1.samsung.com>
 <20200212102009.17428-1-m.szyprowski@samsung.com>
 <a1d66025baa13b2276b12405544fc7107aac8d6c.camel@suse.de>
 <5adcb2de-3570-9c4d-5e5b-726b94fb2029@samsung.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <916c0113-9910-26cd-3720-15399fde507b@i2se.com>
Date:   Thu, 13 Feb 2020 10:59:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5adcb2de-3570-9c4d-5e5b-726b94fb2029@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:rqjER1Wpxcp48iehpHocS30UWq5iynTkVomtysQANDNAsxQUZBr
 dpG3OaBTB/7yXyaPOULjiyFytd/2r48rtEt52nhmdVwrYdmJOoirHVd7MchHYtFRr7Y00gi
 5ErUxFr/yw4yv3YsuIMklWSjllbk5ohw+Sv8VeE5QsRBC4kDpp/Ck4JXGluZY0StD5xyV7P
 LaZo/d6mNLiZZuX8hNVkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yn/y25ko+sQ=:YBuWtfcDihwiPv5UiEgeWY
 jlFhaWYcVsFAfdHx5jBoBUsOOUghY+Eys6ivMNx3FQeaffWvEeWMMRG59zWPnpR5YqMoRUQbt
 NpYqHR2yUadaSWgLI5CW2H9rOHI8FVuE+hSvtt6FhFTlP6BlbqNlhl2935J93m2hCLAIGjg1E
 TjmBFmxq6700QQTt+kUUUbtMqst7dT13JxJJlodaIv5JUQ0xPx/y9g87nEUN+49LJ62sfEUkC
 cyeuG6U7Zh8SmC+kF2ZQfKBJujfROi34DYMHF3JWrVe4NMfukhJ8KiS37Z58XlXPr99CQwUH2
 4TfTC2GzjYfXQ4apGzqciPfqqC9QyeO4LMicxdBmcdgDtr4diOMs30PvPhWvFCaQow4bJ/RaD
 VgfXZ1vFgC5/Fo+orsheeYfYkX0aHHOqmqrAUl32DKb7JYinKAvuWINkJ3LMVcNvCwCT0C4Gx
 Zmo5Xeca0odMP8jZaQHShEh89IUE2TXTLkxKGoPvjDmJyS+6lZRz3R2Vh5sKJb5Ql1rXAwdBK
 7zTYNTZHkTZ4F7Z/x7erJ9LKn1mZv3LpT2uZHdWOr+M7x90L9NYhn9r0uKFL3ZFS7xKcsYLYW
 LZyG8GC28T8FWMv00i8IWS0mC8x+oyBXB5O1oBcDKqiQK6CMbmGkr/KIK19NaTOVcTUM1YD85
 SrOI0ajNQVxmCmrpFLPnnaCsyyAeTDvGwSDpac58HvNXSx2tPPNeMNBMCaK/PyGMumbGlAVMh
 CicEIcSBivprYSwdWuY1OJ9pPgFI7hNs2VV3TaYdv055qjXjhSAq9U8zVuJ9b6/3ZGsVDH6lq
 neGrgMY1FV3+tGsWkrMTGurrs22zKA69eECG4QzMtf+FxmcDzqlgPvYSmIZijp5qHZ4fYKK
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On 13.02.20 08:35, Marek Szyprowski wrote:
> Hi Nicolas
>
> On 12.02.2020 19:31, Nicolas Saenz Julienne wrote:
>> Hi Marek,
>> On Wed, 2020-02-12 at 11:20 +0100, Marek Szyprowski wrote:
>>> Add drivers for the minimal set of devices needed to boot Raspberry Pi4
>>> board.
>>>
>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Just so you know, the amount of support on the RPi4 you might be able to get
>> updating bcm2835_defconfig's config is very limited. Only 1GB of ram and no
>> PCIe (so no USBs).
> Yes, I know. A lots of core features is missing: SMP, HIGHMEM, LPAE, PCI 
> and so on, but having a possibility to boot RPi4 with this defconfig 
> increases the test coverage.

in case you want to increase test coverage, we better enable all
Raspberry Pi 4 relevant hardware parts (hwrng, thermal, PCI ...). This
is what we did for older Pi boards.

SMP, HIGHMEM, LPAE are different and shouldn't be enabled in
bcm2835_defconfig from my PoV.

Best regards
Stefan

