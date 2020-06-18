Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F398DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 16:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1D1D20706
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 16:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592499398;
	bh=YXWdwOCOkUIOgwR8dTDVLi+6A0FJ6tydzt+KqGP8NX8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=i6fkRXPU8UoOmqOE//A9GrwL7IArgBh7+QsBkj038wzTs1ODUrcWZ0N/rI8QDK6Ks
	 UTKI6XQy0yUeKj7JPaCjSE5io+N29qEt+bMIx2365QAWCuh7PSyuyT9BRocEmNw6Nf
	 Vs+nQYlS+GUaAuENjgr/7n7dlVdA0Jhhbs4vR/wo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgFRQ4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 12:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbgFRQ4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 12:56:36 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F68C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 09:56:35 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 97so5084790otg.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 09:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Zro+n3z0njYBHvGQWaJJ5NJct6859FMlEejE/Xg7KJ0=;
        b=iglS7H1g0KWgSc8Vf/iE7DggyvIgMJRA+b87+ohrPrEWwRsgch+QeKyCBIU7oOqmaf
         YlyVDjGBHqwu9vQQxTrsQVoQPfqTCs0YP/TSCuY8epdv/t9Or+/OsHUqhg0XY+2M7XnF
         MlvD8JzQjvt9JwWnYxlanIuqt/wtl1SnUCvas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zro+n3z0njYBHvGQWaJJ5NJct6859FMlEejE/Xg7KJ0=;
        b=V4o3INSI+2tbOk8Du35MJE0/iPemSyQ/S5ry0BKSWvmFvkT1oS3FBW/acN4bzP4ex9
         2CjZOPWPz+S6PRzEg0xyXnG1eYpNFzuyNl717MvAjr1wPlZATPYByArGKGu76i94ZclE
         QxJdS8VLsGt4H+eOu3RMr0qCuk3YKIdvL/EB/hMipsj2yg0OzG9fQ/9DM6lbyXX0wJBH
         H9BEXAic6B9i7seCtzC5rINh77+J6z2N/sxXEnLD+DW8bFn6oe2wsohar9CIWHYqlj2c
         6MhT+ML1SYo6DYTEbIoSHv+NpQqBYE/V1zac2h4cH45WmtHK7AKpdVuQxfnmr7+Q+eEf
         NF9Q==
X-Gm-Message-State: AOAM532ro1tutgN5BRqHp23b++JwgqjygzfarXyparunFlvVYIJffBC6
        Ls3H71XASC5mcFo/pkm+8w9sxA==
X-Google-Smtp-Source: ABdhPJwo1OFUDahuNyT3wch9v/M6kjyidLgcNkfNqbUQIW/bpISmFdP12DbD+5iSAjQBCihXWbfT+A==
X-Received: by 2002:a9d:7f8c:: with SMTP id t12mr4420100otp.66.1592499395153;
        Thu, 18 Jun 2020 09:56:35 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b4sm817636otp.45.2020.06.18.09.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 09:56:34 -0700 (PDT)
Subject: Re: [PATCH] usbip: tools: fix module name in man page
To:     Antonio Borneo <borneo.antonio@gmail.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, matt mooney <mfm@muteddisk.com>,
        Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200618000818.1048203-1-borneo.antonio@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7902323e-fd72-8301-9a11-e6b912b61890@linuxfoundation.org>
Date:   Thu, 18 Jun 2020 10:56:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200618000818.1048203-1-borneo.antonio@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/20 6:08 PM, Antonio Borneo wrote:
> Commit 64e62426f40d ("staging: usbip: edit Kconfig and rename
> CONFIG options") renamed the module usbip as usbip-host, but the
> example in the man page still reports the old module name.
> 
> Fix the module name in usbipd.8
> 
> Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
> Fixes: 64e62426f40d ("staging: usbip: edit Kconfig and rename CONFIG options")
> ---
>   tools/usb/usbip/doc/usbipd.8 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/usb/usbip/doc/usbipd.8 b/tools/usb/usbip/doc/usbipd.8
> index ac4635db3f03..fb62a756893b 100644
> --- a/tools/usb/usbip/doc/usbipd.8
> +++ b/tools/usb/usbip/doc/usbipd.8
> @@ -73,7 +73,7 @@ USB/IP client can connect and use exported devices.
>   
>   .SH EXAMPLES
>   
> -    server:# modprobe usbip
> +    server:# modprobe usbip-host
>   
>       server:# usbipd -D
>           - Start usbip daemon.
> 
> base-commit: b3a9e3b9622ae10064826dccb4f7a52bd88c7407
> 

Looks good. Thanks for fixing this.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
