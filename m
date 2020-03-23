Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95691C54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF3620719
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgCWQ4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:56:53 -0400
Received: from ciao.gmane.io ([159.69.161.202]:56956 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727586AbgCWQ4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:56:52 -0400
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glk-linux-kernel-4@m.gmane-mx.org>)
        id 1jGQNe-0005Ro-VT
        for linux-kernel@vger.kernel.org; Mon, 23 Mar 2020 17:56:50 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] usbip: vhci_hcd: slighly simplify code in
 'vhci_urb_dequeue()'
Date:   Mon, 23 Mar 2020 17:56:46 +0100
Message-ID: <2fb983be-2a42-1b89-447a-a7415ffc7335@wanadoo.fr>
References: <20200321152938.19580-1-christophe.jaillet@wanadoo.fr>
 <c8e319c8-cd65-2c2c-df5d-e75908ca63b7@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <c8e319c8-cd65-2c2c-df5d-e75908ca63b7@kernel.org>
Content-Language: en-US
Cc:     linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20200323165646.qcQF6KroeiwqFOLEEwM7EmPF9Moljfo9e9rJyISdFcE@z>

Le 23/03/2020 à 17:48, shuah a écrit :
> On 3/21/20 9:29 AM, Christophe JAILLET wrote:
>> The allocation of 'unlink' can be moved before a spin_lock.
>> This slighly simplifies the error handling if the memory allocation 
>> fails,
>
> slightly (spelling nit)
>
>> aligns the code structure with what is done in 'vhci_tx_urb()' and 
>> reduces
>> potential lock contention.
>>
>
> Are you seeing any problems or is this a potential lock contention?
> If you are seeing issues, please share the problem seen.
>
No, the issue is just theoretical.


>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   drivers/usb/usbip/vhci_hcd.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
>> index 65850e9c7190..b909a634260c 100644
>> --- a/drivers/usb/usbip/vhci_hcd.c
>> +++ b/drivers/usb/usbip/vhci_hcd.c
>> @@ -905,17 +905,16 @@ static int vhci_urb_dequeue(struct usb_hcd 
>> *hcd, struct urb *urb, int status)
>>           /* tcp connection is alive */
>>           struct vhci_unlink *unlink;
>>   -        spin_lock(&vdev->priv_lock);
>> -
>
> This change might simplify the error path, however it could
> open a race window with the unlink activity during 
> vhci_shutdown_connection() when the connection is being taken
> down. It would be safer to hold both locks as soon as the
> connection check is done.

My proposal was just a small clean-up (from my point of view at least).
If it can have some side effects, please, just consider it as a NACK.

CJ

>
>>           /* setup CMD_UNLINK pdu */
>>           unlink = kzalloc(sizeof(struct vhci_unlink), GFP_ATOMIC);
>>           if (!unlink) {
>> -            spin_unlock(&vdev->priv_lock);
>>               spin_unlock_irqrestore(&vhci->lock, flags);
>>               usbip_event_add(&vdev->ud, VDEV_EVENT_ERROR_MALLOC);
>>               return -ENOMEM;
>>           }
>>   +        spin_lock(&vdev->priv_lock);
>> +
>>           unlink->seqnum = atomic_inc_return(&vhci_hcd->seqnum);
>>           if (unlink->seqnum == 0xffff)
>>               pr_info("seqnum max\n");
>>
>
> thanks,
> -- Shuah
>


