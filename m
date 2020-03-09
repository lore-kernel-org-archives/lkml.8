Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6157EC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371A524655
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgCIQjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 12:39:46 -0400
Received: from foss.arm.com ([217.140.110.172]:54508 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbgCIQjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 12:39:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EA4F30E;
        Mon,  9 Mar 2020 09:39:45 -0700 (PDT)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A6263F534;
        Mon,  9 Mar 2020 09:39:44 -0700 (PDT)
Subject: Re: [PATCH v4 09/13] firmware: arm_scmi: Add Power notifications
 support
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com
References: <20200304162558.48836-1-cristian.marussi@arm.com>
 <20200304162558.48836-10-cristian.marussi@arm.com>
 <20200309122853.000019b0@Huawei.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <ec281e49-a838-1a3b-1329-b7e2b43697f2@arm.com>
Date:   Mon, 9 Mar 2020 16:39:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200309122853.000019b0@Huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2020 12:28, Jonathan Cameron wrote:
> On Wed, 4 Mar 2020 16:25:54 +0000
> Cristian Marussi <cristian.marussi@arm.com> wrote:
> 
>> Make SCMI Power protocol register with the notification core.
>>
>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> 
> One comment inline on an unusual code construct, otherwise fine.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

Thanks

Cristian
>> ---
>> V3 --> V4
>> - scmi_event field renamed
>> V2 --> V3
>> - added handle awareness
>> V1 --> V2
>> - simplified .set_notify_enabled() implementation moving the ALL_SRCIDs
>>   logic out of protocol. ALL_SRCIDs logic is now in charge of the
>>   notification core, together with proper reference counting of enables
>> - switched to devres protocol-registration
>> ---
>>  drivers/firmware/arm_scmi/power.c | 123 ++++++++++++++++++++++++++++++
>>  include/linux/scmi_protocol.h     |  15 ++++
>>  2 files changed, 138 insertions(+)
>>
>> diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
>> index cf7f0312381b..281da7e7e33a 100644
>> --- a/drivers/firmware/arm_scmi/power.c
>> +++ b/drivers/firmware/arm_scmi/power.c
>> @@ -6,6 +6,7 @@
>>   */
>>  
>>  #include "common.h"
>> +#include "notify.h"
>>  
>>  enum scmi_power_protocol_cmd {
>>  	POWER_DOMAIN_ATTRIBUTES = 0x3,
>> @@ -48,6 +49,12 @@ struct scmi_power_state_notify {
>>  	__le32 notify_enable;
>>  };
>>  
>> +struct scmi_power_state_notify_payld {
>> +	__le32 agent_id;
>> +	__le32 domain_id;
>> +	__le32 power_state;
>> +};
>> +
>>  struct power_dom_info {
>>  	bool state_set_sync;
>>  	bool state_set_async;
>> @@ -63,6 +70,11 @@ struct scmi_power_info {
>>  	struct power_dom_info *dom_info;
>>  };
>>  
>> +static enum scmi_power_protocol_cmd evt_2_cmd[] = {
>> +	POWER_STATE_NOTIFY,
>> +	POWER_STATE_CHANGE_REQUESTED_NOTIFY,
>> +};
>> +
>>  static int scmi_power_attributes_get(const struct scmi_handle *handle,
>>  				     struct scmi_power_info *pi)
>>  {
>> @@ -186,6 +198,111 @@ static struct scmi_power_ops power_ops = {
>>  	.state_get = scmi_power_state_get,
>>  };
>>  
>> +static int scmi_power_request_notify(const struct scmi_handle *handle,
>> +				     u32 domain, int message_id, bool enable)
>> +{
>> +	int ret;
>> +	struct scmi_xfer *t;
>> +	struct scmi_power_state_notify *notify;
>> +
>> +	ret = scmi_xfer_get_init(handle, message_id, SCMI_PROTOCOL_POWER,
>> +				 sizeof(*notify), 0, &t);
>> +	if (ret)
>> +		return ret;
>> +
>> +	notify = t->tx.buf;
>> +	notify->domain = cpu_to_le32(domain);
>> +	notify->notify_enable = enable ? cpu_to_le32(BIT(0)) : 0;
>> +
>> +	ret = scmi_do_xfer(handle, t);
>> +
>> +	scmi_xfer_put(handle, t);
>> +	return ret;
>> +}
>> +
>> +static bool scmi_power_set_notify_enabled(const struct scmi_handle *handle,
>> +					  u8 evt_id, u32 src_id, bool enable)
>> +{
>> +	int ret, cmd_id;
>> +
>> +	cmd_id = MAP_EVT_TO_ENABLE_CMD(evt_id, evt_2_cmd);
>> +	if (cmd_id < 0)
>> +		return false;
>> +
>> +	ret = scmi_power_request_notify(handle, src_id, cmd_id, enable);
>> +	if (ret)
>> +		pr_warn("SCMI Notifications - Proto:%X - FAIL_ENABLE - evt[%X] dom[%d] - ret:%d\n",
>> +				SCMI_PROTOCOL_POWER, evt_id, src_id, ret);
>> +
>> +	return !ret ? true : false;
> 
> 	return !ret;
> 
> 	Is the same thing...
> 

ops...I'll fix

>> +}
>> +
>> +static void *scmi_power_fill_custom_report(u8 evt_id, u64 timestamp,
>> +					   const void *payld, size_t payld_sz,
>> +					   void *report, u32 *src_id)
>> +{
>> +	void *rep = NULL;
>> +
>> +	switch (evt_id) {
>> +	case POWER_STATE_CHANGED:
>> +	{
>> +		const struct scmi_power_state_notify_payld *p = payld;
>> +		struct scmi_power_state_changed_report *r = report;
>> +
>> +		if (sizeof(*p) != payld_sz)
>> +			break;
>> +
>> +		r->timestamp = timestamp;
>> +		r->agent_id = le32_to_cpu(p->agent_id);
>> +		r->domain_id = le32_to_cpu(p->domain_id);
>> +		r->power_state = le32_to_cpu(p->power_state);
>> +		*src_id = r->domain_id;
>> +		rep = r;
>> +		break;
>> +	}
>> +	case POWER_STATE_CHANGE_REQUESTED:
>> +	{
>> +		const struct scmi_power_state_notify_payld *p = payld;
>> +		struct scmi_power_state_change_requested_report *r = report;
>> +
>> +		if (sizeof(*p) != payld_sz)
>> +			break;
>> +
>> +		r->timestamp = timestamp;
>> +		r->agent_id = le32_to_cpu(p->agent_id);
>> +		r->domain_id = le32_to_cpu(p->domain_id);
>> +		r->power_state = le32_to_cpu(p->power_state);
>> +		*src_id = r->domain_id;
>> +		rep = r;
>> +		break;
>> +	}
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return rep;
>> +}
>> +
>> +static const struct scmi_event power_events[] = {
>> +	{
>> +		.id = POWER_STATE_CHANGED,
>> +		.max_payld_sz = 12,
>> +		.max_report_sz =
>> +			sizeof(struct scmi_power_state_changed_report),
>> +	},
>> +	{
>> +		.id = POWER_STATE_CHANGE_REQUESTED,
>> +		.max_payld_sz = 12,
>> +		.max_report_sz =
>> +			sizeof(struct scmi_power_state_change_requested_report),
>> +	},
>> +};
>> +
>> +static const struct scmi_protocol_event_ops power_event_ops = {
>> +	.set_notify_enabled = scmi_power_set_notify_enabled,
>> +	.fill_custom_report = scmi_power_fill_custom_report,
>> +};
>> +
>>  static int scmi_power_protocol_init(struct scmi_handle *handle)
>>  {
>>  	int domain;
>> @@ -214,6 +331,12 @@ static int scmi_power_protocol_init(struct scmi_handle *handle)
>>  		scmi_power_domain_attributes_get(handle, domain, dom);
>>  	}
>>  
>> +	scmi_register_protocol_events(handle,
>> +				      SCMI_PROTOCOL_POWER, PAGE_SIZE,
>> +				      &power_event_ops, power_events,
>> +				      ARRAY_SIZE(power_events),
>> +				      pinfo->num_domains);
>> +
>>  	pinfo->version = version;
>>  	handle->power_ops = &power_ops;
>>  	handle->power_priv = pinfo;
>> diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
>> index 797e1e03ae52..baa117f9eda3 100644
>> --- a/include/linux/scmi_protocol.h
>> +++ b/include/linux/scmi_protocol.h
>> @@ -377,4 +377,19 @@ typedef int (*scmi_prot_init_fn_t)(struct scmi_handle *);
>>  int scmi_protocol_register(int protocol_id, scmi_prot_init_fn_t fn);
>>  void scmi_protocol_unregister(int protocol_id);
>>  
>> +/* SCMI Notification API - Custom Event Reports */
>> +struct scmi_power_state_changed_report {
>> +	ktime_t	timestamp;
>> +	u32	agent_id;
>> +	u32	domain_id;
>> +	u32	power_state;
>> +};
>> +
>> +struct scmi_power_state_change_requested_report {
>> +	ktime_t	timestamp;
>> +	u32	agent_id;
>> +	u32	domain_id;
>> +	u32	power_state;
>> +};
>> +
>>  #endif /* _LINUX_SCMI_PROTOCOL_H */
> 
> 

