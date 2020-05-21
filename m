Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3AAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BADFC20829
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="SsroLET2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgEUPpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 11:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbgEUPpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 11:45:03 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAC1C08C5C2
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 08:45:02 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id m12so6441955ljc.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 08:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cmJz+Gx7YLDmT8/F9qf3OOQUtF5Sv5dZUkEevMwOpmM=;
        b=SsroLET2JSHiD8ayuKdihmujwAC67+dgA8oluNDMYpfdBxnArd+BSWFOgdJBz3AUXn
         Jgr19lkTNEI0fzxu/MAgt0HPLhYToFhkeRxwTirCPS+rmBpUdPWsJQZkQzgnOak6GP/P
         jQRpA8hNcjjAOc4MpUXyIEyb0/xvM3uM0Ik9MTwOAptQVKMsGOqSvmSGl3OZmLzF6PlT
         QLQOGo56Agti779dHCpPRDkXKQsEeYXLPM1D62ZYdpTojiTeogdATC6rR22aD/k/GyU5
         NpjJSJf2PL2iDSYkSQERySBp+NKc6wYBCtxCx+QzjOsfbCz+eewsOJx+Ql5o9V0j7MjE
         kmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cmJz+Gx7YLDmT8/F9qf3OOQUtF5Sv5dZUkEevMwOpmM=;
        b=NHkm0BPDoLZozXyXNiqVuMUoLNE2oaCWgOG1vWt6WIGp1dWy9mS2bYnioA7V7KwMT6
         ZqwosusR1IE4jbalpROwVIOXKDxSN2M3a6Ye+NK673LBH7Hf4pf23JV93tlsbfME9/M1
         wDjWQmoMGzpvdbAh5fz3QRln+YzpcEOyo8Fx7XqoNy066UqqLQpKkT1u/Kvzf8qZqk6b
         KjpnbcvRnChV7RBW0TuPszi7T5qCJkSTu5mUphZMS5wpfZvW3hLvj9OfrH3J/cNS3QOd
         p0uY06Dgg44FqL/T7EkMm49vW/PnRzdp7QkeiT5r/lb3uJOK5eTK0re49xwwQZQ7wSAn
         BURA==
X-Gm-Message-State: AOAM533sYgF6iVcixazX5whiINwaij6fSBOzK4L9GOr97q+GR//Zu4gI
        GqGsob+fBMINHslU2tsAz1xrSXXy5L/wZg==
X-Google-Smtp-Source: ABdhPJzF7ksN+o14aJ+SGpc5Githg07FbeQQKCCVP/Xx20hNFOuoDeHcLFuTKLz6iHWPLC6E/tV3rw==
X-Received: by 2002:a05:651c:1104:: with SMTP id d4mr5227117ljo.193.1590075900931;
        Thu, 21 May 2020 08:45:00 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:447:6c16:7801:dcb9:693e:53c? ([2a00:1fa0:447:6c16:7801:dcb9:693e:53c])
        by smtp.gmail.com with ESMTPSA id i8sm2098945lfl.72.2020.05.21.08.44.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 08:45:00 -0700 (PDT)
Subject: Re: [PATCH v3 11/14] bus: cdmm: Add MIPS R5 arch support
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        David Lechner <david@lechnology.com>,
        John Garry <john.garry@huawei.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <marek.behun@nic.cz>,
        Sameer Pujar <spujar@nvidia.com>, linux-kernel@vger.kernel.org
References: <20200521003443.11385-1-Sergey.Semin@baikalelectronics.ru>
 <20200521003443.11385-12-Sergey.Semin@baikalelectronics.ru>
 <9ad8383b-8199-1006-cf91-d760bace705e@cogentembedded.com>
 <20200521125851.5upamjd7ldirj57a@mobilestation>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <73d43b13-c153-cfa0-dbfa-bd0a560a3754@cogentembedded.com>
Date:   Thu, 21 May 2020 18:44:47 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521125851.5upamjd7ldirj57a@mobilestation>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.05.2020 15:58, Serge Semin wrote:

>>> CDMM may be available not only MIPS R2 architectures, but also in
>>                                  ^ on              -re, it's singular
> 
> Thanks, Sergey. Got it. I'll fix it in the next revision.
> 
>>> newer MIPS R5 chips. For instance our P5600 chip has one. Lets mark
> Probably also:                                                ^ Let's
> Right?

    Yes.
    Thanks for replying. :-)

> 
> -Sergey
> 
>>> the CDMM bus being supported for that MIPS arch too.
> 
>>>
>>> Co-developed-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
>>> Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
>>> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
>>> Reviewed-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
>>> Cc: Paul Burton <paulburton@kernel.org>
>>> Cc: Ralf Baechle <ralf@linux-mips.org>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Olof Johansson <olof@lixom.net>
>>> Cc: Rob Herring <robh+dt@kernel.org>
>>> Cc: linux-mips@vger.kernel.org
>>> Cc: devicetree@vger.kernel.org
>> [...]

MBR, Sergei
