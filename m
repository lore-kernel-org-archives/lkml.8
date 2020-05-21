Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4394C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0DCA206F6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MX1yXVd5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbgEUPA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 11:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgEUPA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 11:00:58 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492B7C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 08:00:58 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id v19so35367wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 08:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xNvfr9ZomZgtb8diUDpjPmJt7SHH2ZapuyzSmsU3ahM=;
        b=MX1yXVd5kaBMAOvpkaR5bzihkSli3j3X9/fMwylqRwRa7pPOQXVIyTlQ3xS97+Si0k
         tAeOU7BG/EtPUAp3rIJVrjxElKZWzVuIeN3tepUywI6hnZV5eGUyaI1e1XDzPqHTyy23
         0XdcLWi/he7zy8Tb6K5KkJe9Cmd6CUiJ5zRxvdfdvVFoGEvdgIx5S/znVfAjNkQSNIda
         ScakjOv2AeJwIR/3hMD5blq7YIXNQWZlaInCDlEZ1o/QMA+YcNtUeQciFBWFWRz0ABj5
         3r3zx/CI5jagmDnpUKToaelVfqLtbdPY1f9dLgKV3s4oxxW+Z3Dcuea5ICm5XO6tDHLw
         luoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xNvfr9ZomZgtb8diUDpjPmJt7SHH2ZapuyzSmsU3ahM=;
        b=NkGXlKqau2LgVKpKVTDeHV+ShCBtdjzDHasu0wt435q3LsATUWpzSjXjlLGwxFAlN9
         TRa3mLT7JZQ5FNBOqT04i0pG6xo8MUdH19+a4tHq2rCm9PS8x+qomiQVPv6eqi05ChcC
         sWD37d+GYeFXZh6CI/rksalJjej/tx70ZuZ75t2plX9tDeNA9XMYXoSaXi3ZZogFgRie
         ayjJA9v+eZJnovyH5gMzrPH8FeGGZ+wjiWTDNyWtH6E+MlD2kW/8HoGBvUVCWEJGwdRP
         ENFpEFh8uCdUR8WsrwqEJ35Oyhau5+k065baJxfqZAvJLXldDXiK2Ys7t46IF5LqE3FC
         cv1g==
X-Gm-Message-State: AOAM531LqNzvTbXyL7sFt3ItEnxWHLRAehPFffySAmhypyKAE+23BM5q
        H4s8PcXt4lUcYP7yPTlSqRlytQ==
X-Google-Smtp-Source: ABdhPJwfzvV+R4l+KG6lME5IhqDsVcJgqbzqW+TQCrjI7nds5gXruiaMqMpW57n/BdatSL29su2BBg==
X-Received: by 2002:a1c:9cca:: with SMTP id f193mr9006659wme.71.1590073256943;
        Thu, 21 May 2020 08:00:56 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id 32sm7192512wrr.38.2020.05.21.08.00.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2020 08:00:55 -0700 (PDT)
Subject: Re: [RFC v1 2/3] drivers: nvmem: Add driver for QTI qfprom-efuse
 support
To:     Doug Anderson <dianders@chromium.org>
Cc:     "Ravi Kumar Bokka (Temp)" <rbokka@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        dhavalp@codeaurora.org, mturney@codeaurora.org,
        sparate@codeaurora.org, c_rbokka@codeaurora.org,
        mkurumel@codeaurora.org
References: <1589307480-27508-1-git-send-email-rbokka@codeaurora.org>
 <1589307480-27508-3-git-send-email-rbokka@codeaurora.org>
 <ffaccce7-95c0-2f95-ad3b-55f1da42eaee@linaro.org>
 <14e1fa51-066c-6e1b-01a4-2103612de9e9@codeaurora.org>
 <d5902226-21b3-7941-6405-688d7a115142@linaro.org>
 <b80aaca0-0594-e04b-5320-b5b3c4478161@codeaurora.org>
 <d76e4eb2-fa6a-0b76-3912-83bce678bc96@linaro.org>
 <CAD=FV=XW7GymV_pr_0SvUPWwL6WnPhqMq-crq-RbR_us3-ShNA@mail.gmail.com>
 <9864496c-b066-3fe8-5608-bd9af69663f4@linaro.org>
 <CAD=FV=UbZPQ74COXJbOikq9Wcx1UvtuMuMA+nqkx44uySoqggg@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <99f07eaa-d072-f391-098e-e6f7a50a1960@linaro.org>
Date:   Thu, 21 May 2020 16:00:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=UbZPQ74COXJbOikq9Wcx1UvtuMuMA+nqkx44uySoqggg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/05/2020 23:48, Doug Anderson wrote:
>> Is this only applicable for corrected address space?
> I guess I was proposing a two dts-node / two drive approach here.
> 
> dts node #1:just covers the memory range for accessing the FEC-corrected data
> driver #1: read-only and reads the FEC-corrected data
> 
> dts node #2: covers the memory range that's_not_  the FEC-corrected
> memory range.
> driver #2: read-write.  reading reads uncorrected data
> 
> Does that seem sane?

I see your point but it does not make sense to have two node for same thing.

Isn't the raw address space reads used to for blowing and checking the 
fuses if they are blown correctly or not and software usage of these 
fuses should only be done from correct address space?

the read interface to user should be always from corrected address space
and write interface should be to raw address space.


--srini

> 
> 
