Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF45FC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EF71207DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbgGTTfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 15:35:15 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38533 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgGTTfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 15:35:15 -0400
Received: by mail-pj1-f67.google.com with SMTP id k5so366087pjg.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 12:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FAwXDOVMSGZi/I7ZWIkACyNz/hh5wQgkUbg94T7/lP0=;
        b=PDnPeP0/BwLwSgcaA4NPY4wSrsoIKvZomgDDv0ucZddjEFeMxbgrsznY9jl8HLAi2j
         mdACbHZ71X1ngcDMVP1hvK3bjyZ9QcYuCSKl3u2uRQRCErOjeNwqSpoHq2J5Oaam0Ixl
         t0sdExvW6FAi+51qkJH8Jzl7pbHG/D/lLOgMGfwOjB6CVp7xezhQh1zZYNBrXLxmGVsY
         IjC/wOkpSWoVJ0+YU2/LkVoQ/CjFrhuhjPeif8HAzGTN3WdvP2BCpUU+Y8JpaH2rKc4/
         mpwMjNrzqX5Y8fVW0BVQekLvnRBxU8Yt0mCh9hcQx1JE5FN5q3bRGWUDTfp6eTRc8lR5
         Ei0g==
X-Gm-Message-State: AOAM533fMDjh+mAD3AdWKZ2uQecuuda+Z2EKY+mNQNBUSMkc7R4+rPu9
        mzz+9XuL1i8ChA3gzKmTW9M=
X-Google-Smtp-Source: ABdhPJzdF+z//mhwQF07S3PExCuzsCXpZ0Kr+4nTeKZkNUDuKlHK2ZkqoHFZKnlhXhd+E6guqCWxDw==
X-Received: by 2002:a17:90b:283:: with SMTP id az3mr992221pjb.38.1595273714639;
        Mon, 20 Jul 2020 12:35:14 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:81fd:84d6:3c38:f7ef? ([2601:647:4802:9070:81fd:84d6:3c38:f7ef])
        by smtp.gmail.com with ESMTPSA id n15sm388993pjf.12.2020.07.20.12.35.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 12:35:13 -0700 (PDT)
Subject: Re: [PATCH v15 7/9] nvmet-passthru: Add passthru code to process
 commands
To:     Christoph Hellwig <hch@lst.de>,
        Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20200716203319.16022-1-logang@deltatee.com>
 <20200716203319.16022-8-logang@deltatee.com> <20200720141606.GF4627@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e939dd43-9e7f-8ef0-162b-2a27f53e6e1a@grimberg.me>
Date:   Mon, 20 Jul 2020 12:35:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720141606.GF4627@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> Add passthru command handling capability for the NVMeOF target and
>> export passthru APIs which are used to integrate passthru
>> code with nvmet-core.
>>
>> The new file passthru.c handles passthru cmd parsing and execution.
>> In the passthru mode, we create a block layer request from the nvmet
>> request and map the data on to the block layer request.
>>
>> Admin commands and features are on a white list as there are a number
>> of each that don't make too much sense with passthrough. We use a
>> white list so that new commands can be considered before being blindly
>> passed through. In both cases, vendor specific commands are always
>> allowed.
>>
>> We also blacklist reservation IO commands as the underlying device
>> cannot differentiate between multiple hosts behind a fabric.
> 
> I'm still not so happy about having to look up the namespace and still
> wonder if we should generalize the connect_q to a passthrough_q.  But
> I guess we can do that later and then reduce some of the exports here..

That is a neat idea! should be easy to do (and we can then lose the host
xarray stuff). I don't mind having it on a later patch, but it should be
easy enough to do even before...
