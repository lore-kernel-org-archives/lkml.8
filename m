Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C23FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E50520899
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390159AbgFXH65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 03:58:57 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:54326 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388836AbgFXH65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 03:58:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U0aLOJ8_1592985534;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U0aLOJ8_1592985534)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 24 Jun 2020 15:58:54 +0800
Date:   Wed, 24 Jun 2020 15:58:54 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kbusch@kernel.org, axboe@fb.com, sagi@grimberg.me,
        baolin.wang7@gmail.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] nvme: Add Arbitration Burst support
Message-ID: <20200624075854.GA37292@VM20190228-100.tbsite.net>
Reply-To: Baolin Wang <baolin.wang@linux.alibaba.com>
References: <cover.1592980985.git.baolin.wang@linux.alibaba.com>
 <32d99c016d23d660f5be4a9754b5b9aafe81ab6c.1592980985.git.baolin.wang@linux.alibaba.com>
 <20200624065258.GA18130@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624065258.GA18130@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 08:52:58AM +0200, Christoph Hellwig wrote:
> On Wed, Jun 24, 2020 at 02:49:57PM +0800, Baolin Wang wrote:
> > >From the NVMe spec, "In order to make efficient use of the non-volatile
> > memory, it is often advantageous to execute multiple commands from a
> > Submission Queue in parallel. For Submission Queues that are using
> > weighted round robin with urgent priority class or round robin
> > arbitration, host software may configure an Arbitration Burst setting".
> > Thus add Arbitration Burst setting support.
> 
> What is the value add of doing this in the kernel?  Wouldn't a nvme-cli
> subcommand to just set the arbitration burst to the recommended value,
> either as a saved or current value be both more useful and also cause
> less kernel bloat?

Yes, that's another way to configure the RAB, but for some simple and
frequently-used usage cases, we just want to use the recommanded arbitration
burst as default without bothering the nvme-cli tool every reset time.

