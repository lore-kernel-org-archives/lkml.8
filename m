Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45238C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2274B21556
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgCBPsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 10:48:01 -0500
Received: from foss.arm.com ([217.140.110.172]:34322 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727075AbgCBPsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:48:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAB462F;
        Mon,  2 Mar 2020 07:48:00 -0800 (PST)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDCC23F534;
        Mon,  2 Mar 2020 07:47:59 -0800 (PST)
Subject: Re: [RFC PATCH v3 01/13] firmware: arm_scmi: Add receive buffer
 support for notifications
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com
References: <20200224144124.2008-1-cristian.marussi@arm.com>
 <20200224144124.2008-2-cristian.marussi@arm.com>
 <20200302145213.00003304@Huawei.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <1dbf5793-d8be-bd0b-c302-3874d2346292@arm.com>
Date:   Mon, 2 Mar 2020 15:47:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200302145213.00003304@Huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2020 14:52, Jonathan Cameron wrote:
> On Mon, 24 Feb 2020 14:41:12 +0000
> Cristian Marussi <cristian.marussi@arm.com> wrote:
> 
>> From: Sudeep Holla <sudeep.holla@arm.com>
>>
>> With all the plumbing in place, let's just add the separate dedicated
>> receive buffers to handle notifications that can arrive asynchronously
>> from the platform firmware to OS.
>>
>> Also add one check to see if the platform supports any receive channels
>> before allocating the receive buffers: since those buffers are optionally
>> supported though, the whole xfer initialization is also postponed to be
>> able to check for their existence in advance.
>>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> [Changed parameters in __scmi_xfer_info_init()]
>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> Looks good to me.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

Thanks for the review.

As a side note,  in a couple of days I'm going to push out a v4, which beside trying to
address some concern from Jim regarding the number of memcopies, it will review drastically
subsystem initialization and partially also the locking strategy to address some known issues
present in v3 (which could be exposed loading SCMI protocols as modules in a deferred way).

In short, be aware that, the implementation in patches 05/06/07/08 will be radically different
in the upcoming series.

Regards

Cristian

>> ---
>> V1 --> V2:
>> - reviewed commit message
>> - reviewed parameters of __scmi_xfer_info_init()
>> ---
>>  drivers/firmware/arm_scmi/driver.c | 24 ++++++++++++++++++------
>>  1 file changed, 18 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
>> index dbec767222e9..efb660c34b57 100644
>> --- a/drivers/firmware/arm_scmi/driver.c
>> +++ b/drivers/firmware/arm_scmi/driver.c
>> @@ -76,6 +76,7 @@ struct scmi_xfers_info {
>>   *	implementation version and (sub-)vendor identification.
>>   * @handle: Instance of SCMI handle to send to clients
>>   * @tx_minfo: Universal Transmit Message management info
>> + * @rx_minfo: Universal Receive Message management info
>>   * @tx_idr: IDR object to map protocol id to Tx channel info pointer
>>   * @rx_idr: IDR object to map protocol id to Rx channel info pointer
>>   * @protocols_imp: List of protocols implemented, currently maximum of
>> @@ -89,6 +90,7 @@ struct scmi_info {
>>  	struct scmi_revision_info version;
>>  	struct scmi_handle handle;
>>  	struct scmi_xfers_info tx_minfo;
>> +	struct scmi_xfers_info rx_minfo;
>>  	struct idr tx_idr;
>>  	struct idr rx_idr;
>>  	u8 *protocols_imp;
>> @@ -525,13 +527,13 @@ int scmi_handle_put(const struct scmi_handle *handle)
>>  	return 0;
>>  }
>>  
>> -static int scmi_xfer_info_init(struct scmi_info *sinfo)
>> +static int __scmi_xfer_info_init(struct scmi_info *sinfo,
>> +				 struct scmi_xfers_info *info)
>>  {
>>  	int i;
>>  	struct scmi_xfer *xfer;
>>  	struct device *dev = sinfo->dev;
>>  	const struct scmi_desc *desc = sinfo->desc;
>> -	struct scmi_xfers_info *info = &sinfo->tx_minfo;
>>  
>>  	/* Pre-allocated messages, no more than what hdr.seq can support */
>>  	if (WARN_ON(desc->max_msg >= MSG_TOKEN_MAX)) {
>> @@ -566,6 +568,16 @@ static int scmi_xfer_info_init(struct scmi_info *sinfo)
>>  	return 0;
>>  }
>>  
>> +static int scmi_xfer_info_init(struct scmi_info *sinfo)
>> +{
>> +	int ret = __scmi_xfer_info_init(sinfo, &sinfo->tx_minfo);
>> +
>> +	if (!ret && idr_find(&sinfo->rx_idr, SCMI_PROTOCOL_BASE))
>> +		ret = __scmi_xfer_info_init(sinfo, &sinfo->rx_minfo);
>> +
>> +	return ret;
>> +}
>> +
>>  static int scmi_chan_setup(struct scmi_info *info, struct device *dev,
>>  			   int prot_id, bool tx)
>>  {
>> @@ -699,10 +711,6 @@ static int scmi_probe(struct platform_device *pdev)
>>  	info->desc = desc;
>>  	INIT_LIST_HEAD(&info->node);
>>  
>> -	ret = scmi_xfer_info_init(info);
>> -	if (ret)
>> -		return ret;
>> -
>>  	platform_set_drvdata(pdev, info);
>>  	idr_init(&info->tx_idr);
>>  	idr_init(&info->rx_idr);
>> @@ -715,6 +723,10 @@ static int scmi_probe(struct platform_device *pdev)
>>  	if (ret)
>>  		return ret;
>>  
>> +	ret = scmi_xfer_info_init(info);
>> +	if (ret)
>> +		return ret;
>> +
>>  	ret = scmi_base_protocol_init(handle);
>>  	if (ret) {
>>  		dev_err(dev, "unable to communicate with SCMI(%d)\n", ret);
> 
> 

