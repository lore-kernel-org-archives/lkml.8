Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A018EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 22:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 838EC22B3F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 22:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733021AbgGVWbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 18:31:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41514 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgGVWbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 18:31:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id z15so3342970wrl.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 15:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OAy+Y993VLxZGDr9RipwWkimgf83z0qJOASn+ThnlDA=;
        b=ioD6mGEWbiApnsxSzxLm7VQjZRSTB5JEwL8Oq5ZRKRqcDk8+0A6/Qq5/oZgCaA631y
         020slRqrwx3sD0yom+KN1aRFbedmMlEvirGAW1orsIQc9dFIPg/8mTZPihWDQTQoY769
         97rYjINIJwWWf7Nxl5uZ8wM8oprl70DIcRnc7isHO6/2Nh5vTaFIveMKSNDjGgE6T610
         0TZdDvGcim+2rk+XBegrfXJ9mPEaWc2Vff/7IeLAooNdqLjMVpFzE7O4xCrHmM5G+l1f
         XdCKxI9whddlhb7xNPuB3lzpFLTTILx2g+UBN0CAlxw+bdCa0gi5m/kIFJKqTBSKPIGw
         HO/A==
X-Gm-Message-State: AOAM531S4GUHdia71F9JV7tlFdu8stxnMZQgCDagVHi6DgH05TRHcjQC
        2d1fVfWg2RELjnAoF2ICZzw=
X-Google-Smtp-Source: ABdhPJyAP2MBfAqqZNztN1UpNU9srKE0MxDiqLpxiB8X+iFZsPUmULlwvj0mD1NTPAbp1u+rbgE5Uw==
X-Received: by 2002:adf:ecc8:: with SMTP id s8mr1381743wro.317.1595457100851;
        Wed, 22 Jul 2020 15:31:40 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:45ba:2951:1398:d100? ([2601:647:4802:9070:45ba:2951:1398:d100])
        by smtp.gmail.com with ESMTPSA id 133sm1255699wme.5.2020.07.22.15.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 15:31:40 -0700 (PDT)
Subject: Re: [PATCH v15 7/9] nvmet-passthru: Add passthru code to process
 commands
To:     Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>
References: <20200716203319.16022-1-logang@deltatee.com>
 <20200716203319.16022-8-logang@deltatee.com> <20200720141606.GF4627@lst.de>
 <e939dd43-9e7f-8ef0-162b-2a27f53e6e1a@grimberg.me>
 <5cc390cf-9b0b-b48b-7447-37934be51ee0@deltatee.com>
 <2dc39232-4042-1f93-3dcc-3266e70cf6f0@grimberg.me>
 <98f45e65-2967-3af9-69d1-077a32c43fa2@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6e8cc582-d706-8e99-7191-82b08aa557e2@grimberg.me>
Date:   Wed, 22 Jul 2020 15:31:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <98f45e65-2967-3af9-69d1-077a32c43fa2@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> Thanks for the review Christoph. I think I should be able to make all
>>> the requested changes in the next week or two.
>>>
>>> On 2020-07-20 1:35 p.m., Sagi Grimberg wrote:
>>>>
>>>>> I'm still not so happy about having to look up the namespace and still
>>>>> wonder if we should generalize the connect_q to a passthrough_q.  But
>>>>> I guess we can do that later and then reduce some of the exports here..
>>>>
>>>> That is a neat idea! should be easy to do (and we can then lose the host
>>>> xarray stuff). I don't mind having it on a later patch, but it should be
>>>> easy enough to do even before...
>>>>
>>>
>>> I sort of follow this. I can try to work something up but it will
>>> probably take me a few iterations to get it to where you want it. So,
>>> roughly, we'd create a passthrough_q in core with the controller's IO
>>> tagset and then cleanup the fabrics hosts to use that instead of each
>>> independently creating their connect_q?
>>>
>>> Though, I don't understand how this relates to the host xarray stuff
>>> that Sagi mentioned...
>>
>> passthru commands are in essence REQ_OP_DRV_IN/REQ_OP_DRV_OUT, which
>> means that the driver shouldn't need the ns at all. So if you have a
>> dedicated request queue (mapped to the I/O tagset), you don't need the
>> ns->queue and we can lose the ns lookup altogether.
>>
>> The only part is to check the effects, but that can probably be handled
>> when we setup the passthru controller or something...
> 
> Yes, I implemented the passthru_q (which was quite simple).

Nice..

> But I'm not
> sure how we are supposed to call nvme_command_effects() correctly
> without the ns. You can't possibly do that during setup for every
> possible opcode on every namespace. And even if we do, we'll still need
> the same nvme_find_get_ns() and nvme_put_ns() exports and probably
> another xarray to lookup the information.
> 
> Also, we pass the namespace's disk to in order to get proper block
> accounting for the underlying disk. (Which is pretty important for
> debugging). So we need to lookup the namespace for this too.
> 
> Unless there are some other ideas to solve these issues, I don't think
> this change will gain us anything.

Let's defer it to a followup set than.
