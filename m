Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20EBC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0EA5214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgA1Rf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 12:35:29 -0500
Received: from foss.arm.com ([217.140.110.172]:32830 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgA1Rf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 12:35:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7DB7328;
        Tue, 28 Jan 2020 09:35:27 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97E773F52E;
        Tue, 28 Jan 2020 09:35:26 -0800 (PST)
Date:   Tue, 28 Jan 2020 17:35:24 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     arnd@arndb.de, jassisinghbrar@gmail.com, cristian.marussi@arm.com,
        peng.fan@nxp.com, peter.hilber@opensynergy.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V5] firmware: arm_scmi: Make scmi core independent of the
 transport type
Message-ID: <20200128173524.GB36496@bogus>
References: <f170b33989b426ac095952634fcd1bf45b86a7a3.1580208329.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f170b33989b426ac095952634fcd1bf45b86a7a3.1580208329.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 04:24:19PM +0530, Viresh Kumar wrote:
> The SCMI specification is fairly independent of the transport protocol,
> which can be a simple mailbox (already implemented) or anything else.
> The current Linux implementation however is very much dependent on the
> mailbox transport layer.
>
> This patch makes the SCMI core code (driver.c) independent of the
> mailbox transport layer and moves all mailbox related code to a new
> file: mailbox.c.
>
> We can now implement more transport protocols to transport SCMI
> messages.
>
> The transport protocols just need to provide struct scmi_transport_ops,
> with its version of the callbacks to enable exchange of SCMI messages.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> @Sudeep: Please help getting this tested as well :)
>

I did a quick test and it just works fine ;)

> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> index df35358ff324..805482c41ab4 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -13,6 +13,7 @@
>  #include <linux/errno.h>
>  #include <linux/kernel.h>
>  #include <linux/scmi_protocol.h>
> +#include <linux/stddef.h>

May be not needed anymore ? IIUC you had added it for offset and friends.

>  #include <linux/types.h>
>
>  #include <asm/unaligned.h>
> @@ -33,8 +34,8 @@ enum scmi_common_cmd {
>  /**
>   * struct scmi_msg_resp_prot_version - Response for a message
>   *
> - * @major_version: Major version of the ABI that firmware supports
>   * @minor_version: Minor version of the ABI that firmware supports
> + * @major_version: Major version of the ABI that firmware supports
>   *
>   * In general, ABI version changes follow the rule that minor version increments
>   * are backward compatible. Major revision changes in ABI may not be
> @@ -47,6 +48,19 @@ struct scmi_msg_resp_prot_version {
>  	__le16 major_version;
>  };
>
> +#define MSG_ID_MASK		GENMASK(7, 0)
> +#define MSG_XTRACT_ID(hdr)	FIELD_GET(MSG_ID_MASK, (hdr))
> +#define MSG_TYPE_MASK		GENMASK(9, 8)
> +#define MSG_XTRACT_TYPE(hdr)	FIELD_GET(MSG_TYPE_MASK, (hdr))
> +#define MSG_TYPE_COMMAND	0
> +#define MSG_TYPE_DELAYED_RESP	2
> +#define MSG_TYPE_NOTIFICATION	3
> +#define MSG_PROTOCOL_ID_MASK	GENMASK(17, 10)
> +#define MSG_XTRACT_PROT_ID(hdr)	FIELD_GET(MSG_PROTOCOL_ID_MASK, (hdr))
> +#define MSG_TOKEN_ID_MASK	GENMASK(27, 18)
> +#define MSG_XTRACT_TOKEN(hdr)	FIELD_GET(MSG_TOKEN_ID_MASK, (hdr))
> +#define MSG_TOKEN_MAX		(MSG_XTRACT_TOKEN(MSG_TOKEN_ID_MASK) + 1)
> +
>  /**
>   * struct scmi_msg_hdr - Message(Tx/Rx) header
>   *
> @@ -67,6 +81,33 @@ struct scmi_msg_hdr {
>  	bool poll_completion;
>  };
>
> +/**
> + * pack_scmi_header() - packs and returns 32-bit header
> + *
> + * @hdr: pointer to header containing all the information on message id,
> + *	protocol id and sequence id.
> + *
> + * Return: 32-bit packed message header to be sent to the platform.
> + */
> +static inline u32 pack_scmi_header(struct scmi_msg_hdr *hdr)
> +{
> +	return FIELD_PREP(MSG_ID_MASK, hdr->id) |
> +		FIELD_PREP(MSG_TOKEN_ID_MASK, hdr->seq) |
> +		FIELD_PREP(MSG_PROTOCOL_ID_MASK, hdr->protocol_id);
> +}
> +
> +/**
> + * unpack_scmi_header() - unpacks and records message and protocol id
> + *
> + * @msg_hdr: 32-bit packed message header sent from the platform
> + * @hdr: pointer to header to fetch message and protocol id.
> + */
> +static inline void unpack_scmi_header(u32 msg_hdr, struct scmi_msg_hdr *hdr)
> +{
> +	hdr->id = MSG_XTRACT_ID(msg_hdr);
> +	hdr->protocol_id = MSG_XTRACT_PROT_ID(msg_hdr);
> +}
> +

I prefer this moving of the above code to header as separate patch,
just to keep it easy for bisection in case we break anything with new
transport layer. There's nothing I see, but to be safer. You can also
claim no functionality change with that patch then ;)

>  /**
>   * struct scmi_info - Structure representing a SCMI instance
>   *
>   * @dev: Device pointer
>   * @desc: SoC description for this instance
> - * @handle: Instance of SCMI handle to send to clients
>   * @version: SCMI revision information containing protocol version,
>   *	implementation version and (sub-)vendor identification.
> + * @handle: Instance of SCMI handle to send to clients

I saw this and couple other doc changes that are not related to this patch
but are fixed to existing code ? Can be separate patch again if I am not
wrong.

Otherwise looks good. Since we are not adding module support, I am fine
even if we have to make changes to transport ops bit later if required
and realised when adding new transport. Let us see if Peter has any major
objections.

--
Regards,
Sudeep
