Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1859FC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAAD92082F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbgBNP0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:26:00 -0500
Received: from foss.arm.com ([217.140.110.172]:34580 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729444AbgBNP0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:26:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80B7E328;
        Fri, 14 Feb 2020 07:25:59 -0800 (PST)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F58A3F68E;
        Fri, 14 Feb 2020 07:25:58 -0800 (PST)
Subject: Re: [RFC PATCH 01/11] firmware: arm_scmi: Add receive buffer support
 for notifications
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        james.quinlan@broadcom.com, lukasz.luba@arm.com,
        sudeep.holla@arm.com
References: <20200120122333.46217-1-cristian.marussi@arm.com>
 <20200120122333.46217-2-cristian.marussi@arm.com>
 <20200127170713.000013ee@Huawei.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <97365c4e-3672-64ec-50c7-28dc839a2d35@arm.com>
Date:   Fri, 14 Feb 2020 15:25:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200127170713.000013ee@Huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 27/01/2020 17:07, Jonathan Cameron wrote:
> On Mon, 20 Jan 2020 12:23:23 +0000
> Cristian Marussi <cristian.marussi@arm.com> wrote:
> 
>> From: Sudeep Holla <sudeep.holla@arm.com>
>>
>> With all the plumbing in place, let's just add the separate dedicated
>> receive buffers to handle notifications that can arrive asynchronously
>> from the platform firmware to OS.
>>
>> Also add check to see if the platform supports any receive channels
>> before allocating the receive buffers.
> 
> Perhaps hand hold the reader a tiny bit more by saying that we need
> to move the initialization later so that we can know *if* the receive
> channels are supported.  Took me a moment to figure out why you did that ;)
> 

Addressed in v2.

> One minor suggestion inline.
> 
>>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>  drivers/firmware/arm_scmi/driver.c | 24 ++++++++++++++++++------
>>  1 file changed, 18 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
>> index 2c96f6b5a7d8..9611e8037d77 100644
>> --- a/drivers/firmware/arm_scmi/driver.c
>> +++ b/drivers/firmware/arm_scmi/driver.c
>> @@ -123,6 +123,7 @@ struct scmi_chan_info {
>>   * @version: SCMI revision information containing protocol version,
>>   *	implementation version and (sub-)vendor identification.
>>   * @tx_minfo: Universal Transmit Message management info
>> + * @rx_minfo: Universal Receive Message management info
>>   * @tx_idr: IDR object to map protocol id to Tx channel info pointer
>>   * @rx_idr: IDR object to map protocol id to Rx channel info pointer
>>   * @protocols_imp: List of protocols implemented, currently maximum of
>> @@ -136,6 +137,7 @@ struct scmi_info {
>>  	struct scmi_revision_info version;
>>  	struct scmi_handle handle;
>>  	struct scmi_xfers_info tx_minfo;
>> +	struct scmi_xfers_info rx_minfo;
>>  	struct idr tx_idr;
>>  	struct idr rx_idr;
>>  	u8 *protocols_imp;
>> @@ -690,13 +692,13 @@ int scmi_handle_put(const struct scmi_handle *handle)
>>  	return 0;
>>  }
>>  
>> -static int scmi_xfer_info_init(struct scmi_info *sinfo)
>> +static int __scmi_xfer_info_init(struct scmi_info *sinfo, bool tx)
>>  {
>>  	int i;
>>  	struct scmi_xfer *xfer;
>>  	struct device *dev = sinfo->dev;
>>  	const struct scmi_desc *desc = sinfo->desc;
>> -	struct scmi_xfers_info *info = &sinfo->tx_minfo;
>> +	struct scmi_xfers_info *info = tx ? &sinfo->tx_minfo : &sinfo->rx_minfo;
> 
> Perhaps cleaner to just pass in the relevant info structure rather than a boolean
> to pick it.  Saves people having to check if the boolean is saying it's
> tx or rx when reading the call sites.
> 

Done in the upcoming v2.

Regards

Cristian

>>  
>>  	/* Pre-allocated messages, no more than what hdr.seq can support */
>>  	if (WARN_ON(desc->max_msg >= MSG_TOKEN_MAX)) {
>> @@ -731,6 +733,16 @@ static int scmi_xfer_info_init(struct scmi_info *sinfo)
>>  	return 0;
>>  }
>>  
>> +static int scmi_xfer_info_init(struct scmi_info *sinfo)
>> +{
>> +	int ret = __scmi_xfer_info_init(sinfo, true);
>> +
>> +	if (!ret && idr_find(&sinfo->rx_idr, SCMI_PROTOCOL_BASE))
>> +		ret = __scmi_xfer_info_init(sinfo, false);
>> +
>> +	return ret;
>> +}
>> +
>>  static int scmi_mailbox_check(struct device_node *np, int idx)
>>  {
>>  	return of_parse_phandle_with_args(np, "mboxes", "#mbox-cells",
>> @@ -908,10 +920,6 @@ static int scmi_probe(struct platform_device *pdev)
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
>> @@ -924,6 +932,10 @@ static int scmi_probe(struct platform_device *pdev)
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

