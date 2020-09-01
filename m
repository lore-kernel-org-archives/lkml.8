Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1351C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A247C214D8
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kx9pMxba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgIAW5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 18:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgIAW5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 18:57:46 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39054C061246
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 15:57:46 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id t9so1706332pfq.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 15:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8SCB1R5S0rIlXAP1gD/42mN3rEFGnClEAzglzWI/f5A=;
        b=kx9pMxbaG7HxeA/hSNOaElEvYF6zneOI88aycKG6Q8jpxb2w7bV344cmhdkTDMxzM8
         s4owDu6/DO5Uv9cHyTnKBdmy+nqJhz7wwHz61yAXmFMMhK4Cu789DJwxYjlbPXe0s5+l
         1eE7XdCSERl8fSlQzYXHj1ACbWfO6xdmj6kFMFBA+oZIO+F0oUEUFwv1qB4zVLOSf3Tb
         cEm0nPav5qtkrw25Z04awrm9iRz2WofDvEuWX38Z7ApDCYln3CV04pw1ye/mPQ710zxe
         cuHimPUl3H9I9rn9HJAOO2hqAuXJqTUInl3Y6aiY+aq7bLFN524E3gnv+652wfX5cgO4
         qCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8SCB1R5S0rIlXAP1gD/42mN3rEFGnClEAzglzWI/f5A=;
        b=heXzc1XSxf1A0VCrY8qtmoudEU2pxpczTHS+mG6WiVMQMlkIUSeCmiOwf4UZQel95b
         VJNpw2raimXYo9zQh5EUdPEDN08PD5v+pQ8Y7ulgQFg/h/fox6CFKcMAweizUjJH1lsm
         zMk9Qmy6NX1k3b1LpXd30HtxBbDPqes7YAdlk2ECpZ9oDxUL2s3k53PQ+fISlV17lyrO
         /9znWk6c+zGw0KvX5ZHb8dBGtuCNo7TOkSD/YW3pcTApgAQMCocdx4Bf1/oQdUu+rnyS
         f+uBSTytHJ1khj9BkXGqr0ghmhTezhC/8sT4k4ttfOJcuoM9dsicjHPPqIjINAqQwEUh
         n+dg==
X-Gm-Message-State: AOAM5334IAavFn73Ayrv/siEExYOKRBBiYs+oFSBRJ0ajXMne7FsYj/g
        ZEqPd7HdBTMW8IpAJ2y2nOlsbCNfcXEYqjRQ
X-Google-Smtp-Source: ABdhPJz7/PuTI6toqDV7Y9ZAOMNodGuUCNOHnU2Zfi3eqQltoMCij8HkSX98gsEIVX42xBTyba1VqA==
X-Received: by 2002:a63:521c:: with SMTP id g28mr3479485pgb.247.1599001065304;
        Tue, 01 Sep 2020 15:57:45 -0700 (PDT)
Received: from [192.168.1.187] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id q5sm3122211pfu.16.2020.09.01.15.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 15:57:44 -0700 (PDT)
Subject: Re: [PATCHSET for-5.10/block] blk-iocost: iocost: improve donation,
 debt and excess handling
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, newella@fb.com
References: <20200901185257.645114-1-tj@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cac016f9-ee13-9fd4-22b2-8be0d830f076@kernel.dk>
Date:   Tue, 1 Sep 2020 16:57:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901185257.645114-1-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1-2 applied for 5.9, and the rest for 5.10. Thanks Tejun.

-- 
Jens Axboe

