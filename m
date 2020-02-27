Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AE8C3F2C2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D79246A2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbijVVoe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbgB0W1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 17:27:35 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42316 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729735AbgB0W1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 17:27:34 -0500
Received: by mail-pg1-f196.google.com with SMTP id h8so403361pgs.9;
        Thu, 27 Feb 2020 14:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+SYZ3PTRcJJPdMKWPf5/BPWv0CiT+x6CCVVtS8R2A7s=;
        b=sbijVVoeLw1m3CsJ2BG03OaYDqtIacz0kP7myxiXgyzU+/H2Im4uQ33ZiOCTTcOvmK
         z5xddBxu0zZ+wUVDaRkmeAfx9iyiCe/htECUOya93ShQOWW1ZGDTKz9LpO0U7E/c58l4
         AP22p8BX2tDve08kjDBFX/z11ZbywiAqVk+A7qyuOXxTkSaOrPXqJJJOP3uD3pBD32Ma
         w2s04OMZg7XwHWfl5uBugy3HG+S96nd+BOGA6s1/pePluFHITSsSrPLSsNQsNDQERpQ+
         nf+0eE7ctIkPUKeCZNbrnQrmyjE7q9PXwwCmenNAWtjMvuOG0bu3//6UMnmObqVfJK7h
         n3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+SYZ3PTRcJJPdMKWPf5/BPWv0CiT+x6CCVVtS8R2A7s=;
        b=MTPjtrn8bOOa3x6g3XP3dvlrLQqcyK2RB0hYD/1BDjJgjVOqbt7p4z9+cIx+EDiOdm
         2hzDTVd0+8TNof+p7bC5bgpZ8GqU0FtnNHFU8WkmlB87iIn9idjpl02atVth7tTVRq6p
         52JUZQuKrOkeuFcnrv726lyr1ldEx5GUH4EMLWpzgEgkaZ85BKfBQcDdY9228eY9tk7B
         4u7gRvEL4DMXxKFwhjo6xieHUosCYc2r0m/PfhNl/6/wvqR2dPbpvwM9LWTk+cbSRRe5
         Sy99tHmPq/Cm2KRA2w52bwaooBvaMqhu2WCzt89YxOSePo8Rh1oYrKdUjU/Xpq5Bf0t5
         I3RA==
X-Gm-Message-State: APjAAAVEsgRRnM4uVVFbmbeDnJNy5Zpw3liqzP8z2pe77ieC7uYtFzhf
        aNLANwlo1YniP54x3zOnFyLkYoRM
X-Google-Smtp-Source: APXvYqzZN8kj9UAWLI+YXRS3ytzvcbVBxAAm7QSwgmIv3SAv6KaQ/+8c6cIndzqQz1R0PqZWRz9V0Q==
X-Received: by 2002:a63:ce03:: with SMTP id y3mr1500757pgf.427.1582842452830;
        Thu, 27 Feb 2020 14:27:32 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z5sm8818619pfq.3.2020.02.27.14.27.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 14:27:32 -0800 (PST)
Subject: Re: [RFT PATCH 1/4] usb: dwc2: Simplify and fix DMA alignment code
To:     Doug Anderson <dianders@chromium.org>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QW50dGkgU2VwcMOkbMOk?= <a.seppala@gmail.com>,
        Boris ARZUR <boris@konbu.org>, linux-usb@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Martin Schiller <ms@dev.tdt.de>
References: <20200226210414.28133-1-linux@roeck-us.net>
 <20200226210414.28133-2-linux@roeck-us.net>
 <CAD=FV=WDd4E-zDW73kb-qHo1QYQrD3BTgVpE70rzowpgeXVy7w@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <ce3357a1-467f-1241-ae0d-2e113116ca8d@roeck-us.net>
