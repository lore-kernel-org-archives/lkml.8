Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FE7C54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 15:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 410792070A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 15:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bq6h4Tyz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgDZPTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 11:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgDZPTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 11:19:53 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2271C061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 08:19:53 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id b1so8521988qtt.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 08:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=8ZWSGdX2c877cgHrdn+1pgMsM7ftlK0aUwzgQsojEoM=;
        b=Bq6h4TyzEtquKkwmgwsPqGZ4Y94CMA78QaeUILL+aY4WYaxGGhcIMYfXw96HmEJTE3
         YhO204RJ8WhOTcxlqp1hRH2ivEfiPR+1ZyzuuRP4lwM06pRM1crEKNjcpxPv/LcbVusF
         G9ubRNrM193gsQzOouDyWbC3huFhcnRlGbKJKReNqSc0AG94lU/RM5dBK+cgN95+uIA4
         GUlQiEnCwG/RTo5bEJWZb3h0Js0/eiGlxpwp8OT5JC+dWQ9VOhLpSxzKFhPz4/YyXF8o
         /uCTNyLh7AcRJ7uvLJptwqWrwDbyK6bT1XUHy023ZYZEfiggqyOJyPYxdFyqkprtk1mk
         PGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8ZWSGdX2c877cgHrdn+1pgMsM7ftlK0aUwzgQsojEoM=;
        b=WTFg1m3WV8UZgh3yDreI8MmHmJPcjUVVw3wgcX0r6SoBoIK/zUzTOTbHtyTjpXhRaM
         T2kwHNa9yT3gHgLUbtQulcVupT3PBvgub3BMcoouGosYkQ44mWWsFtbGxKkWCmcC/2/R
         0cfr/t0xosyVjGYb+omWq+G45k2O+0GY9A3fDMO5uDwmcuonijecrFO25+/t+hG3wHTt
         IADEokTdCxpcZGHSonsycsfWmQf1IUZ+EYUXf/Q4JyTyq6eW4pju+Vglm3x/30iBMY1j
         VvQtwjgEebxrB3qo+TroLew3Zu5G+hLIgkctwJFgtPCCbxoVf0+GXPWKQfYJDQzcwaWU
         Cdwg==
X-Gm-Message-State: AGi0PuaAMG62148+RMtO31gwqPTOYNq1zJOIKwvA3FXRiI4CUuxT6lTE
        0SOXD5FFJYkUhJVLd81RK3/BLkDD
X-Google-Smtp-Source: APiQypI7uwhXJtsXpxkV4VR3/8HRnJdeLuu44Nr0lFQBZbSOO/wEiJxrb/iS/SP2Us5KoQwQmvo0cg==
X-Received: by 2002:aed:2ce6:: with SMTP id g93mr19899873qtd.264.1587914392813;
        Sun, 26 Apr 2020 08:19:52 -0700 (PDT)
Received: from [10.0.2.15] (CPEac9e17937810-CM64777dd8e660.cpe.net.cable.rogers.com. [174.112.203.120])
        by smtp.gmail.com with ESMTPSA id x55sm8115275qtk.3.2020.04.26.08.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Apr 2020 08:19:52 -0700 (PDT)
Subject: Re: [PATCH] rapidio: Avoid data race between file operation callbacks
 and mport_cdev_add().
To:     madhuparnabhowmik10@gmail.com, mporter@kernel.crashing.org,
        akpm@linux-foundation.org, dan.carpenter@oracle.com,
        hubcap@omnibond.com, tglx@linutronix.de, ira.weiny@intel.com,
        allison@lohutok.net
Cc:     linux-kernel@vger.kernel.org, andrianov@ispras.ru,
        ldv-project@linuxtesting.org
References: <20200426112950.1803-1-madhuparnabhowmik10@gmail.com>
From:   "alex.b" <alex.bou9@gmail.com>
Message-ID: <2a0d3c96-c332-2c95-db10-ffba78f9c9a3@gmail.com>
Date:   Sun, 26 Apr 2020 11:19:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200426112950.1803-1-madhuparnabhowmik10@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-26 7:29 a.m., madhuparnabhowmik10@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
>
> Fields of md(mport_dev) are set after cdev_device_add().
> However, the file operation callbacks can be called after
> cdev_device_add() and therefore accesses to fields of md in the
> callbacks can race with the rest of the mport_cdev_add() function.
>
> One such example is INIT_LIST_HEAD(&md->portwrites) in
> mport_cdev_add(), the list is initialised after cdev_device_add().
> This can race with list_add_tail(&pw_filter->md_node,&md->portwrites)
> in rio_mport_add_pw_filter() which is called by unlocked_ioctl.
>
> To avoid such data races use cdev_device_add() after initializing md.
>
> Found by Linux Driver Verification project (linuxtesting.org).
>
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> ---
>   drivers/rapidio/devices/rio_mport_cdev.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
> index 8155f59ece38..40296378e5ee 100644
> --- a/drivers/rapidio/devices/rio_mport_cdev.c
> +++ b/drivers/rapidio/devices/rio_mport_cdev.c
> @@ -2379,13 +2379,6 @@ static struct mport_dev *mport_cdev_add(struct rio_mport *mport)
>   	cdev_init(&md->cdev, &mport_fops);
>   	md->cdev.owner = THIS_MODULE;
>   
> -	ret = cdev_device_add(&md->cdev, &md->dev);
> -	if (ret) {
> -		rmcd_error("Failed to register mport %d (err=%d)",
> -		       mport->id, ret);
> -		goto err_cdev;
> -	}
> -
>   	INIT_LIST_HEAD(&md->doorbells);
>   	spin_lock_init(&md->db_lock);
>   	INIT_LIST_HEAD(&md->portwrites);
> @@ -2405,6 +2398,13 @@ static struct mport_dev *mport_cdev_add(struct rio_mport *mport)
>   #else
>   	md->properties.transfer_mode |= RIO_TRANSFER_MODE_TRANSFER;
>   #endif
> +
> +	ret = cdev_device_add(&md->cdev, &md->dev);
> +	if (ret) {
> +		rmcd_error("Failed to register mport %d (err=%d)",
> +		       mport->id, ret);
> +		goto err_cdev;
> +	}
>   	ret = rio_query_mport(mport, &attr);
>   	if (!ret) {
>   		md->properties.flags = attr.flags;

Acked-by: Alexandre Bounine <alex.bou9@gmail.com>


