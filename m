Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BD8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 15:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 503002070B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 15:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IFvtypmn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbgG3PEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 11:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG3PEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 11:04:43 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA3CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 08:04:43 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id g19so16453425ioh.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 08:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mtebjY7zqQmxK4blDByy24YEZvtg1VgS49VyUH+Bk54=;
        b=IFvtypmnuy+FD59buzQsBGlluhs8zj+9N6uxiqSJhSFqkPX345o3ct+kJ07I1a7DVd
         Wt/kT40XJ7NtdugtJzHRfQVLMUZDwf1uEkJiCNYtDezotKmw9o0SmkKDW/E2AWx8AjZR
         DWmzauCwvh/rwYz/8j3Ab1wGhFxsJPFq6w3oMT7J2rToZzcpQgnQ8Bk4ITuj50sbM8IW
         JfNI4LaOtAHcJQa1mhod1stjeUVqDNHnHSEXyCP16wRhbo7/JMeli0N9UP2eyqW5QqCG
         UNl1R7wil5HQ0B6FDhvDk0safChUb76Wl1RcQ3F758MwHtOq6tuuQwAAPRdlYFkJG/bC
         DMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mtebjY7zqQmxK4blDByy24YEZvtg1VgS49VyUH+Bk54=;
        b=HpcoOxsauWpftlWxm5PpoPdnEAYrayHIyNSdV1mg5CiYCJzXqnMuVFsYxcMbCFqFVt
         4U+DY/g4GKmERfiT+Hpjl+A6oK8tmyIb/54JrpXrlQlM7Mohm2zLVfYSxdoPZttuw6y0
         goSoLzWTAlU2IGY/3ubXEfzHp+E5+kVJC2Br1O+Am9F0UfOopVn+IwWQTFRZyOnqgi4X
         HuRMMXPL9aQtLbuoQqyUQuFxhfz8Ji8yT5ZutPuNAvVf2C8gzg7dEzlUfv8ndIRAid7Z
         1tFlTwu/acmSYK75NaXaudPHmtujPkhhdpUWHzytQk/itR98E6q1rUj2O/Ac04psMOic
         bU3w==
X-Gm-Message-State: AOAM532X407iksgqS+xrMyRxCnx2YNCa6ycdRfzCrEJyKkp1COx/bM8m
        dcAnXQW/zOG3kB0Qn2XHMr/SBw==
X-Google-Smtp-Source: ABdhPJy/LIN0Vx8knW+VahVygoK4OZBhqppeSDsSWVHJQbR9ICzzGFP97DTzi2tbufdFdL7FrC7MJw==
X-Received: by 2002:a6b:b682:: with SMTP id g124mr38836585iof.55.1596121482554;
        Thu, 30 Jul 2020 08:04:42 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id b74sm3199806ilb.64.2020.07.30.08.04.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 08:04:42 -0700 (PDT)
Subject: Re: linux-next: Fixes tag needs some work in the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Christoph Hellwig <hch@lst.de>
References: <20200730080849.70cfeeb6@canb.auug.org.au>
 <20200730081203.5358cbc3@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <93067598-8a12-4f98-0c76-3fd1f14cd16e@kernel.dk>
Date:   Thu, 30 Jul 2020 09:04:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730081203.5358cbc3@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/20 4:12 PM, Stephen Rothwell wrote:
> Hi all,
> 
> [Just adding cc's]
> 
> On Thu, 30 Jul 2020 08:08:49 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> In commit
>>
>>   64d452b3560b ("nvme-loop: set ctrl state connecting after init")
>>
>> Fixes tag
>>
>>   Fixes: aa63fa6776a7 ("nvme-fabrics: allow to queue requests for live queues")
>>
>> has these problem(s):
>>
>>   - Target SHA1 does not exist
>>
>> I can't easily find what commit is meant :-(

Yeah, it's obviously garbage, the commit doesn't even exist, let alone the sha.

Chaitanya, where's this from??

-- 
Jens Axboe

