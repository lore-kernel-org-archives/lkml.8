Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB93C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 23:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26BFF20842
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 23:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="FkEOcxMS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgFKXrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 19:47:05 -0400
Received: from ale.deltatee.com ([204.191.154.188]:33110 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgFKXrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 19:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gV9QoHt8EYvoGCRmgXIoNP2+LNt+D1Ofl05Ii0wSJgE=; b=FkEOcxMSQTZ7+vgRXN3priANPV
        P8kEefsc8sUN3ssFd8os7kKyVrXhuQFyr2tdlCspviSAdVUqUDmJ45OyszmwhlUs9s+L7h5CpU8Ly
        jm8B4zi/dnj5S6e8SiDmOoMSupAMqvhKKEs4Gwx2zYCIi8spOjFtNRHY3OYNp6SZdJzg+HW1GhFXF
        DgazrnVGdBmTP35H9W1MDEVqOvRjmJcqnnJzvOnyjBNXAea1MdjOi4WBB6IU8W+B+UQIbUXn1AtyF
        /lsOhUfrkpBEH8gM6HfS+NUJh2EKQ4ZGHnb43wj8yuDabFtMeF+2wIYrNrCQb0NBwufoy39Uv6PL9
        Q6UI9qIA==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1jjWuO-0002NJ-Ai; Thu, 11 Jun 2020 17:46:57 -0600
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20200514172253.6445-1-logang@deltatee.com>
 <20200514172253.6445-8-logang@deltatee.com>
 <BYAPR04MB4965379CE8694F52D684993386800@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <cbe637ec-e80c-def1-2453-70059715e19c@deltatee.com>
Date:   Thu, 11 Jun 2020 17:46:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965379CE8694F52D684993386800@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: sbates@raithlin.com, maxg@mellanox.com, axboe@fb.com, kbusch@kernel.org, sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, Chaitanya.Kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v13 7/9] nvmet-passthru: Add passthru code to process
 commands
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-06-11 5:45 p.m., Chaitanya Kulkarni wrote:
> On 5/14/20 10:23 AM, Logan Gunthorpe wrote:
>> +
>> +static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
>> +{
>> +	struct nvme_ctrl *ctrl = nvmet_req_passthru_ctrl(req);
>> +	struct nvme_ns *ns = NULL;
>> +	struct request *rq = NULL;
>> +	struct request_queue *q;
>> +	u32 effects;
>> +	u16 status;
>> +	int ret;
>> +
>> +	if (likely(req->sq->qid != 0)) {
>> +		u32 nsid = le32_to_cpu(req->cmd->common.nsid);
>> +
>> +		ns = nvme_find_get_ns(ctrl, nsid);
>> +		if (unlikely(!ns)) {
>> +			pr_err("failed to get passthru ns nsid:%u\n", nsid);
>> +			status = NVME_SC_INVALID_NS | NVME_SC_DNR;
>> +			goto fail_out;
>> +		}
>> +	}
>> +
>> +	if (ns)
>> +		q = ns->queue;
>> +	else
>> +		q = ctrl->admin_q;
> 
> Is it possible to avoid explicit if.. else in fast path given that the
> condition exists and we can take an advantage of that, how about
> following ?
> 
> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
> index 9e71fdfbdbb3..4f8e022d254c 100644
> --- a/drivers/nvme/target/passthru.c
> +++ b/drivers/nvme/target/passthru.c
> @@ -84,9 +84,9 @@ static int nvmet_passthru_map_sg(struct nvmet_req 
> *req, struct request *rq)
>   static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
>   {
>          struct nvme_ctrl *ctrl = nvmet_req_passthru_ctrl(req);
> +       struct request_queue *q = ctrl->admin_q;
>          struct nvme_ns *ns = NULL;
>          struct request *rq = NULL;
> -       struct request_queue *q;
>          u32 effects;
>          u16 status;
>          int ret;
> @@ -100,12 +100,8 @@ static void nvmet_passthru_execute_cmd(struct 
> nvmet_req *req)
>                          status = NVME_SC_INVALID_NS | NVME_SC_DNR;
>                          goto fail_out;
>                  }
> -       }
> -
> -       if (ns)
>                  q = ns->queue;
> -       else
> -               q = ctrl->admin_q;
> +       }
> 
>          rq = nvme_alloc_request(q, req->cmd, BLK_MQ_REQ_NOWAIT, 
> NVME_QID_ANY);
>          if (IS_ERR(rq)) {
> 


This makes sense. Will fix for the next revision.

Thanks,

Logan
