Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A25AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 251BF2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="bho3CI5/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbgG1WhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729223AbgG1WhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 18:37:08 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F81C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 15:37:08 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id k23so22474132iom.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 15:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EReXMTG1Tmh9rCxrfzcdSSmSqczZSw6FsxufeVNcmCk=;
        b=bho3CI5/KuDuigkKMG34qqAzwgMi8luz6+3vsZ62NeayRJBAxZ6HVuDYac4v5fs6QA
         LSUt0ZI25na4eiMvDNGdyID1FdA2P+ITGMEI5WOy5v0mDljsHFfxy5PaxteUZZS1QE+d
         nqDqj/ohZPwpBQE98/QpFWwLVsioKrtGWyFK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EReXMTG1Tmh9rCxrfzcdSSmSqczZSw6FsxufeVNcmCk=;
        b=triUySVXKfqWgEyqjNsZ5UXjAiVkEDOL/xhz8hjrw8/g3yc7BCm0lwG9SDoPNOBcPQ
         O9GKRBGtpZJTByj5ypAOjohBtqZ6V/JXoUkHi9kHnAwliVbnufAnBxp7KOjp32xqObs0
         nMfpClUa9up/3zTQfw/i09N+OeY6o5wEhKmJqNpsQnBlOGaEudLnynnhOUcTlTnBE+6U
         mrLMwTF4zf745K/uW4Hi2Dn8li1TP97guUVl1rmSQ4sA+707kH4tFMKSRUVORBGtyeTp
         ENhMqb9YAJMxKFT6zYq8w39VmViYwpIP/S88u2hduEtwWSuujo7OGZ9skh7HLTxg+0AU
         Ep+g==
X-Gm-Message-State: AOAM533Ot5Nf9sZDSyfuo53WuGy6O2lVdWEG3YXEHc0O/eiknxZt5Maz
        hB7HPExCiiQQbJCdLt4Fjfh37Et1NDA=
X-Google-Smtp-Source: ABdhPJyzXHG0tAuOusgIOMdvOpWxshaGRK/E/BmEJ3ru0oPTifXmHxcqzffEoT+KHP49oqXHsitCTg==
X-Received: by 2002:a05:6638:27a:: with SMTP id x26mr4781663jaq.43.1595975827218;
        Tue, 28 Jul 2020 15:37:07 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id b11sm105864ile.32.2020.07.28.15.37.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 15:37:06 -0700 (PDT)
Subject: Re: [PATCH][next] greybus: Use fallthrough pseudo-keyword
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20200727183258.GA28571@embeddedor>
From:   Alex Elder <elder@ieee.org>
Message-ID: <63871608-e076-26b0-85df-cff11699c3a3@ieee.org>
Date:   Tue, 28 Jul 2020 17:37:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727183258.GA28571@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/20 1:32 PM, Gustavo A. R. Silva wrote:
> Replace the existing /* fall through */ comments and its variants with
> the new pseudo-keyword macro fallthrough[1].
> 
> [1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Thanks for the patch.  It looks good, but it raises
another question I'd like discussion on.

It seems that Johan likes default (or final) cases in
switch statements without a "break" statement.  Viresh
and Bryan appear to be fond of this too.

It's pedantic, but I don't like that.  Am I wrong?
   --> Johan/Viresh/Bryan would you please comment?

If they aren't convincing (or don't care) I think break
statements should also be added here:
- In gb_interface_read_and_clear_init_status() for the
   default case
- In gb_interface_activate() for the default case.
- In gb_svc_process_deferred_request() for the default
   case

But let's wait to see what Johan (et al) says.  If you
don't want to do that, say so and I'll do it later.

I looked at the code in drivers/staging/greybus/ and saw
no need to add a "fallthrough" anywhere, but:
- In fw_mgmt_backend_fw_version_operation() Viresh
   seems to have skipped the break in the fault statement
- In gb_uart_request_handler() Bryan did this too.

Depending on discussion, these could be fixed in a
separate patch as well.

These cases aren't found by "checkpatch.pl" because it only
looks at case "blocks" that are followed by another case.
So the last case isn't checked.

					-Alex

> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   drivers/greybus/es2.c       | 2 +-
>   drivers/greybus/interface.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/greybus/es2.c b/drivers/greybus/es2.c
> index 366716f11b1a..1df6ab5d339d 100644
> --- a/drivers/greybus/es2.c
> +++ b/drivers/greybus/es2.c
> @@ -759,7 +759,7 @@ static int check_urb_status(struct urb *urb)
>   	case -EOVERFLOW:
>   		dev_err(dev, "%s: overflow actual length is %d\n",
>   			__func__, urb->actual_length);
> -		/* fall through */
> +		fallthrough;
>   	case -ECONNRESET:
>   	case -ENOENT:
>   	case -ESHUTDOWN:
> diff --git a/drivers/greybus/interface.c b/drivers/greybus/interface.c
> index 67dbe6fda9a1..58ea374d8aaa 100644
> --- a/drivers/greybus/interface.c
> +++ b/drivers/greybus/interface.c
> @@ -1233,7 +1233,7 @@ int gb_interface_add(struct gb_interface *intf)
>   	case GB_INTERFACE_TYPE_GREYBUS:
>   		dev_info(&intf->dev, "GMP VID=0x%08x, PID=0x%08x\n",
>   			 intf->vendor_id, intf->product_id);
> -		/* fall-through */
> +		fallthrough;
>   	case GB_INTERFACE_TYPE_UNIPRO:
>   		dev_info(&intf->dev, "DDBL1 Manufacturer=0x%08x, Product=0x%08x\n",
>   			 intf->ddbl1_manufacturer_id,
> 

