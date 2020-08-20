Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82421C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58A3320786
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="1oTpqa9m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgHTGhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 02:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgHTGhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 02:37:22 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E5FC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 23:37:22 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id di22so704755edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 23:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sLKrzH9MwPqGsgXwtk2KOdG5Y1PUaWmaOENzy3RDTWI=;
        b=1oTpqa9mewNECohmMsYj+eRveSfefrahN/JWuEtdN5qZYeRSPgiHk+r5DSeOlqKXJ2
         xHZTqWPH4bMVTL9qtKpvEdwNg9cNFu8ni1UIgCkF0UdcIgEA9Y/JZa+241+kJALWMWdd
         A3ilCshO5/+M08eJSNj3KoovGweA4lFzvl8yWhS7WmXTWdD/q7KhlYVAtm2N6SwLPyrp
         fhcLdYR2jYUoYZaUjtpUVir7zG58kru94mQ8sxSoGPDhnF4a60y1PGoAPiaDD6e6BzR+
         EWrsad8bF6eimra08ezmAAp4jY5onVm5vyIIQq6jFMv0IiIE9KjkYcn4ML9mcknToqFn
         l1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sLKrzH9MwPqGsgXwtk2KOdG5Y1PUaWmaOENzy3RDTWI=;
        b=dVps1A3eal7WTlcNoqHaGto6oJ6esJ9SqvdTVBc2nzQSva/gcJIig8NuyPvhUWUkNO
         6piyW7fbRSv4ZdbpEQCWfeTCcGFpQPIzDC1eJ6qcgZ5+zr1b1gK+yjJJyq2cvvNJ6DBA
         gY3fBvQWwLqXDwHe2uAGC7Sko3rTSJHwNi/M6i8Py9BcXJpsBHxBv+2xkHhRP8ovw7cu
         LRar2iF9fZ8+zQRCNzghB5D/2/Fd4+CBYNMOtdwrp7FaPT8j0pEzeOmGEtLXEKGTo1Su
         e7QtCdpGJhWVgPA3tgfVm1JqpwSaG+DvO1/5sAk1PO7u2yZtSuj7kGwNH/G0oBhRiw9Z
         UxzA==
X-Gm-Message-State: AOAM530Z/y16k6xIKX8AX2JKEt3CVlB4hD9Prw7aXLs8mK0aq9iSeZUo
        acTPZPJ6SwUES9qN1pRu8NqngQ==
X-Google-Smtp-Source: ABdhPJw1f+/LS3aQnQufiPMLSgWv3ikzJM2mUKgAo9msFfUJoqiNImvZgYem58Wk3tvok8hu+xBWaw==
X-Received: by 2002:aa7:d607:: with SMTP id c7mr1500254edr.184.1597905440828;
        Wed, 19 Aug 2020 23:37:20 -0700 (PDT)
Received: from localhost ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id g9sm712181edk.97.2020.08.19.23.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 23:37:20 -0700 (PDT)
From:   Javier Gonzalez <javier@javigon.com>
X-Google-Original-From: Javier Gonzalez <javier.gonz@samsung.com>
Date:   Thu, 20 Aug 2020 08:37:19 +0200
To:     Jens Axboe <axboe@kernel.dk>
Cc:     david.fugate@linux.intel.com, Christoph Hellwig <hch@lst.de>,
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
Message-ID: <20200820063719.q6wftb23op45wigk@MacBook-Pro.localdomain>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com>
 <20200818071249.GB2544@lst.de>
 <b52854fe11640a5a5f54e08b1d3c7a556f97aad5.camel@linux.intel.com>
 <9fa64efe-8477-5d33-20ed-9619a9fe8d70@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <9fa64efe-8477-5d33-20ed-9619a9fe8d70@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.08.2020 13:25, Jens Axboe wrote:
>On 8/19/20 12:11 PM, David Fugate wrote:
>> On Tue, 2020-08-18 at 07:12 +0000, Christoph Hellwig wrote:
>>> On Tue, Aug 18, 2020 at 10:59:36AM +0530, Kanchan Joshi wrote:
>>>> If drive does not support zone-append natively, enable emulation
>>>> using
>>>> regular write.
>>>> Make emulated zone-append cmd write-lock the zone, preventing
>>>> concurrent append/write on the same zone.
>>>
>>> I really don't think we should add this.  ZNS and the Linux support
>>> were all designed with Zone Append in mind, and then your company did
>>> the nastiest possible move violating the normal NVMe procedures to
>>> make
>>> it optional.  But that doesn't change the fact the Linux should keep
>>> requiring it, especially with the amount of code added here and how
>>> it
>>> hooks in the fast path.
>>
>> Intel does not support making *optional* NVMe spec features *required*
>> by the NVMe driver.
>
>It's not required, the driver will function quite fine without it. If you
>want to use ZNS it's required. The Linux driver thankfully doesn't need
>any vendor to sign off on what it can or cannot do, or what features
>are acceptable.
>
>> It's forgivable WDC's accepted contribution didn't work with other
>> vendors' devices choosing not to implement the optional Zone Append,
>> but it's not OK to reject contributions remedying this.  Provided
>> there's no glaring technical issues, Samsung's contribution should be
>> accepted to maintain both spec compliance as well as vendor neutrality.
>
>It's *always* ok to reject contributions, if those contributions cause
>maintainability issues, unacceptable slowdowns, or whatever other issue
>that the maintainers of said driver don't want to deal with. Any
>contribution should be judged on merit, not based on political decisions
>or opinions. Obviously this thread reeks of it.
>

I'll reply here, where the discussion diverges from this particular
patch.

We will stop pushing for this emulation. We have a couple of SSDs where
we disabled Append, we implemented support for them, and we wanted to
push the changes upstream. That's it. This is no politics not a
conspiracy against the current ZNS spec. We spent a lot of time working
on this spec and are actually doing a fair amount of work to support
Append other places in the stack. In any case, the fuzz stops here.

Javier
