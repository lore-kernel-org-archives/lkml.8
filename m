Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05452C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF5EF20656
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597091795;
	bh=0SlTBLyruOaU9Pt5d4kuvdb9UNJa2UvWRRJfOEpGbZo=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=0GndR0NFlNmwm7SYyNzfvZ1QHHcdroprWumzSVs8/Ji2khLxt968RRx9dSaKfp/2b
	 Q9Xy785RsS0ogVMqGxfWBWbHFNettO7e8B1HWlbEx0tXpZR/MxGYgilZvqN6R+uB6X
	 VtfYN44o7NItrSOi5WreWWWkbDib/oJO5WIWt3k8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgHJUgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 16:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbgHJUgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 16:36:32 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3758C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 13:36:32 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id r21so8356146ota.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 13:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HI5lYobBh5RFongYBHy3SxRT7R6Q8746klJDIeOy6qU=;
        b=EA9XWL8ixJer6vvD9QKB92A7snrHrW1lP9KMNfKkrgDRKIm/boc70yBjqb5A3P6THW
         /0DCP7NdG1s9AnFnaRyiNofaz8s8jhbkPYjsQ3hXZhmCDlofEAtyAneovWP2IwR8Us+D
         cQHMHQGIzZj+AzPMHLwf8Vk6dSvpz/3omoDMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HI5lYobBh5RFongYBHy3SxRT7R6Q8746klJDIeOy6qU=;
        b=F7I3qOxsRxRbFujHBdEalsn2Xgjte3NvWFodF/eH2ypcoix5Vmb3mTCD4KO38wppWw
         M4XvkE2aKtS8yf2BIfr1BJ7sAtFrJ0mbBUWzDzXQ3n+H7w3dzFH0aVM7467JH4C35haj
         QrGwCpD7pOz3tUzkRvW3nGKVsZ5FBPCZnSRiXlEHqRxJPxDUUAXLT04+CBeROxSXIuQF
         JQT67MTnPsiFY+9aj5dYOTtvPjo8VNAA8RBxqTQxSbbpaf3Xq5cj+tDOi8Oc4tZHc06s
         bECUA/2cdsWv/F5A9twymtCVImGWfMaxfhgBKgBPL+E8LNyY1yYAWiyT2LIty3/rGXO1
         yMwg==
X-Gm-Message-State: AOAM531fm8Cw8OGYNILlQ8N+1W5eCdz+K6wAOiJkh6cYBV5S/YkO515O
        WY9QvbvPLBy30g1SzFOjc14YcUgKadk=
X-Google-Smtp-Source: ABdhPJwyXOGud5mnCnLyYllZBzTKdtqelYBxOZV4q9EeZkRhIBCLgeDowbbDa/iwkcMiZ05qI2Yvlg==
X-Received: by 2002:a9d:6d1a:: with SMTP id o26mr2140683otp.84.1597091791948;
        Mon, 10 Aug 2020 13:36:31 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b10sm673545oiy.7.2020.08.10.13.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 13:36:31 -0700 (PDT)
Subject: Re: [PATCH] cpupowerutils: fix spelling mistake "dependant" ->
 "dependent"
To:     Colin King <colin.king@canonical.com>,
        Thomas Renninger <trenn@suse.com>,
        Shuah Khan <shuah@kernel.org>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>, skhan@linuxfoundation.org
References: <20200810102115.62405-1-colin.king@canonical.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <72e1bc33-5ac1-5719-196c-a9d8f265fbff@linuxfoundation.org>
Date:   Mon, 10 Aug 2020 14:36:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200810102115.62405-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/20 4:21 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   tools/power/cpupower/debug/i386/intel_gsic.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/power/cpupower/debug/i386/intel_gsic.c b/tools/power/cpupower/debug/i386/intel_gsic.c
> index e5e926f46d6b..befd837f07f8 100644
> --- a/tools/power/cpupower/debug/i386/intel_gsic.c
> +++ b/tools/power/cpupower/debug/i386/intel_gsic.c
> @@ -71,7 +71,7 @@ int main (void)
>   		printf("\tsmi_cmd=0x?? smi_port=0x?? smi_sig=1\n");
>   		printf("\nUnfortunately, you have to know what exactly are "
>   		       "smi_cmd and smi_port, and this\nis system "
> -		       "dependant.\n");
> +		       "dependent.\n");
>   	}
>   	return 1;
>   }
> 

Thanks for the patch. Applied to 
git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git cpupower 
branch and will be included in
  my next pull request to Rafael.

thanks,
-- Shuah
