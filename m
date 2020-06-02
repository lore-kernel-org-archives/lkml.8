Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DB0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 07:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53024206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 07:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="anQ2chfq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgFBHhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 03:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgFBHhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 03:37:12 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BDCC05BD43
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 00:37:11 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id r9so1868671wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 00:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xqds7VbU+K4A2laqYmDPq+zdOfWX/VjHAo0lo4mVXR0=;
        b=anQ2chfqCtHiZ4pB5qiENxzfk8kF2TaVNvzhYEztrPanUnTZOwgh9uLDEQQUB0D9Nm
         epHJcbtRVzaKPvJAQQ6gnjksaOc6SJjLnX4DJq3azYt54ilj0wLyXuKTfuoyLODJbWm0
         cbky1C0TxwTgECHxolmkjGf913LY89hRXbYtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xqds7VbU+K4A2laqYmDPq+zdOfWX/VjHAo0lo4mVXR0=;
        b=m+/0mFeJ3io1OctxBshgLci+sP8fPtqBdRGk8lMGqwvlPP02ZS40S4d40Mj/e8ZiLD
         CQVVHRJCCLb3N3dbrt8FkK14tuePH4gfnu4mwX5rfP6pfBsRkiwjNyLvN0MuvB9/w4LX
         rjEhgu5hOHve7uunokC8XvDU63Veul4s3w53a1DNjlx00g4FRSMQZWzWE6yHbp5ZeZ5E
         +6VAcCShN9knCVO7iFssIRpQCvc6ZFJHH7wsSH3C91gA2Trb59QnNJRvUCojNPOcttpZ
         GwxL7KjQY8ev3M2HmofDhlpS1pHwdrg0e7hypKcMg0iOcp7AyQBI8SPCzn276A7p0bB0
         bKDA==
X-Gm-Message-State: AOAM5319L//rimb+AeGtSXAtF8ERBK2OXaCm6i2ttKSzOiq1mk6SKGit
        UeZqJJd2ergZ37ZrkAxvlk2dK2mqgA0=
X-Google-Smtp-Source: ABdhPJxVmq6mSWg/iUiuouLU0cmof6ha99AdKRzM2oufoIVIFhcGa8uQFobYRnwf9lC+PgvBrVralA==
X-Received: by 2002:a05:600c:2110:: with SMTP id u16mr2832929wml.26.1591083430327;
        Tue, 02 Jun 2020 00:37:10 -0700 (PDT)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id 23sm2333774wmo.18.2020.06.02.00.37.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 00:37:09 -0700 (PDT)
Subject: Re: [PATCH] ipv4: nexthop: Fix deadcode issue by performing a proper
 NULL check
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
To:     David Miller <davem@davemloft.net>, patrickeigensatz@gmail.com
Cc:     dsahern@kernel.org, scan-admin@coverity.com, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200601111201.64124-1-patrick.eigensatz@gmail.com>
 <20200601.110654.1178868171436999333.davem@davemloft.net>
 <4e6ba1a8-be3b-fd22-e0b8-485d33bb51eb@cumulusnetworks.com>
Message-ID: <beb306e9-228f-6810-fc77-972e5acb5863@cumulusnetworks.com>
Date:   Tue, 2 Jun 2020 10:37:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <4e6ba1a8-be3b-fd22-e0b8-485d33bb51eb@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2020 10:23, Nikolay Aleksandrov wrote:
> On 01/06/2020 21:06, David Miller wrote:
>> From: patrickeigensatz@gmail.com
>> Date: Mon,  1 Jun 2020 13:12:01 +0200
>>
>>> From: Patrick Eigensatz <patrickeigensatz@gmail.com>
>>>
>>> After allocating the spare nexthop group it should be tested for kzalloc()
>>> returning NULL, instead the already used nexthop group (which cannot be
>>> NULL at this point) had been tested so far.
>>>
>>> Additionally, if kzalloc() fails, return ERR_PTR(-ENOMEM) instead of NULL.
>>>
>>> Coverity-id: 1463885
>>> Reported-by: Coverity <scan-admin@coverity.com>
>>> Signed-off-by: Patrick Eigensatz <patrickeigensatz@gmail.com>
>>
>> Applied, thank you.
>>
> 
> Hi Dave,
> I see this patch in -net-next but it should've been in -net as I wrote in my
> review[1]. This patch should go along with the recent nexthop set that fixes
> a few bugs, since it could result in a null ptr deref if the spare group cannot
> be allocated.

Obviously I forgot to mention in my review that it should go to -stable with the
nexthop fix set.

> How would you like to proceed? Should it be submitted for -net as well?
> 
> Thanks,
>  Nik
> 
> [1] https://lkml.org/lkml/2020/6/1/391
> 

