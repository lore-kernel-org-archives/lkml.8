Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D34AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63E9320734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SIu4dD1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgFBVhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 17:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbgFBVha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 17:37:30 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE67C08C5C1
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 14:37:29 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 64so57525pfg.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 14:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q8mIpUceG3IU13jFQrqLEZP0EOCPw5rR96To9YPoKTg=;
        b=SIu4dD1QHQ27sGAP9y1QBliOAmuK1m+HZxCaVpXluU06+NHPHnpe5Xlgm5Db5WYrz2
         4+AerqSWpnGtAu2uIa0Lz9YOsPP8SaGqS+5m4tuGbWjTPT2E61rXMvch0Cl5KTb5bBqu
         DpKtMxbO7XbCeWiCLw18qax9YYZ+b+8XioxeyTRaJxIe3p1iHQNgZbc9hsroHF2ALsSM
         nkHxJDnG4lyIhFiYlPC4hr9ibI7u68O/D0kLFNWSF2Rdmto+iTLBJapds+PaGRSQpHXd
         ax7J9/8iNF5KSxmqQYLKEdQ3ODEjY8k7iNgiuDfM+MihaPg3MEWFThHuuCaEJZ7rG/m0
         qgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q8mIpUceG3IU13jFQrqLEZP0EOCPw5rR96To9YPoKTg=;
        b=jkeX/QA1i4GFM87gmMQodeWF3iBpyy1VJeq6pxr0wAYAtx+WTMK4xjQAAOYk+ZNg+O
         BTWV492yuqKxZzy2dckwr8NTWUhvTtxc9CqNbgoxvMN2jU/hz+lqYonlOGNgfd9g//Gl
         lMWmiI8m5qfPsNGlZarNT7iwSqIgguV5FapMyrDtAoEPI+40ljfIhNEbDna092OAVX/I
         XBCQr8O7NalQGSD1JiEXCKCRN3G9OLcOyuyIZLL9bsREqPJXUk/zHzI9lecSrPezsNBy
         I3+UGAXYJ02AOWsuMEe+9F9rb3oRjkqfTEFIl8EAVDuj/GruFjmHfqvldqW67PUY3453
         /Z4g==
X-Gm-Message-State: AOAM533sSYfuAs+wzC9yvvvgmxx8hYrNwCJ3rd0iErIotPsWejwSrCgE
        Fgz6Z6ETiy6SkgCkTnZDxq5iu+jT9Mmm0g==
X-Google-Smtp-Source: ABdhPJz15GquJLTb+Jgef1vIp7putk9rLYRioZ2burTfngkJh0qPK8dQrQV+phgS3MCQw6BWjN8Z/Q==
X-Received: by 2002:a17:90a:65c4:: with SMTP id i4mr1284486pjs.5.1591133848797;
        Tue, 02 Jun 2020 14:37:28 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y138sm88823pfb.33.2020.06.02.14.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 14:37:27 -0700 (PDT)
Subject: Re: linux-next: manual merge of the block tree with the rdma tree
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Max Gurtovoy <maxg@mellanox.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Doug Ledford <dledford@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yamin Friedman <yaminf@mellanox.com>,
        Israel Rukshin <israelr@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
References: <20200602125647.5f5ed151@canb.auug.org.au>
 <3717aca8-9d75-33f1-ea8c-044af767ab5c@mellanox.com>
 <20200602190153.GA65026@mellanox.com>
 <8be03d71-9c72-bf88-7fd7-76ec7700474a@kernel.dk>
 <20200602190945.GC65026@mellanox.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b8ad79a0-57cc-e823-6b99-47d59ce5dc7d@kernel.dk>
Date:   Tue, 2 Jun 2020 15:37:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200602190945.GC65026@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/20 1:09 PM, Jason Gunthorpe wrote:
> On Tue, Jun 02, 2020 at 01:02:55PM -0600, Jens Axboe wrote:
>> On 6/2/20 1:01 PM, Jason Gunthorpe wrote:
>>> On Tue, Jun 02, 2020 at 11:37:26AM +0300, Max Gurtovoy wrote:
>>>>
>>>> On 6/2/2020 5:56 AM, Stephen Rothwell wrote:
>>>>> Hi all,
>>>>
>>>> Hi,
>>>>
>>>> This looks good to me.
>>>>
>>>> Can you share a pointer to the tree so we'll test it in our labs ?
>>>>
>>>> need to re-test:
>>>>
>>>> 1. srq per core
>>>>
>>>> 2. srq per core + T10-PI
>>>>
>>>> And both will run with shared CQ.
>>>
>>> Max, this is too much conflict to send to Linus between your own
>>> patches. I am going to drop the nvme part of this from RDMA.
>>>
>>> Normally I don't like applying partial series, but due to this tree
>>> split, you can send the rebased nvme part through the nvme/block tree
>>> at rc1 in two weeks..
>>
>> Was going to comment that this is probably how it should have been
>> done to begin with. If we have multiple conflicts like that between
>> two trees, someone is doing something wrong...
> 
> Well, on the other hand having people add APIs in one tree and then
> (promised) consumers in another tree later on has proven problematic
> in the past. It is best to try to avoid that, but in this case I don't
> think Max will have any delay to get the API consumer into nvme in two
> weeks.

Having conflicting trees is a problem. If there's a dependency for
two trees for some new work, then just have a separate branch that's
built on those two. For NVMe core work, then it should include the
pending NVMe changes.

-- 
Jens Axboe

