Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70E1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B65062078A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xZIbVshr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404382AbgFXPOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404209AbgFXPOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:14:14 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B88C061796
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:14:14 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id e8so1564584pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ps+DmDWICz6+D3WRaFwXTobME9VB1u3KQwLSIO91+tk=;
        b=xZIbVshrwWWLxcKIigRdYSM0mQ0nKCs67DOMUGGIQlBMb9rEUc90OCVJt+JA5t2ukE
         o3JKzqQ1VL8Dj8JuTc2eZxA5lvSq3W7ZDZl5QV/P7N2p0EoVUqX+kksHwolzClLiXyLL
         Ys3Ei+a+iCP+ma0Nae31UP5NF3YaLXZj0FSrIpaNqGSa60QGrKZt1OlHUYMAqB8k/6d/
         LbJVQGwTtW7y/Kl6NUbHJFXXOShX7hHl6pCAw4OD5Hm/2kgzz34+Nb4adlSYLKuBxTSW
         VMO4MQ1jZM4E57/tK07JCxoYBCU3cCPRO7EXy4EcFSCd7FePtBbLmw7TP8ogZVX7fUVX
         /4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ps+DmDWICz6+D3WRaFwXTobME9VB1u3KQwLSIO91+tk=;
        b=fJrenBXhkoVMq2F/3LROuERKhYytDKf29am9Y79p9AOnX4/WXwDyUwPeNd4sic6goj
         bvsDVZ+XyhJWMmzzUouZQ1kjDd+u1Lfsqb5z3dY38JEv98xG00Aozh5bbGFIvRr9zadG
         jSFfxz8nYaQFEM0mA2re2rGxykyiMLYS9fXywukxlrCHvvUKyfzO4LjEcGs67QnLeWCG
         Q6A4VE4bOgWNnZn2rEmS+MgMoQvn1bOOX+fFKTs90e9enjeOX4vGXwb3sfKROdW/WNec
         YznQz/2aCfOMpIYRtUgGz8vTVTwCk9VSgt/SBdWh5j4yIrfeXu3nIXMzE83lqMBNbaN7
         +pvA==
X-Gm-Message-State: AOAM533p7rizk0EHnZK7pLp3DlyIAVQMbLtE6srLWW4vYKb7HR5GyoNK
        I6gOsOt5ix3MXvJV27lY/F7KVK/t8Ok=
X-Google-Smtp-Source: ABdhPJzYL1CFUVfnzLvI6QU88euYu/ZksQ0VBb3mRMhCLNIUkamn41/nsnDt2BfAPm0YWMGKFGGbaw==
X-Received: by 2002:a63:f50b:: with SMTP id w11mr22012876pgh.157.1593011653721;
        Wed, 24 Jun 2020 08:14:13 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id b191sm17710007pga.13.2020.06.24.08.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 08:14:13 -0700 (PDT)
Subject: Re: move block bits out of fs.h
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200620071644.463185-1-hch@lst.de>
 <c2fba635-b2ce-a2b5-772b-4bfcb9b43453@kernel.dk>
 <20200624151211.GA17344@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <216bcea4-a38d-8a64-bc0f-be61b2f26e79@kernel.dk>
Date:   Wed, 24 Jun 2020 09:14:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624151211.GA17344@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/20 9:12 AM, Christoph Hellwig wrote:
> On Wed, Jun 24, 2020 at 09:09:42AM -0600, Jens Axboe wrote:
>> Applied for 5.9 - I kept this in a separate topic branch, fwiw. There's the
>> potential for some annoying issues with this, so would rather have it in
>> a branch we can modify easily, if we need to.
> 
> Hmm, I have a bunch of things building on top of this pending, so that
> branch split will be interesting to handle.

We can stuff it in for-5.9/block, but then I'd rather just rebase that
on 5.8-rc2 now since it's still early days. If we don't, we already
have conflicts...

-- 
Jens Axboe

