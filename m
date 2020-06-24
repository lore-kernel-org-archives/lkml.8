Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A699AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8237720768
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593035865;
	bh=Kfbz80ghSgu0B9W/jsct8FWQNrFxJJubtNLs4wKsmlk=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=RS+tMb8g1f80JMKBHjRC+jZnKZg9ZjEUv86LJ1W+YPHamMqcpjgg3FReaJclJv3Jv
	 OVbxzY5qIlPC3ktk5XemAdT5W6vU6O6jVWLBmxkZ/izhx5S9E22zFLMM8ZWqvb8I0B
	 rSXEJTpTtuZFMNCHY1G6F8zB6fxsXhJrbhskU0hQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388739AbgFXV5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 17:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729463AbgFXV5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 17:57:43 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4525FC0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 14:57:42 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id p82so3211321oif.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 14:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F5AhL2bw/AOtKqc03G2nDI16ZsoZh1UsNskRAYtbaNU=;
        b=Ub0IvynTicp+ncO5uesCo41hnMa6SGFTx+Rk5RUhRB/bX8HEyqVyOlI3jviU/nKKuT
         SEMLWUKenW8w6jKxISbDptqFASkR0dY3ANVGFobTFLVmo4yvCJnQv7OJIaLz9Psv2xbd
         1NeV3vpx7icM7V2WMXYqzLl0MGcOwIzwZg8t0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F5AhL2bw/AOtKqc03G2nDI16ZsoZh1UsNskRAYtbaNU=;
        b=TiKxkxjt6fVrtl4+/Dr28/VopqGsRV+eJxPT+k3Z5wEZTEJT0bdEBdbTYluY/71Ri9
         b9uel89MCqXhZ5t2yyYtHE5PUY1flnAjppy9USgDHmDoP4VeVXUmEE1zesAv/H3RGp8R
         XRc+kvIa2J7OTUXaGIO/bkIwxsARE/KIBnQcVP9NnwfXyTRQS/CIjisjU8J1NbtgGUJX
         OpDmSNfXhHje8UecMG7YSpohY51uxROZZ39RlReUnhONpNcrscsesVJGUKGqMk+G+c7r
         T1XQHEy0irVY8yn8TRqerhx++QW5HkGD9cbMt62qpIVggSRBluHvlpvrYus3QSBgEeCf
         Gvbw==
X-Gm-Message-State: AOAM530w3whIKwJd1pU7G7cv282FFggrSWAdDa4h6DFDcTHTmI1Aglm1
        83+5XK/Leo8jOhmI/P8dbxBM8r0mv0U=
X-Google-Smtp-Source: ABdhPJyyEtqUlR6E8hzeOtso0lOe7AZ2Fmexq6+l1Rhftt9AFPvFyjXqyH+anZEIkaCgIM7dcfKe5A==
X-Received: by 2002:a05:6808:99c:: with SMTP id a28mr22100205oic.162.1593035861670;
        Wed, 24 Jun 2020 14:57:41 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g51sm5070186otg.17.2020.06.24.14.57.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 14:57:41 -0700 (PDT)
Subject: Re: [PATCH 5.7 000/477] 5.7.6-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, skhan@linuxfoundation.org
References: <20200623195407.572062007@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <86d738fd-5f5d-9328-6d7b-6f5148bc3e72@linuxfoundation.org>
Date:   Wed, 24 Jun 2020 15:57:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/20 1:49 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.7.6 release.
> There are 477 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Jun 2020 19:52:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.7.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

