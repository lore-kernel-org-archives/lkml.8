Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C23C35666
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 16:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15908206ED
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 16:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgBVQbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 11:31:34 -0500
Received: from mx2.yrkesakademin.fi ([85.134.45.195]:22755 "EHLO
        mx2.yrkesakademin.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgBVQbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 11:31:34 -0500
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Feb 2020 11:31:33 EST
Subject: Re: Regression in 5.4 kernel on 32-bit Radeon IBM T40
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        Woody Suwalski <terraluna977@gmail.com>
CC:     DRI mailing list <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Pavel Machek <pavel@ucw.cz>
References: <400f6ce9-e360-0860-ca2a-fb8bccdcdc9b@gmail.com>
 <20200109141436.GA22111@lst.de>
 <9ad75215-3ff1-ee76-9985-12fd78d6aa5f@amd.com>
From:   Thomas Backlund <tmb@mageia.org>
Message-ID: <801e4196-5e22-e805-4d45-0245efdaa508@mageia.org>
Date:   Sat, 22 Feb 2020 18:16:28 +0200
MIME-Version: 1.0
In-Reply-To: <9ad75215-3ff1-ee76-9985-12fd78d6aa5f@amd.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Den 09-01-2020 kl. 17:12, skrev Christian König:
> Hi Christoph,
> 
> Am 09.01.20 um 15:14 schrieb Christoph Hellwig:
>> Hi Woody,
>>
>> sorry for the late reply, I've been off to a vacation over the holidays.
>>
>> On Sat, Dec 14, 2019 at 10:17:15PM -0500, Woody Suwalski wrote:
>>> Regression in 5.4 kernel on 32-bit Radeon IBM T40
>>> triggered by
>>> commit 33b3ad3788aba846fc8b9a065fe2685a0b64f713
>>> Author: Christoph Hellwig <hch@lst.de>
>>> Date:   Thu Aug 15 09:27:00 2019 +0200
>>>
>>> Howdy,
>>> The above patch has triggered a display problem on IBM Thinkpad T40, 
>>> where
>>> the screen is covered with a lots of random short black horizontal 
>>> lines,
>>> or distorted letters in X terms.
>>>
>>> The culprit seems to be that the dma_get_required_mask() is returning a
>>> value 0x3fffffff
>>> which is smaller than dma_get_mask()0xffffffff.That results in
>>> dma_addressing_limited()==0 in ttm_bo_device(), and using 40-bits dma
>>> instead of 32-bits.
>> Which is the intended behavior assuming your system has 1GB of memory.
>> Does it?
> 
> Assuming the system doesn't have the 1GB split up somehow crazy over the 
> address space that should indeed work as intended.
> 
>>
>>> If I hardcode "1" as the last parameter to ttm_bo_device_init() in 
>>> place of
>>> a call to dma_addressing_limited(),the problem goes away.
>> I'll need some help from the drm / radeon / TTM maintainers if there are
>> any other side effects from not passing the need_dma32 paramters.
>> Obviously if the device doesn't have more than 32-bits worth of dram and
>> no DMA offset we can't feed unaddressable memory to the device.
>> Unfortunately I have a very hard time following the implementation of
>> the TTM pool if it does anything else in this case.
> 
> The only other thing which comes to mind is using huge pages. Can you 
> try a kernel with CONFIG_TRANSPARENT_HUGEPAGE disabled?
> 


Any progress on this ?

We have a bugreport in Mageia with the hw:
Dell Inspiron 5100, 32-bit P4 processor, 2GB of RAM, Radeon Mobility 
7500 (RV200) graphics

that gets display issues too and reverting the offending commit restores 
normal behaviour.

and the same issue is still there with 5.5 series kernels.

--
Thomas
