Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D61C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6A5F208CA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zWf7fhWF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgIAOmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728536AbgIAOl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:41:58 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03584C061245
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 07:41:57 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b16so516471pjp.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 07:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rN6mVq1C675COOeO9181t4h75F89OjQk6hHpgH+S2X8=;
        b=zWf7fhWFHujfWaocQn49l9sQhhPq6xyQeaCS4rvpip82Yg4nGFcQsS/l32lvBaxghQ
         w8UaOQwYaD6gwz9dGJN2uVaNuBPQZYnoFcap4fWwhOCDmaaq4RrKwPeefiocvDkkgHrJ
         24Uuwoy8QMsErURjw7uLdcKrhxkFqbkopqSxv/HyZO/ftoDj+/LMXPdlvUmq1LM3M2Yy
         th1SUVnuedh8P7SRbR7zqCtQchZ55aIsGN9Tez4fMp9NS+3qhEQZAaOneAMbclltMKdH
         Ly8iQ51E0C6AGzrvyHAL99zOB1yxiMqKYX5tIUS75Po6vwYmPu9+lw7PDYD+usWZ0So7
         5hGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rN6mVq1C675COOeO9181t4h75F89OjQk6hHpgH+S2X8=;
        b=TrjLGJWYzdRl9lnjksYeQN4C9WmYic27Kl+mQ7gN4NBcc4+FlVlpBG8bmhjJyO7qkF
         gc3KzighaGvag+2sCsUK7aQj+oroPVD5NyEUIbwP5Ad1N8VAm0bqxCjdE+lM4tND4xNw
         BtzvaQ1H+++Dt835/secUyPeC4TEoxCb3cGMGZLYXFg6kKRzK8Yit/KARfHvpEBFKfFm
         86r5RUeTlgzzB7TCVSdJb/jPelxvOTqTKgkz7iTWttx5Qs94s2HZJyLBvgzRIK3JhXZM
         mD5do2BWwO23zTX3ixgrdT77uCLSrIDvLm0tXeU/UGnaOCqpUdy9Ud3u0aSCFK1hYYgg
         Md7w==
X-Gm-Message-State: AOAM5331XehP1rCThGDLKCE621nEgg1h3SiuCjANTe9k4CmHkDitwKLm
        RPurQNFYmLDPEmaJg6/wD61AniMrvnOoEDoi
X-Google-Smtp-Source: ABdhPJxyUYNNoAYg+p0rUio5na1hUQeQkT9Gz50MFaKFx0Ho8v3YbST/94HbTYB5NkVRq+gbMPEODQ==
X-Received: by 2002:a17:90b:1049:: with SMTP id gq9mr1941000pjb.28.1598971317157;
        Tue, 01 Sep 2020 07:41:57 -0700 (PDT)
Received: from [192.168.1.187] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id r123sm2340138pfc.187.2020.09.01.07.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 07:41:56 -0700 (PDT)
Subject: Re: [PATCH v3 0/4] Some clean-ups for bio merge
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     ming.lei@redhat.com, hch@lst.de, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1598580324.git.baolin.wang@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <aa37ce36-c02f-835b-e62b-3e47daa27022@kernel.dk>
Date:   Tue, 1 Sep 2020 08:41:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1598580324.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/20 8:52 PM, Baolin Wang wrote:
> Hi,
> 
> There are some duplicated code when trying to merge bio from pluged list
> and software queue, thus this patch set did some clean-ups when merging
> a bio. Any comments are welcome. Thanks.

Applied, thanks.

-- 
Jens Axboe

