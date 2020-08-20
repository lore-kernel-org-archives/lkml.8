Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E517C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 762A32063A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="IT6+PQy6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgHTGpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 02:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgHTGp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 02:45:29 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CB5C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 23:45:29 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id bo3so1206832ejb.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 23:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B2y41juScN4ZEMe70aXDJO6X28WGacc1jO+T2JLh1b0=;
        b=IT6+PQy6X4iz+w6Eh7CIYhS3hgDl484sGcro3drqzFgNAve9mQvrXDPT4j/INV1mWP
         GNQdYmVU8BqCQmj6s0p1d8/uTlSbX6e2uea2PEm7J3Tu7GiY8I3o2fbSFOPcRK6++7sY
         d4Rj3txdjLkVxkoMMw67PHhFtOslq8uZyK9SLWwAj0eUOa5wLZI/Ta8HoEzd0KKsBK3C
         zs6qS0xTNbyXhG8OASIlwWNKIfluhxcIK3KQmi2GZ7fq74HEo4vMCljrYlhyc0rCSl1C
         NwZf14AlOcXz37b37RbFiX4Yi4Gj+o+6Gv6q1cqpXpdiAaLAuicEhK8PJW98v+C799NB
         crOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B2y41juScN4ZEMe70aXDJO6X28WGacc1jO+T2JLh1b0=;
        b=qp+0rDYycqvRoiiPccKPKyg2Vmt+JFQvBaqJ4VPyNMTxnzxY8hopUILrG5RAO+EJZj
         mqVvCba9cCyC+JlMp47Ql9p7fJXbysDc3OWYxnMltxMsxGHT2iOUcndJSgksM/IhtW5q
         TcUoe1c5wAFgdubQeZm4oNy/hyJQCi/H26D4qYMLiNNhh3+zrupfOUNwCU10LUKvblWD
         9XRSWbj/YyeEhaQ8zhSBWcHWPWHY+NWUdV9El/o6ZlbbPMFOxD65PwREUra0xvLsZu6h
         5Ikur0kY65mS8e9j37vvhuIq/tRScrJFihJAtO1zsjwMK8RQXGqrizBygDpywCSTmQ5K
         SOaQ==
X-Gm-Message-State: AOAM5333NzmYL+jYrLt32KlppoHR2NJsCQWYTJsKaEca5sxrRXsOnH8s
        lIbpB1gtgsyIUdnu2A5WRXTUkg==
X-Google-Smtp-Source: ABdhPJyZYHK1KxivsA8bWcGYFGuwT622rCb6PKrf13z3/NhYNHnl3A6e5rd45/cGeuH+6eeUcuBENw==
X-Received: by 2002:a17:906:868a:: with SMTP id g10mr1223275ejx.342.1597905927822;
        Wed, 19 Aug 2020 23:45:27 -0700 (PDT)
Received: from localhost ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id kt27sm819772ejb.15.2020.08.19.23.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 23:45:26 -0700 (PDT)
Date:   Thu, 20 Aug 2020 08:45:25 +0200
From:   Javier Gonzalez <javier@javigon.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200820064525.lae7fnnaiz7rkqvd@MacBook-Pro.localdomain>
References: <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com>
 <20200818071249.GB2544@lst.de>
 <20200818095033.h6ybdwiq3ljagl5a@mpHalley.local>
 <20200818155004.GA26688@lst.de>
 <20200818180428.obipue6adpqqpwjj@MacBook-Pro.localdomain>
 <20200819074035.GA21991@lst.de>
 <20200819083353.rwblagiesocfcq7i@mpHalley.local>
 <CY4PR04MB3751DE6CEB9C233BF7C9D86AE75D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200819104349.GA2697@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200819104349.GA2697@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.08.2020 12:43, Christoph Hellwig wrote:
>On Wed, Aug 19, 2020 at 09:14:13AM +0000, Damien Le Moal wrote:
>> While defining a zone append command for SCSI/ZBC is possible (using sense data
>> for returning the written offset), there is no way to define zone append for
>> SATA/ZAC without entirely breaking the ATA command model. This is why we went
>> after an emulation implementation instead of trying to standardized native
>> commands. That implementation does not have any performance impact over regular
>> writes *and* zone write locking does not in general degrade HDD write
>> performance (only a few corner cases suffer from it). Comparing things equally,
>> the same could be said of NVMe drives that do not have zone append native
>> support: performance will be essentially the same using regular writes and
>> emulated zone append. But mq-deadline and zone write locking will significantly
>> lower performance for emulated zone append compared to a native zone append
>> support by the drive.
>
>And to summarize the most important point - Zone Append doesn't exist
>in ZAC/ABC.  For people that spent the last years trying to make zoned
>storage work, the lack of such a primite has been the major pain point.
>That's why I came up with the Zone Append design in response to a
>request for such an operation from another company that is now heavily
>involved in both Linux development and hosting Linux VMs.  For ZAC and
>ZBC the best we can do is to emulate the approach in the driver, but
>for NVMe we can do it.  ZNS until just before the release had Zone
>Append mandatory, and it did so for a very good reason.  While making
>it optional allows OEMs to request drives without it, I fundamentally
>think we should not support that in Linux and request vendors do
>implement writes to zones the right way.

Ok. We will just pursue Linux support for the ZNS following the append
model.

>
>And just as some OEMs can request certain TPs or optional features to
>be implemented, so can Linux.  Just to give an example from the zone
>world - Linux requires uniform and power of two zone sizes, which in
>ZAC and ZBC are not required.