Date:   Thu, 27 Feb 2020 14:27:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=WDd4E-zDW73kb-qHo1QYQrD3BTgVpE70rzowpgeXVy7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/20 2:06 PM, Doug Anderson wrote:
> Hi,
> 
> On Wed, Feb 26, 2020 at 1:04 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
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
> 
> I do like the cleanliness of being able to easily identify the old
> buffer (AKA by putting it first) and I agree that the existing code
> was only really guaranteeing 4-byte alignment and if we truly needed
> more alignment then we'd be allocating a lot more bounce buffers
> (which is pretty expensive).
> 
> ...but the argument in commit 56406e017a88 ("usb: dwc2: Fix DMA
> alignment to start at allocated boundary") is still a compelling one.

Sure, but, as mentioned above, it wasn't followed anyway.

> Maybe at least put a comment in the code next to the "#define
> DWC2_USB_DMA_ALIGN" saying that we think that this is enough alignment
> for anyone using dwc2's built-in DMA logic?
> 
Makes sense. I'll add a comment.

> 
>> Cc: Douglas Anderson <dianders@chromium.org>
>> Cc: Boris Arzur <boris@konbu.org>
>> Fixes: 56406e017a88 ("usb: dwc2: Fix DMA alignment to start at allocated boundary")
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>  drivers/usb/dwc2/hcd.c | 67 ++++++++++++++++++++++--------------------
>>  1 file changed, 35 insertions(+), 32 deletions(-)
> 
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
> * Since one of the commits you refer to was written by Martin Schiller
> it probably wouldn't hurt to CC him.
> 
I'll do that.

> 
>> diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
>> index b90f858af960..f6d8cc9cee34 100644
>> --- a/drivers/usb/dwc2/hcd.c
>> +++ b/drivers/usb/dwc2/hcd.c
>> @@ -2471,19 +2471,21 @@ static int dwc2_alloc_split_dma_aligned_buf(struct dwc2_hsotg *hsotg,
>>
>>  #define DWC2_USB_DMA_ALIGN 4
>>
>> +struct dma_aligned_buffer {
>> +       void *old_xfer_buffer;
>> +       u8 data[0];
>> +};
>> +
>>  static void dwc2_free_dma_aligned_buffer(struct urb *urb)
>>  {
>> -       void *stored_xfer_buffer;
>> +       struct dma_aligned_buffer *dma;
>>         size_t length;
>>
>>         if (!(urb->transfer_flags & URB_ALIGNED_TEMP_BUFFER))
>>                 return;
>>
>> -       /* Restore urb->transfer_buffer from the end of the allocated area */
>> -       memcpy(&stored_xfer_buffer,
>> -              PTR_ALIGN(urb->transfer_buffer + urb->transfer_buffer_length,
>> -                        dma_get_cache_alignment()),
>> -              sizeof(urb->transfer_buffer));
>> +       dma = container_of(urb->transfer_buffer,
>> +                          struct dma_aligned_buffer, data);
>>
>>         if (usb_urb_dir_in(urb)) {
>>                 if (usb_pipeisoc(urb->pipe))
>> @@ -2491,49 +2493,50 @@ static void dwc2_free_dma_aligned_buffer(struct urb *urb)
>>                 else
>>                         length = urb->actual_length;
>>
>> -               memcpy(stored_xfer_buffer, urb->transfer_buffer, length);
>> +               memcpy(dma->old_xfer_buffer, dma->data, length);
>>         }
>> -       kfree(urb->transfer_buffer);
>> -       urb->transfer_buffer = stored_xfer_buffer;
>> +       urb->transfer_buffer = dma->old_xfer_buffer;
>> +       kfree(dma);
>>
>>         urb->transfer_flags &= ~URB_ALIGNED_TEMP_BUFFER;
>>  }
>>
>>  static int dwc2_alloc_dma_aligned_buffer(struct urb *urb, gfp_t mem_flags)
>>  {
>> -       void *kmalloc_ptr;
>> +       struct dma_aligned_buffer *dma;
>>         size_t kmalloc_size;
>>
>> -       if (urb->num_sgs || urb->sg ||
>> -           urb->transfer_buffer_length == 0 ||
>> +       if (urb->num_sgs || urb->sg || urb->transfer_buffer_length == 0 ||
>> +           (urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP) ||
>>             !((uintptr_t)urb->transfer_buffer & (DWC2_USB_DMA_ALIGN - 1)))
> 
> Maybe I'm misunderstanding things, but it feels like we need something
> more here.  Specifically I'm worried about the fact when the transfer
> buffer is already aligned but the length is not a multiple of the
> endpoint's maximum transfer size.  You need to handle that, right?
> AKA something like this (untested):
> 
> /* Simple case of not having to allocate a bounce buffer */
> if (urb->num_sgs || urb->sg || urb->transfer_buffer_length == 0 ||
>     (urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP))
>   return 0;
> 
> /* Can also avoid bounce buffer if alignment and size are good */
> maxp = usb_endpoint_maxp(&ep->desc);
> if (maxp == urb->transfer_buffer_length &&

No, transfer_buffer_length would have to be a multiple of maxp. There
are many situations where roundup(transfer_buffer_length, maxp) !=
transfer_buffer_length. I agree, this would be the prudent approach
(and it was my original implementation), but then it didn't seem to
cause trouble so far, and I was hesitant to add it in because it results
in creating temporary buffers for almost every receive operation.
I'd like to get some test feedback from Boris - if the current code
causes crashes with his use case, we'll know that it is needed.
Otherwise, we'll have to decide if the current approach (with fewer
copies) is worth the risk, or if we want to play save and always
copy if roundup(transfer_buffer_length, maxp) != transfer_buffer_length.

Thanks,
Guenter

> 
>     !((uintptr_t)urb->transfer_buffer & (DWC2_USB_DMA_ALIGN - 1)))
>   return 0;
> >
> Other than that this looks good to me.
> 
> -Doug
> 

