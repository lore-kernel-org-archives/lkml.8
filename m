Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41018C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1751E20768
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593119496;
	bh=bx8lxF5Ao3ZLXPO+psSEIif4L5uWCNzZWfAbljoX+7I=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=zucd4YIPrfkarAwvwcnddBXF3qaNN0eRxgl1IaXfEmYueA+rR2X2WlcY2MKYTBUu8
	 KcxikhT74/OawC4h8anT8KQwrUaXORFOB01LEl/CMXVNkk8Jrfe0veOtjAo0b492il
	 8PRvcsL+ziyXlbU6Phr/twFy/QuCW2d08iFqu534=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405695AbgFYVLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 17:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391185AbgFYVLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 17:11:31 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85458C08C5DB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 14:11:31 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 18so6656043otv.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 14:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k8OAgKU400QXnB0pfTjlnf95XjI/EzLjkKF5VofXQm4=;
        b=PRlf6ZWNu4GPS81dC4s7MfFqIEHMhbdvPqkS1UIdPn1TWcdCK+/5IWkjTxr5vpZzYn
         fDGX4ifgtn3Mg7dkjKUZaAHBE5vuo+/b33ePQqlhxNJphscN3/rO7uu2anraBpa/AfCr
         hBR6SAe1FHi8J8lCGN3tzgh306U7MyhKMDKV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k8OAgKU400QXnB0pfTjlnf95XjI/EzLjkKF5VofXQm4=;
        b=HWiv4X/AMqK08TJLBgPmVU3BxaFTwKFw6DwqeZgGXgwexF02Uhjcs+8p4YPmZQWwxs
         1v1cuIeuffUC0Y1tLFsCM4UY7a8KITcWQoiSHJGrMXr5hilKKripw5Xg+HbGceGNJdR0
         HI9UuNFCslTqdafZiub8yLMkHS4VULijB4VphEoEYvRzQXu8rtnxR9sMHWRC0NB17LLV
         ZpOtxdjBokAHkfJliSIwOqhDoKca89gTyTA6kCm0SO7aSt3zZLKfZd3Uw41EnrGLMWSg
         CxF9I92RxbvxRjMyRcrYne1aEsJCw6iyR6WZMJJRTngps3X1+zCBHdtocK0eG9JoWZuo
         Uv7A==
X-Gm-Message-State: AOAM533hZUqvhGL7oMepF30STkxzyEYDr4ISfajNssptQtUr0baNHMTV
        Rf9SeaS9RffFRFgaRgaFbVem3g==
X-Google-Smtp-Source: ABdhPJwF5ukoGz73lxNiyFqPSchj8qJ/85yti5EHyTKNoVRangU31mzsP5hM6tq/QIL3mAzcHzGJ1A==
X-Received: by 2002:a9d:845:: with SMTP id 63mr3844564oty.213.1593119490869;
        Thu, 25 Jun 2020 14:11:30 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x24sm2475115oto.31.2020.06.25.14.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 14:11:30 -0700 (PDT)
Subject: Re: [PATCH v2] usbip: tools: add in man page how to load the client's
 module
To:     Antonio Borneo <borneo.antonio@gmail.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200618000831.1048255-1-borneo.antonio@gmail.com>
 <2da8fc9e34440c1fa5f9007baaa3921767cdec50.1593090874.git.borneo.antonio@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <07af6971-b9d2-33a6-ec01-21c53050bc04@linuxfoundation.org>
Date:   Thu, 25 Jun 2020 15:11:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <2da8fc9e34440c1fa5f9007baaa3921767cdec50.1593090874.git.borneo.antonio@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/20 7:17 AM, Antonio Borneo wrote:
> While the man page usbipd.8 already informs the user on which
> kernel module has to be used on server side, the man page usbip.8
> does not provide any equivalent information on client side.
> Also, it could be hard for a newbie to identify the proper usbip
> client kernel module, due to the name "vhci-hcd" that has no
> immediate assonance with usbip.
> 
> Add in usbip.8 the command to add the module vhci-hcd, similarly
> as it's already present in usbipd.8 for usbip-host.
> While there, rephrase the description of the command "usbip list
> --remote=server".
> 
> Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
> --
> 
> v1->v2: rephrase the description of command "usbip list ..."
>          fix a typo in commit message
> ---
>   tools/usb/usbip/doc/usbip.8 | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/usb/usbip/doc/usbip.8 b/tools/usb/usbip/doc/usbip.8
> index a6097be25d28..a15d20063b98 100644
> --- a/tools/usb/usbip/doc/usbip.8
> +++ b/tools/usb/usbip/doc/usbip.8
> @@ -83,7 +83,9 @@ List local USB devices.
>   .SH EXAMPLES
>   
>       client:# usbip list --remote=server
> -        - List exportable usb devices on the server.
> +        - List devices exported by remote server.
> +
> +    client:# modprobe vhci-hcd
>   
>       client:# usbip attach --remote=server --busid=1-2
>           - Connect the remote USB device.
> 
> base-commit: 48778464bb7d346b47157d21ffde2af6b2d39110
> 

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
