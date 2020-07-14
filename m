Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C142EC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E396212CC
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="hvMq0Ftj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgGNUKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:10:32 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:20786 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgGNUKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 16:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1594757429;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=GNcdh9hbyCSYCE1dhM3aHIwRYOjxxn/mU4RGqzYVsko=;
        b=hvMq0FtjXZ4ja0TuywxipPbO7azfGxH7OjuTLXyy6VhFPRT4qrOdDkKAsMlFVdtFq9
        YT9PNq2F/LNh8bzxKgp5CQ5MNp+xONj78Vt59maynjmADTgIY8ZqoFuIWfFzCYH7mTme
        CCXyAcxzAyuUia3pDuzOvJ8/e0DpQ7wV/gxIfCwxXsPPzWWBaNPZ7j+43SlV4yJPQEbw
        F9a8IUc93tDHcIoNPoIbhxn5HR5pIKA7yQChmlxvyZB7xL8k6l14C4Rd6FfyP70HV4x/
        v0ZlwWd3N7PTJlplBuTmU/FN6oHzbIcyrcraE5MH9/87eqp4j2OAKvVgPqswJDSitneJ
        m8bQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3HMbEWKOdeVTdI="
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 46.10.5 DYNA|AUTH)
        with ESMTPSA id R09ac6w6EKA9tgs
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 14 Jul 2020 22:10:09 +0200 (CEST)
Subject: Re: [PATCH net-next] can: silence remove_proc_entry warning
To:     Zhang Changzhong <zhangchangzhong@huawei.com>, mkl@pengutronix.de,
        davem@davemloft.net, kuba@kernel.org
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1594709090-3203-1-git-send-email-zhangchangzhong@huawei.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <e2344833-b2f4-cc6f-4b6c-868afc3ced6e@hartkopp.net>
Date:   Tue, 14 Jul 2020 22:10:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1594709090-3203-1-git-send-email-zhangchangzhong@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14.07.20 08:44, Zhang Changzhong wrote:
> If can_init_proc() fail to create /proc/net/can directory,
> can_remove_proc() will trigger a warning:
> 
> WARNING: CPU: 6 PID: 7133 at fs/proc/generic.c:672 remove_proc_entry+0x17b0
> Kernel panic - not syncing: panic_on_warn set ...
> 
> Fix to return early from can_remove_proc() if can proc_dir
> does not exists.
> 
> Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Thanks!

> ---
>   net/can/proc.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/can/proc.c b/net/can/proc.c
> index e6881bf..077af42 100644
> --- a/net/can/proc.c
> +++ b/net/can/proc.c
> @@ -471,6 +471,9 @@ void can_init_proc(struct net *net)
>    */
>   void can_remove_proc(struct net *net)
>   {
> +	if (!net->can.proc_dir)
> +		return;
> +
>   	if (net->can.pde_version)
>   		remove_proc_entry(CAN_PROC_VERSION, net->can.proc_dir);
>   
> @@ -498,6 +501,5 @@ void can_remove_proc(struct net *net)
>   	if (net->can.pde_rcvlist_sff)
>   		remove_proc_entry(CAN_PROC_RCVLIST_SFF, net->can.proc_dir);
>   
> -	if (net->can.proc_dir)
> -		remove_proc_entry("can", net->proc_net);
> +	remove_proc_entry("can", net->proc_net);
>   }
> 
