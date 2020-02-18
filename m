Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A658AC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 12:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B79B20836
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 12:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b9jPDwNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgBRMbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 07:31:43 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33856 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgBRMbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 07:31:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582029101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8SlpuMhxEkNsVu++R0qzZ0u0OpROVAfPhZWy1e0dEb8=;
        b=b9jPDwNhgHW6pQ/ivHxq9yoNq13hAo72+D+SA8qy1qLfamlgHIPBKV+giAtDWszM3ozp8c
        GsVGAo4GK7mGeDCFEdiR1lc6BFqGXgemlZXLgKFB7ysLQkTffDaey+uZQrB2lhLSSzghPl
        czKAzwMySXAeXe4G4fwAWGa39fHPFoI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-KUDYJ7h0PqqF7VqkYFVNCQ-1; Tue, 18 Feb 2020 07:31:40 -0500
X-MC-Unique: KUDYJ7h0PqqF7VqkYFVNCQ-1
Received: by mail-wm1-f72.google.com with SMTP id n17so931wmk.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 04:31:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8SlpuMhxEkNsVu++R0qzZ0u0OpROVAfPhZWy1e0dEb8=;
        b=N7qKtjipPl5W8qQSUW4oBML+UyOdrkHMq+g5e/axEOjhf/XzDSc6kelp93QLViob4n
         MR8Bz0YXL/WSSbncIlpLvtBIWQz5G6F8q9H3+NiE8AF/Gw7z5AbSNpdy6G6VBpC+TDfQ
         HSHe2ayZ+kvqQMoxyrBCHBUjagk5HFteAqdhi7rXakG8nQIWHBeeTJHnC8DYWQM3CTxp
         WehR9K18XJZ7ilIXtVZgQLyp8Ez24NHWVySqecfKxWbwGXJUDXbNlsGyMJ0Yi9gmdRh1
         JbGHJ0FOh2cDtt84q4Tw1OrDon1mkv4doyuO2opKRGPqT1VYkZFWvM/UUoAazr+NPcL7
         PAAw==
X-Gm-Message-State: APjAAAWwtFzRQb7ReJI1sRut7hKUavQE1V3om5MCS16lzrRh1Zy5AeTJ
        48q6QFl3pyVoXEk/MuLB1/c44BgwrjbanLhn63rwEDO1qTzLl40occXxh1zXnbC+8ScBW0mPLBX
        ID4ihRhR40Sk3YlOEb0HOuYyU
X-Received: by 2002:a5d:6151:: with SMTP id y17mr28368350wrt.110.1582029098847;
        Tue, 18 Feb 2020 04:31:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqyX7L8WQTkUFJv9QhdUj6RJA4xdxAXKjDQbK3r6resoWQuxm7d2+WUtLLTRQZ1zvQ/gtSV0vQ==
X-Received: by 2002:a5d:6151:: with SMTP id y17mr28368330wrt.110.1582029098553;
        Tue, 18 Feb 2020 04:31:38 -0800 (PST)
Received: from steredhat (host209-4-dynamic.27-79-r.retail.telecomitalia.it. [79.27.4.209])
        by smtp.gmail.com with ESMTPSA id b16sm3283514wmj.39.2020.02.18.04.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 04:31:37 -0800 (PST)
Date:   Tue, 18 Feb 2020 13:31:35 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] io_uring: remove unnecessary NULL checks
Message-ID: <20200218123135.5iihagj3lkwx4h52@steredhat>
References: <20200217143945.ua4lawkg22ggfihr@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217143945.ua4lawkg22ggfihr@kili.mountain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 05:39:45PM +0300, Dan Carpenter wrote:
> The "kmsg" pointer can't be NULL and we have already dereferenced it so
> a check here would be useless.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  fs/io_uring.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 72bc378edebc..e9f339453ddb 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -3065,7 +3065,7 @@ static int io_sendmsg(struct io_kiocb *req, struct io_kiocb **nxt,
>  			if (req->io)
>  				return -EAGAIN;
>  			if (io_alloc_async_ctx(req)) {
> -				if (kmsg && kmsg->iov != kmsg->fast_iov)
> +				if (kmsg->iov != kmsg->fast_iov)
>  					kfree(kmsg->iov);
>  				return -ENOMEM;
>  			}
> @@ -3219,7 +3219,7 @@ static int io_recvmsg(struct io_kiocb *req, struct io_kiocb **nxt,
>  			if (req->io)
>  				return -EAGAIN;
>  			if (io_alloc_async_ctx(req)) {
> -				if (kmsg && kmsg->iov != kmsg->fast_iov)
> +				if (kmsg->iov != kmsg->fast_iov)
>  					kfree(kmsg->iov);
>  				return -ENOMEM;
>  			}

Make sense.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

