Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91446C4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2A620658
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgBZX2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 18:28:13 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34508 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgBZX2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 18:28:13 -0500
Received: by mail-oi1-f195.google.com with SMTP id l136so1417399oig.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 15:28:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RyN8wdyx5UTXqhX47LF5ataeVQFJ6brgByOTBGpOppg=;
        b=qB1WLiJH8TfQ6K5vlsQ4FLxDhXfaz3aPlMwWOcdR1MEBtvEn7Blm7IOADUvxlBugYx
         98bkcb8ClA2haDf+Dy9ql0psTCI4WiEWFr6SZCaVaYkV9lDtvArWRM3ZJ2zQKgZbH9rf
         JrbUR2tnci1ZpNPVvCGP/zEnO9OOWAiYtSgIfYGqtbV2zrsJtXtNO7Kf0tCjDofMkXtk
         AaJqDf09I/utuiEyGcbfJADmozqI88nY6AnZZzB1BtsZEf/HjxeiqhNWi/Hjum2uGBrk
         Zdmg57gZEOFDSOZdobmkmhUsojgj1GXPOWSDXo+Ihcq9rUwWQL0oUHaTr3+3xaI37kWJ
         Et3w==
X-Gm-Message-State: APjAAAV2raVuEuLEPcZnKxfzjQzC+ioKQ3A0C2y6U6U7tfMiRwDM39GR
        ElAWkw11uQVEnaAg2TvcsnE=
X-Google-Smtp-Source: APXvYqywzEAMuKK6yzb4V86yyPuzG2G22fxxXo68hGxc4vPFA1gUkbMBOPBA/0AWAh7A8BF3/Y2ufQ==
X-Received: by 2002:a54:468a:: with SMTP id k10mr1239874oic.3.1582759692462;
        Wed, 26 Feb 2020 15:28:12 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id n22sm1325231otj.36.2020.02.26.15.28.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 15:28:11 -0800 (PST)
Subject: Re: [PATCH v11 7/9] nvmet-passthru: Add passthru code to process
 commands
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20200220203652.26734-1-logang@deltatee.com>
 <20200220203652.26734-8-logang@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <becbf34c-e22e-3c48-41df-f23fee2da658@grimberg.me>
Date:   Wed, 26 Feb 2020 15:28:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200220203652.26734-8-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
> +{
> +	/*
> +	 * Passthru all vendor specific commands
> +	 */
> +	if (req->cmd->common.opcode >= nvme_admin_vendor_start)
> +		return nvmet_setup_passthru_command(req);
> +
> +	switch (req->cmd->common.opcode) {
> +	case nvme_admin_async_event:
> +		req->execute = nvmet_execute_async_event;
> +		return NVME_SC_SUCCESS;
> +	case nvme_admin_keep_alive:
> +		/*
> +		 * Most PCIe ctrls don't support keep alive cmd, we route keep
> +		 * alive to the non-passthru mode. In future please change this
> +		 * code when PCIe ctrls with keep alive support available.
> +		 */
> +		req->execute = nvmet_execute_keep_alive;
> +		return NVME_SC_SUCCESS;
> +	case nvme_admin_set_features:
> +		switch (le32_to_cpu(req->cmd->features.fid)) {
> +		case NVME_FEAT_ASYNC_EVENT:
> +		case NVME_FEAT_KATO:
> +		case NVME_FEAT_NUM_QUEUES:
> +			req->execute = nvmet_execute_set_features;
> +			return NVME_SC_SUCCESS;
> +		default:
> +			return nvmet_setup_passthru_command(req);
> +		}

This looks questionable... There are tons of features that doesn't
make sense here like hmb, temperature stuff, irq stuff, timestamps,
reservations etc... passing-through these will have confusing
semantics.. Maybe white-list what actually makes sense to passthru?

> +		break;
> +	case nvme_admin_get_features:
> +		switch (le32_to_cpu(req->cmd->features.fid)) {
> +		case NVME_FEAT_ASYNC_EVENT:
> +		case NVME_FEAT_KATO:
> +		case NVME_FEAT_NUM_QUEUES:
> +			req->execute = nvmet_execute_get_features;
> +			return NVME_SC_SUCCESS;
> +		default:
> +			return nvmet_setup_passthru_command(req);
> +		}

Same here.

> +		break;
> +	case nvme_admin_identify:
> +		switch (req->cmd->identify.cns) {
> +		case NVME_ID_CNS_CTRL:
> +			req->execute = nvmet_passthru_execute_cmd;
> +			req->p.end_req = nvmet_passthru_override_id_ctrl;
> +			return NVME_SC_SUCCESS;
> +		case NVME_ID_CNS_NS:
> +			req->execute = nvmet_passthru_execute_cmd;
> +			req->p.end_req = nvmet_passthru_override_id_ns;
> +			return NVME_SC_SUCCESS;

Aren't you missing NVME_ID_CNS_NS_DESC_LIST? and
NVME_ID_CNS_NS_ACTIVE_LIST?

> +		default:
> +			return nvmet_setup_passthru_command(req);
> +		}

Also here, all the namespace management stuff has questionable
semantics in my mind...

> +	case nvme_admin_get_log_page:
> +		return nvmet_setup_passthru_command(req);
> +	default:
> +		/* By default, blacklist all admin commands */
> +		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
> +	}
> +}
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 3d5189f46cb1..e29f4b8145fa 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -858,6 +858,7 @@ enum nvme_admin_opcode {
>   	nvme_admin_security_recv	= 0x82,
>   	nvme_admin_sanitize_nvm		= 0x84,
>   	nvme_admin_get_lba_status	= 0x86,
> +	nvme_admin_vendor_start		= 0xC0,
>   };
>   
>   #define nvme_admin_opcode_name(opcode)	{ opcode, #opcode }
> 
