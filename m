Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D1DC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BAD821841
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1iPAXJkZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgEHPdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 11:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgEHPdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 11:33:19 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16F6C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 08:33:17 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id c16so1781491ilr.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 08:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5Cd+7bkSYmAgh5DN2n8p/aA30ZkROc8uSmHqYwQWmIo=;
        b=1iPAXJkZlmhJ7BWDzF+X/VxemjHkBOyCJgHgt65w4dKt/0PlKCx0c/u64jtLZxjAjf
         RhtUZjMuUdqdzPQ3LA99pdgmqUHu3PM/094MHVDxE6NeWVI4x/nePVvrHxnkwZz54Dj6
         mhprggRTf6YEW316PXqEfnWWBJUx0fO7rt6kzkIgVx/CMs4YfolvA9bfWOOuGaTWGBg1
         Iw8bCQEj6A8zfNpUO0qxMcGPc5t+KauHAuUR78JZRDN1xPNFPuzqiN6TtJFhDMlyjLt+
         2svlxe7tUdDVWIdczvsS82svc0CNZUfqjSnzY+sF3UmFRL+vEmpTKOEhv4nqKVU1TiZt
         nZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5Cd+7bkSYmAgh5DN2n8p/aA30ZkROc8uSmHqYwQWmIo=;
        b=VgH8AmZmizYtTXrn4fNkZr9IH+62qGvlbol8GpKJSMWQlvDcutI6ApfWOipP6lDO7W
         luSbAfkqo9T230wQpUjfJFJOqkVrtarflD7OYulCnZKkgZkqdpCFj9yyFo10eMPoyRn0
         RFf8XSI45Q3OklnTtsU+bss/vRIhGfkLS5hUllIoL0weJUERcZZvre0ReluVavMv8cTB
         sLIpkmaVO5pE4zabG6NheLHY67znGrQmjvAsxoGsI921kNsif3x9M6zRP5iXzgb/vows
         C+UfSK8EjzPqAkgXCufKmcjiWvOeEQ/zWE+fI0blQ41N8uD78U4dDxfWmztCpOQAPIiy
         gXNQ==
X-Gm-Message-State: AGi0PuYmqbG/lhWspxEim3Mp9eD25ruVciHY1sohWPiCgJv2uvXX4dxn
        LP8dNLIwfeuUrCPG1VcYjurkPw==
X-Google-Smtp-Source: APiQypKdVtlaL71EVvq3emaUv8Y5xpm9c6baK99R3bNrpVMnsd3KYQCR5+DwQRQy+eekJ9a63TUoAg==
X-Received: by 2002:a92:8804:: with SMTP id h4mr69496ild.251.1588951997047;
        Fri, 08 May 2020 08:33:17 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u17sm923258ilb.86.2020.05.08.08.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 08:33:16 -0700 (PDT)
Subject: Re: [PATCH] fs/io_uring: fix O_PATH fds in openat, openat2, statx
To:     Hillf Danton <hdanton@sina.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Max Kellermann <mk@cm4all.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20200507185725.15840-1-mk@cm4all.com>
 <20200507190131.GF23230@ZenIV.linux.org.uk>
 <4cac0e53-656c-50f0-3766-ae3cc6c0310a@kernel.dk>
 <20200507192903.GG23230@ZenIV.linux.org.uk>
 <8e3c88cc-027b-4f90-b4f8-a20d11d35c4b@kernel.dk>
 <20200507220637.GH23230@ZenIV.linux.org.uk>
 <283c8edb-fea2-5192-f1d6-3cc57815b1e2@kernel.dk>
 <20200507224447.GI23230@ZenIV.linux.org.uk>
 <e16125f2-c3ec-f029-c607-19bede54fa17@kernel.dk>
 <20200507233132.GJ23230@ZenIV.linux.org.uk>
 <629de3b6-cf80-fe37-1dde-7f0464da0a04@kernel.dk>
 <20200508152918.12340-1-hdanton@sina.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <35aa8592-5565-3578-d90f-3b56bb8ab078@kernel.dk>
Date:   Fri, 8 May 2020 09:33:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508152918.12340-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/20 9:29 AM, Hillf Danton wrote:
> Dunno if what's missing makes  grumpy.
> 
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -3439,6 +3439,11 @@ static void io_close_finish(struct io_wq
>  static int io_close(struct io_kiocb *req, bool force_nonblock)
>  {
>  	int ret;
> +	struct fd f;
> +
> +	f = fdget(req->close.fd);
> +	if (!f.file)
> +		return -EBADF;
>  
>  	req->close.put_file = NULL;
>  	ret = __close_fd_get_file(req->close.fd, &req->close.put_file);

Can you expand? With the last patch posted, we don't do that fget/fdget
at all. __close_fd_get_file() will error out if we don't have a file
there. It does change the close error from -EBADF to -ENOENT, so maye we
just need to improve that?


diff --git a/fs/io_uring.c b/fs/io_uring.c
index 979d9f977409..9fd1257c8404 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -786,7 +786,6 @@ static const struct io_op_def io_op_defs[] = {
 		.needs_fs		= 1,
 	},
 	[IORING_OP_CLOSE] = {
-		.needs_file		= 1,
 		.file_table		= 1,
 	},
 	[IORING_OP_FILES_UPDATE] = {
@@ -3399,10 +3398,6 @@ static int io_close_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		return -EBADF;
 
 	req->close.fd = READ_ONCE(sqe->fd);
-	if (req->file->f_op == &io_uring_fops ||
-	    req->close.fd == req->ctx->ring_fd)
-		return -EBADF;
-
 	return 0;
 }
 
@@ -3434,8 +3429,11 @@ static int io_close(struct io_kiocb *req, bool force_nonblock)
 
 	req->close.put_file = NULL;
 	ret = __close_fd_get_file(req->close.fd, &req->close.put_file);
-	if (ret < 0)
+	if (ret < 0) {
+		if (ret == -ENOENT)
+			ret = -EBADF;
 		return ret;
+	}
 
 	/* if the file has a flush method, be safe and punt to async */
 	if (req->close.put_file->f_op->flush && force_nonblock) {

-- 
Jens Axboe

