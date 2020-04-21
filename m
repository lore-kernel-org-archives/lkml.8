Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BA1C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 04:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59F932084D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 04:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgDUEv0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 00:51:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36610 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgDUEv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 00:51:26 -0400
Received: from mail-pj1-f72.google.com ([209.85.216.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jQksV-0005qS-R0
        for linux-kernel@vger.kernel.org; Tue, 21 Apr 2020 04:51:24 +0000
Received: by mail-pj1-f72.google.com with SMTP id bg6so2203696pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 21:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BLtq2QdjOzCrJMLFZ+hejhyptyhEVzibl60GGDinzt4=;
        b=j/mArgB442WbWM6AzvWEOkcD+7DFUVt59u4DEzWIiYsNqTRnUyaSUXET0HtxEsgvfe
         c/TWrPl4L5OF11tEluMcJSioM3+08NPilu4bmaiCFT5w+h8WwCJv8qWi5DEZqTm9Dac9
         Ti5YeVfVrzXF4/gduKvEuq52rGiH7A0m4EAQbUyLJ/kT1CEUrInXpMBEUOZnTjTfrE07
         TbJxEdf4aoB1jvF7cJaLTBvZXIsC6TsYFN58N9OsVzuxNHtXeXaOlePulcZdZ7CymPuN
         mqkuNNikZIDLWPFilfjgTI4CzHPghEJ/heMXhzVLwhlLEU3qZeKWKkOUKcOsk7QLq8Gg
         +hAQ==
X-Gm-Message-State: AGi0PuY24vXXM0DKMyE/PGVI78GuDuHGpmMk6V1xRE5zHOtjYIoM4NUS
        0LX7quI7HnzAZeYX41GeUsTAFQxbsGGtsKKjWD3Mxwj+VP0oGYfd2B2SbMsYwOQmrrxYtxoLp+w
        JRWvg3FQMAPeN0RHGaPJ8qBmnAZXMeYsjWD5iJ4ykSA==
X-Received: by 2002:a17:90a:7349:: with SMTP id j9mr3358500pjs.196.1587444682538;
        Mon, 20 Apr 2020 21:51:22 -0700 (PDT)
X-Google-Smtp-Source: APiQypJDvmMZav1WQf4l8MDQtC6CWJ9V2og5hui0h4wbn2cbAwgyAaVGbvnQ6aHap5W2YJ/VGNCNOQ==
X-Received: by 2002:a17:90a:7349:: with SMTP id j9mr3358482pjs.196.1587444682263;
        Mon, 20 Apr 2020 21:51:22 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id mq6sm1074269pjb.38.2020.04.20.21.51.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2020 21:51:21 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] nvme/pci: Use Discard instead of Write Zeroes on SK hynix
 SC300
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200417125929.GA5053@lst.de>
Date:   Tue, 21 Apr 2020 12:51:18 +0800
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-stable <stable@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <33565F7F-307C-408C-861D-72517F564967@canonical.com>
References: <20200417083641.28205-1-kai.heng.feng@canonical.com>
 <20200417125929.GA5053@lst.de>
To:     Christoph Hellwig <hch@lst.de>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 17, 2020, at 20:59, Christoph Hellwig <hch@lst.de> wrote:
> 
> On Fri, Apr 17, 2020 at 04:36:41PM +0800, Kai-Heng Feng wrote:
>> After commit 6e02318eaea5 ("nvme: add support for the Write Zeroes
>> command"), SK hynix SC300 becomes very slow with the following error
>> message:
>> [  224.567695] blk_update_request: operation not supported error, dev nvme1n1, sector 499384320 op 0x9:(WRITE_ZEROES) flags 0x1000000 phys_seg 0 prio class 0]
>> 
>> Use quirk NVME_QUIRK_DEALLOCATE_ZEROES to workaround this issue.
> 
> Do you have a written guarantee from SK Hynix that it will always zero
> all blocks discarded?

Raised the issue to SK Hynix and waiting for their reply...

Kai-Heng
