Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD4BC35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 22:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704B320708
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 22:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tmF0Qn78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgBKWQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 17:16:12 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:44180 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgBKWQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 17:16:12 -0500
Received: by mail-il1-f195.google.com with SMTP id s85so4861528ill.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 14:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H6KlLlplsizPpKg7w1wwWFh0NtfbnywsiGoeM+An45U=;
        b=tmF0Qn78uukVn/7m3JgznZh14E1BbLbdzDeNuplNjnXZHkeVmluNenRKCBDlMWzGWi
         zNw7wHXcWOj8goeYAeJhTbN/mf9EvwzuPIUc1D2mqdyRke3Pi5c5pLUN8RJnFeqyyVHI
         LQMghKWEwzQypBfuBs/CvLlfxDGHGNOFqODbQg/1+PGvgZHvFlFXE5EGuQnJPFlGCyty
         Y8N5XVoig8JgX8mtJnb1HPFWka4M18YNoFbKXlmQAwoqo6x8/MUz0OmdQv6kBnZcHm5d
         HcKAAh+DggxrZm+g0jqSG7O1B8jb38CatG/7m+PxfZLBdC/j58KNBJx30cWdxtOeZu4u
         BTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H6KlLlplsizPpKg7w1wwWFh0NtfbnywsiGoeM+An45U=;
        b=nvHxA0iYZfShp1wct8BRpcV9duTMiBbH+EnCyqXnBYjNfX5vuv/NmRUobnHD1VFSiW
         ctyvRGui5JAIB3QA5LbBfxtjsth2G+8eHy6Cx7LWCS4GwU3DWHm3C5ewPJXhNHV+9pW5
         baPNS4MHaG6WE2NRv07sd9+eJb3x/WLzuQTAIr6O16/5ju/2I/+EvRedGFj3mQ90iv8/
         j/D3fc1pPTuxf/ijdVwxvx+MT9e1tPpJ7tuI5nWtfVN0pcBsqkpwvsRF5ggMpQU3tiRb
         FVy850yshpFQYQy4DYfPoUnG+Y2wCtb5OuKaCzYjkCjSYCKjgJGznS0974+SKVR+s6fx
         tQ2g==
X-Gm-Message-State: APjAAAUDAaKHXQzSjxXGxBnve4jx84JNTWEGEZxM8lLyVOtS/U+RlAOL
        MUiYO5AYuT3Yym7cxmbIHv6d8C05P/0tAg==
X-Google-Smtp-Source: APXvYqzTqJNXmNj4lMWwdLNrDnJkdwd3aVpL7i2tk1tOW88coogfvaC/JMWvkpyM8dBzuY4epaT2ZA==
X-Received: by 2002:a05:6e02:8eb:: with SMTP id n11mr8102929ilt.26.1581459369847;
        Tue, 11 Feb 2020 14:16:09 -0800 (PST)
Received: from [172.22.22.10] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id s10sm1376816iop.36.2020.02.11.14.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2020 14:16:09 -0800 (PST)
Subject: Re: [greybus-dev] [PATCH] staging: greybus: Replace zero-length array
 with flexible-array member
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org
References: <20200211211219.GA673@embeddedor>
From:   Alex Elder <elder@linaro.org>
Message-ID: <e465ca6e-ed9f-4340-9f4c-104f9b6acb74@linaro.org>
Date:   Tue, 11 Feb 2020 16:15:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211211219.GA673@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/20 3:12 PM, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertenly introduced[3] to the codebase from now on.
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/staging/greybus/raw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/raw.c b/drivers/staging/greybus/raw.c
> index 838acbe84ca0..2b301b2aa107 100644
> --- a/drivers/staging/greybus/raw.c
> +++ b/drivers/staging/greybus/raw.c
> @@ -30,7 +30,7 @@ struct gb_raw {
>  struct raw_data {
>  	struct list_head entry;
>  	u32 len;
> -	u8 data[0];
> +	u8 data[];
>  };
>  
>  static struct class *raw_class;
> 

Does the kamlloc() call in receive_data() have any problems
with the sizeof(*raw_data) passed as its argument?

I'm not entirely sure what sizeof(struct-with-flexible-array-member)
produces.

					-Alex
