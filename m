Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EF8C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 22:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 940F62080D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 22:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgGTWfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 18:35:21 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41166 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgGTWfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 18:35:21 -0400
Received: by mail-pf1-f196.google.com with SMTP id q17so9755854pfu.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 15:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qVsb3irT98yWXpJxhGCe+v3RWy+B0oryB1ExGX84sUM=;
        b=Nv6n0//pv2iJuiUjCR4MPWk05L/t4CP4+4z8LYJYBPGwwzp8CYL+16LidHp9RIurW8
         sJTm8ZJVdxsWxL2m6Yaa9fNJQ/OPCfRHzOp2WiqGfHO7ESoK0iy9EsdUV/1Gu+zdaUWP
         p4rDMpZLYQ3VeUJknqtWcqb/lSR2d5lZSvcV8BEuig8vGXKvyglp3uZYtD9YQ+rlwLle
         OLHz7jtyGTTqsmRpHDup1szXNgksCW8TxoK/kMkHsx7YxIndbSm7kNnIvZpXDY0DO/mf
         yJ676EcgV9eMP0LJ9uc57jbpSptzNKVo9rs70XfMeTbvxPdqkQtPoFC5qb1fCYekX7Jw
         QSSg==
X-Gm-Message-State: AOAM532hUiM88Y7ixlB3Bl/Dmx4EUWALaw5G8PZ4a3hDSa06FiNBL0te
        dkERSGfX7PguuY9Qis3ajvU=
X-Google-Smtp-Source: ABdhPJwLwOv2cDyLT2iUdhQRRdhgA++8oV1eJMBcYxZCfKoAYMj9H4ko3IsgMSax1T8I4JGHAJibWw==
X-Received: by 2002:a63:5d1:: with SMTP id 200mr20793955pgf.59.1595284520130;
        Mon, 20 Jul 2020 15:35:20 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:81fd:84d6:3c38:f7ef? ([2601:647:4802:9070:81fd:84d6:3c38:f7ef])
        by smtp.gmail.com with ESMTPSA id o128sm18201897pfg.127.2020.07.20.15.35.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 15:35:19 -0700 (PDT)
Subject: Re: [PATCH v15 7/9] nvmet-passthru: Add passthru code to process
 commands
To:     Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20200716203319.16022-1-logang@deltatee.com>
 <20200716203319.16022-8-logang@deltatee.com> <20200720141606.GF4627@lst.de>
 <e939dd43-9e7f-8ef0-162b-2a27f53e6e1a@grimberg.me>
 <5cc390cf-9b0b-b48b-7447-37934be51ee0@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2dc39232-4042-1f93-3dcc-3266e70cf6f0@grimberg.me>
Date:   Mon, 20 Jul 2020 15:35:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5cc390cf-9b0b-b48b-7447-37934be51ee0@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Thanks for the review Christoph. I think I should be able to make all
> the requested changes in the next week or two.
> 
> On 2020-07-20 1:35 p.m., Sagi Grimberg wrote:
>>
>>> I'm still not so happy about having to look up the namespace and still
>>> wonder if we should generalize the connect_q to a passthrough_q.  But
>>> I guess we can do that later and then reduce some of the exports here..
>>
>> That is a neat idea! should be easy to do (and we can then lose the host
>> xarray stuff). I don't mind having it on a later patch, but it should be
>> easy enough to do even before...
>>
> 
> I sort of follow this. I can try to work something up but it will
> probably take me a few iterations to get it to where you want it. So,
> roughly, we'd create a passthrough_q in core with the controller's IO
> tagset and then cleanup the fabrics hosts to use that instead of each
> independently creating their connect_q?
> 
> Though, I don't understand how this relates to the host xarray stuff
> that Sagi mentioned...

passthru commands are in essence REQ_OP_DRV_IN/REQ_OP_DRV_OUT, which
means that the driver shouldn't need the ns at all. So if you have a
dedicated request queue (mapped to the I/O tagset), you don't need the
ns->queue and we can lose the ns lookup altogether.

The only part is to check the effects, but that can probably be handled
when we setup the passthru controller or something...
