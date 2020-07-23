Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E84EC433EB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36BFB20771
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbgGWQKv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 12:10:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54077 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgGWQKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 12:10:51 -0400
Received: from mail-pj1-f71.google.com ([209.85.216.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jydo0-0003Al-OX
        for linux-kernel@vger.kernel.org; Thu, 23 Jul 2020 16:10:48 +0000
Received: by mail-pj1-f71.google.com with SMTP id g16so4180928pjz.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 09:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mloZu1UH6qYYfFGV+CjNmoEgB8w841kwWHgyCLqHBnk=;
        b=KVVggFj4lcfsbAkLPJaQA9KPl72Tymm7eJ5lgQkmjzIyT9HWQOKSjyGFFK15KeU5Kw
         S9aDsfc+alx+kOtauHAZ7rBIsP2bru6Ga88LIqUuB3fJp4phuGh8hr6gOWbU6w1rN7T0
         bPOfdkg/0QOceE+CPKEjQiDmwWlAears5as7XCyqiQRh/3TlfF7swsuewtucIdxzwLnd
         VWR6ra5bQnTgTjbwIMZuTvI5TpCDcGWXHLw5Vybuz7dBMK4fOrMzHzo8hGGBIVMBcIuc
         fUKRNiQRrdot2VucZ4VTBzEra0+HhETMikDVojsUD8Zp6Im2nbMWtkwqB20wJkC30oAc
         fZRA==
X-Gm-Message-State: AOAM530YQJpHwy4JeltHc+q2X4Pb0h8w/SM5mUBYJGPZc+2QwiYogY6i
        IgsEEEbEfMemEHGOSIp0ot6HOHpQ3trT9dRuFipCUBDGdb0EtOIFxTCj6Ru5KcTQIr5dTbwP0BZ
        o06DgSeUzTw6N9mFqbKnqa0Bg4fwkyj35o63rZ6Si1w==
X-Received: by 2002:a17:902:b7c8:: with SMTP id v8mr4419446plz.201.1595520647032;
        Thu, 23 Jul 2020 09:10:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUlKUEWiLCJJBN4W/MsSwrvF+0LVOXjMJ5iKUh8RFRcu39sl9LdmwE+p+bhw9APuhnDrjnBg==
X-Received: by 2002:a17:902:b7c8:: with SMTP id v8mr4419410plz.201.1595520646672;
        Thu, 23 Jul 2020 09:10:46 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id z11sm3393823pfk.46.2020.07.23.09.10.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2020 09:10:42 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH v2] nvme/pci: Add new quirk for SK hynix PC400 NLB
 off-by-one bug
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200723160325.GA17996@lst.de>
Date:   Fri, 24 Jul 2020 00:10:39 +0800
Cc:     kbusch@kernel.org, axboe@fb.com, sagi@grimberg.me,
        kyounghwan sohn <kyounghwan.sohn@sk.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <45DFD291-E6BF-48DE-A447-6FA4086D40A5@canonical.com>
References: <20200417083641.28205-1-kai.heng.feng@canonical.com>
 <20200723155731.22313-1-kai.heng.feng@canonical.com>
 <20200723160325.GA17996@lst.de>
To:     Christoph Hellwig <hch@lst.de>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jul 24, 2020, at 00:03, Christoph Hellwig <hch@lst.de> wrote:
> 
> On Thu, Jul 23, 2020 at 11:57:31PM +0800, Kai-Heng Feng wrote:
>> After commit 6e02318eaea5 ("nvme: add support for the Write Zeroes
>> command"), SK hynix PC400 becomes very slow with the following error
>> message:
>> [  224.567695] blk_update_request: operation not supported error, dev nvme1n1, sector 499384320 op 0x9:(WRITE_ZEROES) flags 0x1000000 phys_seg 0 prio class 0]
>> 
>> SK Hynix PC400 has a buggy firmware that treats NLB as max value instead
>> of a range, so the NLB passed isn't a valid value to the firmware.
>> 
>> According to SK hynix there are three commands are affected:
>> - Write Zeroes
>> - Compare
>> - Write Uncorrectable
>> 
>> Write Uncorrectable isn't implemented yet, so add a new quirk to
>> workaround the former two commands.
> 
> compare isn't implemented either in the kernel, and we certainly
> aren't going to do these quirks for passthrough.  So I think we really
> want a "write zeroes is buggy" quirk and just disable issuing that
> command from the driver.

Ok, will send a new version based on your suggestion.

> 
>> 
>> BugLink: https://bugs.launchpad.net/bugs/1872383
>> Cc: kyounghwan sohn <kyounghwan.sohn@sk.com>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> v2:
>> - SK hynix found the root cause so change the approach accordingly.
>> - lspci is wrong, the device is PC400 instead of SC300.
> 
> I don't remember seing a v1..

Well, because it took some time for the vendor to find the root cause...
Here's the v1:
https://lkml.org/lkml/2020/4/17/169

Kai-Heng

