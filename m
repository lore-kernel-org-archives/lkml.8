Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B9AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 15:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4A7B2088E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 15:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591371042;
	bh=fJ1kYoP5veId5Jd8fw/yIVkYzV2PtjIiOOhQuCsrsgE=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Vv7mVXA1g8JC7wl/SBoVa4XeCvmrcxM47cYapPONyxqNHnOyjoQu6dgJntE2TX0x/
	 hgGDorwtsxJslw+++7kc/I7tLfsbVnXJKHqMIBLasT+yvmH9Z381B6Eap7YxEQa0iJ
	 QgdvPRAqDwdm/xC6WXHN0Z8tUzpkxcfkjmKN5GU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgFEPal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 11:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbgFEPak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 11:30:40 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057F2C08C5C3
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 08:30:39 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id m2so7892357otr.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 08:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uy6/ov1vILLkH7kcuXe0+MBG/XzMaYdojJE5StW+fqg=;
        b=DI+hpKl+hUQ+AIfZj9GZk8j3r7WzMOcipaTkPdvxCb5Asn6qns/SwZZHJni5DGjzn/
         8G0xYJRVktvVGfHikyN9FoVY6xBvGt6+8JsV+X+bIYH+B3R8oIy1lApTZLRWYj4V6lMT
         7fdLsnHhSgOsgpxryS2H1UbujF39NVfjo1hsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uy6/ov1vILLkH7kcuXe0+MBG/XzMaYdojJE5StW+fqg=;
        b=CNmLLwKo+ccEc2mkrg3lBwmAA3eAhE47E/seXviGHO4HiGrYlhR2xFwyVoTHhF1dv+
         ZWtvL1PhI+YTvZfr6EESNFh52It0iK2N2C6A9IZznxoqaxabe/NzSMbWojK3DtW0Wsqt
         IKsjzNgpQFVFQOBsR2na/XBEu1WPmk2hMieYFKmFc/5CHnYjzgnRgERvuSPiabHCm2LZ
         iadE8iC5ZbnmBi2ypMe5EChmfktq/gmc8VZSPF3mY6stwAFTyA6cZnQVHRQZ+9rha9gQ
         McC1khUGkbK2Sj9zkf/7sO8TWsjjcy/yq09hhcqIPVooAC1uxEh2/15bkCBgXLpL13OV
         b0Ow==
X-Gm-Message-State: AOAM532YItoPS8rHHRQID6aeNqpPH+5F7bqJkFkxrD+SdemHxBuKpBcQ
        Lc8u3Wt9Lu/4EQQihOHS4EvdrlLyQRw=
X-Google-Smtp-Source: ABdhPJykV+GXVonGB/g4y+9di/oDQYBEb8B+1SaloTuri4DmB9oIZBrDy6MlOduor4F6bmoAIvnm1w==
X-Received: by 2002:a9d:822:: with SMTP id 31mr7601100oty.137.1591371038337;
        Fri, 05 Jun 2020 08:30:38 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v20sm7144otq.64.2020.06.05.08.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 08:30:37 -0700 (PDT)
Subject: Re: [PATCH 5.6 00/43] 5.6.17-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200605140152.493743366@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <dee14be9-f6fd-30f7-f399-4e74b104eefc@linuxfoundation.org>
Date:   Fri, 5 Jun 2020 09:30:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200605140152.493743366@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/20 8:14 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.6.17 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 07 Jun 2020 13:54:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.6.17-rc1.gz

wget 
https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.6.17-rc1.gz
--2020-06-05 09:24:32-- 
https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.6.17-rc1.gz
Resolving www.kernel.org (www.kernel.org)... 147.75.56.137
Connecting to www.kernel.org (www.kernel.org)|147.75.56.137|:443... 
connected.
HTTP request sent, awaiting response... 301 Moved Permanently
Location: 
https://mirrors.edge.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.6.17-rc1.gz 
[following]
--2020-06-05 09:24:32-- 
https://mirrors.edge.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.6.17-rc1.gz
Resolving mirrors.edge.kernel.org (mirrors.edge.kernel.org)... 147.75.69.165
Connecting to mirrors.edge.kernel.org 
(mirrors.edge.kernel.org)|147.75.69.165|:443... connected.
HTTP request sent, awaiting response... 404 Not Found
2020-06-05 09:24:33 ERROR 404: Not Found.

Looks like patches didn't make it to mirror yet? Seeing the same
error with the other stable patches.

thanks,
-- Shuah
