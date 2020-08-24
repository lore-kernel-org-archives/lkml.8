Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAD5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B5FA20838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIMUTWo0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgHXPcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 11:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgHXPbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:31:18 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816EAC061755;
        Mon, 24 Aug 2020 08:31:16 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id h2so4406651plr.0;
        Mon, 24 Aug 2020 08:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yfrSztbxyVdrNkvRaWSKyH2m7g61Tuoyn5zH5uHd9ms=;
        b=UIMUTWo0aS/9WpBY0/Rgjj0FyKbsqnIHwrU2InueSQVvJLzR3llEIhviAxPpttma8L
         nfqV4+dyId2sZUfB1BiS01o0hEpnxTUGg0o9E/p2GOMVHaxUB832Xsl17w7/3EvJg2cu
         IJ1CkUbxuKNKD4fyMc+UVEE8hE+Znuahni2rZ2nnxnrLo/Y5Tpx8mKLrD83kUFntC0LY
         urHiVMfpUsBCuZFULaPL81ZrdsuKIk4ByelrIClMTyZFWWioi/iMlCHhvG69c9PdzoV2
         BR/OzONhPkbAV2f8qk8thXcuowm1rCh6V3UUBvPyWnm8doRCQOxeMRIUk7UAAjl6MIvx
         CqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yfrSztbxyVdrNkvRaWSKyH2m7g61Tuoyn5zH5uHd9ms=;
        b=VEWJ9mQa/fkroK/s4Y2gLQsg0BkjcqsUbfM9eYO9BzAZ8AQauJhzYnA2gn4T3PLrtY
         /KcfCM0NwbTpf3cMI7ZFFlTHJ+8eiyumLQjQn7t9Pu0f0NOUBAvCkOsc5+HrTP7vzvVx
         xeGv8MLt3OrjHIo0EHvb+DjRiunOjpwcN4wh9tt6fcMPFQhgrShdYE2y1f6+7FemHaaA
         QivC3Saux/55Cpwdp5AU862ijPumbJmYtj8Oz0+XxsqFOJ2TFoZ4UhI0zH8vN3aTHTz5
         c5Mgv2umRMnBqbX+4pcQcpuhwo3kUCKoj9F8npfF4Ho14XDTdq1ST7yjtLBclgL0p3Ya
         1FqQ==
X-Gm-Message-State: AOAM533/eDVxtYwrosSe1szM4b04zM+EpgomKvi5DSHweoytye+jeg05
        L5UWLOmXKO1m9t8RQbZ5321Xf9xPzkw=
X-Google-Smtp-Source: ABdhPJyeufnHQksiycUw+vgAQFd1rddVw+8vkyVrFnPxm115km4UoI0yMxlnpguo5uIIYHONBOzvPg==
X-Received: by 2002:a17:90b:b18:: with SMTP id bf24mr4697310pjb.223.1598283075175;
        Mon, 24 Aug 2020 08:31:15 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id x127sm12343586pfd.86.2020.08.24.08.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 08:31:14 -0700 (PDT)
Subject: Re: [PATCH] net: systemport: Fix memleak in bcm_sysport_probe
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200824055831.26745-1-dinghao.liu@zju.edu.cn>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <a83f59bd-e4cf-bb97-2812-5641daaaac1a@gmail.com>
Date:   Mon, 24 Aug 2020 08:31:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200824055831.26745-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/23/2020 10:58 PM, Dinghao Liu wrote:
> When devm_kcalloc() fails, dev should be freed just
> like what we've done in the subsequent error paths.
> 
> Fixes: 7b78be48a8eb6 ("net: systemport: Dynamically allocate number of TX rings")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

This has already been applied, but this is good.
-- 
Florian
