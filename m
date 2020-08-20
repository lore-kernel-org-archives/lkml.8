Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URG_BIZ,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7BFC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FAC2208B3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="e+je4UI0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbgHTRLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730285AbgHTRLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 13:11:02 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D35FC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:11:02 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f5so1322390plr.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g1Ec2aiSR8okAneKzTV7deaJgayy3R6pU4u3Zwp9mDs=;
        b=e+je4UI0ndDKcz0RqGNYIBM1E772hGkzCepSNoniXi1pWUiOoO5030WpiDTNtD4AT5
         bfrvuv3vOFaz+NNSJvf+ogjla86OHNaeGpdkXnl6i+chnNw5pcUHySN36TYloJz+hpwj
         3GBjF3CWG3QxqX3IPkW9DBAo6OxcKyOZFcpJ2MEVKXnmRwlYgf2Yur42t8vpT04uVt13
         Ue1HXAXY33cf5Omr2OG31Hegf46c9RB8RN9CMcJMdC8Cq8SkH8DgOOSLClXHjRth6nij
         Abf3lCW4PFvP7sPiNNsgcsVehPu1NReG2Vp6u+pO85EyMjp38XAknC6/I/Y6/osIzx+6
         3A3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g1Ec2aiSR8okAneKzTV7deaJgayy3R6pU4u3Zwp9mDs=;
        b=QVq4c5vGriHO5mJnfzz5Upcvzk8TurBW3FoIatevWi2+lttW390f2QZdZFnGYnkRzK
         tuqqx5DaRc7w9+tsRQp/31YOW91EiK2IzRwDZm24WT8Ipz2L81fBiBQEudhhwGSziKRr
         zh2QMEilAPcd6EtptDJobLAelgb5T7GSr72/wAJVxes6f340Xjo6cw36le1WJ70q+A6A
         v3tpy9ul4BHq7kst8tkFJwZP+yNPEYltrmrU/QoDUzyXrZ0EpxhtbTKzoQmcYcpXwSx1
         KDMRAWrxVFMZxIbzEO0zFfrFNfvTUa6df6quoCLggomC4UEEQ7JgIvHPY94m4GXX7AEs
         3+Ug==
X-Gm-Message-State: AOAM533TCWp87ebqW6j/QBZQ+lmL/UarXNxAJXPrj2iDz9+ivYKupS1I
        g4sVFrTEZcGKh/9q1bPKhUF4lWXyQB2qHkPq
X-Google-Smtp-Source: ABdhPJxkWxe6AXAe6q7sC+LDEE67yFQYFltAU31qIhU8qyLH8/0NRVaS1sJAZ+l++iZBiwrbalZdjg==
X-Received: by 2002:a17:90a:d3d4:: with SMTP id d20mr3103117pjw.111.1597943461135;
        Thu, 20 Aug 2020 10:11:01 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21c1::16b5? ([2620:10d:c090:400::5:609b])
        by smtp.gmail.com with ESMTPSA id g15sm3463099pfh.70.2020.08.20.10.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 10:11:00 -0700 (PDT)
Subject: Re: v5.9-rc1 commit reliably breaks pci nvme detection
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-kernel@vger.kernel.org
References: <20200817135011.GA2072@lx-t490>
 <20200817155658.GB1221871@dhcp-10-100-145-180.wdl.wdc.com>
 <d077aec4-d79b-b52e-cdd9-bcc89fbbde5f@fb.com>
 <2356f514-9408-6a6f-871d-046984963533@kernel.dk>
 <20200820170729.GA4116@lx-t490>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <83a3d1b6-1eb5-859b-3c5c-287d8d18a99b@kernel.dk>
Date:   Thu, 20 Aug 2020 11:10:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200820170729.GA4116@lx-t490>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/20 11:07 AM, Ahmed S. Darwish wrote:
> On Thu, Aug 20, 2020 at 09:35:38AM -0600, Jens Axboe wrote:
>> On 8/17/20 9:58 AM, Jens Axboe wrote:
>>> On 8/17/20 8:56 AM, Keith Busch wrote:
>>>> On Mon, Aug 17, 2020 at 03:50:11PM +0200, Ahmed S. Darwish wrote:
>>>>> Hello,
>>>>>
>>>>> Below v5.9-rc1 commit reliably breaks my boot on a Thinkpad e480
>>>>> laptop. PCI nvme detection fails, and the kernel becomes not able
>>>>> anymore to find the rootfs / parse "root=".
>>>>>
>>>>> Bisecting v5.8=>v5.9-rc1 blames that commit. Reverting it *reliably*
>>>>> fixes the problem and makes me able to boot v5.9-rc1.
>>>>
>>>> The fix is staged in the nvme tree here:
>>>>
>>>>   http://git.infradead.org/nvme.git/commit/286155561ecd13b6c85a78eaf2880d3baea03b9e
>>>
>>> That would have been nice to have in -rc1...
>>
>> And now we're getting very close to shipping items for -rc2, and it's still
>> not in. Can we please get the nvme pull request out for -rc2?
>>
> 
> I keep wondering that myself. Completely breaking the boot like this is
> really not nice -- and for x86-64 laptops no less :-(

To be fair, I've only heard this one complaint about it, so hopefully it's
not too widespread. I'm on an x86-64 laptop myself with nvme, and it works
just fine :-)

> The fix is really small and isolated. "Urgent pull requests", containing
> only a fix or two, were created *exactly* for this reson...

Totally agree on that, it should have gone in for -rc1. This will be going
upstream tomorrow, so the end is near...

-- 
Jens Axboe

