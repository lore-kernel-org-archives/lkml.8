Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A07EC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 23:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A28BF2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 23:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgGTX23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 19:28:29 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:34165 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgGTX22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 19:28:28 -0400
Received: by mail-pj1-f67.google.com with SMTP id cv18so575819pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 16:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sIfyFvfqHZ+qa2NLs8qwPqjhpDOmDh/lGN1827apR70=;
        b=TSa+g/aS9lBoPbTrtnyroWBL5wXStV41syKfBDDyuuKWmXB6MSXX0OdtIAIIxzDO1M
         FJiq6E1xNeP0u25DueuNG2YAiku4VaDzwqrO/2rxFkrXnC76yH1RDju4KENpR6dIBBV7
         c99rZNPM9XDr/3pY152f+DEnMGaJlN26S7LFAb7y+wPH2t33YMzsEvuwotvvzovByXVU
         Z/aGH12InnCMaQ59aoAM3SNVOM+i66oYiv28EB/rD3JTDlXAetDvPLutEI1cofslmD7l
         hw/n1CPbCajJpFhgV3jmwopp0bIoytRpcXbVuBbJywCJTcHU7F6q80BLUc98+pJshoB3
         PSAw==
X-Gm-Message-State: AOAM530PAGHkSaUffgyXz0Eh8nt/6Sh2gbQR1DqVFvXPA9MMAbr6HFg/
        khRbdwMChUWYYvWnKIeKDv4=
X-Google-Smtp-Source: ABdhPJxkUk+ewAsf2iX7NQ1DfinhMORAq1Wmdh2HMcvooKPGLXvtlkxgsRlW/i8v2MuCEUkJhRG2ig==
X-Received: by 2002:a17:90b:390e:: with SMTP id ob14mr1533589pjb.221.1595287708205;
        Mon, 20 Jul 2020 16:28:28 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:81fd:84d6:3c38:f7ef? ([2601:647:4802:9070:81fd:84d6:3c38:f7ef])
        by smtp.gmail.com with ESMTPSA id o129sm18689520pfg.14.2020.07.20.16.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 16:28:27 -0700 (PDT)
Subject: Re: [PATCH v15 7/9] nvmet-passthru: Add passthru code to process
 commands
To:     Keith Busch <kbusch@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
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
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d7596065-f33b-5533-7254-153b82e6b88b@grimberg.me>
Date:   Mon, 20 Jul 2020 16:28:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720231701.GA682160@dhcp-10-100-145-180.wdl.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/20 4:17 PM, Keith Busch wrote:
> On Mon, Jul 20, 2020 at 05:01:19PM -0600, Logan Gunthorpe wrote:
>> On 2020-07-20 4:35 p.m., Sagi Grimberg wrote:
>>
>>> passthru commands are in essence REQ_OP_DRV_IN/REQ_OP_DRV_OUT, which
>>> means that the driver shouldn't need the ns at all. So if you have a
>>> dedicated request queue (mapped to the I/O tagset), you don't need the
>>> ns->queue and we can lose the ns lookup altogether.
> 
> We still need a request_queue to dispatch the command. I guess you could
> make a generic one for the controller that isn't tied to a namespace,
> but we lose the fair shared tag allocation.

What do you mean fair shared tag allocation?
