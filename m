Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E0EC55181
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3221B20857
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgDTWe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:34:26 -0400
Received: from ale.deltatee.com ([207.54.116.67]:47076 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgDTWe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 18:34:26 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1jQezX-00056i-9U; Mon, 20 Apr 2020 16:34:16 -0600
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20200420164700.21620-1-logang@deltatee.com>
 <20200420164700.21620-2-logang@deltatee.com>
 <20200420222646.GA11115@redsun51.ssa.fujisawa.hgst.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ce687c5d-eb19-e9b5-e03a-97dd2a04b4ea@deltatee.com>
Date:   Mon, 20 Apr 2020 16:34:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200420222646.GA11115@redsun51.ssa.fujisawa.hgst.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sbates@raithlin.com, maxg@mellanox.com, Chaitanya.Kulkarni@wdc.com, axboe@fb.com, sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, kbusch@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v12 1/9] nvme-core: Clear any SGL flags in passthru
 commands
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-04-20 4:26 p.m., Keith Busch wrote:
> On Mon, Apr 20, 2020 at 10:46:52AM -0600, Logan Gunthorpe wrote:
>> The host driver should decide whether to use SGLs or PRPs and they
>> currently assume the flags are cleared after the call to
>> nvme_setup_cmd(). However, passed-through commands may erroneously
>> set these bits; so clear them for all cases.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>>  drivers/nvme/host/core.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 91c1bd659947..f5283b300e87 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -756,6 +756,8 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
>>  	case REQ_OP_DRV_IN:
>>  	case REQ_OP_DRV_OUT:
>>  		memcpy(cmd, nvme_req(req)->cmd, sizeof(*cmd));
>> +		/* passthru commands should let the driver set the SGL flags */
>> +		cmd->common.flags &= ~NVME_CMD_SGL_ALL;
>>  		break;
> 
> Is this really necessary? The passthrough handler currently rejects user
> commands that set command flags:

Yes, the flags coming from the passthru target's host (in subsequent
patches in this series) may have these set and we need to clear them
somewhere. The passthru code submits the requests directly using
blk_execute_rq_nowait() and thus the check in nvme_user_cmd() doesn't apply.

If I recall correctly, we had originally cleared the flags in the target
code, but Christoph had suggested it should be done more generally in
nvme_setup_cmd().

Logan
