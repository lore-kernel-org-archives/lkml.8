Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030E6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 23:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB6C02065D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 23:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgGTXPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 19:15:35 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45838 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgGTXPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 19:15:34 -0400
Received: by mail-pl1-f196.google.com with SMTP id k4so9391865pld.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 16:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8MdlYlmqeapz+lWES5DzlofRg8ebONQpfWbq8TC/AcE=;
        b=HbV26hpIEIvZ0Cl3ngWRa9VLpuEj+ZSS9Zum0kh7e8rvkcbhWBcAIqxLQVbScCjM3q
         wcXb4CBobzClGy3OmxEc60frMsD9ZGviN8I5cvxomHesi2CyHGOQKxmbK5s2f7HpyvYN
         JM0U12f/gDSW/vLgUA+rRBU0MMIa31g/FRnLHJeNSBg/mJybTTUzi8bEw0cpNQkIU2jJ
         HYDZ+ZTF62pvdVw303oVJ8tntiB4oh+TWuc6qS2mMlAWSgRAYdDEHECSRPGZ99LUfoYH
         u2H4rrskGpDlqYTmv9ZTIQCLfPtJVFahTNnvO7Dw3/0aYz3CJc8pKJCoHCGxkd/SHxo8
         9Ltg==
X-Gm-Message-State: AOAM530ym1jDnBGKmw9pWv2KY1Z1Se4OgDTcXB+Ouh/nubPp0JNYUyl4
        EdyyHkXT3VoHMRh83B+c+ns=
X-Google-Smtp-Source: ABdhPJwbJoyhAgLqcBDDHOBujk/HlsFuCFkXaqar88knZbTDRJMGZtq/wh80vgsj1WSZEMX0aeVy0g==
X-Received: by 2002:a17:90a:bf02:: with SMTP id c2mr1625764pjs.114.1595286933772;
        Mon, 20 Jul 2020 16:15:33 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:81fd:84d6:3c38:f7ef? ([2601:647:4802:9070:81fd:84d6:3c38:f7ef])
        by smtp.gmail.com with ESMTPSA id y27sm16821780pgc.56.2020.07.20.16.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 16:15:32 -0700 (PDT)
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
 <2dc39232-4042-1f93-3dcc-3266e70cf6f0@grimberg.me>
 <b8fc47a2-0b53-3316-775f-0e9a8eddfdc2@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b395c041-9ecf-4239-2cc2-4ecbfe2a550d@grimberg.me>
Date:   Mon, 20 Jul 2020 16:15:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b8fc47a2-0b53-3316-775f-0e9a8eddfdc2@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
>>>>> wonder if we should generalize the connect_q to a passthrough_q.  But
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
> 
> Thanks, that helps clarify things a bit, but which xarray were you
> talking about?

The patch from Chaitanya

See "[PATCH V4 2/2] nvme-core: use xarray for ctrl ns tracking"
