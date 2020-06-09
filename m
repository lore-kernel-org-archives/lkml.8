Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C62AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EFA42078C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbgFIOAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:00:21 -0400
Received: from foss.arm.com ([217.140.110.172]:42866 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728196AbgFIOAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 10:00:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A541A1FB;
        Tue,  9 Jun 2020 07:00:13 -0700 (PDT)
Received: from [10.37.12.95] (unknown [10.37.12.95])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E48C13F66F;
        Tue,  9 Jun 2020 07:00:08 -0700 (PDT)
Subject: Re: [PATCH] firmware: arm_scmi: Use signed integer to report transfer
 status
To:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Jim Quinlan <james.quinlan@broadcom.com>
References: <20200609134503.55860-1-sudeep.holla@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <d2aaadd1-d988-2978-f5e8-06b131c61b94@arm.com>
Date:   Tue, 9 Jun 2020 15:00:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200609134503.55860-1-sudeep.holla@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/9/20 2:45 PM, Sudeep Holla wrote:
> Currently the trace event 'scmi_xfer_end' reports the status of the
> transfer using the unsigned status field read from the firmware. This
> may not be easy to interpret and also may miss to present any timeouts
> that happen in the driver.
> 
> Let us use signed integer so that error values are emitted out after
> they are mapped from firmware errors to standard linux error codes.
> While at this, let us also include any timeouts in the driver itself.
> 
> Cc: Jim Quinlan <james.quinlan@broadcom.com>
> Cc: Lukasz Luba <lukasz.luba@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/firmware/arm_scmi/driver.c | 3 +--
>   include/trace/events/scmi.h        | 6 +++---
>   2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 7483cacf63f9..136acbe2f4a1 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -392,8 +392,7 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
>   		info->desc->ops->mark_txdone(cinfo, ret);
>   
>   	trace_scmi_xfer_end(xfer->transfer_id, xfer->hdr.id,
> -			    xfer->hdr.protocol_id, xfer->hdr.seq,
> -			    xfer->hdr.status);
> +			    xfer->hdr.protocol_id, xfer->hdr.seq, ret);
>   
>   	return ret;
>   }
> diff --git a/include/trace/events/scmi.h b/include/trace/events/scmi.h
> index f076c430d243..f3a4b4d60714 100644
> --- a/include/trace/events/scmi.h
> +++ b/include/trace/events/scmi.h
> @@ -35,7 +35,7 @@ TRACE_EVENT(scmi_xfer_begin,
>   
>   TRACE_EVENT(scmi_xfer_end,
>   	TP_PROTO(int transfer_id, u8 msg_id, u8 protocol_id, u16 seq,
> -		 u32 status),
> +		 int status),
>   	TP_ARGS(transfer_id, msg_id, protocol_id, seq, status),
>   
>   	TP_STRUCT__entry(
> @@ -43,7 +43,7 @@ TRACE_EVENT(scmi_xfer_end,
>   		__field(u8, msg_id)
>   		__field(u8, protocol_id)
>   		__field(u16, seq)
> -		__field(u32, status)
> +		__field(int, status)
>   	),
>   
>   	TP_fast_assign(
> @@ -54,7 +54,7 @@ TRACE_EVENT(scmi_xfer_end,
>   		__entry->status = status;
>   	),
>   
> -	TP_printk("transfer_id=%d msg_id=%u protocol_id=%u seq=%u status=%u",
> +	TP_printk("transfer_id=%d msg_id=%u protocol_id=%u seq=%u status=%d",
>   		__entry->transfer_id, __entry->msg_id, __entry->protocol_id,
>   		__entry->seq, __entry->status)
>   );
> 

Indeed looks better with the Linux like ret status

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
