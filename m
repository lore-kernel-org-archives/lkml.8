Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD811C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 14:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8134521569
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 14:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="s1NxKgcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgAUOAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 09:00:39 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41225 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgAUOAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 09:00:39 -0500
Received: by mail-qt1-f195.google.com with SMTP id k40so2627617qtk.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 06:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T3pQh4UckFpVVYMnTU2C2nEcKAWZ5QNLADQwFYgscxc=;
        b=s1NxKgcB7b2fWkPqDuWtLBrJmbzy3Gu/G0nXXFUWS78t64NBLo20y2YZSuUdMCk3Yz
         jYaCNwqEW92+eDZplCRchAjcgns8MD3xrEKum4irgThfd6wJ3m3NEZtti3VRiBEtqZMX
         0DY2DoqphpU2VTi6QKgibhWu46oYTnHcS37hDbPsTcJCdOhRNayyalaEWCBQ7N8Y/RjX
         pmfPS7JwWzYnQGP015HgEYi8rJA6gdT5rWXQD0vov6sjex5rC60W5fPGhwL7jEWqsIeN
         tnlLJRc+ykSzCTdhMqLc37iCtwOYbusZX7wFDY/ARsizrqbK6RmrObrUywI9LI8ZCauK
         gRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T3pQh4UckFpVVYMnTU2C2nEcKAWZ5QNLADQwFYgscxc=;
        b=kOZ9Hn9jzy0bLhtYYiQLXllyQbFrCEzLdwoMTCgDmTb/6A5ZEqsRsQwIcSKkPNpFV6
         3Gd/8c2XXP71Z6o9RVa2RaUj4Rf7cvwyqv9vh3xuU70isqjgZue9VnCnSoAGu5+OJyDq
         XFjAbxGw7O3SKknbwddE70Aff/phCWIvwZind59CVG7IITGnM08vy6/ugNS799EhaT5E
         K3z8g5UzYmXE3i8tLwdYUTrxsHTqpZB4ocCbgNlb4pdr2EyufJc29Gqpb0egbj1PFW4J
         H5ZEssV5Ia9X3xv4k/UPJ4JlQSCMKkDw9O9Hh/7Mw1hewVwLvQVtL7sO63PCqxChpT3H
         X5ig==
X-Gm-Message-State: APjAAAXqYKT1Hw1Og5QIMNrj7blSgqjKT56odY7hQqV05xuYGpEVUAFJ
        mBhsi/YAebcQkpU8UuNwfG8igwh4pRUxMA==
X-Google-Smtp-Source: APXvYqx3fQrBeqZBE7DHfQCEm1KagdXQie8eYLDq2jkZfFZ5KwawetnBY3UW3WmqbvJIAJYtq6VOFA==
X-Received: by 2002:ac8:4657:: with SMTP id f23mr4584941qto.378.1579615237725;
        Tue, 21 Jan 2020 06:00:37 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::822a])
        by smtp.gmail.com with ESMTPSA id a36sm19768784qtk.29.2020.01.21.06.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 06:00:36 -0800 (PST)
Subject: Re: [PATCH] nbd: add a flush_workqueue in nbd_start_device
To:     Sun Ke <sunke32@huawei.com>, axboe@kernel.dk, mchristi@redhat.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
References: <20200121124813.13332-1-sunke32@huawei.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <82a3eb7e-883c-a091-feec-27f3937491ab@toxicpanda.com>
Date:   Tue, 21 Jan 2020 09:00:35 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200121124813.13332-1-sunke32@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/20 7:48 AM, Sun Ke wrote:
> When kzalloc fail, may cause trying to destroy the
> workqueue from inside the workqueue.
> 
> If num_connections is m (2 < m), and NO.1 ~ NO.n
> (1 < n < m) kzalloc are successful. The NO.(n + 1)
> failed. Then, nbd_start_device will return ENOMEM
> to nbd_start_device_ioctl, and nbd_start_device_ioctl
> will return immediately without running flush_workqueue.
> However, we still have n recv threads. If nbd_release
> run first, recv threads may have to drop the last
> config_refs and try to destroy the workqueue from
> inside the workqueue.
> 
> To fix it, add a flush_workqueue in nbd_start_device.
> 
> Fixes: e9e006f5fcf2 ("nbd: fix max number of supported devs")
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---
>   drivers/block/nbd.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index b4607dd96185..dd1f8c2c6169 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1264,7 +1264,12 @@ static int nbd_start_device(struct nbd_device *nbd)
>   
>   		args = kzalloc(sizeof(*args), GFP_KERNEL);
>   		if (!args) {
> -			sock_shutdown(nbd);
> +			if (i == 0)
> +				sock_shutdown(nbd);
> +			else {
> +				sock_shutdown(nbd);
> +				flush_workqueue(nbd->recv_workq);
> +			}

Just for readability sake why don't we just flush_workqueue() unconditionally, 
and add a comment so we know why in the future.  Thanks,

Josef
