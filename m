Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37226C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F6C24670
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387579AbgBNP2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:28:50 -0500
Received: from foss.arm.com ([217.140.110.172]:34640 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387398AbgBNP2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:28:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A64E6328;
        Fri, 14 Feb 2020 07:28:49 -0800 (PST)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DAC3F3F68E;
        Fri, 14 Feb 2020 07:28:48 -0800 (PST)
Subject: Re: [RFC PATCH 03/11] firmware: arm_scmi: Add support for
 notifications message processing
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        james.quinlan@broadcom.com, lukasz.luba@arm.com,
        sudeep.holla@arm.com
References: <20200120122333.46217-1-cristian.marussi@arm.com>
 <20200120122333.46217-4-cristian.marussi@arm.com>
 <20200127173232.000045ac@Huawei.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <5a5096b6-5716-f786-4f53-88425531e2e6@arm.com>
Date:   Fri, 14 Feb 2020 15:28:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200127173232.000045ac@Huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 27/01/2020 17:32, Jonathan Cameron wrote:
> On Mon, 20 Jan 2020 12:23:25 +0000
> Cristian Marussi <cristian.marussi@arm.com> wrote:
> 
>> From: Sudeep Holla <sudeep.holla@arm.com>
>>
>> Add the mechanisms to distinguish notifications from delayed responses and
>> to properly fetch notification messages upon reception: notifications
>> processing does not continue further after the fetch phase.
>>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> 
> Couple of bits that seem more interesting than expected inline...
> 
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
> 
> Hmm. A function called *_delayed_resp that takes a boolean to say if
> it is a delayed_resp is in the category of non obvious....  Needs a rename
> at the very least.
> 

Changed logic and naming in v2, also because now v2 is on top of Viresh series
which makes transport layer independent. (in fact an additional dedicated patch
is dedicated to extend the transport layer for notifications too)


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
> First I wondered why this wasn't a switch which would make a clear distinction
> between notification path and delayed response... 
> 
> However, it seems delayed_resp path also handles other values of msg_type,
> though only 0 which is a command I think...
> 
> Passing a enum that I think can take 4 values, only 3 of which are defined
> into a function as a boolean is 'interesting'. Don't do that.
> 

Reworked the logic in v2

Thanks

Regards

Cristian
> 
>> +
>>  }
>>  
>>  /**
> 
> 

