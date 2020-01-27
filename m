Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA08C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B29124672
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgA0Rcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 12:32:35 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2311 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727296AbgA0Rcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 12:32:35 -0500
Received: from lhreml706-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id D55F8CCDE192AD8B62A3;
        Mon, 27 Jan 2020 17:32:33 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml706-cah.china.huawei.com (10.201.108.47) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 27 Jan 2020 17:32:33 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 27 Jan
 2020 17:32:33 +0000
Date:   Mon, 27 Jan 2020 17:32:32 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <james.quinlan@broadcom.com>, <lukasz.luba@arm.com>,
        <sudeep.holla@arm.com>
Subject: Re: [RFC PATCH 03/11] firmware: arm_scmi: Add support for
 notifications message processing
Message-ID: <20200127173232.000045ac@Huawei.com>
In-Reply-To: <20200120122333.46217-4-cristian.marussi@arm.com>
References: <20200120122333.46217-1-cristian.marussi@arm.com>
        <20200120122333.46217-4-cristian.marussi@arm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml737-chm.china.huawei.com (10.201.108.187) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2020 12:23:25 +0000
Cristian Marussi <cristian.marussi@arm.com> wrote:

> From: Sudeep Holla <sudeep.holla@arm.com>
> 
> Add the mechanisms to distinguish notifications from delayed responses and
> to properly fetch notification messages upon reception: notifications
> processing does not continue further after the fetch phase.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Couple of bits that seem more interesting than expected inline...

> ---
>  drivers/firmware/arm_scmi/driver.c | 92 +++++++++++++++++++++---------
>  1 file changed, 65 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 9611e8037d77..28ed1f0cb417 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -212,6 +212,15 @@ static void scmi_fetch_response(struct scmi_xfer *xfer,
>  	memcpy_fromio(xfer->rx.buf, mem->msg_payload + 4, xfer->rx.len);
>  }
>  
> +static void scmi_fetch_notification(struct scmi_xfer *xfer, size_t max_len,
> +				    struct scmi_shared_mem __iomem *mem)
> +{
> +	/* Skip only length of header in payload area i.e 4 bytes */
> +	xfer->rx.len = min_t(size_t, max_len, ioread32(&mem->length) - 4);
> +
> +	memcpy_fromio(xfer->rx.buf, mem->msg_payload, xfer->rx.len);
> +}
> +
>  /**
>   * pack_scmi_header() - packs and returns 32-bit header
>   *
> @@ -339,6 +348,58 @@ __scmi_xfer_put(struct scmi_xfers_info *minfo, struct scmi_xfer *xfer)
>  	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
>  }
>  
> +static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
> +{
> +	struct scmi_xfer *xfer;
> +	struct device *dev = cinfo->dev;
> +	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
> +	struct scmi_xfers_info *minfo = &info->rx_minfo;
> +	struct scmi_shared_mem __iomem *mem = cinfo->payload;
> +
> +	xfer = scmi_xfer_get(cinfo->handle, minfo);
> +	if (IS_ERR(xfer)) {
> +		dev_err(dev, "failed to get free message slot (%ld)\n",
> +			PTR_ERR(xfer));
> +		iowrite32(SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE,
> +			  &mem->channel_status);
> +		return;
> +	}
> +
> +	unpack_scmi_header(msg_hdr, &xfer->hdr);
> +	scmi_dump_header_dbg(dev, &xfer->hdr);
> +	scmi_fetch_notification(xfer, info->desc->max_msg_size, mem);
> +	__scmi_xfer_put(minfo, xfer);
> +
> +	iowrite32(SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE, &mem->channel_status);
> +}
> +
> +static void scmi_handle_xfer_delayed_resp(struct scmi_chan_info *cinfo,
> +					  u16 xfer_id, bool delayed_resp)

Hmm. A function called *_delayed_resp that takes a boolean to say if
it is a delayed_resp is in the category of non obvious....  Needs a rename
at the very least.

> +{
> +	struct scmi_xfer *xfer;
> +	struct device *dev = cinfo->dev;
> +	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
> +	struct scmi_xfers_info *minfo = &info->tx_minfo;
> +	struct scmi_shared_mem __iomem *mem = cinfo->payload;
> +
> +	/* Are we even expecting this? */
> +	if (!test_bit(xfer_id, minfo->xfer_alloc_table)) {
> +		dev_err(dev, "message for %d is not expected!\n", xfer_id);
> +		return;
> +	}
> +
> +	xfer = &minfo->xfer_block[xfer_id];
> +
> +	scmi_dump_header_dbg(dev, &xfer->hdr);
> +
> +	scmi_fetch_response(xfer, mem);
> +
> +	if (delayed_resp)
> +		complete(xfer->async_done);
> +	else
> +		complete(&xfer->done);
> +}
> +
>  /**
>   * scmi_rx_callback() - mailbox client callback for receive messages
>   *
> @@ -355,41 +416,18 @@ static void scmi_rx_callback(struct mbox_client *cl, void *m)
>  {
>  	u8 msg_type;
>  	u32 msg_hdr;
> -	u16 xfer_id;
> -	struct scmi_xfer *xfer;
>  	struct scmi_chan_info *cinfo = client_to_scmi_chan_info(cl);
> -	struct device *dev = cinfo->dev;
> -	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
> -	struct scmi_xfers_info *minfo = &info->tx_minfo;
>  	struct scmi_shared_mem __iomem *mem = cinfo->payload;
>  
>  	msg_hdr = ioread32(&mem->msg_header);
>  	msg_type = MSG_XTRACT_TYPE(msg_hdr);
> -	xfer_id = MSG_XTRACT_TOKEN(msg_hdr);
>  
>  	if (msg_type == MSG_TYPE_NOTIFICATION)
> -		return; /* Notifications not yet supported */
> -
> -	/* Are we even expecting this? */
> -	if (!test_bit(xfer_id, minfo->xfer_alloc_table)) {
> -		dev_err(dev, "message for %d is not expected!\n", xfer_id);
> -		return;
> -	}
> -
> -	xfer = &minfo->xfer_block[xfer_id];
> -
> -	scmi_dump_header_dbg(dev, &xfer->hdr);
> -
> -	scmi_fetch_response(xfer, mem);
> -
> -	trace_scmi_rx_done(xfer->transfer_id, xfer->hdr.id,
> -			   xfer->hdr.protocol_id, xfer->hdr.seq,
> -			   msg_type);
> -
> -	if (msg_type == MSG_TYPE_DELAYED_RESP)
> -		complete(xfer->async_done);
> +		scmi_handle_notification(cinfo, msg_hdr);
>  	else
> -		complete(&xfer->done);
> +		scmi_handle_xfer_delayed_resp(cinfo, MSG_XTRACT_TOKEN(msg_hdr),
> +					      msg_type);
First I wondered why this wasn't a switch which would make a clear distinction
between notification path and delayed response... 

However, it seems delayed_resp path also handles other values of msg_type,
though only 0 which is a command I think...

Passing a enum that I think can take 4 values, only 3 of which are defined
into a function as a boolean is 'interesting'. Don't do that.


> +
>  }
>  
>  /**


