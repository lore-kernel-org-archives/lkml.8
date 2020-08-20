Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2567C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA8192080C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="KwsteLEU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgHTIDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 04:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgHTIDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 04:03:16 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656BAC061757
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 01:03:15 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id c16so1375098ejx.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 01:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R8fk87r2NB5AfCq6Eih8WnPcjOrj6NaIDnoUfvFvZuc=;
        b=KwsteLEUTu5af/PUU3LB9WbBpqWYT9Or3Fm6fZFPCrqnKu2VPmUx8Ie6wDvdE0pNKe
         Z7/viAz840rUFRXrziTkhOYiQej7+UDJYB9rMBcFujtp5Ywv2qEV9GaenWvdfxqmNn8x
         yIU84VtWVRR3mCdtC4Yg8RHo2YRwCt+piymIaJ/+DQwDUUNSsqhOv1HuBYBlOGZuV4hs
         22fnLpHR+SeeUPOp4QAJbjIqRm8zw9W06+KE/I0bkc4JI9HDwi3zGWitpfVL4g3r1XMk
         C5vKm72BxyaM6Hk/goLK8oNZtuyPkRR0gDmvuae0WmpW0WynR5oCjBiAe2l4SlqdavQr
         kcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R8fk87r2NB5AfCq6Eih8WnPcjOrj6NaIDnoUfvFvZuc=;
        b=jdzfqQTzsZz2ZV4JbOq/oxUozq0phILBKd4xzZMo2BNkzSznvjYTeDIJ+qOw3EBzHM
         XZbwvkbl3G/fDjVs4gLKWy6CEU8J+xiudAQohuWT8KToD1WtpYvKnWaWzAS+lDvxE42y
         LZn12GjIhBJhbKJ/LRjZc2NKa0sqee6jJDBKo6TTiZxqNRUMEwZ9zm5TcJ64d3lFlMTO
         D91BF3cqHLkUbcCXomygVzCoonLI1TCGY71r+kM2ohnuN6AjNubUige6LthaUiW5w5vA
         7PTu2sSC8aebsjXeIfixu9OwMwQUUazq5OQYirlWJVY8V7WaF4SHZd36KF/UK4v2psCi
         8X0w==
X-Gm-Message-State: AOAM530Wh6VK1hLt7qN/2sH3tqU9Yk9w0IzI1YpleZIoy0hY73LlgJ0j
        CXC92683cPUTZDqlvOsrLpcROg==
X-Google-Smtp-Source: ABdhPJxaazq3f/bU/Ux+ct20z483SNcc8H8VttXDhliGkBkB3jKQqOtusyU3lgxf80JjEr9OoII+bA==
X-Received: by 2002:a17:906:9592:: with SMTP id r18mr1989603ejx.464.1597910593863;
        Thu, 20 Aug 2020 01:03:13 -0700 (PDT)
Received: from localhost ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id v7sm890198edd.48.2020.08.20.01.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 01:03:13 -0700 (PDT)
Date:   Thu, 20 Aug 2020 10:03:12 +0200
From:   Javier Gonzalez <javier@javigon.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, david.fugate@linux.intel.com,
        Kanchan Joshi <joshi.k@samsung.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200820080312.oxsnsedn6rqf3rcx@mpHalley.local>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com>
 <20200818071249.GB2544@lst.de>
 <b52854fe11640a5a5f54e08b1d3c7a556f97aad5.camel@linux.intel.com>
 <9fa64efe-8477-5d33-20ed-9619a9fe8d70@kernel.dk>
 <20200820063719.q6wftb23op45wigk@MacBook-Pro.localdomain>
 <20200820065250.GA6885@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200820065250.GA6885@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.08.2020 08:52, Christoph Hellwig wrote:
>On Thu, Aug 20, 2020 at 08:37:19AM +0200, Javier Gonzalez wrote:
>> We will stop pushing for this emulation. We have a couple of SSDs where
>> we disabled Append, we implemented support for them, and we wanted to
>> push the changes upstream. That's it. This is no politics not a
>> conspiracy against the current ZNS spec. We spent a lot of time working
>> on this spec and are actually doing a fair amount of work to support
>> Append other places in the stack. In any case, the fuzz stops here.
>
>FYI, from knowing your personally I'm pretty confident you are not
>part of a conspiracy and you are just doing your best given the context,
>and I appreciate all your work!

Thanks Christoph.

>
>I'm a lot less happy about thinks that happen in other groups not
>involving you directly, and I'm still pretty mad at how the games were
>played there, and especially other actors the seem to be reading the
>list here, and instead of taking part in the discussion are causing fuzz
>in completely unrelated venues.

Yes. Hopefully, we will start keeping things separated and using this
list for Linux, technical conversations only.

