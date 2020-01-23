Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300C2C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 10:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032DF2253D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 10:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgAWK6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 05:58:38 -0500
Received: from foss.arm.com ([217.140.110.172]:37720 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgAWK6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 05:58:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E298931B;
        Thu, 23 Jan 2020 02:58:35 -0800 (PST)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D4DC3F6C4;
        Thu, 23 Jan 2020 02:58:35 -0800 (PST)
Subject: Re: [RFC PATCH 03/11] firmware: arm_scmi: Add support for
 notifications message processing
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com
References: <20200120122333.46217-1-cristian.marussi@arm.com>
 <20200120122333.46217-4-cristian.marussi@arm.com>
 <4c59008e-6010-fb98-d7bf-8677454d1e4f@broadcom.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <049bac5a-dbc2-f3a2-a039-1dcf4c503103@arm.com>
Date:   Thu, 23 Jan 2020 10:58:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <4c59008e-6010-fb98-d7bf-8677454d1e4f@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jim

On 22/01/2020 23:27, Jim Quinlan wrote:
> Hi,
> 
> I tried "git am" on an mbox file  from these commits and get stuck on
> 
>     Applying: firmware: arm_scmi: Add receive buffer support for notifications
>     Applying: firmware: arm_scmi: Update protocol commands and notification list
>     Applying: firmware: arm_scmi: Add support for notifications message processing
>     error: patch failed: drivers/firmware/arm_scmi/driver.c:355
>     error: drivers/firmware/arm_scmi/driver.c: patch does not apply
> 
> 
> Could you please apply this email patchset and let me know if it works for you?  I am doing this onto
> 
>     257d0e20ec4f include: trace: Add SCMI header with trace events     
> 
> 

Sorry... my fault .. it is on top of the following commit on that same branch in fact:

729d3530a504 drivers: firmware: scmi: Extend SCMI transport layer by trace events

10:51 $ git am patch_scmi_notif/ext_V1/final/00*                          
Applying: firmware: arm_scmi: Add receive buffer support for notifications
Applying: firmware: arm_scmi: Update protocol commands and notification list         
Applying: firmware: arm_scmi: Add support for notifications message processing
Applying: firmware: arm_scmi: Add core notifications support                    
Applying: firmware: arm_scmi: Add notifications anti-tampering                                 
Applying: firmware: arm_scmi: Enable core notifications                  
Applying: firmware: arm_scmi: Add Power notifications support             
Applying: firmware: arm_scmi: Add Perf notifications support                
Applying: firmware: arm_scmi: Add Sensor notifications support             
Applying: firmware: arm_scmi: Add Reset notifications support                  
Applying: firmware: arm_scmi: Add Base notifications support            

I'll follow up to my cover to warn about this.

Thanks for trying it out.

Regards

Cristian

> as you directed.
> 
> Thanks,
> Jim
> 
> 
> 
> On 1/20/20 7:23 AM, Cristian Marussi wrote:
>> From: Sudeep Holla <sudeep.holla@arm.com>
>>
>> Add the mechanisms to distinguish notifications from delayed responses and
>> to properly fetch notification messages upon reception: notifications
>> processing does not continue further after the fetch phase.
>>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>> ---
>>  drivers/firmware/arm_scmi/driver.c | 92 +++++++++++++++++++++---------
>>  1 file changed, 65 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
>> index 9611e8037d77..28ed1f0cb417 100644
>> --- a/drivers/firmware/arm_scmi/driver.c
>> +++ b/drivers/firmware/arm_scmi/driver.c
>> @@ -212,6 +212,15 @@ static void scmi_fetch_response(struct scmi_xfer *xfer,
>>  	memcpy_fromio(xfer->rx.buf, mem->msg_payload + 4, xfer->rx.len);
>>  }
>>  
>> +static void scmi_fetch_notification(struct scmi_xfer *xfer, size_t max_len,
>> +				    struct scmi_shared_mem __iomem *mem)
>> +{
>> +	/* Skip only length of header in payload area i.e 4 bytes */
>> +	xfer->rx.len = min_t(size_t, max_len, ioread32(&mem->length) - 4);
>> +
>> +	memcpy_fromio(xfer->rx.buf, mem->msg_payload, xfer->rx.len);
>> +}
>> +
>>  /**
>>   * pack_scmi_header() - packs and returns 32-bit header
>>   *
>> @@ -339,6 +348,58 @@ __scmi_xfer_put(struct scmi_xfers_info *minfo, struct scmi_xfer *xfer)
>>  	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
>>  }
>>  
>> +static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
>> +{
>> +	struct scmi_xfer *xfer;
>> +	struct device *dev = cinfo->dev;
>> +	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
>> +	struct scmi_xfers_info *minfo = &info->rx_minfo;
>> +	struct scmi_shared_mem __iomem *mem = cinfo->payload;
>> +
>> +	xfer = scmi_xfer_get(cinfo->handle, minfo);
>> +	if (IS_ERR(xfer)) {
>> +		dev_err(dev, "failed to get free message slot (%ld)\n",
>> +			PTR_ERR(xfer));
>> +		iowrite32(SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE,
>> +			  &mem->channel_status);
>> +		return;
>> +	}
>> +
>> +	unpack_scmi_header(msg_hdr, &xfer->hdr);
>> +	scmi_dump_header_dbg(dev, &xfer->hdr);
>> +	scmi_fetch_notification(xfer, info->desc->max_msg_size, mem);
>> +	__scmi_xfer_put(minfo, xfer);
>> +
>> +	iowrite32(SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE, &mem->channel_status);
>> +}
>> +
>> +static void scmi_handle_xfer_delayed_resp(struct scmi_chan_info *cinfo,
>> +					  u16 xfer_id, bool delayed_resp)
>> +{
>> +	struct scmi_xfer *xfer;
>> +	struct device *dev = cinfo->dev;
>> +	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
>> +	struct scmi_xfers_info *minfo = &info->tx_minfo;
>> +	struct scmi_shared_mem __iomem *mem = cinfo->payload;
>> +
>> +	/* Are we even expecting this? */
>> +	if (!test_bit(xfer_id, minfo->xfer_alloc_table)) {
>> +		dev_err(dev, "message for %d is not expected!\n", xfer_id);
>> +		return;
>> +	}
>> +
>> +	xfer = &minfo->xfer_block[xfer_id];
>> +
>> +	scmi_dump_header_dbg(dev, &xfer->hdr);
>> +
>> +	scmi_fetch_response(xfer, mem);
>> +
>> +	if (delayed_resp)
>> +		complete(xfer->async_done);
>> +	else
>> +		complete(&xfer->done);
>> +}
>> +
>>  /**
>>   * scmi_rx_callback() - mailbox client callback for receive messages
>>   *
>> @@ -355,41 +416,18 @@ static void scmi_rx_callback(struct mbox_client *cl, void *m)
>>  {
>>  	u8 msg_type;
>>  	u32 msg_hdr;
>> -	u16 xfer_id;
>> -	struct scmi_xfer *xfer;
>>  	struct scmi_chan_info *cinfo = client_to_scmi_chan_info(cl);
>> -	struct device *dev = cinfo->dev;
>> -	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
>> -	struct scmi_xfers_info *minfo = &info->tx_minfo;
>>  	struct scmi_shared_mem __iomem *mem = cinfo->payload;
>>  
>>  	msg_hdr = ioread32(&mem->msg_header);
>>  	msg_type = MSG_XTRACT_TYPE(msg_hdr);
>> -	xfer_id = MSG_XTRACT_TOKEN(msg_hdr);
>>  
>>  	if (msg_type == MSG_TYPE_NOTIFICATION)
>> -		return; /* Notifications not yet supported */
>> -
>> -	/* Are we even expecting this? */
>> -	if (!test_bit(xfer_id, minfo->xfer_alloc_table)) {
>> -		dev_err(dev, "message for %d is not expected!\n", xfer_id);
>> -		return;
>> -	}
>> -
>> -	xfer = &minfo->xfer_block[xfer_id];
>> -
>> -	scmi_dump_header_dbg(dev, &xfer->hdr);
>> -
>> -	scmi_fetch_response(xfer, mem);
>> -
>> -	trace_scmi_rx_done(xfer->transfer_id, xfer->hdr.id,
>> -			   xfer->hdr.protocol_id, xfer->hdr.seq,
>> -			   msg_type);
>> -
>> -	if (msg_type == MSG_TYPE_DELAYED_RESP)
>> -		complete(xfer->async_done);
>> +		scmi_handle_notification(cinfo, msg_hdr);
>>  	else
>> -		complete(&xfer->done);
>> +		scmi_handle_xfer_delayed_resp(cinfo, MSG_XTRACT_TOKEN(msg_hdr),
>> +					      msg_type);
>> +
>>  }
>>  
>>  /**
> 
> 

