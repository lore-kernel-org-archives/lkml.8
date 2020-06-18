Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4A2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 17:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDEF72080D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 17:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592500298;
	bh=kR2qUCl6H0tLGIz3fK767cSV2I1JT33iZx5kogPI7CU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=ZkURzFyt6uqLr0FtMFsFj0qxjrnCglTi7HLW8UdOTDNwlRU6MT2/xTUWlSfyjdHri
	 JtB0gGABF5r2XtjuiGCJbIScCk+i9kRE3ZP3/tgzDBpAjddpk77goRle1QydtA1bV2
	 ON0lQRVEKq0VtvINpz+nRjs/O7iEoWalkQWcOkqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbgFRRLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 13:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgFRRLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 13:11:33 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3004AC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 10:11:33 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id d4so5137972otk.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 10:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m56O9oyGheb7iqPx3y65EPbbyQ1wr2kzzTnOcksS43k=;
        b=cJp9zOQC0gC906ow0l6j8q9KiNEvGPpjzzHnBLW5f5UXJSp2JKMXzGknat9SRN+dkt
         w2gA1CS6jHyZhHtYVhWLdjFU8pZgd1wfT0i734PuD7tNHBL1Xh5Il/+jJ4SBIx9e6K/p
         VUyBzcvlvKaFRvjGYv2brWns5rtpJE9102tMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m56O9oyGheb7iqPx3y65EPbbyQ1wr2kzzTnOcksS43k=;
        b=eVsNgDzRxH3bUQFUBy0VxWR2Zw9044RCWuS1hrsvlkOeh0xmVHBnJrujAmZpd6W4fj
         3lhxAby5tPZBGk+WxxeTqhQexontpKcXDGkrY7GZkh6c1FMRKC6rZjW3buK5OFSTxtaP
         QVF7jeYOXiHyR2FPH8Jykqn/lv/328dktAueLx8VeiLeB+jkjpKReHI0oQrNRDzVrd+8
         +ewMiPb4/jBKij44TAjG6e+iDrGqDZb5lnqF9hTmIpDyqqQeBz7q5F6j786t2fqX9YAa
         ilOe/oTzPcfMbR7BNH8LG+HNCwk/iS4v04TmsXeiqHUpfNtugYWZZqspCJR+yIOj7kcB
         F88A==
X-Gm-Message-State: AOAM533E2iQ31/FXNy4aynd4lWSFiSNpvq7TR//DGAsbLpX/HXX8gfd2
        DVQ1PQcAjWp7EEqrr9wDp5PZYehTpj0=
X-Google-Smtp-Source: ABdhPJzp6MAPICetIONmQzCwKHp9K0QLrfalAs/N4dm2NHnxKcTJhjWi82s/9X+lJB9oBcs3ACitMA==
X-Received: by 2002:a9d:62c6:: with SMTP id z6mr4184725otk.70.1592500292528;
        Thu, 18 Jun 2020 10:11:32 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c13sm817170otm.78.2020.06.18.10.11.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 10:11:32 -0700 (PDT)
Subject: Re: [PATCH] usbip: tools: add in man page how to load the client's
 module
To:     Antonio Borneo <borneo.antonio@gmail.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200618000831.1048255-1-borneo.antonio@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <95bd8906-5864-e5ae-e0d7-eae093b2d8af@linuxfoundation.org>
Date:   Thu, 18 Jun 2020 11:11:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200618000831.1048255-1-borneo.antonio@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/20 6:08 PM, Antonio Borneo wrote:
> While the man page usbipd.8 already informs the user on which
> kernel module has to be used on server side, the man page usbip.8
> does not provide any equivalent information on client side.
> Also, it could be hard for a newby to identify the proper usbip
> client kernel module, due to the name "vhci-hcd" that has no
> immediate assonance with usbip.
> 
> Add in usbip.8 the command to add the module vhci-hcd, similarly
> as it's already present in usbipd.8 for usbip-host.
> 
> Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
> ---
>   tools/usb/usbip/doc/usbip.8 | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/usb/usbip/doc/usbip.8 b/tools/usb/usbip/doc/usbip.8
> index a6097be25d28..81313f4913b4 100644
> --- a/tools/usb/usbip/doc/usbip.8
> +++ b/tools/usb/usbip/doc/usbip.8
> @@ -85,6 +85,8 @@ List local USB devices.
>       client:# usbip list --remote=server
>           - List exportable usb devices on the server.
>   

While you are making changes, please change the above to the
following. This is more accurate.

List devices exported by remote=server

> +    client:# modprobe vhci-hcd
> +

>       client:# usbip attach --remote=server --busid=1-2
>           - Connect the remote USB device.
>   
> 

thanks,
-- Shuah
