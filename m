Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DB7C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 13:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01E02073D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 13:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbgCDNuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 08:50:20 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43095 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729462AbgCDNuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 08:50:20 -0500
Received: by mail-ed1-f67.google.com with SMTP id dc19so2371134edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 05:50:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8jD1aQ0K4ZHRI9L4DVErk5de13t4CvMVfGLComiCULQ=;
        b=ZqltTS70iJsun/g6QXtqNguIewELXM1O803THyGEJYI64VgICBoe8o1hehYLIkd1Hp
         G+sXavVGYL37hZG36ov+1XSgpiUmyyImioTe/Ty2pKQ4iupuqcYkLUdHzE954ElUvG2/
         KBjL9JyH/8VFnstg7h5QSZJ3vCwxmxb9jsybHS9OneN2ouDigNjoi5ungOaQHhPj8aIE
         zh0pwJivwLJbSWhEAKt/KynxIGGAhF7gkRG1xeFF3a5cYqLPoOxTy30wyZxJYnZGdwu8
         BPy8y//WtFTBwJlcQI+xzEVzLJsFSOfzsLRZt5FkwnKcmM7WbtYOKwzqqCqRkaIguEIR
         efcg==
X-Gm-Message-State: ANhLgQ3dYf4wq0BXJXvrvnaInqgBeTbbe3CJ/PR5B4wNcUpTNdgWHWe4
        zvK9DQkqiX3plnI1iKjzQjc=
X-Google-Smtp-Source: ADFU+vsZrq7uJzWcS4/3LZotBPFTQ9gsYfoZvYENWEf9F84kQ9T2I6uins3J28b/fwvpIldukXjlEQ==
X-Received: by 2002:a17:906:8284:: with SMTP id h4mr2489505ejx.224.1583329818066;
        Wed, 04 Mar 2020 05:50:18 -0800 (PST)
Received: from a483e7b01a66.ant.amazon.com (54-240-197-232.amazon.com. [54.240.197.232])
        by smtp.gmail.com with ESMTPSA id a7sm48294ejs.33.2020.03.04.05.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 05:50:17 -0800 (PST)
Subject: Re: [PATCH v3 1/2] xenbus: req->body should be updated before
 req->state
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, joe.jin@oracle.com
References: <20200303221423.21962-1-dongli.zhang@oracle.com>
From:   Julien Grall <julien@xen.org>
Message-ID: <a45de885-2050-f590-b298-b3297da957a5@xen.org>
Date:   Wed, 4 Mar 2020 13:50:15 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200303221423.21962-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/03/2020 22:14, Dongli Zhang wrote:
> The req->body should be updated before req->state is updated and the
> order should be guaranteed by a barrier.
> 
> Otherwise, read_reply() might return req->body = NULL.
> 
> Below is sample callstack when the issue is reproduced on purpose by
> reordering the updates of req->body and req->state and adding delay in
> code between updates of req->state and req->body.
> 
> [   22.356105] general protection fault: 0000 [#1] SMP PTI
> [   22.361185] CPU: 2 PID: 52 Comm: xenwatch Not tainted 5.5.0xen+ #6
> [   22.366727] Hardware name: Xen HVM domU, BIOS ...
> [   22.372245] RIP: 0010:_parse_integer_fixup_radix+0x6/0x60
> ... ...
> [   22.392163] RSP: 0018:ffffb2d64023fdf0 EFLAGS: 00010246
> [   22.395933] RAX: 0000000000000000 RBX: 75746e7562755f6d RCX: 0000000000000000
> [   22.400871] RDX: 0000000000000000 RSI: ffffb2d64023fdfc RDI: 75746e7562755f6d
> [   22.405874] RBP: 0000000000000000 R08: 00000000000001e8 R09: 0000000000cdcdcd
> [   22.410945] R10: ffffb2d6402ffe00 R11: ffff9d95395eaeb0 R12: ffff9d9535935000
> [   22.417613] R13: ffff9d9526d4a000 R14: ffff9d9526f4f340 R15: ffff9d9537654000
> [   22.423726] FS:  0000000000000000(0000) GS:ffff9d953bc80000(0000) knlGS:0000000000000000
> [   22.429898] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   22.434342] CR2: 000000c4206a9000 CR3: 00000001ea3fc002 CR4: 00000000001606e0
> [   22.439645] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   22.444941] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   22.450342] Call Trace:
> [   22.452509]  simple_strtoull+0x27/0x70
> [   22.455572]  xenbus_transaction_start+0x31/0x50
> [   22.459104]  netback_changed+0x76c/0xcc1 [xen_netfront]
> [   22.463279]  ? find_watch+0x40/0x40
> [   22.466156]  xenwatch_thread+0xb4/0x150
> [   22.469309]  ? wait_woken+0x80/0x80
> [   22.472198]  kthread+0x10e/0x130
> [   22.474925]  ? kthread_park+0x80/0x80
> [   22.477946]  ret_from_fork+0x35/0x40
> [   22.480968] Modules linked in: xen_kbdfront xen_fbfront(+) xen_netfront xen_blkfront
> [   22.486783] ---[ end trace a9222030a747c3f7 ]---
> [   22.490424] RIP: 0010:_parse_integer_fixup_radix+0x6/0x60
> 
> The virt_rmb() is added in the 'true' path of test_reply(). The "while"
> is changed to "do while" so that test_reply() is used as a read memory
> barrier.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>

