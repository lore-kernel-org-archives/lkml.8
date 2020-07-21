Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D2CC433F2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 00:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71BAD21702
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 00:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgGUAjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 20:39:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42355 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbgGUAjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 20:39:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id o11so19488985wrv.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 17:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WIattoPaCAsVucZKkhcZ7N2CYGctJaZRL7pAstTnc94=;
        b=mMlnHjPQ3UsJ3t29igdDxwuxhEzP+e38y7ya8zDFEG0XYo2pcvBaa4LKv+W0MSQjCU
         JiNSg0L8oTEr1Fa4jm7Tq8GG36nQL+KO99HONLvJux7tM+OPMWIMQ5HMQW5BCacw243k
         W6AP92mt3iiraPf2Ut3iVH1TfyNLHIbqBN939rYeC1W6ow8MRRhDkbhdgO3/zaWD/yoa
         UNxJ/Gbg2VTsKOVPTA9Id0ANloAGA8wmF39i0k12dZjWJJo6iZTEgVPaj1wcrj4flHaB
         G4gHqAvOqWXPnhNvqDqXKKhTIJPDPm/QpLs4/KrXH7s19yKbfzb+V/X6t4lDniDG5iRN
         rmJg==
X-Gm-Message-State: AOAM5318AwyveSVLbuPA9cMJPdTTVrZ0k+SuyoxKd2RpuvhoQkoh56RQ
        6w84BuZS5kqmgGvBlWMQLnM=
X-Google-Smtp-Source: ABdhPJy0I9jvMNyeDN0EtZsqfs/0P32YscqEU5DPBKoUyiNHWyhY5aPNZvsv90AleasVLDiY7/+w0g==
X-Received: by 2002:a05:6000:1209:: with SMTP id e9mr10835605wrx.404.1595291950346;
        Mon, 20 Jul 2020 17:39:10 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:81fd:84d6:3c38:f7ef? ([2601:647:4802:9070:81fd:84d6:3c38:f7ef])
        by smtp.gmail.com with ESMTPSA id 1sm1267910wmf.21.2020.07.20.17.39.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 17:39:09 -0700 (PDT)
Subject: Re: [PATCH v15 7/9] nvmet-passthru: Add passthru code to process
 commands
To:     Keith Busch <kbusch@kernel.org>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
References: <20200716203319.16022-1-logang@deltatee.com>
 <20200716203319.16022-8-logang@deltatee.com> <20200720141606.GF4627@lst.de>
 <e939dd43-9e7f-8ef0-162b-2a27f53e6e1a@grimberg.me>
 <5cc390cf-9b0b-b48b-7447-37934be51ee0@deltatee.com>
 <2dc39232-4042-1f93-3dcc-3266e70cf6f0@grimberg.me>
 <b8fc47a2-0b53-3316-775f-0e9a8eddfdc2@deltatee.com>
 <20200720231701.GA682160@dhcp-10-100-145-180.wdl.wdc.com>
 <d7596065-f33b-5533-7254-153b82e6b88b@grimberg.me>
 <20200721000630.GA682317@dhcp-10-100-145-180.wdl.wdc.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <be06756a-bb05-ae83-3aea-6eb97d985160@grimberg.me>
Date:   Mon, 20 Jul 2020 17:39:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721000630.GA682317@dhcp-10-100-145-180.wdl.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> On Mon, Jul 20, 2020 at 05:01:19PM -0600, Logan Gunthorpe wrote:
>>>> On 2020-07-20 4:35 p.m., Sagi Grimberg wrote:
>>>>
>>>>> passthru commands are in essence REQ_OP_DRV_IN/REQ_OP_DRV_OUT, which
>>>>> means that the driver shouldn't need the ns at all. So if you have a
>>>>> dedicated request queue (mapped to the I/O tagset), you don't need the
>>>>> ns->queue and we can lose the ns lookup altogether.
>>>
>>> We still need a request_queue to dispatch the command. I guess you could
>>> make a generic one for the controller that isn't tied to a namespace,
>>> but we lose the fair shared tag allocation.
>>
>> What do you mean fair shared tag allocation?
> 
> See hctx_may_queue().

Still not following your point... this queue is yet another request
queue on the I/O tagset, e.g.

ctrl->passthru_q = blk_mq_init_queue(ctrl->tagset);
