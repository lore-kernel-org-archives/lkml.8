Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C38C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4697A20659
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgEGInf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 04:43:35 -0400
Received: from gofer.mess.org ([88.97.38.141]:36089 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgEGInf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 04:43:35 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 247D9C63EB; Thu,  7 May 2020 09:43:33 +0100 (BST)
Date:   Thu, 7 May 2020 09:43:33 +0100
From:   Sean Young <sean@mess.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     mchehab@kernel.org, kstewart@linuxfoundation.org,
        tomasbortoli@gmail.com, gregkh@linuxfoundation.org,
        allison@lohutok.net, tglx@linutronix.de,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: usb: ttusb-dec: avoid buffer overflow in
 ttusb_dec_handle_irq() when DMA failures/attacks occur
Message-ID: <20200507084332.GA14459@gofer.mess.org>
References: <20200505142110.7620-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505142110.7620-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 10:21:10PM +0800, Jia-Ju Bai wrote:
> In ttusb_dec_init_usb():
>   dec->irq_buffer = usb_alloc_coherent(...)
> 
> Thus, "dec->irq_buffer" is a DMA value, and it is assigned to "buffer"
> in ttusb_dec_handle_irq():
>   char *buffer = dec->irq_buffer;
> 
> When DMA failures or attacks occur, the value of buffer[4] can be
> changed at any time. In this case, "buffer[4] - 1 < ARRAY_SIZE(rc_keys)"
> can be first satisfied, and then the value of buffer[4] can be changed
> to a large number, causing a buffer-overflow vulnerability.
> 
> To avoid the risk of this vulnerability, buffer[4] is assigned to a
> non-DMA local variable "index" at the beginning of
> ttusb_dec_handle_irq(), and then this variable replaces each use of
> buffer[4] in the function.

This change is the urb completion handler. As I understand it, dma is
done by the usb host controller, in this case in response to an interrupt
request urb from the usb device side. 

In the completion handler, once we are done reading the data in the buffer,
the urb is submitted again. Only then can the interrupt request urb be resent
by the device, so there is no possibility of the dma buffer being
overwritten.

Now I might be mistaken of course. I can see that firewire and pci devices
do suffer from the problems describe in the paper, but not usb.

> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/media/usb/ttusb-dec/ttusb_dec.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/usb/ttusb-dec/ttusb_dec.c b/drivers/media/usb/ttusb-dec/ttusb_dec.c
> index 3198f9624b7c..8543c552515b 100644
> --- a/drivers/media/usb/ttusb-dec/ttusb_dec.c
> +++ b/drivers/media/usb/ttusb-dec/ttusb_dec.c
> @@ -250,6 +250,7 @@ static void ttusb_dec_handle_irq( struct urb *urb)
>  	struct ttusb_dec *dec = urb->context;
>  	char *buffer = dec->irq_buffer;
>  	int retval;
> +	u8 index = buffer[4];
>  
>  	switch(urb->status) {
>  		case 0: /*success*/
> @@ -281,11 +282,11 @@ static void ttusb_dec_handle_irq( struct urb *urb)
>  		 * this should/could be added later ...
>  		 * for now lets report each signal as a key down and up
>  		 */
> -		if (buffer[4] - 1 < ARRAY_SIZE(rc_keys)) {

Here buffer[4] is signed char, so if buffer[4] == 0 then (buffer[4] - 1) = -1,
this becomes "if (-1 < ARRAY_SIZE(rc_keys))", which evaluates to false,
due to it becoming an unsigned compare. _I think_.

Not the most readable code at all.

> -			dprintk("%s:rc signal:%d\n", __func__, buffer[4]);
> -			input_report_key(dec->rc_input_dev, rc_keys[buffer[4] - 1], 1);
> +		if (index - 1 < ARRAY_SIZE(rc_keys)) {
> +			dprintk("%s:rc signal:%d\n", __func__, index);
> +			input_report_key(dec->rc_input_dev, rc_keys[index - 1], 1);
>  			input_sync(dec->rc_input_dev);
> -			input_report_key(dec->rc_input_dev, rc_keys[buffer[4] - 1], 0);
> +			input_report_key(dec->rc_input_dev, rc_keys[index - 1], 0);

Like Greg said, this patch reduces the number of dereferences and makes
the code much cleaner, but the commit message is misleading.

>  			input_sync(dec->rc_input_dev);
>  		}
>  	}
> -- 
> 2.17.1


Thanks,

Sean
