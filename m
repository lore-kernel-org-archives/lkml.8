Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833BFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 02:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F3852074B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 02:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BxQ1adGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgGQCQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 22:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgGQCQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 22:16:36 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98E8C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 19:16:36 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a23so3036699pfk.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 19:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k/j//DrqA105JQB+yLLyaqJ9jhi6KMPYTBR0gDdzdRY=;
        b=BxQ1adGxHQqa8k4kj4znuKdnMoztP0XQDdDcHV4CEkMyhF3h7pXPkorgvdhMY/XaKA
         qhNQwel/88jUrfDLV1O1Gjh9TKHDIg2sLr0VVQJL5Yz5i9GtkVidc+kvuT04wGvl+BEX
         d/Byyx8aTCy22K51FZxR3bx3d1duO1KC/ZQsf8YSudgLrZIXTwW16/rv3W0vwWpOGYsr
         I2U69Qm04ugGfqrp6SQPWFrckfqNmRr8jZBk+/2+VgozwGYxfBwWnd18j6QY4B6sTXrA
         DT1Ej8MN9d8FemaZGFFwEA3ccL5eIC6AsfCKGzJEt9bCO94cRuKMsc3fgxP4hcWdBobN
         Ndog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k/j//DrqA105JQB+yLLyaqJ9jhi6KMPYTBR0gDdzdRY=;
        b=jemYEr6K6NxfWXBfXrJjQFGsXivOpqPUT/tpAHUokCdK1uB8ijKkvK89IyNEJINl1r
         /eyifQGlzfh7C2iXs8ySDweoYdPxiLxcb3lZh4eON3OMZjlQ9aTFiVThr0DtBWJSBCW+
         tx3IT9vqimYnIq1m1jfCEDBfIfFoslcQ3EY/XdvTLZv4b/71PTLp3U9ojsxc2lf9woOF
         4xUiMGoFfJEV/CfYI/Onyns9d03PEaoAECfJOx6tAgFSbYAZ95t0szv4MKalyvnbCKar
         Ap/siK3SxwRkDj5s3IBo2t8s1ZeR5c4BIvxgLKerUDP6tFdyy+PQ6ra4u7hwoMyaJUyz
         B9OQ==
X-Gm-Message-State: AOAM531H4ohvSGH34fXnjjmeyMYT2xzgZMsCue0CexZyY+awCTdKjupc
        DjxWEBRPy0yUQyMd6OhYwEXtRYnWowKcJg==
X-Google-Smtp-Source: ABdhPJxjT6UxMk4dugu2pkV2kCi5VK/E9SIRHyOkuEc25MvJm3iR7aQyn05v7ts6ekzr7eHuNaO7LQ==
X-Received: by 2002:a63:b546:: with SMTP id u6mr6507607pgo.381.1594952195776;
        Thu, 16 Jul 2020 19:16:35 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id bf11sm1082019pjb.48.2020.07.16.19.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 19:16:35 -0700 (PDT)
Subject: Re: [PATCH -next] rsxx: Convert to DEFINE_SHOW_ATTRIBUTE
To:     miaoqinglang <miaoqinglang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200716090432.13691-1-miaoqinglang@huawei.com>
 <e4caa1de-db2c-c2f4-d1e8-fef7073a52ea@kernel.dk>
 <c19c9e32-4b31-bcf1-df45-a29220e7e6cc@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <87a5f046-e77b-af25-6656-c8b075a16edf@kernel.dk>
Date:   Thu, 16 Jul 2020 20:16:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c19c9e32-4b31-bcf1-df45-a29220e7e6cc@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/20 7:37 PM, miaoqinglang wrote:
> 
> 在 2020/7/16 23:45, Jens Axboe 写道:
>> On 7/16/20 3:04 AM, Qinglang Miao wrote:
>>> From: Liu Shixin <liushixin2@huawei.com>
>>>
>>> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>> None of these apply against the 5.9 block tree, looks like some
>> read -> read_iter conversion has happened in another branch that
>> I'm not privy to.
> 
> Hi Jens,
> 
>      Sorry I didn't mention it in commit log, but this patch is based  
> on linux-next where commit <4d4901c6d7> has switched over direct  
> seq_read method calls to seq_read_iter, this is why there's conflict in  
> your apply.
> 
>      Do you think I should send a new patch based on 5.8rc?

That'll just create a needless conflict. But I don't even know what tree
is carrying the patch that changes it to use seq_read_iter, so hard to
make other suggestions.

Alternatively, I can hang on to them until the other change hits
mainline, and then queue them up after that.

-- 
Jens Axboe

