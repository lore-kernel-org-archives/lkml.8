Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D76C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 22:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6B36208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 22:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="hR02xQhh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgGTWBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 18:01:50 -0400
Received: from ale.deltatee.com ([204.191.154.188]:50766 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgGTWBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 18:01:49 -0400
X-Greylist: delayed 1215 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Jul 2020 18:01:49 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EI4HV6io6QvxPNiiP4h3U+USCze8na4pN1lXIYxzsKE=; b=hR02xQhhHkzb0x75CmE926uQPi
        kl8Qui+dyXxqehG+rEIaDSxHS5IkQAoE+3VCIQZM+SJ6igXfHmxalPZozHDne+U6Wb9olrPFi/QTL
        w7nu84wzNw7+EzIxnYSIwatdu20/yhGJYD5R1DiN5L068fm8V1mvO3mbNcSGY76JTd/IC8YN3IC7A
        pu6YaSkr3LvhIORG9nK5gDlVAd6kt2Z/XBXIhiIO3tFsBtEveBTG4RQ4EFidyCm7iKocAsKTBEfnO
        wrWbv7OUVOImZ1Dx38WrbJ0MgJJcRukmDbnbLxlB3q7GYA177bJk5/cso0881QsVNzQOxnfMKrV6U
        AJxIQ3ZA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1jxdXL-0002HX-UZ; Mon, 20 Jul 2020 15:41:28 -0600
To:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20200716203319.16022-1-logang@deltatee.com>
 <20200716203319.16022-8-logang@deltatee.com> <20200720141606.GF4627@lst.de>
 <e939dd43-9e7f-8ef0-162b-2a27f53e6e1a@grimberg.me>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <5cc390cf-9b0b-b48b-7447-37934be51ee0@deltatee.com>
Date:   Mon, 20 Jul 2020 15:41:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e939dd43-9e7f-8ef0-162b-2a27f53e6e1a@grimberg.me>
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

Thanks for the review Christoph. I think I should be able to make all
the requested changes in the next week or two.

On 2020-07-20 1:35 p.m., Sagi Grimberg wrote:
> 
>> I'm still not so happy about having to look up the namespace and still
>> wonder if we should generalize the connect_q to a passthrough_q.  But
>> I guess we can do that later and then reduce some of the exports here..
> 
> That is a neat idea! should be easy to do (and we can then lose the host
> xarray stuff). I don't mind having it on a later patch, but it should be
> easy enough to do even before...
> 

I sort of follow this. I can try to work something up but it will
probably take me a few iterations to get it to where you want it. So,
roughly, we'd create a passthrough_q in core with the controller's IO
tagset and then cleanup the fabrics hosts to use that instead of each
independently creating their connect_q?

Though, I don't understand how this relates to the host xarray stuff
that Sagi mentioned...

Logan
