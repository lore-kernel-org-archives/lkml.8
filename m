Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41181C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 11:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19DD0206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 11:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbgGMLUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 07:20:53 -0400
Received: from foss.arm.com ([217.140.110.172]:56066 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729556AbgGMLUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 07:20:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 025A231B;
        Mon, 13 Jul 2020 04:20:53 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 469913F7D8;
        Mon, 13 Jul 2020 04:20:52 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
Subject: Re: [PATCH 2/3] firmware: arm_scmi: Remove unneeded __packed
 attribute
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, sudeep.holla@arm.com
References: <20200710133919.39792-1-cristian.marussi@arm.com>
 <20200710133919.39792-2-cristian.marussi@arm.com>
Message-ID: <751ee628-ff38-a383-5832-aab4905af32b@arm.com>
Date:   Mon, 13 Jul 2020 12:20:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200710133919.39792-2-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2020 14:39, Cristian Marussi wrote:
> Remove __packed attribute from struct scmi_event_header.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

A drive-by review. But this doesn't look safe to me. sizeof(struct 
scmi_event_header) is used in several places and this change will modify 
that from 13 to 16, but leave the structure members at the same offset 
(as the members are naturally aligned). In particular the naïve header 
size is now bigger than the offset to payld.

What is the justification for __packed being 'unneeded'?

Steve

> ---
>   drivers/firmware/arm_scmi/notify.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
> index c4d006cfde88..752415367305 100644
> --- a/drivers/firmware/arm_scmi/notify.c
> +++ b/drivers/firmware/arm_scmi/notify.c
> @@ -258,7 +258,7 @@ struct scmi_event_header {
>   	u8	evt_id;
>   	size_t	payld_sz;
>   	u8	payld[];
> -} __packed;
> +};
>   
>   struct scmi_registered_event;
>   
> 

