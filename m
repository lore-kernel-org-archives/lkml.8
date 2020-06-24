Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471F9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 03:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2699120CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 03:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388548AbgFXDGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 23:06:43 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:49883 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387985AbgFXDGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 23:06:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U0Yj-gp_1592967997;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U0Yj-gp_1592967997)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 24 Jun 2020 11:06:38 +0800
Date:   Wed, 24 Jun 2020 11:06:37 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     axboe@fb.com, hch@lst.de, sagi@grimberg.me, baolin.wang7@gmail.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] nvme: Add Arbitration Burst support
Message-ID: <20200624030637.GA66445@VM20190228-100.tbsite.net>
Reply-To: Baolin Wang <baolin.wang@linux.alibaba.com>
References: <cover.1592916850.git.baolin.wang@linux.alibaba.com>
 <bf3f47ba50f72d0b775ca4bd098f183056d964ba.1592916850.git.baolin.wang@linux.alibaba.com>
 <20200624025715.GB1291930@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624025715.GB1291930@dhcp-10-100-145-180.wdl.wdc.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 07:57:15PM -0700, Keith Busch wrote:
> On Tue, Jun 23, 2020 at 09:24:32PM +0800, Baolin Wang wrote:
> > +void nvme_set_arbitration_burst(struct nvme_ctrl *ctrl)
> > +{
> > +	u32 result;
> > +	int status;
> > +
> > +	if (!ctrl->rab)
> > +		return;
> > +
> > +	/*
> > +	 * The Arbitration Burst setting indicates the maximum number of
> > +	 * commands that the controller may launch at one time from a
> > +	 * particular Submission Queue. It is recommended that host software
> > +	 * configure the Arbitration Burst setting as close to the recommended
> > +	 * value by the controller as possible.
> > +	 */
> > +	status = nvme_set_features(ctrl, NVME_FEAT_ARBITRATION, ctrl->rab,
> 
> Since 'rab' is an 8-bit field, but the feature's AB value is only 3
> bits, we should add a validity check.

Sure.

> 
> > +}
> > +EXPORT_SYMBOL_GPL(nvme_set_arbitration_burst);
> 
> I don't see any particular reason to export this function just for the
> pci transport to use. Just make it a local static function an call it
> from nvme_init_identify().

OK. Thanks.

