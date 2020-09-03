Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFB8C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E80620722
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpkcLkR9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgICTba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 15:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgICTbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 15:31:22 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BD3C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 12:31:21 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id a2so3755297otr.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 12:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4Ds0pilk2n31SUh/VCS796KjocXgyLpE6TMUOjrCscU=;
        b=TpkcLkR9Qruqr4xs1c0PrDQ7676Xb3Wl53/ahnz5w7QRAdJFlXpw2Aj8G3YRdRwxl9
         hBqiouvnei8/WdSqGsNnPpbfNydTgjyquu/9XfJVo/+15aPlnr7Eml47q8Jd/rPbQvPx
         HTHR59kwmmxC+R2N0++fYvUzVg/hTwnm34sBjG2rbK9WrphlXkQa99/BCwzRJ1gTAXVc
         jfxr3ZW90RELQZqB/MqA/RlzpmprYrTgMzTNJiIo0O7SM1Vd5Bo1+7YCF1yHAVU+H9QO
         MYR7C5ngsDNzgKhBz0j7NUSV2e1i9vxFdaXbUDhYcEl4EUq/Aeyx1zbXd9xoGMMt4q2B
         X6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=4Ds0pilk2n31SUh/VCS796KjocXgyLpE6TMUOjrCscU=;
        b=dkkGWmNY0fDP0VAppKYKleKISziy4Ldjfm4JBf37UYoJCcDwxZY60E07IQggrYcmfk
         khB+HLkxk118y6OPfQf77mxrlvvhCEnRRC5yLQ6qW7AGyuXNBBe6QBnJC7Y+qzdbOb8i
         xH3vsjFB16yCfgP53h0pgmx7p7d9Gc9/b/BLMh3Tx0eIivSAIDNUc8yuzV2jR9ws2zUk
         bkY6rHKSkEfOwPkZTcGSP6KAWuCt4WIUU+a4q5cU4teJt8xyrlwvkiApjKj+I9BHR8BE
         xYg4WBU9EJm1CB58v0iYk6Zw2g66my+vhM7vKoLatKQxIDL1WZxmeRSWhza/QvFnDlJb
         QF3g==
X-Gm-Message-State: AOAM531TKHAHwaJI/0wUdLLTrhTpqYkzQbCcxXwyDOhJNUP9CT0Dsvmh
        U0ZtVLY+M7fqIqpWz8fdMX8nWdi7+w==
X-Google-Smtp-Source: ABdhPJywx4DlgNOa/Cwh/x7itIYS9v0uWkuKmO5dKMUZ9w3eN7WeYAa/xfu8jMeZ+Kf49+3MKyK+rA==
X-Received: by 2002:a9d:429:: with SMTP id 38mr2673005otc.88.1599161481252;
        Thu, 03 Sep 2020 12:31:21 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id i23sm676586oii.53.2020.09.03.12.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 12:31:20 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:a442:8186:b629:4877])
        by serve.minyard.net (Postfix) with ESMTPSA id E68A1180056;
        Thu,  3 Sep 2020 19:31:18 +0000 (UTC)
Date:   Thu, 3 Sep 2020 14:31:17 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi: add a newline when printing parameter 'panic_op'
 by sysfs
Message-ID: <20200903193117.GB4442@minyard.net>
Reply-To: minyard@acm.org
References: <1599130873-2402-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599130873-2402-1-git-send-email-wangxiongfeng2@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 07:01:13PM +0800, Xiongfeng Wang wrote:
> When I cat ipmi_msghandler parameter 'panic_op' by sysfs, it displays as
> follows. It's better to add a newline for easy reading.
> 
> root@(none):/# cat /sys/module/ipmi_msghandler/parameters/panic_op
> noneroot@(none):/#

Thanks, it's in my for-next queue.

-corey

> 
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index 737c0b6..6ebb549 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -89,19 +89,19 @@ static int panic_op_read_handler(char *buffer, const struct kernel_param *kp)
>  {
>  	switch (ipmi_send_panic_event) {
>  	case IPMI_SEND_PANIC_EVENT_NONE:
> -		strcpy(buffer, "none");
> +		strcpy(buffer, "none\n");
>  		break;
>  
>  	case IPMI_SEND_PANIC_EVENT:
> -		strcpy(buffer, "event");
> +		strcpy(buffer, "event\n");
>  		break;
>  
>  	case IPMI_SEND_PANIC_EVENT_STRING:
> -		strcpy(buffer, "string");
> +		strcpy(buffer, "string\n");
>  		break;
>  
>  	default:
> -		strcpy(buffer, "???");
> +		strcpy(buffer, "???\n");
>  		break;
>  	}
>  
> -- 
> 1.7.12.4
> 
