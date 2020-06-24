Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBCFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A042A2078E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388331AbgFXBeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 21:34:13 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:44391 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387804AbgFXBeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 21:34:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U0Xwlnb_1592962448;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U0Xwlnb_1592962448)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 24 Jun 2020 09:34:08 +0800
Date:   Wed, 24 Jun 2020 09:34:08 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>, axboe@fb.com, hch@lst.de,
        baolin.wang7@gmail.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] nvme: Add Arbitration Burst support
Message-ID: <20200624013408.GA40094@VM20190228-100.tbsite.net>
Reply-To: Baolin Wang <baolin.wang@linux.alibaba.com>
References: <cover.1592916850.git.baolin.wang@linux.alibaba.com>
 <bf3f47ba50f72d0b775ca4bd098f183056d964ba.1592916850.git.baolin.wang@linux.alibaba.com>
 <20200623144014.GB1288900@dhcp-10-100-145-180.wdl.wdc.com>
 <38482b1b-b1c7-bb41-b086-6ce00f6a9d1d@grimberg.me>
 <20200623180108.GA1291100@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623180108.GA1291100@dhcp-10-100-145-180.wdl.wdc.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 11:01:08AM -0700, Keith Busch wrote:
> On Tue, Jun 23, 2020 at 10:39:01AM -0700, Sagi Grimberg wrote:
> > 
> > > >  From the NVMe spec, "In order to make efficient use of the non-volatile
> > > > memory, it is often advantageous to execute multiple commands from a
> > > > Submission Queue in parallel. For Submission Queues that are using
> > > > weighted round robin with urgent priority class or round robin
> > > > arbitration, host software may configure an Arbitration Burst setting".
> > > > Thus add Arbitration Burst setting support.
> > > 
> > > But if the user changed it to something else that better matches how
> > > they want to use queues, the driver is just going to undo that setting
> > > on the next reset.
> > 
> > Where do we do priority class arbitration? no one sets it
> 
> Not the priority class, we don't use WRR in this driver. The RR
> arbitration can be set from user space and saved across controller
> resets, like:
> 
>   # nvme set-feature -f 1 -v 3 --save
> 
> This patch would undo the saved feature value.

OK, I understaood your concern. Now we will select the RR arbitration as default
in nvme_enable_ctrl(), but for some cases, we will not set the arbitration burst
values from userspace, and we still want to use the defaut arbitration burst that
recommended by the controller, taking into consideration any latency requirements.

So I'd like to add a parameter to decide if we can use the default arbitration
burst like below, how do yo think? Thanks.

static bool use_default_arb;
module_param(use_default_arb, bool, 0444);
MODULE_PARM_DESC(use_default_arb, "use default arbitration burst that
recommended by the controller");

