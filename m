Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7143EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 23:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46DF2207FC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 23:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="tOLfZLK8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgGTXB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 19:01:26 -0400
Received: from ale.deltatee.com ([204.191.154.188]:51708 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgGTXB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 19:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wh/cbRuJktuOsZzlc8uRgoVgjdqNsTzfdwIGfGrtxog=; b=tOLfZLK8pRPsPMltT5G8kggzB0
        nO41G2ploZ70DChEYnLTnJPhOV19aXLUIaLE66P1go572nRzWz1RCML0pFyGUwkTw8+P9WmzC/rHc
        pF0trKf1llt0ta4rL64uGgZRp/nSyDLfBy4aokNrjaWDGfO8sC0dHKpBp7nssrm5URlhkt8Me/n3a
        m/bQ1XKXy7xOeLpwOVrrLAPST3wBVBu+6NnQlfGnsCtzdZ12zJ9u1Big4u1pOMoEVo9+1hkHSYNti
        rW9h7PkY35K25VVHWpL8lAUQj21Ry8TGnJpwFqeyKtDhFO3BNwg+tWN1c3U6a1pN5jPgPQCQs9+gS
        lMraswAw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1jxeme-0003gG-LY; Mon, 20 Jul 2020 17:01:21 -0600
To:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
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
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b8fc47a2-0b53-3316-775f-0e9a8eddfdc2@deltatee.com>
Date:   Mon, 20 Jul 2020 17:01:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2dc39232-4042-1f93-3dcc-3266e70cf6f0@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sbates@raithlin.com, maxg@mellanox.com, Chaitanya.Kulkarni@wdc.com, axboe@fb.com, kbusch@kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, hch@lst.de, sagi@grimberg.me
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v15 7/9] nvmet-passthru: Add passthru code to process
 commands
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-07-20 4:35 p.m., Sagi Grimberg wrote:
> 
>> Thanks for the review Christoph. I think I should be able to make all
>> the requested changes in the next week or two.
>>
>> On 2020-07-20 1:35 p.m., Sagi Grimberg wrote:
>>>
>>>> I'm still not so happy about having to look up the namespace and still
>>>> wonder if we should generalize the connect_q to a passthrough_q.  But
>>>> I guess we can do that later and then reduce some of the exports here..
>>>
>>> That is a neat idea! should be easy to do (and we can then lose the host
>>> xarray stuff). I don't mind having it on a later patch, but it should be
>>> easy enough to do even before...
>>>
>>
>> I sort of follow this. I can try to work something up but it will
>> probably take me a few iterations to get it to where you want it. So,
>> roughly, we'd create a passthrough_q in core with the controller's IO
>> tagset and then cleanup the fabrics hosts to use that instead of each
>> independently creating their connect_q?
>>
>> Though, I don't understand how this relates to the host xarray stuff
>> that Sagi mentioned...
> 
> passthru commands are in essence REQ_OP_DRV_IN/REQ_OP_DRV_OUT, which
> means that the driver shouldn't need the ns at all. So if you have a
> dedicated request queue (mapped to the I/O tagset), you don't need the
> ns->queue and we can lose the ns lookup altogether.

Thanks, that helps clarify things a bit, but which xarray were you
talking about?

Logan
