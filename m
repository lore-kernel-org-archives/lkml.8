Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989B9C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B65A2468E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgB1Q11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 11:27:27 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:60955 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1Q10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:27:26 -0500
Received: from [192.168.1.183] ([37.4.249.171]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MJV5K-1inyfA4AHY-00JvWc; Fri, 28 Feb 2020 17:26:49 +0100
Subject: Re: [RFT PATCH 1/4] usb: dwc2: Simplify and fix DMA alignment code
To:     Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QW50dGkgU2VwcMOkbMOk?= <a.seppala@gmail.com>,
        Boris ARZUR <boris@konbu.org>, linux-usb@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Martin Schiller <ms@dev.tdt.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
References: <20200226210414.28133-1-linux@roeck-us.net>
 <20200226210414.28133-2-linux@roeck-us.net>
 <CAD=FV=WDd4E-zDW73kb-qHo1QYQrD3BTgVpE70rzowpgeXVy7w@mail.gmail.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Openpgp: preference=signencrypt
Autocrypt: addr=stefan.wahren@i2se.com; keydata=
 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 AQ==
Message-ID: <ea445ef5-3e8a-1e58-d264-0d7dad064fc8@i2se.com>
Date:   Fri, 28 Feb 2020 17:26:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=WDd4E-zDW73kb-qHo1QYQrD3BTgVpE70rzowpgeXVy7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:8Ci6HbpqEwshCElsKWJpQlfMV5T1blfqm6rwrhbJgIr7QXruf3A
 KYX8XYjJEep5W1y6Kww6Bu682WjJ1E8hN2zqjwworTkvSjJyyp31+HoSJOghY60FyQmcg3M
 Z3BVoXmsVJOeXISnjRi2q5AZxixB846WWAL/mO21CESKL0ORZ9mFawXyy47SGRGyRn7GSen
 ssbZKuOfUY20oHwu3rVOQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Sl3WOhjELo0=:mpC+1+m9q8DIQof6qeCWyW
 U/Hs9iSfD0FxlmHjo0+BxXdVL+kRGvMn31X33MEQjeXZWH2Bxj9mROzgy+rYfAn3TeROefQjN
 sKYYQE+F3Vfaar2BiThjYVETsJx6IKZqzY0zogF2yyBdrUzTaRd0Bd7DFlq9aUbQ6aubEKc4Y
 UkoAJGCB7VLZrlr0gO9j4DRXgPJLOhFtIq4qG6U0wyipHF4a+r00VEQvVASHgGQg3p8Ur0cpD
 /TXjynQQxT54Hj7xvTo1HPeU6zeeK2jlE8kWY1f18TGHfHMOQc0gXvcCoxXMu9eQ4whT+elxF
 lUgI3CYTtByqHyFnfM+sJSkITxYeFEBK49d3EQMWNfS8uPD2rlqS6i7Pn/bSa2f7oJ9vHGLKN
 BTE/izdMBBdejwUr3sMNLHf8XqBULh7OlrVdGPhSwKJJ2o6xT30MP4U1upVt6BUsjfo60WjVU
 /XXxevAKpC07uPhS7r/xlpJVEs1ax0KU8sJqd6r6g1kXeG/q4eZeAnhAPBvbxr8n6u4xWOow0
 0v56m9SipqK8WG5veKO6gy+b6o8C/1x+tjQhsKldThHmHUrXiL+TXuhFOb1cIXPhDkXLRphkg
 exJYfi1jKRCRFbachjKwirAKbuaO8XWpi251jIKyj7T8vX9SS/9sztkXP6OHTTBVpPELKJARQ
 hxI7pqyqQnsvwHf0Oo4NVdLBbMEf6akqU08K2ulW7WiFJ1Cqg/kafur30Aopp4Zn2RtuzRBHC
 Xg1GLFbcAsY83vL982nPqa8T5kWiaWqRR4L77PuVLu2jRwWikrnI0jpprfWswgOERhjvk87fV
 +rZvrRraLNCg0/RRQza9mxg0zJjR7fLqmeq8mZ5HlfNTCaaBnFoY7b4tMVGKZeyDN9Kcabr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

[add Nicolas the new BCM2835 maintainer]

Am 27.02.20 um 23:06 schrieb Doug Anderson:
> Hi,
>
> On Wed, Feb 26, 2020 at 1:04 PM Guenter Roeck <linux@roeck-us.net> wrote:
>> The code to align buffers for DMA was first introduced with commit
>> 3bc04e28a030 ("usb: dwc2: host: Get aligned DMA in a more supported way").
>> It was updated with commit 56406e017a88 ("usb: dwc2: Fix DMA alignment
>> to start at allocated boundary") because it did not really align buffers to
>> DMA boundaries but to word offsets. This was then optimized in commit
>> 1e111e885238 ("usb: dwc2: Fix inefficient copy of unaligned buffers")
>> to only copy actual data rather than the whole buffer. Commit 4a4863bf2e79
>> ("usb: dwc2: Fix DMA cache alignment issues") changed this further to add
>> a padding at the end of the buffer to ensure that the old data pointer is
>> not in the same cache line as the buffer.
>>
>> This last commit states "Otherwise, the stored_xfer_buffer gets corrupted
>> for IN URBs on non-cache-coherent systems". However, such corruptions are
>> still observed. This suggests that the commit may have been hiding a
>> problem rather than fixing it. Further analysis shows that this is indeed
>> the case: The code in dwc2_hc_start_transfer() assumes that the transfer
>> size is a multiple of wMaxPacketSize, and rounds up the transfer size
>> communicated to the chip accordingly. Added debug code confirms that
>> the chip does under some circumstances indeed send more data than requested
>> in the urb receive buffer size.
>>
>> On top of that, it turns out that buffers are still not guaranteed to be
>> aligned to dma_get_cache_alignment(), but to DWC2_USB_DMA_ALIGN (4).
>> Further debugging shows that packets aligned to DWC2_USB_DMA_ALIGN
>> but not to dma_get_cache_alignment() are indeed common and work just fine.
>> This suggests that commit 56406e017a88 was not really necessary because
>> even without it packets were already aligned to DWC2_USB_DMA_ALIGN.
>>
>> To simplify the code, move the old data pointer back to the beginning of
>> the new buffer, restoring most of the original commit. Stop aligning the
>> buffer to dma_get_cache_alignment() since it isn't needed and only makes
>> the code more complex. Instead, ensure that the allocated buffer is a
>> multiple of wMaxPacketSize to ensure that the chip does not write beyond
>> the end of the buffer.
> I do like the cleanliness of being able to easily identify the old
> buffer (AKA by putting it first) and I agree that the existing code
> was only really guaranteeing 4-byte alignment and if we truly needed
> more alignment then we'd be allocating a lot more bounce buffers
> (which is pretty expensive).
>
> ...but the argument in commit 56406e017a88 ("usb: dwc2: Fix DMA
> alignment to start at allocated boundary") is still a compelling one.
> Maybe at least put a comment in the code next to the "#define
> DWC2_USB_DMA_ALIGN" saying that we think that this is enough alignment
> for anyone using dwc2's built-in DMA logic?
>
>
>> Cc: Douglas Anderson <dianders@chromium.org>
>> Cc: Boris Arzur <boris@konbu.org>
>> Fixes: 56406e017a88 ("usb: dwc2: Fix DMA alignment to start at allocated boundary")
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>  drivers/usb/dwc2/hcd.c | 67 ++++++++++++++++++++++--------------------
>>  1 file changed, 35 insertions(+), 32 deletions(-)
> Sorry for such a mess and thank you for all the work tracking down and
> documenting all the problems.  Clearly deep understanding of DMA is
> not something I can claim.  :(
>
> A few points of order first:
> * Although get_maintainer doesn't identify him, it has seemed like
> Felipe Balbi lands most of the dwc2 things.  Probably a good idea to
> CC him.
> * I have historically found Stefan Wahren interested in dwc2 fixes and
> willing to test them on Raspberry Pi w/ various peripherals.

i'm not the BCM2835 maintainer anymore, but will give it a try.

Regards
Stefan

