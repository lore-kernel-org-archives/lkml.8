Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99446C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 23:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7035E2073E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 23:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="WAloTPwM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgFKXJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 19:09:17 -0400
Received: from ale.deltatee.com ([204.191.154.188]:60766 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgFKXJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 19:09:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+vs0C/x8fZ6Qvq4Ip5YKMPuZ++Vs0ocLislt6BL3la8=; b=WAloTPwMgU2upwFJKMUdRAUGZ8
        4p1/0GV9JlIs2ivHjKaAKUlHd3xcqGuZhAVchW59vWBfETKC6HIF7+pgmeIrTiXP8lYNq1Vjz8fmY
        tQ8f2Erm6ZDTed3rqvSYLjaeyb1U2wgygecbpCHiYCowQ8llVtUooB2fnApunbI40K3ctDtnmEzrt
        MF//xWp7RU0y0CEFC2Fv4zMYz7N/yNgYmLtFP0XoexQFch9pIM0kJefh0pYMdxZ3j+k0npaJezeHh
        L4Axj9xRiHwpm9og8P9U5VxBozbzMaB03rm1J+ctRwBU+H0PvGwdlGkdAycgYgU4Ux/llWHlEztWx
        +cmKHI7A==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1jjWJn-0001i8-KE; Thu, 11 Jun 2020 17:09:08 -0600
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20200514172253.6445-1-logang@deltatee.com>
 <20200514172253.6445-3-logang@deltatee.com>
 <BYAPR04MB49658F968DC104E99B5C923286800@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <09f1de95-533e-6707-9c86-665f32eb53d7@deltatee.com>
Date:   Thu, 11 Jun 2020 17:09:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49658F968DC104E99B5C923286800@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: sbates@raithlin.com, maxg@mellanox.com, axboe@fb.com, kbusch@kernel.org, sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, Chaitanya.Kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v13 2/9] nvme: Create helper function to obtain command
 effects
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-06-11 4:56 p.m., Chaitanya Kulkarni wrote:
> On 5/14/20 10:23 AM, Logan Gunthorpe wrote:
>> Separate the code to obtain command effects from the code
>> to start a passthru request and open code nvme_known_admin_effects()
>> in the new helper.
>>
>> The new helper function will be necessary for nvmet passthru
>> code to determine if we need to change out of interrupt context
>> to handle the effects.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>>   drivers/nvme/host/core.c | 39 ++++++++++++++++++++++-----------------
>>   1 file changed, 22 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index d22859543e4b..5062a83c3634 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -1317,22 +1317,8 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
>>   			metadata, meta_len, lower_32_bits(io.slba), NULL, 0);
>>   }
>>   
>> -static u32 nvme_known_admin_effects(u8 opcode)
>> -{
>> -	switch (opcode) {
>> -	case nvme_admin_format_nvm:
>> -		return NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC |
>> -					NVME_CMD_EFFECTS_CSE_MASK;
>> -	case nvme_admin_sanitize_nvm:
>> -		return NVME_CMD_EFFECTS_CSE_MASK;
>> -	default:
>> -		break;
>> -	}
>> -	return 0;
>> -}
>> -
>> -static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>> -								u8 opcode)
>> +static u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>> +				u8 opcode)
>>   {
>>   	u32 effects = 0;
>>   
>> @@ -1348,7 +1334,26 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>>   
>>   	if (ctrl->effects)
>>   		effects = le32_to_cpu(ctrl->effects->acs[opcode]);
>> -	effects |= nvme_known_admin_effects(opcode);
>> +
>> +	switch (opcode) {
>> +	case nvme_admin_format_nvm:
>> +		effects |= NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC |
>> +			NVME_CMD_EFFECTS_CSE_MASK;
>> +		break;
>> +	case nvme_admin_sanitize_nvm:
>> +		effects |= NVME_CMD_EFFECTS_CSE_MASK;
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return effects;
>> +}
>> +
>> +static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>> +			       u8 opcode)
>> +{
>> +	u32 effects = nvme_command_effects(ctrl, ns, opcode);
>>   
>>   	/*
>>   	 * For simplicity, IO to all namespaces is quiesced even if the command
>>
> 
> Seems like you have changed the existing function body from
> returning from switch to returning at the end of the function along with
> the name that is why diff is large, which also adds an extra variable 
> named "effect".
> 
> How about following ? which keeps the diff small and removes the extra 
> variable and keeps the existing code as it.

That doesn't really get what's needed for the new helper. We need a new
helper that gets the effects as nvme_passthru_start() sees them
(including ctrl->effects->acs[opcode]). Changing the name of
nvme_known_admin_effects() is not equivalent.

This patch would be possible to do without open coding
nvme_known_admin_effects() in the new helper, but doing so helps to
clean things up a bit as nvme_known_admin_effects() isn't used anywhere
else.

Logan


> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 78fc38b8356f..f47013fdc5ee 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1326,7 +1326,8 @@ static int nvme_submit_io(struct nvme_ns *ns, 
> struct nvme_user_io __user *uio)
>                          metadata, meta_len, lower_32_bits(io.slba), 
> NULL, 0);
>   }
> 
> -static u32 nvme_known_admin_effects(u8 opcode)
> +static u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
> +                               u8 opcode)
>   {
>          switch (opcode) {
>          case nvme_admin_format_nvm:
> @@ -1343,7 +1344,7 @@ static u32 nvme_known_admin_effects(u8 opcode)
>   static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>                                                                  u8 opcode)
>   {
> -       u32 effects = 0;
> +       u32 effects = nvme_command_effects(ctrl, ns, opcode);
> 
>          if (ns) {
>                  if (ctrl->effects)
> @@ -1357,7 +1358,6 @@ static u32 nvme_passthru_start(struct nvme_ctrl 
> *ctrl, struct nvme_ns *ns,
> 
>          if (ctrl->effects)
>                  effects = le32_to_cpu(ctrl->effects->acs[opcode]);
> -       effects |= nvme_known_admin_effects(opcode);
> 
>          /*
>           * For simplicity, IO to all namespaces is quiesced even if the 
> command
> 