Reviewed-by: Julien Grall <jgrall@amazon.com>

> ---
> Changed since v1:
>    - change "barrier()" to "virt_rmb()" in test_reply()
> Changed since v2:
>    - Use "virt_rmb()" only in 'true' path
> 
>   drivers/xen/xenbus/xenbus_comms.c | 2 ++
>   drivers/xen/xenbus/xenbus_xs.c    | 9 ++++++---
>   2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/xen/xenbus/xenbus_comms.c b/drivers/xen/xenbus/xenbus_comms.c
> index d239fc3c5e3d..852ed161fc2a 100644
> --- a/drivers/xen/xenbus/xenbus_comms.c
> +++ b/drivers/xen/xenbus/xenbus_comms.c
> @@ -313,6 +313,8 @@ static int process_msg(void)
>   			req->msg.type = state.msg.type;
>   			req->msg.len = state.msg.len;
>   			req->body = state.body;
> +			/* write body, then update state */
> +			virt_wmb();
>   			req->state = xb_req_state_got_reply;
>   			req->cb(req);
>   		} else
> diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
> index ddc18da61834..3a06eb699f33 100644
> --- a/drivers/xen/xenbus/xenbus_xs.c
> +++ b/drivers/xen/xenbus/xenbus_xs.c
> @@ -191,8 +191,11 @@ static bool xenbus_ok(void)
>   
>   static bool test_reply(struct xb_req_data *req)
>   {
> -	if (req->state == xb_req_state_got_reply || !xenbus_ok())
> +	if (req->state == xb_req_state_got_reply || !xenbus_ok()) {
> +		/* read req->state before all other fields */
> +		virt_rmb();
>   		return true;
> +	}
>   
>   	/* Make sure to reread req->state each time. */
>   	barrier();
> @@ -202,7 +205,7 @@ static bool test_reply(struct xb_req_data *req)
>   
>   static void *read_reply(struct xb_req_data *req)
>   {
> -	while (req->state != xb_req_state_got_reply) {
> +	do {
>   		wait_event(req->wq, test_reply(req));
>   
>   		if (!xenbus_ok())
> @@ -216,7 +219,7 @@ static void *read_reply(struct xb_req_data *req)
>   		if (req->err)
>   			return ERR_PTR(req->err);
>   
> -	}
> +	} while (req->state != xb_req_state_got_reply);
>   
>   	return req->body;
>   }
> 

-- 
Julien Grall
